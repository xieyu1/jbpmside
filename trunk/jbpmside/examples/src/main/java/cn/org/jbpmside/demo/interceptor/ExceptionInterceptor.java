package cn.org.jbpmside.demo.interceptor;

import cn.org.jbpmside.core.exception.unchecked.ClientNotAwareException;
import com.opensymphony.xwork.ActionInvocation;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Author: xinpeng
 * Date: 2009-1-19
 * Time: 11:36:06
 * To change this template use File | Settings | File Templates.
 */
public class ExceptionInterceptor {
    private static final Log log = LogFactory.getLog(ExceptionInterceptor.class);
    public static final String EXCEPTION = "exception";

    public void destroy() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void init() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public String intercept(ActionInvocation invocation) throws Exception {
        try {
            return invocation.invoke();
        } catch (Exception e) {

            String message = "Caught exception while invoking action: " + invocation.getAction();
            if (e instanceof ClientNotAwareException) {
                message = ((ClientNotAwareException) e).getDisplayMsg();
                invocation.getInvocationContext().put("_exception_message_", message);
            } else {
                if (log.isDebugEnabled()) {
                    e.printStackTrace();
                }
                log.error("The error stack: ", e);
            }
            log.error(message);
            return EXCEPTION;
        }
    }
}
