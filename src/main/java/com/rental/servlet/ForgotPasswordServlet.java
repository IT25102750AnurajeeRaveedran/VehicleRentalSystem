package com.rental.servlet;

import com.rental.util.UserFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email       = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirm     = request.getParameter("confirmPassword");

        // Check passwords match
        if (!newPassword.equals(confirm)) {
            response.sendRedirect("forgotPassword.jsp?error=mismatch");
            return;
        }

        // Check email exists
        if (UserFileHandler.findByEmail(email) == null) {
            response.sendRedirect("forgotPassword.jsp?error=notfound");
            return;
        }

        // Reset password
        boolean success = UserFileHandler.resetPassword(email, newPassword);

        if (success) {
            response.sendRedirect("login.jsp?msg=reset");
        } else {
            response.sendRedirect("forgotPassword.jsp?error=failed");
        }
    }
}