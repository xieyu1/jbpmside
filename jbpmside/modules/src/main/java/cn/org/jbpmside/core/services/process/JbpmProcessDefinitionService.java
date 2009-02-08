package cn.org.jbpmside.core.services.process;

import org.jbpm.graph.def.ProcessDefinition;

import java.util.List;

import cn.org.jbpmside.core.util.page.Page;

/**
 * 流程定义服务
 * User: xinpeng
 * Date: 2008-10-20
 * Time: 22:09:42
 */
public interface JbpmProcessDefinitionService {
    /**
     * 获取所有版本最新的流程定义列表
     *
     * @return 流程定义的集合
     */
    List<ProcessDefinition> getAllLatestProcessDefinitionLists(Page page);

    /**
     * 根据page获取版本最新的流程定义列表
     *
     * @param page 分页
     * @return 流程定义的集合
     */
    List<ProcessDefinition> getLatestProcessDefinitionListsByPage(Page page);

}
