package cn.org.jbpmside.core.services.task;


import cn.org.jbpmside.core.util.page.Page;
import cn.org.jbpmside.core.services.task.dto.TaskInstanceDTO;

import java.util.Collection;

/**
 * 任务实例查询服务
 * Author: xinpeng
 * Date: 2008-10-21
 * Time: 11:08:14
 */
public interface JbpmWorklistQueryService {
    /**
     * 取到待签列表
     * @param userId  用户userid
     * @param page    分页
     * @return      TaskInstanceDTO的集合
     */
    public Collection<TaskInstanceDTO> queryTodoSignInListByPage(String userId,Page page);
    /**
     * 取到已签列表
     * @param userId  用户userid
     * @param page    分页
     * @return      TaskInstanceDTO的集合
     */
    public Collection<TaskInstanceDTO> queryAlreadySignInListByPage(String userId,Page page);

    /**
     * 取到待办列表
     * @param userId  用户userid
     * @param page    分页
     * @return      TaskInstanceDTO的集合
     */
    public Collection<TaskInstanceDTO> queryTodoListByPage(String userId, Page page);

    /**
     * 取到已办列表
     * @param userId  用户userid
     * @param page    分页
     * @return      TaskInstanceDTO的集合
     */
    public Collection<TaskInstanceDTO> queryCompletedListByPage(String userId, Page page);
     /**
     * 取到办结列表
     * @param userId  用户userid
     * @param page    分页
     * @return      TaskInstanceDTO的集合
     */
    public Collection<TaskInstanceDTO> queryProcessCompletedListByPage(String userId, Page page);
    /**
     * 通过roottokenid获取当前流程的所有任务
     * @param tokenid    root tokenid
     * @return      TaskInstanceDTO的集合
     */
    public Collection<TaskInstanceDTO> getDetailTaskListByTokenid(long tokenid);
}
