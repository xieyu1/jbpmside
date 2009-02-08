package cn.org.jbpmside.demo.event;

import org.jbpm.graph.def.ActionHandler;
import org.jbpm.graph.exe.ExecutionContext;
import org.jbpm.graph.exe.Token;
import org.jbpm.graph.node.TaskNode;
import org.jbpm.taskmgmt.def.Task;
import org.jbpm.taskmgmt.exe.TaskMgmtInstance;
import org.jbpm.taskmgmt.exe.TaskInstance;
import org.springframework.util.StringUtils;

import cn.org.jbpmside.demo.identity.client.IClientDentityService;

/**
 * 会签用到的action-event
 * User: yuchen
 * Date: 2008-12-1
 * Time: 10:51:35
 */
public class CreateTaskInstanceAction implements ActionHandler {
    /**
     * 
     * @param executionContext     执行上下文
     * @throws Exception
     */
    public void execute(ExecutionContext executionContext) throws Exception {
        String allLeaders   =   IClientDentityService.TEST_ALL_LEADER_USER_IDS;
        String[] allLeader  = StringUtils.split(allLeaders,",");
        TaskNode taskNode = (TaskNode) executionContext.getNode();
        Task task = (Task) taskNode.getTasks().iterator().next();
        Token token = executionContext.getToken();
        TaskMgmtInstance tmi = executionContext.getTaskMgmtInstance();
        for (String leader : allLeader) {
            TaskInstance tasks = tmi.createTaskInstance(task, token);
            tasks.setActorId(leader);
        }
    }


}