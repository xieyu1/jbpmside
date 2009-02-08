package cn.org.jbpmside.core.listener;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.ArrayList;
import java.util.List;

import com.opensymphony.xwork.config.providers.ResourceFinder;
import com.opensymphony.xwork.config.providers.XmlConfigurationProvider;
import com.opensymphony.xwork.config.ConfigurationProvider;
import com.opensymphony.xwork.config.ConfigurationManager;

/**
 * description: 对webwork的所有的配置文件的读取监听
 * author: yuchen
 * date: 2009-01-14
 * time: 21:39:17
 */
public class XworkXmlConfigurationProviderListener implements ServletContextListener {

    private static Log log = LogFactory.getLog(XworkXmlConfigurationProviderListener.class);

    /**
     * 发布流程定义初始化
     * @param servletContextEvent 从接口实现，详见ServletContextListener
     */
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        log.info("beginning to load xwork config file......");
                List<String> xworkConfigFileList = new ArrayList<String>();
                String[] fileList = ResourceFinder.getXwork();
                for (int i = 0, len = fileList.length; i < len; i++) {
                    xworkConfigFileList.add(fileList[i]);
                }
                ConfigurationProvider configurationProvider = new XmlConfigurationProvider(xworkConfigFileList);
                ConfigurationManager.addConfigurationProvider(configurationProvider);
                log.info("all the xwork config file has been loaded successfully!");
    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }
}