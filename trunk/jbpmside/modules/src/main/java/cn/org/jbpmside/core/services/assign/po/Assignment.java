package cn.org.jbpmside.core.services.assign.po;

/**
 * Author: xinpeng
 * Date: 2008-10-24
 * Time: 11:07:42
 */
public class Assignment {


    private String currentUserId;       //当前用户userid
    private String assigneeId;
    private String assigneeName;
    private String businessId;


    public String getCurrentUserId() {
        return currentUserId;
    }

    public void setCurrentUserId(String currentUserId) {
        this.currentUserId = currentUserId;
    }

    public String getAssigneeId() {
        return assigneeId;
    }

    public void setAssigneeId(String assigneeId) {
        this.assigneeId = assigneeId;
    }

    public String getAssigneeName() {
        return assigneeName;
    }

    public void setAssigneeName(String assigneeName) {
        this.assigneeName = assigneeName;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }
}
