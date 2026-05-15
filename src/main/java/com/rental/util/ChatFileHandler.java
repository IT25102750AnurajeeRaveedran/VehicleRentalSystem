package com.rental.util;

import com.rental.model.ChatMessage;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ChatFileHandler {

    private static final String FILE_PATH =
            System.getProperty("user.home") + "/chat.txt";

    public static List<ChatMessage> readAll() {
        List<ChatMessage> messages = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return messages;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    messages.add(ChatMessage.fromFileString(line));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return messages;
    }

    public static void writeAll(List<ChatMessage> messages) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (ChatMessage m : messages) {
                writer.write(m.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // CREATE - Add new message
    public static void addMessage(ChatMessage message) {
        List<ChatMessage> messages = readAll();
        messages.add(message);
        writeAll(messages);
    }

    // READ - Get messages by user
    public static List<ChatMessage> getMessagesByUser(String userId) {
        List<ChatMessage> result = new ArrayList<>();
        for (ChatMessage m : readAll()) {
            if (m.getUserId().equals(userId) ||
                    ("admin".equals(m.getType()) && m.getUserId().equals(userId))) {
                result.add(m);
            }
        }
        return result;
    }

    // READ - Get all messages for admin
    public static List<ChatMessage> getAllMessages() {
        return readAll();
    }

    // READ - Get unique user IDs who chatted
    public static List<String> getChatUserIds() {
        List<String> userIds = new ArrayList<>();
        for (ChatMessage m : readAll()) {
            if (!userIds.contains(m.getUserId()) && !"admin".equals(m.getType())) {
                userIds.add(m.getUserId());
            }
        }
        return userIds;
    }

    // DELETE - Clear chat for a user
    public static void clearChat(String userId) {
        List<ChatMessage> messages = readAll();
        messages.removeIf(m -> m.getUserId().equals(userId));
        writeAll(messages);
    }
}