package org.jbpmside.console.gui.geom;


/**
 * 矩形.
 *
 * @author Lingo
 */
public class Rect {
    /** x. */
    private int x;

    /** y. */
    private int y;

    /** w. */
    private int w;

    /** h. */
    private int h;

    /** default constructor. */
    public Rect() {
    }

    /**
     * constructor.
     *
     * @param x int
     * @param y int
     * @param w int
     * @param h int
     */
    public Rect(int x, int y, int w, int h) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }

    /**
     * 矩形与线段的交点.
     *
     * @param line Line
     * @return Point
     */
    public Point getCrossPoint(Line line) {
        Point p = null;
        Line top = new Line(x, y, x + w, y);
        p = top.getCrossPoint(line);

        if (p != null) {
            return p;
        }

        Line bottom = new Line(x, y + h, x + w, y + h);

        p = bottom.getCrossPoint(line);

        if (p != null) {
            return p;
        }

        Line left = new Line(x, y, x, y + h);
        p = left.getCrossPoint(line);

        if (p != null) {
            return p;
        }

        Line right = new Line(x + w, y, x + w, y + h);
        p = right.getCrossPoint(line);

        return p;
    }

    /**
     * 与另一个矩形的交线.
     *
     * @param rect Rect
     * @return Line
     */
    public Line getCrossLine(Rect rect) {
        Line line = new Line(this.getCenterX(), this.getCenterY(),
                rect.getCenterX(), rect.getCenterY());

        Point from = getCrossPoint(line);

        Point to = rect.getCrossPoint(line);

        return new Line(from.getX(), from.getY(), to.getX(), to.getY());
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

    /** @return w. */
    public int getW() {
        return w;
    }

    /** @param w int. */
    public void setW(int w) {
        this.w = w;
    }

    /** @return h. */
    public int getH() {
        return h;
    }

    /** @param h int. */
    public void setH(int h) {
        this.h = h;
    }

    /** @return center x. */
    public int getCenterX() {
        return x + (w / 2);
    }

    /** @return center y. */
    public int getCenterY() {
        return y + (h / 2);
    }

    /** @return String. */
    public String toString() {
        return "Rect[" + x + "," + y + "," + w + "," + h + "]";
    }
}
