package cn.org.jbpmside.core.services.assign;

import org.jbpm.taskmgmt.def.AssignmentHandler;
import org.jbpm.taskmgmt.exe.Assignable;
import org.jbpm.graph.exe.ExecutionContext;

/**
 * 给自己分配任务
 * Author: xinpeng
 * Date: 2008-10-21
 * Time: 14:32:32
 */
public class SelfAssignmentHandler implements AssignmentHandler {
    /**
     * 指派任务给人
     *
     * @param assignable       指派任务
     * @param executionContext 执行上下文
     * @throws Exception
     */
    public void assign(Assignable assignable, ExecutionContext executionContext) throws Exception {

    }
}
