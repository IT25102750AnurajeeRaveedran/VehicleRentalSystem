package com.rental.model;

public class Booking {

    private String bookingId;
    private String userId;
    private String vehicleId;
    private String brand;
    private String model;
    private String startDate;
    private String endDate;
    private double totalPrice;
    private String status; // "active", "returned", "cancelled"

    public Booking(String bookingId, String userId, String vehicleId,
                   String brand, String model, String startDate,
                   String endDate, double totalPrice, String status) {
        this.bookingId  = bookingId;
        this.userId     = userId;
        this.vehicleId  = vehicleId;
        this.brand      = brand;
        this.model      = model;
        this.startDate  = startDate;
        this.endDate    = endDate;
        this.totalPrice = totalPrice;
        this.status     = status;
    }

    // Getters
    public String getBookingId()  { return bookingId; }
    public String getUserId()     { return userId; }
    public String getVehicleId()  { return vehicleId; }
    public String getBrand()      { return brand; }
    public String getModel()      { return model; }
    public String getStartDate()  { return startDate; }
    public String getEndDate()    { return endDate; }
    public double getTotalPrice() { return totalPrice; }
    public String getStatus()     { return status; }

    // Setters
    public void setBookingId(String bookingId)   { this.bookingId = bookingId; }
    public void setUserId(String userId)         { this.userId = userId; }
    public void setVehicleId(String vehicleId)   { this.vehicleId = vehicleId; }
    public void setBrand(String brand)           { this.brand = brand; }
    public void setModel(String model)           { this.model = model; }
    public void setStartDate(String startDate)   { this.startDate = startDate; }
    public void setEndDate(String endDate)       { this.endDate = endDate; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public void setStatus(String status)         { this.status = status; }

    public String toFileString() {
        return bookingId + "," + userId + "," + vehicleId + "," +
                brand + "," + model + "," + startDate + "," +
                endDate + "," + totalPrice + "," + status;
    }

    public static Booking fromFileString(String line) {
        String[] p = line.split(",");
        return new Booking(p[0], p[1], p[2], p[3], p[4],
                p[5], p[6], Double.parseDouble(p[7]), p[8]);
    }
}