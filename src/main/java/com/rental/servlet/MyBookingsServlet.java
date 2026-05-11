package com.rental.servlet;

import com.rental.model.Booking;
import com.rental.model.User;
import com.rental.util.BookingFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/myBookings")
public class MyBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp?error=notloggedin");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        List<Booking> bookings = BookingFileHandler.getBookingsByUser(user.getUserId());
        request.setAttribute("bookings", bookings);
        request.setAttribute("user", user);

        request.getRequestDispatcher("/myBookings.jsp")
                .forward(request, response);
    }
}