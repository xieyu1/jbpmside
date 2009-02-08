package cn.org.jbpmside.core.exception.unchecked;

import org.apache.commons.logging.Log;

/**
 * Author: yangpeng
 * Date: 2009-1-19
 * Time: 11:18:30
 * To change this template use File | Settings | File Templates.
 */
public class ClientNotAwareException extends RuntimeException{

    // 运行期抛出的异常
    protected Throwable throwable;
    // 运行期传过来的日志记录类
    protected Log log;
    // 错误码
    protected String errMsgNum;
    // 显示到界面端的信息
    protected String displayMsg;

    /**
     * 重写默认的构造函数，只允许使用这个构造函数来构造这个异常
     * 不包含参数时，可以将args传入null值
     *
     * @param throwable 异常对象
     * @param log       记录日志类
     * @param displayMsg      显示到界面端的信息
     */
    public ClientNotAwareException(Throwable throwable, Log log, String errMsgNum, String displayMsg) {
        this.throwable = throwable;
        this.log = log;
        this.errMsgNum = errMsgNum;
        this.displayMsg = displayMsg;
    }

    public String getDisplayMsg() {
        return displayMsg;
    }

    public void setDisplayMsg(String displayMsg) {
        this.displayMsg = displayMsg;
    }

    public String getErrMsgNum() {
        return errMsgNum;
    }

    public void setErrMsgNum(String errMsgNum) {
        this.errMsgNum = errMsgNum;
    }

    public Log getLog() {
        return log;
    }

    public void setLog(Log log) {
        this.log = log;
    }

    public Throwable getThrowable() {
        return throwable;
    }

    public void setThrowable(Throwable throwable) {
        this.throwable = throwable;
    }
}
