package com.rental.model;

public class Feedback {

    private String feedbackId;
    private String userId;
    private String userName;
    private String vehicleId;
    private String comment;
    private int rating; // 1 to 5
    private String date;

    public Feedback(String feedbackId, String userId, String userName,
                    String vehicleId, String comment, int rating, String date) {
        this.feedbackId = feedbackId;
        this.userId     = userId;
        this.userName   = userName;
        this.vehicleId  = vehicleId;
        this.comment    = comment;
        this.rating     = rating;
        this.date       = date;
    }

    // Getters
    public String getFeedbackId() { return feedbackId; }
    public String getUserId()     { return userId; }
    public String getUserName()   { return userName; }
    public String getVehicleId()  { return vehicleId; }
    public String getComment()    { return comment; }
    public int getRating()        { return rating; }
    public String getDate()       { return date; }

    // Setters
    public void setFeedbackId(String feedbackId) { this.feedbackId = feedbackId; }
    public void setUserId(String userId)         { this.userId = userId; }
    public void setUserName(String userName)     { this.userName = userName; }
    public void setVehicleId(String vehicleId)   { this.vehicleId = vehicleId; }
    public void setComment(String comment)       { this.comment = comment; }
    public void setRating(int rating)            { this.rating = rating; }
    public void setDate(String date)             { this.date = date; }

    public String toFileString() {
        return feedbackId + "," + userId + "," + userName + "," +
                vehicleId + "," + comment.replace(",", ";") + "," +
                rating + "," + date;
    }

    public static Feedback fromFileString(String line) {
        String[] p = line.split(",");
        return new Feedback(p[0], p[1], p[2], p[3],
                p[4].replace(";", ","),
                Integer.parseInt(p[5]), p[6]);
    }
}