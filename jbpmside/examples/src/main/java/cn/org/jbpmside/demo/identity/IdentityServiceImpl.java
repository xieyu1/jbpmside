package cn.org.jbpmside.demo.identity;

import cn.org.jbpmside.core.services.identity.IIdentityService;
import cn.org.jbpmside.demo.identity.client.IClientDentityService;


import java.util.Collection;

/**
 * 客户端的组织用户实现,实现了 jbpmside-版本的.jar中的接口
 * User: yuchen
 * Date: 2008-12-1
 * Time: 14:31:18
 */
public class IdentityServiceImpl implements IIdentityService {
    private IClientDentityService iclientDentityService;

   /**
     * 根据roleid获取userid的集合
     *
     * @param roleId   角色id
     * @return       用户userid 集合
     */
    public Collection<String> getUserIdsByRoleId(String roleId) {
        return iclientDentityService.getUserIdsByRoleId(roleId);
    }

    /**
     * 根据roleid串获取userid的集合
     *
     * @param roleIds     角色id数组
     * @return    用户userid 集合
     */
    public Collection<String> getUserIdsByRoleIds(String[] roleIds) {
       return iclientDentityService.getUserIdsByRoleIds(roleIds);
    }

    /**
     * 根据Groupid获取userid的集合
     *
     * @param groupId     组的id
     * @return   用户userid 集合
     */
    public Collection<String> getUserIdsByGroupId(String groupId) {
       return iclientDentityService.getUserIdsByGroupId(groupId);
    }

    /**
     * 根据Groupid串获取userid的集合
     *
     * @param groupIds        组id的数组
     * @return    用户userid 集合
     */
    public Collection<String> getUserIdsByGroupId(String[] groupIds) {
        return iclientDentityService.getUserIdsByGroupId(groupIds);
    }

    /**
     * 根据userId获取所有上级领导的userid的集合
     *
     * @param userId       用户userid
     * @return      用户userid 集合
     */
    public Collection<String> getAllLeaderUserIdsByUserId(String userId) {
        return iclientDentityService.getAllLeaderUserIdsByUserId(userId);
    }

    /**
     * 根据userId获取直接上级领导的userid
     *
     * @param userId     用户userid
     * @return       直接领导userid
     */
    public String getDirectorateLeaderUserIdByUserId(String userId) {
        return iclientDentityService.getDirectorateLeaderUserIdByUserId(userId);
    }

    /**
     * 根据岗位id获取userid的集合
     *
     * @param postId     岗位id
     * @return       用户userid 集合
     */
    public Collection<String> getUserIdsByPostId(String postId) {
        return iclientDentityService.getUserIdsByPostId(postId);
    }

    /**
     * 根据岗位id的集合获取userid的集合
     *
     * @param postIds   岗位id数组
     * @return     用户userid 集合
     */
    public Collection<String> getUserIdsByPostId(String[] postIds) {
        return iclientDentityService.getUserIdsByPostId(postIds);
    }

    /**
     * 获取当前用户id
     *
     * @return   当前用户userid
     */
    public String getCurrentlyUserId() {
        return iclientDentityService.getCurrentlyUserId();
    }

    public void setIclientDentityService(IClientDentityService iclientDentityService) {
        this.iclientDentityService = iclientDentityService;
    }
}
