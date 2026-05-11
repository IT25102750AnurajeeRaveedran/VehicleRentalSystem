package com.rental.servlet;

import com.rental.model.Feedback;
import com.rental.model.User;
import com.rental.util.FeedbackFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet("/submitFeedback")
public class SubmitFeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        String vehicleId = request.getParameter("vehicleId");
        String comment   = request.getParameter("comment");
        int rating       = Integer.parseInt(request.getParameter("rating"));
        String date      = LocalDate.now().toString();
        String feedbackId = "F" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();

        Feedback feedback = new Feedback(
                feedbackId,
                user.getUserId(),
                user.getFullName(),
                vehicleId,
                comment,
                rating,
                date
        );

        FeedbackFileHandler.addFeedback(feedback);
        response.sendRedirect("myBookings?msg=feedback");
    }
}