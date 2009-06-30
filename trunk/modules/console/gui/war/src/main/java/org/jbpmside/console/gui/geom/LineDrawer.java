package org.jbpmside.console.gui.geom;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Polygon;
import java.awt.RenderingHints;
import java.awt.geom.Line2D;


/**
 * The Line draw program draws a line with an arrowhead pointing to the direction of the line.
 *
 * @author Naveen thankappan
 */
public class LineDrawer {
    /** default head size. */
    public static final int DEFAULT_HEAD_SIZE = 6;

    /** default difference. */
    public static final int DEFAULT_DEFFERENCE = 0;

    /** default factor. */
    public static final double DEFAULT_FACTOR = 0.5;

    /** default color. */
    public static final Color DEFAULT_COLOR = Color.decode("#909090");

    /** x1. */
    private int startx;

    /** y1. */
    private int starty;

    /** x2. */
    private int x;

    /** y2. */
    private int y;

    /**
     * constructor.
     *
     * @param startx Storing the start x coordinate of the line
     * @param starty Storing the start y coordinate of the line
     * @param endx Storing the end x coordinate of the line
     * @param endy Storing the end y coordinate of the line
     */
    public LineDrawer(int startx, int starty, int endx, int endy) {
        this.startx = startx;
        this.starty = starty;
        x = endx;
        y = endy;
    }

    /**
     * draw.
     *
     * @param g2 graphics
     * @param stroke float
     */
    public void draw(Graphics2D g2, float stroke) {
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
            RenderingHints.VALUE_ANTIALIAS_ON);

        g2.setStroke(new BasicStroke(stroke));

        g2.draw(new Line2D.Double(startx, starty, x, y));

        // g.setColor(Color.gray);
        g2.setPaint(DEFAULT_COLOR);

        // g2.setColor(Color.black);
        drawArrow(g2, startx, starty, x, y);
    }

    /**
     * Drawing the arrow.
     *
     * @param g2 Graphics
     * @param x1 int
     * @param y1 int
     * @param x2 int
     * @param y2 int
     */
    public void drawArrow(Graphics2D g2, int x1, int y1, int x2, int y2) {
        //startx,starty,endx,endy,headsize,difference,factor
        g2.drawPolygon(getArrow(x1, y1, x2, y2, DEFAULT_HEAD_SIZE,
                DEFAULT_DEFFERENCE, DEFAULT_FACTOR));

        g2.fillPolygon(getArrow(x1, y1, x2, y2, DEFAULT_HEAD_SIZE,
                DEFAULT_DEFFERENCE, DEFAULT_FACTOR));
    }

    /**
     * get the arrow.
     *
     * @param x1 int
     * @param y1 int
     * @param x2 int
     * @param y2 int
     * @param headsize int
     * @param difference int
     * @param factor double
     * @return Polygon
     */
    public Polygon getArrow(int x1, int y1, int x2, int y2, int headsize,
        int difference, double factor) {
        int[] crosslinebase = getArrowHeadLine(x1, y1, x2, y2, headsize);

        int[] headbase = getArrowHeadLine(x1, y1, x2, y2,
                headsize - difference);

        int[] crossline = getArrowHeadCrossLine(crosslinebase[0],
                crosslinebase[1], x2, y2, factor);

        Polygon head = new Polygon();

        head.addPoint(headbase[0], headbase[1]);

        head.addPoint(crossline[0], crossline[1]);

        head.addPoint(x2, y2);

        head.addPoint(crossline[2], crossline[3]);

        head.addPoint(headbase[0], headbase[1]);

        head.addPoint(x1, y1);

        return head;
    }

    /**
     * get arrow head line.
     *
     * @param xsource x1
     * @param ysource y1
     * @param xdest x2
     * @param ydest y2
     * @param distance int
     * @return int[]
     */
    public int[] getArrowHeadLine(int xsource, int ysource, int xdest,
        int ydest, int distance) {
        int[] arrowhead = new int[2];

        int headsize = distance;

        double stretchfactor = 0;

        stretchfactor = 1
            - (headsize / (Math.sqrt(((xdest - xsource) * (xdest - xsource))
                + ((ydest - ysource) * (ydest - ysource)))));

        arrowhead[0] = (int) (stretchfactor * (xdest - xsource)) + xsource;

        arrowhead[1] = (int) (stretchfactor * (ydest - ysource)) + ysource;

        return arrowhead;
    }

    /**
     * get arrow head cross line.
     *
     * @param x1 int
     * @param x2 int
     * @param b1 int
     * @param b2 int
     * @param factor double
     * @return int[]
     */
    public int[] getArrowHeadCrossLine(int x1, int x2, int b1, int b2,
        double factor) {
        int[] crossline = new int[4];

        int xdest = (int) (((b1 - x1) * factor) + x1);

        int ydest = (int) (((b2 - x2) * factor) + x2);

        crossline[0] = (int) (((x1 + x2) - ydest));

        crossline[1] = (int) (((x2 + xdest) - x1));

        crossline[2] = crossline[0] + ((x1 - crossline[0]) * 2);

        crossline[3] = crossline[1] + ((x2 - crossline[1]) * 2);

        return crossline;
    }
}
