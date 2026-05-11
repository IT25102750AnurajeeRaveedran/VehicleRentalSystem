package com.rental.servlet;

import com.rental.model.Vehicle;
import com.rental.util.BookingFileHandler;
import com.rental.util.VehicleFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String bookingId = request.getParameter("bookingId");
        String vehicleId = request.getParameter("vehicleId");

        // Update booking status to cancelled
        BookingFileHandler.updateStatus(bookingId, "cancelled");

        // Make vehicle available again
        List<Vehicle> vehicles = VehicleFileHandler.readAll();
        for (Vehicle v : vehicles) {
            if (v.getVehicleId().equals(vehicleId)) {
                v.setAvailable(true);
                break;
            }
        }
        VehicleFileHandler.writeAll(vehicles);

        response.sendRedirect("myBookings?msg=cancelled");
    }
}