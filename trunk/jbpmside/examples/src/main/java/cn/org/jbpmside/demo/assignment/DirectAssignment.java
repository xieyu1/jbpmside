package cn.org.jbpmside.demo.assignment;

import org.jbpm.taskmgmt.def.AssignmentHandler;
import org.jbpm.taskmgmt.exe.Assignable;
import org.jbpm.graph.exe.ExecutionContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import cn.org.jbpmside.demo.identity.client.IClientDentityService;

/**
 * 直接领导分配任务
 * User: yuchen
 * Date: 2008-11-28
 * Time: 9:36:21
 */
public class DirectAssignment implements AssignmentHandler {
    private static final Log log = LogFactory.getLog(DirectAssignment.class);

    /**
     * 任务分配给人
     * @param assignable       任务分配
     * @param executionContext   执行上下文
     * @throws Exception
     */
    public void assign(Assignable assignable, ExecutionContext executionContext) throws Exception {
        String leaderId= IClientDentityService.TEST_DIRECTORATE_LEADER_USER_ID;
             assignable.setActorId(leaderId);
    }

}
