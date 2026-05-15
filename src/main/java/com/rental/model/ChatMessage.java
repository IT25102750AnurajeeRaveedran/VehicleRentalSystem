package com.rental.model;

public class ChatMessage {

    private String messageId;
    private String userId;
    private String userName;
    private String message;
    private String dateTime;
    private String type; // "user" or "admin"

    public ChatMessage(String messageId, String userId, String userName,
                       String message, String dateTime, String type) {
        this.messageId = messageId;
        this.userId    = userId;
        this.userName  = userName;
        this.message   = message;
        this.dateTime  = dateTime;
        this.type      = type;
    }

    // Getters
    public String getMessageId() { return messageId; }
    public String getUserId()    { return userId; }
    public String getUserName()  { return userName; }
    public String getMessage()   { return message; }
    public String getDateTime()  { return dateTime; }
    public String getType()      { return type; }

    // Setters
    public void setMessageId(String messageId) { this.messageId = messageId; }
    public void setUserId(String userId)       { this.userId = userId; }
    public void setUserName(String userName)   { this.userName = userName; }
    public void setMessage(String message)     { this.message = message; }
    public void setDateTime(String dateTime)   { this.dateTime = dateTime; }
    public void setType(String type)           { this.type = type; }

    public String toFileString() {
        return messageId + "," + userId + "," + userName + "," +
                message.replace(",", ";") + "," + dateTime + "," + type;
    }

    public static ChatMessage fromFileString(String line) {
        String[] p = line.split(",");
        return new ChatMessage(
                p[0], p[1], p[2],
                p[3].replace(";", ","),
                p[4], p[5]
        );
    }
}