package com.rental.model;

public class Vehicle {

    private String vehicleId;
    private String brand;
    private String model;
    private String type;
    private double pricePerDay;
    private boolean available;

    public Vehicle(String vehicleId, String brand, String model,
                   String type, double pricePerDay, boolean available) {
        this.vehicleId = vehicleId;
        this.brand = brand;
        this.model = model;
        this.type = type;
        this.pricePerDay = pricePerDay;
        this.available = available;
    }

    public String getVehicleId()   { return vehicleId; }
    public String getBrand()       { return brand; }
    public String getModel()       { return model; }
    public String getType()        { return type; }
    public double getPricePerDay() { return pricePerDay; }
    public boolean isAvailable()   { return available; }

    public void setVehicleId(String vehicleId)     { this.vehicleId = vehicleId; }
    public void setBrand(String brand)             { this.brand = brand; }
    public void setModel(String model)             { this.model = model; }
    public void setType(String type)               { this.type = type; }
    public void setPricePerDay(double pricePerDay) { this.pricePerDay = pricePerDay; }
    public void setAvailable(boolean available)    { this.available = available; }

    public String toFileString() {
        return vehicleId + "," + brand + "," + model + "," +
                type + "," + pricePerDay + "," + available;
    }

    public static Vehicle fromFileString(String line) {
        String[] parts = line.split(",");
        return new Vehicle(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                Double.parseDouble(parts[4]),
                Boolean.parseBoolean(parts[5])
        );
    }
}