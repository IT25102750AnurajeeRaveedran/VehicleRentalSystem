package com.rental.servlet;

import com.rental.model.Vehicle;
import com.rental.util.BookingFileHandler;
import com.rental.util.VehicleFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/returnVehicle")
public class ReturnVehicleServlet extends HttpServlet {

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

        // Update booking status to returned
        BookingFileHandler.updateStatus(bookingId, "returned");

        // Update vehicle availability back to true
        List<Vehicle> vehicles = VehicleFileHandler.readAll();
        for (Vehicle v : vehicles) {
            if (v.getVehicleId().equals(vehicleId)) {
                v.setAvailable(true);
                break;
            }
        }
        VehicleFileHandler.writeAll(vehicles);

        response.sendRedirect("myBookings?msg=returned");
    }
}