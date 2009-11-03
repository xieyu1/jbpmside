package org.jbpmside.console.gui.geom;


/**
 * 点.
 *
 * @author Lingo
 */
public class Point {
    /** x. */
    private int x;

    /** y. */
    private int y;

    /**
     * constructor.
     *
     * @param x int
     * @param y int
     */
    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    /** @return x. */
    public int getX() {
        return x;
    }

    /** @param x int. */
    public void setX(int x) {
        this.x = x;
    }

    /** @return y. */
    public int getY() {
        return y;
    }

    /** @param y int. */
    public void setY(int y) {
        this.y = y;
    }

    /** @return String. */
    public String toString() {
        return "Point[" + x + "," + y + "]";
    }
}
