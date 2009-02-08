package cn.org.jbpmside.core.services.process;

import org.jbpm.graph.exe.ProcessInstance;

import java.util.Map;

/**
 * 流程实例服务
 * Author: xinpeng
 * Date: 2008-10-20
 * Time: 21:22:03
 */
public interface JbpmProcessInstanceService {
    /**
     * 开始流程（流程名称，启动流程的参与者）
     *
     * @param userId      用户userid
     * @param processName 流程名称
     */
    public void startProcess(String userId, String processName);

    /**
     * 开始流程（流程名称，启动流程的参与者，流程变量MAP）
     *
     * @param userId              用户userid
     * @param processName         流程名称
     * @param processParameterMap 流程参数列表
     */
    public void startProcess(String userId, String processName, Map<String, Object> processParameterMap);

    /**
     * 签收
     *
     * @param taskInstanceId 任务实例id
     */
    public void signInTaskInstance(long taskInstanceId);

    /**
     * 完成任务实例
     *
     * @param taskInstanceId 任务实例id
     */

    public void completeTaskInstance(long taskInstanceId);

    /**
     * 设置流程变量（key，value）
     *
     * @param processInstanceId 流程实例id
     * @param name              流程变量名称
     * @param value             流程变量对应的值
     */
    public void setVariable(long processInstanceId, String name, Object value);

    /**
     * 设置流程变量map（key，value）
     *
     * @param processInstanceId 流程实例id
     * @param variableMap       流程变量的key和value的map
     */
    public void setVariable(long processInstanceId, Map<String, Object> variableMap);

    /**
     * 根据tokenid获取流程实例对象
     *
     * @param rootTokenId      根tokenid
     * @return                流程实例对象
     */

    public ProcessInstance getProcessInstance(long rootTokenId);

    /**
     * 回退
     *
     * @param completedTaskInstanceId    完成的任务实例的id
     */
    public void callbackTaskInstance(long completedTaskInstanceId);
}
