package org.jbpmside.console.gui.geom;


/**
 * 数字工具类.
 *
 * @author Lingo
 */
public class NumberUtils {
    /** 足够小的数字. */
    public static final double SMALLIST_NUM = 0.1;

    /** protected constructor. */
    protected NumberUtils() {
    }

    /**
     * 判断两个doulbe是否在足够小的范围内相同.
     *
     * @param n1 double
     * @param n2 double
     * @return boolean
     */
    public static boolean isEquals(double n1, double n2) {
        return Math.abs(n1 - n2) < SMALLIST_NUM;
    }
}
