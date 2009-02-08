package cn.org.jbpmside.core.services.assign;

import org.jbpm.taskmgmt.def.AssignmentHandler;
import org.jbpm.taskmgmt.exe.Assignable;
import org.jbpm.graph.exe.ExecutionContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * 给直接领导分配任务
 * Author: xinpeng
 * Date: 2008-10-23
 * Time: 10:50:21
 */
public class DirectorateLeaderOfUserAssignmentHandler implements AssignmentHandler {

    private static final Log log = LogFactory.getLog(DirectorateLeaderOfUserAssignmentHandler.class);

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
