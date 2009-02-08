package cn.org.jbpmside.core.services.identity;

import java.util.Collection;

/**
 * 组织用户的接口
 * User: yuchen
 * Date: 2008-12-1
 * Time: 13:47:59
 */
public interface IIdentityService {
    /**
     * 根据roleid获取userid的集合
     *
     * @param roleId
     * @return  userid的集合
     */
    Collection<String> getUserIdsByRoleId(String roleId);
    /**
     * 根据roleid串获取userid的集合
     *
     * @param roleIds
     * @return   userid的集合
     */
    Collection<String> getUserIdsByRoleIds(String[] roleIds);
    /**
     * 根据Groupid获取userid的集合
     *
     * @param groupId
     * @return    userid的集合
     */
    Collection<String> getUserIdsByGroupId(String groupId);
    /**
     * 根据Groupid串获取userid的集合
     *
     * @param groupIds
     * @return     userid的集合
     */
    Collection<String> getUserIdsByGroupId(String[] groupIds);
     /**
     * 根据userId获取所有上级领导的userid的集合
     *
     * @param userId
     * @return  userid的集合
     */
    Collection<String> getAllLeaderUserIdsByUserId(String userId);
     /**
     * 根据userId获取直接上级领导的userid
     *
     * @param userId
     * @return   直接领导userid
     */
    String getDirectorateLeaderUserIdByUserId(String userId);

    /**
     * 根据岗位id获取userid的集合
     *
     * @param postId
     * @return   userid的集合
     */
     Collection<String> getUserIdsByPostId(String postId);
     /**
     * 根据岗位id的集合获取userid的集合
     *
     * @param postIds
     * @return  userid的集合
     */
     Collection<String> getUserIdsByPostId(String[] postIds);
    /**
     *  获取当前用户id
     * 
     * @return   userid的集合
     */
    String getCurrentlyUserId();
    
}
