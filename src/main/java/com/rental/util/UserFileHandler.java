package com.rental.util;

import com.rental.model.User;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserFileHandler {

    private static final String FILE_PATH =
            System.getProperty("user.home") + "/users.txt";

    public static List<User> readAll() {
        List<User> users = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return users;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    users.add(User.fromFileString(line));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    public static void writeAll(List<User> users) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User u : users) {
                writer.write(u.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // CREATE - Register new user
    public static boolean registerUser(User user) {
        List<User> users = readAll();
        // Check if email already exists
        for (User u : users) {
            if (u.getEmail().equalsIgnoreCase(user.getEmail())) {
                return false; // Email already registered
            }
        }
        users.add(user);
        writeAll(users);
        return true;
    }

    // READ - Login user
    public static User loginUser(String email, String password) {
        List<User> users = readAll();
        for (User u : users) {
            if (u.getEmail().equalsIgnoreCase(email)
                    && u.getPassword().equals(password)) {
                return u;
            }
        }
        return null;
    }

    // READ - Find by email
    public static User findByEmail(String email) {
        List<User> users = readAll();
        for (User u : users) {
            if (u.getEmail().equalsIgnoreCase(email)) {
                return u;
            }
        }
        return null;
    }

    // UPDATE - Reset password
    public static boolean resetPassword(String email, String newPassword) {
        List<User> users = readAll();
        for (User u : users) {
            if (u.getEmail().equalsIgnoreCase(email)) {
                u.setPassword(newPassword);
                writeAll(users);
                return true;
            }
        }
        return false;
    }
}