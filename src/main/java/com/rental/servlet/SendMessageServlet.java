package com.rental.servlet;

import com.rental.model.ChatMessage;
import com.rental.model.User;
import com.rental.util.ChatFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user    = (User) session.getAttribute("loggedUser");
        String message = request.getParameter("message");
        String type    = request.getParameter("type"); // "user" or "admin"

        if (message == null || message.trim().isEmpty()) {
            response.sendRedirect("chat");
            return;
        }

        String messageId = "M" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();
        String dateTime  = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

        // For admin replies, get the target userId
        String targetUserId = request.getParameter("targetUserId");
        String userId = (targetUserId != null && !targetUserId.isEmpty())
                ? targetUserId : user.getUserId();

        ChatMessage chatMessage = new ChatMessage(
                messageId, userId, user.getFullName(),
                message.trim(), dateTime,
                type != null ? type : "user"
        );

        ChatFileHandler.addMessage(chatMessage);

        // Redirect based on role
        if ("admin".equals(user.getRole())) {
            response.sendRedirect("adminChat?userId=" + userId);
        } else {
            response.sendRedirect("chat");
        }
    }
}