package cn.org.jbpmside.core.util;

import cn.org.jbpmside.core.exception.unchecked.ClientNotAwareException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

/**
 * description:异常的国际化处理类，通过读取异常的国际化文件，根据异常码取得异常描述信息
 * author: yangpeng
 * date: 2009-1-19
 * time: 10:57:14
 */
public class ExceptionUtil {

    // 资源文件的列表
    private static List<ResourceBundle> bundleList = new ArrayList<ResourceBundle>();

    // 资源文件，多个的话以逗号分隔
    private static StringBuffer bundleBaseNames = new StringBuffer("");

    private static final Log logger = LogFactory.getLog(ExceptionUtil.class);

    static {
        String[] bundleBaseKeys = {};
        List<String> bundleBaseNameList = new ArrayList<String>();
        try {
            // bundleBase 的键值数组
            bundleBaseKeys = JbpmSideConfig.getStringArray("common.exception.resources");
            for (String bundleBaseKey : bundleBaseKeys) {
                bundleBaseNameList.add(StringUtils.trim(JbpmSideConfig.getString(bundleBaseKey)));
            }
        } catch (Exception e) {
            System.err.println("common.exception.resources key not correctly in config.properties");
        }
        for (String bundleBaseName : bundleBaseNameList) {
            try {
                bundleList.add(ResourceBundle.getBundle(bundleBaseName));
                bundleBaseNames.append(bundleBaseName + ",");
            } catch (Exception e) {
                // 对应的资源文件加载不到，bundleBaseName可能为null值
                logger.error("properties file: " + bundleBaseName + " is not found in classpath.");
            }
        }
    }

    /**
     * 统一对产品中的异常进行处理，适用于抛出的异常是RuntimeException类型的异常
     *
     * @param throwable 异常对象
     * @param log       记录日志类
     * @param errMsgNum 错误码
     * @param args      传递的参数
     */
    public static void processException(Throwable throwable, Log log, String errMsgNum, Object[] args) {
        if (log.isDebugEnabled()) {
            throwable.printStackTrace();
        }
        String displayMsg = getLocalizedMessage(errMsgNum, args);
        log.error(displayMsg);
        if (throwable instanceof ClientNotAwareException) {
            throw (ClientNotAwareException) throwable;
        }
        throw new ClientNotAwareException(throwable, log, errMsgNum, displayMsg);
    }

    /**
     * 统一对产品中的异常进行处理，适用于抛出的异常是RuntimeException类型的异常
     *
     * @param throwable 异常对象
     * @param log       记录日志类
     * @param errMsgNum 错误码
     */
    public static void processException(Throwable throwable, Log log, String errMsgNum) {
        processException(throwable, log, errMsgNum, null);
    }

    /**
     * 根据指定的错误编号和参数返回本地化的错误信息字符串
     *
     * @param errMsgNum 错误编号
     * @param args      参数
     * @return 本地化的错误信息字符串
     */
    private static String getLocalizedMessage(String errMsgNum, Object[] args) {
        String detailMsg = getBundleString(errMsgNum);
        if (detailMsg == null) {
            Object[] error = {bundleBaseNames, errMsgNum};
            logger.error(MessageFormat.format("Missing resource in {0} key = {1}", error));
            detailMsg = "#" + errMsgNum;
        }
        if (args != null)
            detailMsg = MessageFormat.format(detailMsg, args);
        return detailMsg;
    }

    /**
     * 在多个资源配置文件中找错误编号对应的详细信息
     *
     * @param errMsgNum 错误编号
     * @return 错误的详细解释
     */
    private static String getBundleString(String errMsgNum) {
        String detailMsg = null;
        for (ResourceBundle bundle : bundleList) {
            try {
                detailMsg = bundle.getString(errMsgNum);
                break;
            } catch (MissingResourceException missingresourceexception) {
                // 异常时什么也不需要做
            }
        }
        return detailMsg;
    }
}
