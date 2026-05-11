package com.rental.servlet;

import com.rental.model.Booking;
import com.rental.model.User;
import com.rental.util.BookingFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/rentalHistory")
public class RentalHistoryServlet extends HttpServlet {

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

        List<Booking> bookings = BookingFileHandler.getAllBookings();

        // Calculate total revenue
        double totalRevenue = 0;
        int activeCount = 0;
        int returnedCount = 0;
        int cancelledCount = 0;

        for (Booking b : bookings) {
            if ("active".equals(b.getStatus())) activeCount++;
            else if ("returned".equals(b.getStatus())) returnedCount++;
            else if ("cancelled".equals(b.getStatus())) cancelledCount++;
            if (!"cancelled".equals(b.getStatus())) totalRevenue += b.getTotalPrice();
        }

        request.setAttribute("bookings",       bookings);
        request.setAttribute("totalRevenue",   totalRevenue);
        request.setAttribute("activeCount",    activeCount);
        request.setAttribute("returnedCount",  returnedCount);
        request.setAttribute("cancelledCount", cancelledCount);
        request.setAttribute("adminUser",      admin);

        request.getRequestDispatcher("/rentalHistory.jsp")
                .forward(request, response);
    }
}