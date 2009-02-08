package cn.org.jbpmside.core.util.db;

import org.hibernate.Session;
import org.hibernate.Query;
import org.hibernate.HibernateException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.jbpm.JbpmContext;
import org.jbpm.JbpmConfiguration;

import cn.org.jbpmside.core.util.page.Page;

/**
 * 提供数据的底层操作
 * User: yuchen
 * Date: 2008-11-24
 * Time: 17:26:16
 */
public class JbpmBaseJdbcDAO {
    private Page page;
    private Session hibernateSession;
    static ThreadLocal currentContextsStack = new ThreadLocal();

    /**
     * 默认构造器
     */
    public JbpmBaseJdbcDAO() {
        JbpmContext jbpmContext = this.getCurrentJbpmContext();
        this.hibernateSession = jbpmContext.getSession();
    }

    /**
     * 获取当前的jbpm的上下文JbpmContext
     *
     * @return JbpmContext    jbpm的上下文
     */
    public JbpmContext getCurrentJbpmContext() {
        JbpmContext jbpmContext;
        jbpmContext = (JbpmContext) currentContextsStack.get();
        if (jbpmContext == null) {
            jbpmContext = JbpmConfiguration.getInstance().createJbpmContext();
            currentContextsStack.set(jbpmContext);
        }
        return jbpmContext;
    }

    /**
     * 获取hibernate的Session
     *
     * @return hibernate的Session
     */
    public Session getSession() {
        return this.hibernateSession;
    }

    /**
     * 带参构造器
     *
     * @param pageSize    每页显示记录数
     * @param currentPage 当前页
     * @param recordCount 记录总数
     */
    public JbpmBaseJdbcDAO(int pageSize, int currentPage, int recordCount) {
        this();
        page = new Page();
        page.setRecordCount(recordCount);
        page.setCurrentPage(currentPage);
        page.setPageSize(pageSize);
    }

    /**
     * @param page 分页
     */
    public JbpmBaseJdbcDAO(Page page) {
        this();
        this.page = page;
    }

    /**
     * 根据sql，参数查询出结果
     *
     * @param sql          查询的sql或者是hql语句
     * @param parameterMap 参数map
     * @return 查询结果的对象列表
     */
    public List<Object> findByOutQuery(String sql, Map<String, Object> parameterMap) {
        Query query = null;
        List list = null;
        try {
            boolean issql = sql.indexOf("from") != -1;//sql中包含字符串 “from”
            if (issql)
                query = hibernateSession.createQuery(sql);        //查询对象
            else
                query = hibernateSession.getNamedQuery(sql);        //查询对象
            if (this.page != null) {
                page.setRecordCount(this.getTotalCount(sql, parameterMap));
                int pageSize = page.getPageSize();//每页显示的条数
                log.debug("the pageSize is "+pageSize);
                int firstResult = page.getFromIndex();//从第多少条记录开始查询
                  log.debug("the firstResult is "+firstResult);
                if (pageSize > 0 && firstResult >= 0) {
                    query.setFirstResult(firstResult);
                    query.setMaxResults(pageSize);
                }
            }
            parameterMap = parameterMap == null ? new HashMap() : parameterMap;
            for (String key : parameterMap.keySet()) {      //对查询条件进行迭代
                if (key != null && !"".equals(key)) {
                    Object value = parameterMap.get(key);
                    if (value != null) {
                        query.setParameter(key, value);     //加入查询条件
                    }
                }
            }
            list = query.list();
        } catch (HibernateException e) {
            if (log.isDebugEnabled())
                e.printStackTrace();
            else
                log.error("method--[findByOutQuery] throws HibernateException" + e);
            throw new RuntimeException(e);
        }
        return list;
    }

    /**
     * 根据sql，参数和页码查询出结果
     *
     * @param sql          查询的sql或者是hql语句
     * @param parameterMap 参数map
     * @param page         分页
     * @return 查询结果的对象列表
     */
    public List<Object> findByOutQuery(String sql, Map<String, Object> parameterMap, Page page) {
        this.page = page;
        return this.findByOutQuery(sql, parameterMap);
    }

    /**
     * 根据sql，参数和页码查询出结果
     *
     * @param sql          查询的sql或者是hql语句
     * @param parameterMap 参数map
     * @param pageSize     每页显示的条数
     * @param currentPage  当前页码
     * @param recordCount  记录总数
     * @return 查询结果的对象列表
     */
    public List<Object> findByOutQueryAndPage(String sql, Map<String, Object> parameterMap, int pageSize, int currentPage, int recordCount) {
        page = new Page();
        page.setRecordCount(recordCount);
        page.setCurrentPage(currentPage);
        page.setPageSize(pageSize);
        return this.findByOutQuery(sql, parameterMap);
    }

    /**
     * 取到总共的条数
     *
     * @param sql          查询的sql或者是hql语句
     * @param parameterMap 参数map
     * @return 查询结果的对象列表
     */
    private Integer getTotalCount(String sql, Map<String, Object> parameterMap) {
        Integer amount = 0;
        Query query = null;
        try {
            boolean issql = sql.indexOf("from") != -1;//sql中包含字符串 “from”
            if (!issql) {
                query = hibernateSession.getNamedQuery(sql);
                sql = query.getQueryString();
            }
            int sql_index = sql.indexOf(" from");
            String countStr = "select count(*) " + sql.substring(sql_index);
            query = hibernateSession.createQuery(countStr);        //查询对象
            parameterMap = parameterMap == null ? new HashMap() : parameterMap;
            for (String key : parameterMap.keySet()) {      //对查询条件进行迭代
                if (key != null && !"".equals(key)) {
                    Object value = parameterMap.get(key);
                    if (value != null) {
                        query.setParameter(key, value);     //加入查询条件
                    }
                }
            }
            List list = query.list();
            if (!list.isEmpty()) {
                Object count = list.get(0);
                amount = Integer.parseInt(count.toString());
            }
        } catch (HibernateException e) {
            if (log.isDebugEnabled())
                e.printStackTrace();
            else
                log.error("method--[getTotalCount] throws HibernateException" + e);
            throw new RuntimeException(e);
        }
        return amount;
    }

    private static Log log = LogFactory.getLog(JbpmBaseJdbcDAO.class);

}
