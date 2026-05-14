package com.rental.util;

import java.io.File;
import java.net.URISyntaxException;
import java.nio.file.Path;
import java.nio.file.Paths;

public final class DbFileUtil {

    // DB_DIR is resolved at runtime to the project root's db_txt folder when possible.
    private static File DB_DIR;

    static {
        DB_DIR = new File(findProjectRoot(), "db_txt");
        ensureDirectory();
    }

    private DbFileUtil() {
    }

    public static String getPath(String fileName) {
        ensureDirectory();
        return new File(DB_DIR, fileName).getPath();
    }

    private static void ensureDirectory() {
        if (!DB_DIR.exists() && !DB_DIR.mkdirs()) {
            throw new IllegalStateException("Unable to create database directory: " + DB_DIR.getAbsolutePath());
        }
    }

    /**
     * Attempt to locate the project root by walking up from the class code location
     * until a directory containing pom.xml is found. Falls back to user.dir when
     * project root cannot be determined.
     */
    private static File findProjectRoot() {
        try {
            Path codePath = Paths.get(DbFileUtil.class.getProtectionDomain().getCodeSource().getLocation().toURI());
            File current = codePath.toFile();
            if (current.isFile()) {
                current = current.getParentFile();
            }

            int maxDepth = 10;
            int depth = 0;
            while (current != null && depth++ < maxDepth) {
                File pom = new File(current, "pom.xml");
                if (pom.exists()) {
                    return current;
                }
                current = current.getParentFile();
            }
        } catch (URISyntaxException e) {
            // ignore and fall back
        }
        // fallback to user.dir
        return new File(System.getProperty("user.dir"));
    }
}

