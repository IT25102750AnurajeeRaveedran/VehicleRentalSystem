package com.rental.servlet;

import com.rental.model.ChatMessage;
import com.rental.model.User;
import com.rental.util.ChatFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp?error=notloggedin");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        // Get messages for this user
        List<ChatMessage> messages = ChatFileHandler.getMessagesByUser(user.getUserId());

        request.setAttribute("messages", messages);
        request.setAttribute("user", user);

        request.getRequestDispatcher("/chat.jsp")
                .forward(request, response);
    }
}