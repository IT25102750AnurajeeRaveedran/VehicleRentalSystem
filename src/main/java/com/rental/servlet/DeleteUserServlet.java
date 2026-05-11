package com.rental.servlet;

import com.rental.model.User;
import com.rental.util.UserFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

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

        String userId = request.getParameter("userId");

        // Don't allow admin to delete themselves
        if (userId.equals(admin.getUserId())) {
            response.sendRedirect("manageUsers?error=selfdelete");
            return;
        }

        List<User> users = UserFileHandler.readAll();
        users.removeIf(u -> u.getUserId().equals(userId));
        UserFileHandler.writeAll(users);

        response.sendRedirect("manageUsers?msg=deleted");
    }
}