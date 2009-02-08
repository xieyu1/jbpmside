package cn.org.jbpmside.demo.identity.client;

import java.util.Collection;

/**
 * 客户端的组织用户
 * User: yuchen
 * Date: 2008-12-2
 * Time: 12:55:14
 */
public interface IClientDentityService {
    /**
     * 角色所对应的用户id串
     */
    String TEST_ROLE_USER_IDS = "role1,role2,role3"; 
    /**
     *    部门所对应的用户id串
     */
    String TEST_GROUP_USER_IDS = "group1,group2,group3";
    /**
     * 用户所对应的所有他的上级领导用户id串
     */
    String TEST_ALL_LEADER_USER_IDS = "leader2,leader1";
    /**
     * 岗位所对应的用户id串
     */
    String TEST_POST_USER_IDS = "post1,post2,post3";
    /**
     * 用户所对应的直接领导用户id串
     */
    String TEST_DIRECTORATE_LEADER_USER_ID = "leader3";
    /**
     * 财务
     */
    String TEST_CAIWU_USER_ID="caiwu";
    /**
     * 根据roleid获取userid的集合
     *
     * @param roleId
     * @return     userid的集合
     */
    Collection<String> getUserIdsByRoleId(String roleId);

    /**
     * 根据roleid串获取userid的集合
     *
     * @param roleIds
     * @return    userid的集合
     */
    Collection<String> getUserIdsByRoleIds(String[] roleIds);

    /**
     * 根据Groupid获取userid的集合
     *
     * @param groupId
     * @return     userid的集合
     */
    Collection<String> getUserIdsByGroupId(String groupId);

    /**
     * 根据Groupid串获取userid的集合
     *
     * @param groupIds
     * @return   userid的集合
     */
    Collection<String> getUserIdsByGroupId(String[] groupIds);

    /**
     * 根据userId获取所有上级领导的userid的集合
     *
     * @param userId
     * @return   userid的集合
     */
    Collection<String> getAllLeaderUserIdsByUserId(String userId);

    /**
     * 根据userId获取直接上级领导的userid
     *
     * @param userId
     * @return   直接领导的userid
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
     * 获取当前用户id
     *
     * @return  当前用户userid
     */
    String getCurrentlyUserId();
}
