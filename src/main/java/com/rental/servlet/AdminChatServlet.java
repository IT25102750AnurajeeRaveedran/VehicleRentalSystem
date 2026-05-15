package com.rental.servlet;

import com.rental.model.ChatMessage;
import com.rental.model.User;
import com.rental.util.ChatFileHandler;
import com.rental.util.UserFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/adminChat")
public class AdminChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User admin = (User) session.getAttribute("loggedUser");
        if (!admin.getRole().equals("admin")) {
            response.sendRedirect("vehicles");
            return;
        }

        // Get all unique users who chatted
        List<String> chatUserIds = ChatFileHandler.getChatUserIds();
        List<User> chatUsers = new ArrayList<>();
        for (String uid : chatUserIds) {
            List<User> allUsers = UserFileHandler.readAll();
            for (User u : allUsers) {
                if (u.getUserId().equals(uid)) {
                    chatUsers.add(u);
                    break;
                }
            }
        }

        // Get messages for selected user
        String selectedUserId = request.getParameter("userId");
        List<ChatMessage> messages = new ArrayList<>();
        if (selectedUserId != null && !selectedUserId.isEmpty()) {
            messages = ChatFileHandler.getMessagesByUser(selectedUserId);
        }

        request.setAttribute("chatUsers",      chatUsers);
        request.setAttribute("messages",       messages);
        request.setAttribute("selectedUserId", selectedUserId);
        request.setAttribute("adminUser",      admin);

        request.getRequestDispatcher("/adminChat.jsp")
                .forward(request, response);
    }
}