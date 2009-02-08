package cn.org.jbpmside.core.services.process;

/**
 * 流程定义发布
 * User: yuchen
 * Date: 2008-11-25
 * Time: 16:52:38
 */
public interface IDeployJbpmProcessService {
    /**
     * 发布所有流程  版本号都加1
     */
    void deployAll();

    /**
     * 发布指定流程名称的流程  该流程name的版本号加1
     * @param name
     */
    void deployByname(String name);
}
