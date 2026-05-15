package com.rental.servlet;

import com.rental.model.User;
import com.rental.util.DbFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/adminNotifications")
public class AdminNotificationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp?error=notloggedin");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect("vehicles?error=notadmin");
            return;
        }

        List<String> notifications = new ArrayList<>();
        File f = new File(DbFileUtil.getPath("notifications.txt"));
        if (f.exists()) {
            try (BufferedReader r = new BufferedReader(new FileReader(f))) {
                String line;
                while ((line = r.readLine()) != null) {
                    if (!line.trim().isEmpty()) notifications.add(line.trim());
                }
            }
        }

        request.setAttribute("notifications", notifications);
        request.setAttribute("adminUser", user);
        request.getRequestDispatcher("/adminNotifications.jsp").forward(request, response);
    }
}

