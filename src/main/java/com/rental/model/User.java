package com.rental.model;

public class User {

    private String userId;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String role; // "user" or "admin"

    public User(String userId, String fullName, String email,
                String password, String phone, String role) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = role;
    }

    // Getters
    public String getUserId()   { return userId; }
    public String getFullName() { return fullName; }
    public String getEmail()    { return email; }
    public String getPassword() { return password; }
    public String getPhone()    { return phone; }
    public String getRole()     { return role; }

    // Setters
    public void setUserId(String userId)     { this.userId = userId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setEmail(String email)       { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setPhone(String phone)       { this.phone = phone; }
    public void setRole(String role)         { this.role = role; }

    // Save to file as one line
    public String toFileString() {
        return userId + "," + fullName + "," + email + ","
                + password + "," + phone + "," + role;
    }

    // Read from file line
    public static User fromFileString(String line) {
        String[] parts = line.split(",");
        return new User(parts[0], parts[1], parts[2],
                parts[3], parts[4], parts[5]);
    }
}