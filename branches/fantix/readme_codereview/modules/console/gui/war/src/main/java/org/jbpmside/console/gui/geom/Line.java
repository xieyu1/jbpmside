package org.jbpmside.console.gui.geom;


/**
 * 连接两点的线段.
 *
 * @author Lingo
 */
public class Line {
    /** 起点x. */
    private int x1;

    /** 起点y. */
    private int y1;

    /** 终点x. */
    private int x2;

    /** 终点y. */
    private int y2;

    /**
     * 构造方法.
     *
     * @param x1 x
     * @param y1 y
     * @param x2 x
     * @param y2 y
     */
    public Line(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    /**
     * 斜率.
     *
     * @return k
     */
    public double getK() {
        return ((double) y2 - y1) / (x2 - x1);
    }

    /**
     * y = kx + d.
     *
     * @return d
     */
    public double getD() {
        return y1 - (getK() * x1);
    }

    /**
     * 与指定线段是否平行.
     *
     * @param line Line
     * @return 是否平行
     */
    public boolean isParallel(Line line) {
        if ((x1 == x2) && (line.x1 == line.x2)) {
            return true;
        } else if ((x1 == x2) && (line.x1 != line.x2)) {
            return false;
        } else if ((x1 != x2) && (line.x1 == line.x2)) {
            return false;
        } else {
            return NumberUtils.isEquals(getK(), line.getK());
        }
    }

    /**
     * 于指定线段是否是同一条线.
     *
     * @param line Line
     * @return 是否是同一条直线
     */
    public boolean isSameLine(Line line) {
        if (isParallel(line)) {
            return NumberUtils.isEquals((x1 * line.getK()) + line.getD(),
                y1);
        } else {
            return false;
        }
    }

    /**
     * 指定的点是否在线段上.
     *
     * @param p Point
     * @return boolean
     */
    public boolean contains(Point p) {
        int s = ((x1 - x2) * (x1 - x2)) + ((y1 - y2) * (y1 - y2));
        int s1 = ((p.getX() - x1) * (p.getX() - x1))
            + ((p.getY() - y1) * (p.getY() - y1));
        int s2 = ((p.getX() - x2) * (p.getX() - x2))
            + ((p.getY() - y2) * (p.getY() - y2));

        return NumberUtils.isEquals(Math.sqrt(s1) + Math.sqrt(s2),
            Math.sqrt(s));
    }

    /**
     * 获得两条线段的交点.
     *
     * @param line Line
     * @return Point
     */
    public Point getCrossPoint(Line line) {
        if (isParallel(line)) {
            return null;
        }

        Point p = new Point(0, 0);

        if (x1 == x2) {
            p.setX(x1);
            p.setY((int) ((line.getK() * p.getX()) + line.getD()));
        } else if (line.x1 == line.x2) {
            p.setX(line.x1);
            p.setY((int) getD());
        } else {
            double k1 = getK();
            double k2 = line.getK();
            double d1 = getD();
            double d2 = line.getD();

            p.setX((int) ((d2 - d1) / (k1 - k2)));
            p.setY((int) ((k1 * p.getX()) + d1));
        }

        if (line.contains(p) && contains(p)) {
            return p;
        } else {
            return null;
        }
    }

    /** @return x1. */
    public int getX1() {
        return x1;
    }

    /** @param x1 int. */
    public void setX1(int x1) {
        this.x1 = x1;
    }

    /** @return y1. */
    public int getY1() {
        return y1;
    }

    /** @param y1 int. */
    public void setY1(int y1) {
        this.y1 = y1;
    }

    /** @return x2. */
    public int getX2() {
        return x2;
    }

    /** @param x2 int. */
    public void setX2(int x2) {
        this.x2 = x2;
    }

    /** @return y2. */
    public int getY2() {
        return y2;
    }

    /** @param y2 int. */
    public void setY2(int y2) {
        this.y2 = y2;
    }

    /** @return String. */
    public String toString() {
        return "Line[" + x1 + "," + y1 + "," + x2 + "," + y2 + "]";
    }
}
