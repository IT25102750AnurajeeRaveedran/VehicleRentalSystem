package com.rental.servlet;

import com.rental.model.Booking;
import com.rental.model.User;
import com.rental.model.Vehicle;
import com.rental.util.BookingFileHandler;
import com.rental.util.VehicleFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.UUID;

@WebServlet("/rentVehicle")
public class RentVehicleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp?error=notloggedin");
            return;
        }

        String vehicleId = request.getParameter("vehicleId");
        String brand     = request.getParameter("brand");
        String model     = request.getParameter("model");
        String price     = request.getParameter("price");

        request.setAttribute("vehicleId", vehicleId);
        request.setAttribute("brand", brand);
        request.setAttribute("model", model);
        request.setAttribute("price", price);

        request.getRequestDispatcher("/rentVehicle.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        String vehicleId  = request.getParameter("vehicleId");
        String brand      = request.getParameter("brand");
        String model      = request.getParameter("model");
        String startDate  = request.getParameter("startDate");
        String endDate    = request.getParameter("endDate");
        double pricePerDay = Double.parseDouble(request.getParameter("pricePerDay"));

        // Calculate total price
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end   = LocalDate.parse(endDate);
        long days = ChronoUnit.DAYS.between(start, end);
        if (days <= 0) days = 1;
        double totalPrice = days * pricePerDay;

        // Create booking
        String bookingId = "B" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();
        Booking booking = new Booking(
                bookingId, user.getUserId(), vehicleId,
                brand, model, startDate, endDate, totalPrice, "active"
        );
        BookingFileHandler.addBooking(booking);

        // Update vehicle availability to false
        List<Vehicle> vehicles = VehicleFileHandler.readAll();
        for (Vehicle v : vehicles) {
            if (v.getVehicleId().equals(vehicleId)) {
                v.setAvailable(false);
                break;
            }
        }
        VehicleFileHandler.writeAll(vehicles);

        response.sendRedirect("myBookings?msg=booked");
    }
}