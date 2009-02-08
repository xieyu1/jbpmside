package cn.org.jbpmside.demo.filter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;


/**
 * 对指定的访问的session进行过滤
 * User: yuchen
 * Date: 2009-1-14
 * Time: 21:59:06
 */

public class CheckSessionFilter implements Filter {

    private static final Log log = LogFactory.getLog(CheckSessionFilter.class);

    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void destroy() {

    }

    /**
     * 
     * @param servletRequest     详见ServletRequest
     * @param servletResponse    详见ServletResponse
     * @param filterChain        详见FilterChain
     * @throws ServletException     ServletException异常
     */
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        try {
            String parameterName = (String) request.getParameter("name");
            String sessionName = (String) request.getSession().getAttribute("loginName");
            String loginName = parameterName != null ? parameterName : sessionName;
            if (loginName == null) {
                loginName = "null"; //设置了一个默认值字符串“null”
            }
            request.getSession().setAttribute("loginName", loginName);
            log.debug("the loginName is :" + loginName);
            filterChain.doFilter(servletRequest, servletResponse);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
