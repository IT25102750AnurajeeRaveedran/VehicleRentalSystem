package com.rental.util;

import com.rental.model.Feedback;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackFileHandler {

    private static final String FILE_PATH =
            System.getProperty("user.home") + "/feedback.txt";

    public static List<Feedback> readAll() {
        List<Feedback> list = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return list;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    list.add(Feedback.fromFileString(line));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void writeAll(List<Feedback> list) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Feedback f : list) {
                writer.write(f.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // CREATE - Add feedback
    public static void addFeedback(Feedback feedback) {
        List<Feedback> list = readAll();
        list.add(feedback);
        writeAll(list);
    }

    // READ - Get all feedback
    public static List<Feedback> getAllFeedback() {
        return readAll();
    }

    // READ - Get feedback by user
    public static List<Feedback> getFeedbackByUser(String userId) {
        List<Feedback> result = new ArrayList<>();
        for (Feedback f : readAll()) {
            if (f.getUserId().equals(userId)) {
                result.add(f);
            }
        }
        return result;
    }

    // DELETE - Remove feedback
    public static void deleteFeedback(String feedbackId) {
        List<Feedback> list = readAll();
        list.removeIf(f -> f.getFeedbackId().equals(feedbackId));
        writeAll(list);
    }
}