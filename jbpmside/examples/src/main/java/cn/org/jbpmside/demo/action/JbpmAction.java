package cn.org.jbpmside.demo.action;


import com.opensymphony.xwork.ActionContext;
import cn.org.jbpmside.core.services.process.IDeployJbpmProcessService;
import cn.org.jbpmside.core.services.process.JbpmProcessDefinitionService;
import cn.org.jbpmside.core.services.process.JbpmProcessInstanceService;
import cn.org.jbpmside.core.services.task.JbpmWorklistQueryService;
import cn.org.jbpmside.core.services.task.dto.TaskInstanceDTO;
import cn.org.jbpmside.core.util.page.Page;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * Created by IntelliJ IDEA.
 * User: yuchen
 * Date: 2008-11-25
 * Time: 17:20:01
 * To change this template use File | Settings | File Templates.
 */

public class JbpmAction {
    private String processname;
    private IDeployJbpmProcessService ideployJbpmProcessService;//流程发布
    private JbpmProcessDefinitionService jbpmProcessDefinitionService;//流程定义服务
    private Page page = new Page();
    private String currentpagenum; // 当前页-String
    private String expense_money;
    private String tokenid;
    private String taskid;
    private static int DEFAULT_PAGE_SIZE = 15;      //默认每页显示的条数
    private static String SESSION_LOGIN_NAME = "loginName"; //webwork中的session中的登录名
    private List jbpmProcessDefinitionList;   //流程定义
    private Collection<TaskInstanceDTO> jbpmTaskInstanceList;     //任务实例
    private JbpmProcessInstanceService jbpmProcessInstanceService;
    private JbpmWorklistQueryService jbpmWorklistQueryService;
    private static final Log log = LogFactory.getLog(JbpmAction.class);

    /**
     * 发布流程为processName的流程定义
     *
     * @return
     */
    public String deploy() {
        ideployJbpmProcessService.deployByname(this.processname);
        return "success";
    }

    /**
     * 发布所有的流程定义
     *
     * @return
     */
    public String deployAll() {
        ideployJbpmProcessService.deployAll();
        return "success";
    }

    /**
     * 默认执行
     *
     * @return
     */
    public String execute() {
        return "success";
    }

    /**
     * @return
     */
    public String findAllProcessDefination() {
        page.setCurrentPage(getIntCurrentPageNum());
        page.setPageSize(DEFAULT_PAGE_SIZE);
        this.jbpmProcessDefinitionList = jbpmProcessDefinitionService.getLatestProcessDefinitionListsByPage(page);
        return "success";
    }

    /**
     * 启动流程
     *
     * @return
     */
    public String startProcess() {
        Map session = ActionContext.getContext().getSession();
        String actorLoginName = (String) session.get(SESSION_LOGIN_NAME);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put(cn.org.jbpmside.demo.variable.IVariableService.JBPM_EWAY_DEMO_VARIABLE_EXPENSE_MONEY, this.expense_money);
        map.put(cn.org.jbpmside.demo.variable.IVariableService.JBPM_EWAY_DEMO_VARIABLE_EXPENSE_LOGIN_NAME, actorLoginName);
        jbpmProcessInstanceService.startProcess(actorLoginName, this.processname, map);
        return "success";
    }
    /**
     * 待阅列表
     *
     * @return
     */
    public String todosign() {
        Map session = ActionContext.getContext().getSession();
        String actorLoginName = (String) session.get(SESSION_LOGIN_NAME);
        page.setCurrentPage(getIntCurrentPageNum());
        page.setPageSize(DEFAULT_PAGE_SIZE);
        jbpmTaskInstanceList = jbpmWorklistQueryService.queryTodoSignInListByPage(actorLoginName, page);
        return "success";
    }


     /**
     * 已阅列表
     *
     * @return
     */
    public String alreadysign() {
        Map session = ActionContext.getContext().getSession();
        String actorLoginName = (String) session.get(SESSION_LOGIN_NAME);
        page.setCurrentPage(getIntCurrentPageNum());
        page.setPageSize(DEFAULT_PAGE_SIZE);
        jbpmTaskInstanceList = jbpmWorklistQueryService.queryAlreadySignInListByPage(actorLoginName, page);
        return "success";
    }
     /**
     * 待办列表
     *
     * @return
     */
    public String todoList() {
        Map session = ActionContext.getContext().getSession();
        String actorLoginName = (String) session.get(SESSION_LOGIN_NAME);
        page.setCurrentPage(getIntCurrentPageNum());
        page.setPageSize(DEFAULT_PAGE_SIZE);
        jbpmTaskInstanceList = jbpmWorklistQueryService.queryTodoListByPage(actorLoginName, page);
        return "success";
    }

    /**
     * 已办列表
     *
     * @return
     */
    public String completedList() {
        Map session = ActionContext.getContext().getSession();
        String actorLoginName = (String) session.get(SESSION_LOGIN_NAME);
        log.debug("actorLoginName==="+actorLoginName);
        page.setCurrentPage(getIntCurrentPageNum());
        page.setPageSize(DEFAULT_PAGE_SIZE);
        jbpmTaskInstanceList = jbpmWorklistQueryService.queryCompletedListByPage(actorLoginName, page);
        return "success";
    }
   /**
     * 办结列表
     *
     * @return
     */
    public String processCompletedList() {
        Map session = ActionContext.getContext().getSession();
        String actorLoginName = (String) session.get(SESSION_LOGIN_NAME);
        page.setCurrentPage(getIntCurrentPageNum());
        page.setPageSize(DEFAULT_PAGE_SIZE);
        jbpmTaskInstanceList = jbpmWorklistQueryService.queryProcessCompletedListByPage(actorLoginName, page);
        return "success";
    }
    /**
     * 流程跟踪任务列表
     *
     * @return
     */
    public String processDetailList() {
        long longtokenid = 1l;
        try {
            if(tokenid == null)
                 log.error("tokenid is null,please make sure your tokenid is not null");
            longtokenid = Long.parseLong(this.tokenid);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("tokenid is not number,check tokenid is valid");
        }
        jbpmTaskInstanceList = jbpmWorklistQueryService.getDetailTaskListByTokenid(longtokenid);
        return "success";
    }

    /**
     * 执行此任务
     *
     * @return
     */
    public String completdTask() {
        long longtaskid = 1l;
        try {
            if(taskid == null)
                 log.error("taskid is null,please make sure your tokenid is not null");
            longtaskid = Long.parseLong(this.taskid);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("taskid is not number,check taskid is valid");
        }

        jbpmProcessInstanceService.completeTaskInstance(longtaskid);
        return "success";
    }


    /**
     * 阅读此任务
     *
     * @return
     */
    public String signTask() {
        long longtaskid = 1l;
        try {
           if(taskid == null)
                 log.error("taskid is null,please make sure your tokenid is not null");
            longtaskid = Long.parseLong(this.taskid);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("taskid is not number,check taskid is valid");
        }
        jbpmProcessInstanceService.signInTaskInstance(longtaskid);
        return "success";
    }

    /**
     * 取到当前的页号-int
     *
     * @return
     */
    public int getIntCurrentPageNum() {
        int currNum = 1;
        try {
            this.currentpagenum = currentpagenum == null ? "1" : currentpagenum;
            currNum = Integer.parseInt(this.currentpagenum);
        } catch (Exception e) {
            return currNum;
        }
        return currNum;
    }
    //getter and setter method
    public void setIdeployJbpmProcessService(IDeployJbpmProcessService ideployJbpmProcessService) {
        this.ideployJbpmProcessService = ideployJbpmProcessService;
    }

    public void setJbpmProcessDefinitionService(JbpmProcessDefinitionService jbpmProcessDefinitionService) {
        this.jbpmProcessDefinitionService = jbpmProcessDefinitionService;
    }

    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }


    public String getProcessname() {
        return processname;
    }

    public void setProcessname(String processname) {
        this.processname = processname;
    }

    public String getCurrentpagenum() {
        return currentpagenum;
    }

    public void setCurrentpagenum(String currentpagenum) {
        this.currentpagenum = currentpagenum;
    }

    public List getJbpmProcessDefinitionList() {
        return jbpmProcessDefinitionList;
    }

    public void setJbpmProcessDefinitionList(List jbpmProcessDefinitionList) {
        this.jbpmProcessDefinitionList = jbpmProcessDefinitionList;
    }

    public JbpmProcessInstanceService getJbpmProcessInstanceService() {
        return jbpmProcessInstanceService;
    }

    public void setJbpmProcessInstanceService(JbpmProcessInstanceService jbpmProcessInstanceService) {
        this.jbpmProcessInstanceService = jbpmProcessInstanceService;
    }

    public void setJbpmWorklistQueryService(JbpmWorklistQueryService jbpmWorklistQueryService) {
        this.jbpmWorklistQueryService = jbpmWorklistQueryService;
    }

    public Collection<TaskInstanceDTO> getJbpmTaskInstanceList() {
        return jbpmTaskInstanceList;
    }

    public void setJbpmTaskInstanceList(Collection<TaskInstanceDTO> jbpmTaskInstanceList) {
        this.jbpmTaskInstanceList = jbpmTaskInstanceList;
    }

    public String getExpense_money() {
        return expense_money;
    }

    public void setExpense_money(String expense_money) {
        this.expense_money = expense_money;
    }

    public String getTokenid() {
        return tokenid;
    }

    public void setTokenid(String tokenid) {
        this.tokenid = tokenid;
    }

    public String getTaskid() {
        return taskid;
    }

    public void setTaskid(String taskid) {
        this.taskid = taskid;
    }
}
