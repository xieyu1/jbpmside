package org.jbpmside.console.gui.support;

import java.io.InputStream;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.sql.DataSource;

import org.jbpm.api.Execution;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.IdentityService;
import org.jbpm.api.ProcessDefinition;
import org.jbpm.api.ProcessDefinitionQuery;
import org.jbpm.api.ProcessEngine;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.ProcessInstanceQuery;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.TaskService;
import org.jbpm.api.activity.ActivityExecution;
import org.jbpm.api.env.Environment;
import org.jbpm.api.env.EnvironmentFactory;
import org.jbpm.api.identity.Group;
import org.jbpm.api.identity.User;
import org.jbpm.api.model.Activity;
import org.jbpm.api.model.ActivityCoordinates;
import org.jbpm.api.model.OpenExecution;
import org.jbpm.api.model.OpenProcessInstance;
import org.jbpm.api.model.Transition;
import org.jbpm.api.task.OpenTask;
import org.jbpm.api.task.Task;

import org.jbpm.pvm.internal.identity.impl.IdentitySessionImpl;
import org.jbpm.pvm.internal.identity.impl.UserImpl;
import org.jbpm.pvm.internal.identity.spi.IdentitySession;


public class JbpmTemplate {
    private ProcessEngine processEngine;
    private DataSource dataSource;

    public void setProcessEngine(ProcessEngine processEngine) {
        this.processEngine = processEngine;
    }

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public List<ProcessDefinition> getLatestProcessDefinitions() {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();
        List<ProcessDefinition> definitions = repositoryService.createProcessDefinitionQuery()
                                                               .orderAsc(ProcessDefinitionQuery.PROPERTY_NAME)
                                                               .list();
        Map<String, ProcessDefinition> map = new LinkedHashMap<String, ProcessDefinition>();

        for (ProcessDefinition pd : definitions) {
            String key = pd.getKey();
            ProcessDefinition processDefinition = map.get(key);

            if ((processDefinition == null)
                    || (processDefinition.getVersion() < pd.getVersion())) {
                map.put(key, pd);
            }
        }

        return new ArrayList(map.values());
    }

    public void deploy(String name, InputStream inputStream) {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();

        repositoryService.createDeployment()
                         .addResourceFromInputStream(name, inputStream)
                         .deploy();
    }

    public void deployXml(String xml) {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();

        repositoryService.createDeployment()
                         .addResourceFromString("process.jpdl.xml", xml)
                         .deploy();
    }

    public void removeProcessDefinitionById(String id) {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();
        ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                                                .processDefinitionId(id)
                                                .uniqueResult();
        repositoryService.deleteDeploymentCascade(pd.getDeploymentDbid());
    }

    public List<Transition> getTransitionsForTask(long id) {
        TaskService taskService = processEngine.getTaskService();
        Task task = taskService.getTask(id);
        EnvironmentFactory environmentFactory = (EnvironmentFactory) processEngine;
        Environment env = environmentFactory.openEnvironment();

        try {
            OpenTask openTask = (OpenTask) task;
            ActivityExecution activityExecution = (ActivityExecution) openTask
                .getExecution();
            Activity activity = activityExecution.getActivity();

            return activity.getOutgoingTransitions();
        } finally {
            env.close();
        }
    }

    public List<Transition> getTransitionsForSignalProcess(String id) {
        ExecutionService executionService = processEngine
            .getExecutionService();
        ProcessInstance pi = executionService.findProcessInstanceById(id);
        EnvironmentFactory environmentFactory = (EnvironmentFactory) processEngine;
        Environment env = environmentFactory.openEnvironment();

        try {
            ActivityExecution activityExecution = (ActivityExecution) pi;
            Activity activity = activityExecution.getActivity();

            return activity.getOutgoingTransitions();
        } finally {
            env.close();
        }
    }

    public void completeTask(long dbid, String transitionName,
        Map<String, Object> variables) {
        TaskService taskService = processEngine.getTaskService();
        taskService.setVariables(dbid, variables);
        taskService.completeTask(dbid, transitionName);
    }

    public void startProcess(String id, Map<String, Object> variables) {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();
        ExecutionService executionService = processEngine
            .getExecutionService();
        ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                                                .processDefinitionId(id)
                                                .uniqueResult();

        executionService.startProcessInstanceById(pd.getId(), variables);
    }

    public void signalProcess(String id, String transitionName,
        Map<String, Object> variables) {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();
        ExecutionService executionService = processEngine
            .getExecutionService();
        ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                                                .processDefinitionId(id)
                                                .uniqueResult();
        executionService.setVariables(id, variables);

        executionService.signalExecutionById(id, transitionName);
    }

    public List<ProcessInstance> getProcessInstances(String pdId) {
        ExecutionService executionService = processEngine
            .getExecutionService();

        return executionService.createProcessInstanceQuery()
                               .processDefinitionId(pdId).list();
    }

    public ActivityCoordinates getActivityCoordinates(String id) {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();
        ExecutionService executionService = processEngine
            .getExecutionService();

        ProcessInstance pi = executionService.findProcessInstanceById(id);
        EnvironmentFactory environmentFactory = (EnvironmentFactory) processEngine;

        Environment env = environmentFactory.openEnvironment();

        try {
            ProcessDefinition pd = ((OpenProcessInstance) pi)
                .getProcessDefinition();
            String activityName = ((ActivityExecution) pi).getActivityName();

            return repositoryService.getActivityCoordinates(pd.getId(),
                activityName);
        } finally {
            env.close();
        }
    }

    public void removeProcessInstance(String id) {
        ExecutionService executionService = processEngine
            .getExecutionService();

        executionService.deleteProcessInstance(id);
    }

    public Map<String, Object> getVariablesForTask(long id) {
        TaskService taskService = processEngine.getTaskService();
        Set<String> names = taskService.getVariableNames(id);

        return taskService.getVariables(id, names);
    }

    public Map<String, Object> getVariablesForProcess(String id) {
        ExecutionService executionService = processEngine
            .getExecutionService();
        Set<String> names = executionService.getVariableNames(id);

        return executionService.getVariables(id, names);
    }

    public List<Task> getTasks() {
        TaskService taskService = processEngine.getTaskService();

        return taskService.createTaskQuery().list();
    }

    public InputStream getResourceFromProcessDefinition(long id,
        String name) {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();

        return repositoryService.getResourceAsStream(id, name);
    }

    public InputStream getResourceFromProcessInstance(String id,
        String name) {
        RepositoryService repositoryService = processEngine
            .getRepositoryService();
        ExecutionService executionService = processEngine
            .getExecutionService();

        ProcessInstanceQuery query = executionService
            .createProcessInstanceQuery();
        query.processInstanceId(id);

        Execution processInstance = (Execution) query.uniqueResult();
        ProcessDefinition pd = ((OpenExecution) processInstance)
            .getProcessDefinition();

        return repositoryService.getResourceAsStream(pd.getDeploymentDbid(),
            name);
    }

    public List<User> getUsers() {
        IdentityService identityService = processEngine.getIdentityService();

        return identityService.findUsers();
    }

    public List<Group> getGroupsByUser(String id) {
        IdentityService identityService = processEngine.getIdentityService();

        return identityService.findGroupsByUser(id);
    }

    public void addUser(String id, String password, String givenName,
        String familyName) {
        IdentityService identityService = processEngine.getIdentityService();
        identityService.createUser(id, password, givenName, familyName);
    }

    public void removeUser(String id) {
        IdentityService identityService = processEngine.getIdentityService();
        identityService.deleteUser(id);
    }

    public List<Group> getGroups() {
        EnvironmentFactory environmentFactory = (EnvironmentFactory) processEngine;
        Environment env = environmentFactory.openEnvironment();

        try {
            IdentitySession identitySession = env.get(IdentitySession.class);

            return ((IdentitySessionImpl) identitySession).findGroups();
        } finally {
            env.close();
        }
    }

    public void addGroup(String name, String type, String parentGroupId) {
        IdentityService identityService = processEngine.getIdentityService();
        identityService.createGroup(name, type, parentGroupId);
    }

    public void removeGroup(String id) {
        IdentityService identityService = processEngine.getIdentityService();
        identityService.deleteGroup(id);
    }

    public void addMember(String userId, String groupId, String role) {
        IdentityService identityService = processEngine.getIdentityService();
        identityService.createMembership(userId, groupId, role);
    }

    public boolean checkLogin(String username, String password) {
        IdentityService identityService = processEngine.getIdentityService();

        UserImpl user = (UserImpl) identityService.findUserById(username);

        return (user != null) && password.equals(user.getPassword());
    }

    public ProcessDefinition getProcessDefinitionByProcessInstanceId(
        String processInstanceId) {
        ExecutionService executionService = processEngine
            .getExecutionService();
        ProcessInstance pi = executionService.findProcessInstanceById(processInstanceId);
        EnvironmentFactory environmentFactory = (EnvironmentFactory) processEngine;
        Environment env = environmentFactory.openEnvironment();

        try {
            return ((OpenProcessInstance) pi).getProcessDefinition();
        } finally {
            env.close();
        }
    }

    public String reportOverallActivity() {
        StringBuffer buff = new StringBuffer(
                "<graph showNames='Overall Activity' decimalPrecision='2'>");
        Connection conn = null;

        try {
            conn = dataSource.getConnection();

            Statement state = conn.createStatement();
            ResultSet rs = state.executeQuery(
                    "SELECT d.DBID_ as dpl, p.STRINGVAL_ as processId"
                    + " FROM JBPM4_DEPLOYMENT d, JBPM4_DEPLOYPROP p"
                    + " WHERE p.KEY_='pdid'"
                    + " AND d.DBID_=p.DEPLOYMENT_"
                    + " GROUP BY dpl,processId");

            while (rs.next()) {
                buff.append("<set name='").append(rs.getString("dpl"))
                    .append("' value='").append(rs.getString("processId"))
                    .append("'/>");
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }

        buff.append("</graph>");

        return buff.toString();
    }

    public String reportMostActiveProcess() {
        StringBuffer buff = new StringBuffer(
                "<graph showNames='Most Active Process' decimalPrecision='2'>");
        Connection conn = null;

        try {
            conn = dataSource.getConnection();

            Statement state = conn.createStatement();

            String sql = "  select d.STRINGVAL_ as id, count(p.ID_) as num"
                + "    from JBPM4_DEPLOYPROP d left join JBPM4_HIST_PROCINST p"
                + "      on d.STRINGVAL_=p.PROCDEFID_"
                + "   where d.KEY_='pdid' group by d.STRINGVAL_";
            ResultSet rs = state.executeQuery(sql);

            while (rs.next()) {
                buff.append("<set name='").append(rs.getString("id"))
                    .append("' value='").append(rs.getString("num"))
                    .append("'/>");
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }

        buff.append("</graph>");

        return buff.toString();
    }
}
