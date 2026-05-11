package com.rental.servlet;

import com.rental.model.User;
import com.rental.util.UserFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedUser = (User) session.getAttribute("loggedUser");

        // Delete user from file
        List<User> users = UserFileHandler.readAll();
        users.removeIf(u -> u.getEmail().equalsIgnoreCase(loggedUser.getEmail()));
        UserFileHandler.writeAll(users);

        // Destroy session
        session.invalidate();

        response.sendRedirect("login.jsp?msg=deleted");
    }
}