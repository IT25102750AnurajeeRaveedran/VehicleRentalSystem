package com.rental.util;

import com.rental.model.Booking;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingFileHandler {

    private static final String FILE_PATH =
            System.getProperty("user.home") + "/bookings.txt";

    public static List<Booking> readAll() {
        List<Booking> bookings = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return bookings;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    bookings.add(Booking.fromFileString(line));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public static void writeAll(List<Booking> bookings) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Booking b : bookings) {
                writer.write(b.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // CREATE - Add new booking
    public static void addBooking(Booking booking) {
        List<Booking> bookings = readAll();
        bookings.add(booking);
        writeAll(bookings);
    }

    // READ - Get bookings by user ID
    public static List<Booking> getBookingsByUser(String userId) {
        List<Booking> result = new ArrayList<>();
        for (Booking b : readAll()) {
            if (b.getUserId().equals(userId)) {
                result.add(b);
            }
        }
        return result;
    }

    // READ - Get all bookings
    public static List<Booking> getAllBookings() {
        return readAll();
    }

    // UPDATE - Update booking status
    public static void updateStatus(String bookingId, String status) {
        List<Booking> bookings = readAll();
        for (Booking b : bookings) {
            if (b.getBookingId().equals(bookingId)) {
                b.setStatus(status);
                break;
            }
        }
        writeAll(bookings);
    }

    // DELETE - Cancel booking
    public static void deleteBooking(String bookingId) {
        List<Booking> bookings = readAll();
        bookings.removeIf(b -> b.getBookingId().equals(bookingId));
        writeAll(bookings);
    }
}