package com.rental.util;

import com.rental.model.Vehicle;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleFileHandler {

    private static final String FILE_PATH =
            System.getProperty("user.home") + "/vehicles.txt";

    public static List<Vehicle> readAll() {
        List<Vehicle> vehicles = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return vehicles;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    vehicles.add(Vehicle.fromFileString(line));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    public static void writeAll(List<Vehicle> vehicles) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Vehicle v : vehicles) {
                writer.write(v.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void addVehicle(Vehicle vehicle) {
        List<Vehicle> vehicles = readAll();
        vehicles.add(vehicle);
        writeAll(vehicles);
    }

    public static void updateVehicle(Vehicle updated) {
        List<Vehicle> vehicles = readAll();
        for (int i = 0; i < vehicles.size(); i++) {
            if (vehicles.get(i).getVehicleId().equals(updated.getVehicleId())) {
                vehicles.set(i, updated);
                break;
            }
        }
        writeAll(vehicles);
    }

    public static void deleteVehicle(String vehicleId) {
        List<Vehicle> vehicles = readAll();
        vehicles.removeIf(v -> v.getVehicleId().equals(vehicleId));
        writeAll(vehicles);
    }
}