package cn.org.jbpmside.demo.identity.client;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.StringUtils;


import java.util.Collection;
import java.util.ArrayList;
import java.util.Map;

import com.opensymphony.xwork.ActionContext;

/**
 * 客户端的组织用户实现
 * User: yuchen
 * Date: 2008-12-2
 * Time: 12:55:41
 */
public class ClientDentityServiceImpl implements IClientDentityService {
    private static final Log log = LogFactory.getLog(ClientDentityServiceImpl.class);
    private static String SESSION_LOGIN_NAME = "loginName"; //webwork中的session中的登录名

    /**
     * 根据roleid获取userid的集合
     *
     * @param roleId 角色id
     * @return userid的集合
     */
    public Collection<String> getUserIdsByRoleId(String roleId) {
        return this.getCollectionByString(TEST_ROLE_USER_IDS);
    }

    /**
     * 根据roleid串获取userid的集合
     *
     * @param roleIds 角色id数组
     * @return userid的集合
     */
    public Collection<String> getUserIdsByRoleIds(String[] roleIds) {
        return this.getCollectionByString(TEST_ROLE_USER_IDS);
    }

    /**
     * 根据Groupid获取userid的集合
     *
     * @param groupId 部门id
     * @return userid的集合
     */
    public Collection<String> getUserIdsByGroupId(String groupId) {
        return this.getCollectionByString(TEST_GROUP_USER_IDS);
    }

    /**
     * 根据Groupid串获取userid的集合
     *
     * @param groupIds 部门id数组
     * @return userid的集合
     */
    public Collection<String> getUserIdsByGroupId(String[] groupIds) {
        return this.getCollectionByString(TEST_GROUP_USER_IDS);
    }

    /**
     * 根据userId获取所有上级领导的userid的集合
     *
     * @param userId 用户userid
     * @return userid的集合
     */
    public Collection<String> getAllLeaderUserIdsByUserId(String userId) {
        return this.getCollectionByString(TEST_ALL_LEADER_USER_IDS);
    }

    /**
     * 根据userId获取直接上级领导的userid
     *
     * @param userId 用户userid
     * @return 获取直接领导
     */
    public String getDirectorateLeaderUserIdByUserId(String userId) {
        return TEST_DIRECTORATE_LEADER_USER_ID;
    }

    /**
     * 根据岗位id获取userid的集合
     *
     * @param postId     岗位id
     * @return userid的集合
     */
    public Collection<String> getUserIdsByPostId(String postId) {
        return this.getCollectionByString(TEST_POST_USER_IDS);
    }

    /**
     * 根据岗位id的集合获取userid的集合
     *
     * @param postIds 岗位 id
     * @return userid的集合
     */
    public Collection<String> getUserIdsByPostId(String[] postIds) {
        return this.getCollectionByString(TEST_POST_USER_IDS);
    }

    /**
     * 获取当前用户id
     *
     * @return 当前用户userid
     */
    public String getCurrentlyUserId() {
        Map session = ActionContext.getContext().getSession();
        String actorLoginName = (String) session.get(SESSION_LOGIN_NAME);
        if (actorLoginName == null) {
            log.error("【error】，【当前用户为null】");
            throw new NullPointerException("【error】，【当前用户为null】");
        }
        return actorLoginName;
    }

    /*
     * 将数组转换成集合
     * @param str
     * @return    userid的集合
     */
    private Collection<String> getCollectionByString(String str) {
        String[] strs = StringUtils.split(str, ",");
        Collection<String> collection = new ArrayList();
        for (String sstr : strs) {
            collection.add(sstr);
        }
        return collection;
    }
}
