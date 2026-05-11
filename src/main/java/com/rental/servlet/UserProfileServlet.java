package com.rental.servlet;

import com.rental.model.User;
import com.rental.util.UserFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/userProfile")
public class UserProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp?error=notloggedin");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");
        User freshUser = UserFileHandler.findByEmail(user.getEmail());

        if (freshUser != null) {
            request.setAttribute("user", freshUser);
        } else {
            request.setAttribute("user", user);
        }

        request.getRequestDispatcher("/userDashboard.jsp")
                .forward(request, response);
    }
}