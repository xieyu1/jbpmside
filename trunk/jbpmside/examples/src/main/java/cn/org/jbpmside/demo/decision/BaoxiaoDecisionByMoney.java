package cn.org.jbpmside.demo.decision;

import org.jbpm.graph.node.DecisionHandler;
import org.jbpm.graph.exe.ExecutionContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import cn.org.jbpmside.demo.variable.IVariableService;


/**
 * 报销决策
 * User: yuchen
 * Date: 2008-11-30
 * Time: 10:30:22
 */
public class BaoxiaoDecisionByMoney implements DecisionHandler {
    private static final Log log = LogFactory.getLog(BaoxiaoDecisionByMoney.class);

    /**
     *
     * @param executionContext    执行上下文
     * @return
     */
    public String decide(ExecutionContext executionContext) {
        String strMoney = (String) executionContext.getContextInstance().getVariable(IVariableService.JBPM_EWAY_DEMO_VARIABLE_EXPENSE_MONEY);
        int money = 0;
        try {
            money = Integer.parseInt(strMoney);
        }catch (Exception e) {
            e.printStackTrace();
            log.error(e.getMessage());
        }
        if (money > 1000)
            return IDecisionService.JBPM_EWAY_DEMO_DECISION_EXPENSE_SUPER_DEPARTMENT;     //高级部门审批
        else
            return IDecisionService.JBPM_EWAY_DEMO_DECISION_EXPENSE_DEPARTMENT;      //部门审批
    }   
}