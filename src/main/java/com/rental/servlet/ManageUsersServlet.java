package com.rental.servlet;

import com.rental.model.User;
import com.rental.util.UserFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageUsers")
public class ManageUsersServlet extends HttpServlet {

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

        List<User> users = UserFileHandler.readAll();
        request.setAttribute("users", users);
        request.setAttribute("adminUser", admin);

        request.getRequestDispatcher("/manageUsers.jsp")
                .forward(request, response);
    }
}