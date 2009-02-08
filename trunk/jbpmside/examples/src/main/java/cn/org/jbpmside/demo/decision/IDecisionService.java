package cn.org.jbpmside.demo.decision;

/**
 * 决策接口
 * User: yuchen
 * Date: 2008-11-30
 * Time: 12:01:54
 */
public interface IDecisionService {
    /**
     * JBPM,东方易维，demo，报销，决策,部门审批
     */
    public static final String JBPM_EWAY_DEMO_DECISION_EXPENSE_DEPARTMENT = "小于等于1000";
    /**
     * JBPM,东方易维，demo，报销，决策,高级部门审批
     */
    public static final String JBPM_EWAY_DEMO_DECISION_EXPENSE_SUPER_DEPARTMENT = "大于1000";
}
