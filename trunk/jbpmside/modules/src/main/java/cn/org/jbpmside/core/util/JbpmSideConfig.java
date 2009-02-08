package cn.org.jbpmside.core.util;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;

import java.io.File;
import java.util.Iterator;
import java.util.Properties;

/**
 * jbpmside的系统配置文件读取类
 * Author: xinpeng
 * Date: 2009-1-19
 * Time: 10:59:52
 * To change this template use File | Settings | File Templates.
 */
public class JbpmSideConfig {

    private static Configuration config = null;

    static {
        try {
            String filePath = System.getProperty("JBPMSIDE_HOME");

            if (filePath == null) {
                System.out.println("没有指定环境变量JBPMSIDE_HOME。");
            } else {
                config = new PropertiesConfiguration(filePath + File.separator + "config.properties");
            }
        } catch (Exception e) {
            System.out.println("没有发现配置文件。");
            e.printStackTrace();
        }
    }

    public static boolean isEmpty() {
        return config.isEmpty();
    }

    public static boolean containsKey(String key) {
        return config.containsKey(key);
    }

    public static void addProperty(String key, Object value) {
        config.addProperty(key, value);
    }

    public static void setProperty(String key, Object value) {
        config.setProperty(key, value);
    }

    public static void clearProperty(String key) {
        config.clearProperty(key);
    }

    public static Object getProperty(String key) {
        return config.getProperties(key);
    }

    public static Iterator getKeys(String key) {
        return config.getKeys(key);
    }

    public static Iterator getKeys() {
        return config.getKeys();
    }

    public static Properties getProperties(String key) {
        return config.getProperties(key);
    }

    public static boolean getBoolean(String key) {
        return config.getBoolean(key);
    }

    public static boolean getBoolean(String key, boolean defaultValue) {
        return config.getBoolean(key, defaultValue);
    }

    public static Boolean getBoolean(String key, Boolean defaultValue) {
        return config.getBoolean(key, defaultValue);
    }

    public static byte getByte(String key) {
        return config.getByte(key);
    }

    public static byte getByte(String key, byte defaultValue) {
        return config.getByte(key, defaultValue);
    }

    public static Byte getByte(String key, Byte defaultValue) {
        return config.getByte(key, defaultValue);
    }

    public static double getDouble(String key) {
        return config.getDouble(key);
    }

    public static double getDouble(String key, double defaultValue) {
        return config.getDouble(key, defaultValue);
    }

    public static Double getDouble(String key, Double defaultValue) {
        return config.getDouble(key, defaultValue);
    }

    public static float getFloat(String key) {
        return config.getFloat(key);
    }

    public static float getFloat(String key, float defaultValue) {
        return config.getFloat(key, defaultValue);
    }

    public static Float getFloat(String key, Float defaultValue) {
        return config.getFloat(key, defaultValue);
    }

    public int getInt(String key) {
        return config.getInt(key);
    }

    public static int getInt(String key, int defaultValue) {
        return config.getInt(key, defaultValue);
    }

    public static Integer getInteger(String key, Integer defaultValue) {
        return config.getInteger(key, defaultValue);
    }

    public static long getLong(String key) {
        return config.getLong(key);
    }

    public static long getLong(String key, long defaultValue) {
        return config.getLong(key, defaultValue);
    }

    public static Long getLong(String key, Long defaultValue) {
        return config.getLong(key, defaultValue);
    }

    public static short getShort(String key) {
        return config.getShort(key);
    }

    public static short getShort(String key, short defaultValue) {
        return config.getShort(key, defaultValue);
    }

    public static Short getShort(String key, Short defaultValue) {
        return config.getShort(key, defaultValue);
    }

    public static String getString(String key) {
        return config.getString(key);
    }

    public static String getString(String key, String defaultValue) {
        return config.getString(key, defaultValue);
    }

    public static String[] getStringArray(String key) {
        return config.getStringArray(key);
    }

    public static Configuration subset(String prefix) {
        return config.subset(prefix);
    }
}
