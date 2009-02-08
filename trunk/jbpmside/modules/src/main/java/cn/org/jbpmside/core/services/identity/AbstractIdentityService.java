package cn.org.jbpmside.core.services.identity;

import cn.org.jbpmside.core.services.identity.IIdentityService;

import java.util.Collection;

/**
 * 对组织用户的接口的虚类
 * User: yuchen
 * Date: 2008-12-1
 * Time: 14:02:28
 */
public abstract class AbstractIdentityService implements IIdentityService {
    /**
     * 根据roleid获取userid的集合
     *
     * @param roleId    角色id
     * @return  userid的String类型的集合
     */
    public Collection<String> getUserIdsByRoleId(String roleId) {
        //todo
        return null;
    }

    /**
     * 根据roleid串获取userid的集合
     *
     * @param roleIds  角色id的String数组
     * @return   userid的String类型的集合
     */
    public Collection<String> getUserIdsByRoleIds(String[] roleIds) {
        //todo
        return null;
    }

    /**
     * 根据Groupid获取userid的集合
     *
     * @param groupId    组id
     * @return userid的集合
     */
    public Collection<String> getUserIdsByGroupId(String groupId) {
        //todo
        return null;
    }

    /**
     * 根据Groupid串获取userid的集合
     *
     * @param groupIds   组的id数组
     * @return  userid的集合
     */
    public Collection<String> getUserIdsByGroupId(String[] groupIds) {
        //todo
        return null;
    }

    /**
     * 根据userId获取所有上级领导的userid的集合
     *
     * @param userId    用户useridid
     * @return   所有领导userid的集合
     */
    public Collection<String> getAllLeaderUserIdsByUserId(String userId) {
        //todo
        return null;
    }

    /**
     * 根据userId获取直接上级领导的userid
     *
     * @param userId
     * @return  直接上级领导的userid
     */
    public String getDirectorateLeaderUserIdByUserId(String userId) {
        //todo
        return null;
    }

    /**
     * 根据岗位id获取userid的集合
     *
     * @param postId  岗位
     * @return   userid的集合
     */
    public Collection<String> getUserIdsByPostId(String postId) {
        //todo
        return null;
    }

    /**
     * 根据岗位id的集合获取userid的集合
     *
     * @param postIds   岗位数组
     * @return    userid的集合
     */
    public Collection<String> getUserIdsByPostId(String[] postIds) {
        //todo
        return null;
    }

    /**
     * 获取当前用户id
     *
     * @return  当前用户userid
     */
    public String getCurrentlyUserId() {
        //todo
        return null;
    }
    
}
