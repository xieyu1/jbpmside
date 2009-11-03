package org.jbpmside.console.gui.bean;

import java.util.ArrayList;
import java.util.List;

import org.jbpmside.console.gui.geom.Rect;


/**
 * 流程节点.
 *
 * @author Lingo
 */
public class NodeBean extends Rect {
    /** type. */
    private String type;

    /** name. */
    private String name;

    /** transitions. */
    private List<TransitionBean> transitions = new ArrayList<TransitionBean>();

    /** @return type. */
    public String getType() {
        return type;
    }

    /** @param type String. */
    public void setType(String type) {
        this.type = type;
    }

    /** @return name. */
    public String getName() {
        return name;
    }

    /** @param name String. */
    public void setName(String name) {
        this.name = name;
    }

    /** @return transitions. */
    public List<TransitionBean> getTransitions() {
        return transitions;
    }

    /**
     * 为节点添加一个转移.
     *
     * @param transitionName String
     * @param to String
     */
    public void addTransition(String transitionName, String to) {
        transitions.add(new TransitionBean(transitionName, to));
    }

    /**
     * 获得节点对应的图片路径.
     *
     * @return String
     */
    public String getPicName() {
        if (type.equals("start")) {
            return "/icons/48/start_event_empty.png";
        } else if (type.equals("end")) {
            return "/icons/48/end_event_terminate.png";
        } else if (type.equals("decision")) {
            return "/icons/48/gateway_exclusive.png";
        }

        return null;
    }

    /** @return String. */
    public String toString() {
        return transitions.toString();
    }
}
