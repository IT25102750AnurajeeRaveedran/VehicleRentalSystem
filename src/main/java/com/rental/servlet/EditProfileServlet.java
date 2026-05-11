package com.rental.servlet;

import com.rental.model.User;
import com.rental.util.UserFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedUser = (User) session.getAttribute("loggedUser");

        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");
        String password = request.getParameter("password");

        // Read all users and update
        List<User> users = UserFileHandler.readAll();
        for (User u : users) {
            if (u.getEmail().equalsIgnoreCase(loggedUser.getEmail())) {
                u.setFullName(fullName);
                u.setPhone(phone);
                if (password != null && !password.isEmpty()) {
                    u.setPassword(password);
                }
                // Update session
                session.setAttribute("loggedUser", u);
                session.setAttribute("userName", u.getFullName());
                break;
            }
        }
        UserFileHandler.writeAll(users);

        response.sendRedirect("userProfile?msg=updated");
    }
}