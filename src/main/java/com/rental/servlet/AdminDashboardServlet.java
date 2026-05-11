package com.rental.servlet;

import com.rental.model.Booking;
import com.rental.model.User;
import com.rental.model.Vehicle;
import com.rental.util.BookingFileHandler;
import com.rental.util.UserFileHandler;
import com.rental.util.VehicleFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if logged in as admin
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp?error=notloggedin");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");
        if (!user.getRole().equals("admin")) {
            response.sendRedirect("vehicles?error=notadmin");
            return;
        }

        // Get all data
        List<User>    users    = UserFileHandler.readAll();
        List<Vehicle> vehicles = VehicleFileHandler.readAll();
        List<Booking> bookings = BookingFileHandler.getAllBookings();

        // Calculate stats
        int totalUsers    = users.size();
        int totalVehicles = vehicles.size();
        int totalBookings = bookings.size();
        int activeBookings = 0;
        double totalRevenue = 0;

        for (Booking b : bookings) {
            if ("active".equals(b.getStatus())) activeBookings++;
            if (!"cancelled".equals(b.getStatus())) totalRevenue += b.getTotalPrice();
        }

        int availableVehicles = 0;
        for (Vehicle v : vehicles) {
            if (v.isAvailable()) availableVehicles++;
        }

        request.setAttribute("totalUsers",       totalUsers);
        request.setAttribute("totalVehicles",    totalVehicles);
        request.setAttribute("totalBookings",    totalBookings);
        request.setAttribute("activeBookings",   activeBookings);
        request.setAttribute("totalRevenue",     totalRevenue);
        request.setAttribute("availableVehicles",availableVehicles);
        request.setAttribute("recentBookings",   bookings);
        request.setAttribute("adminUser",        user);

        request.getRequestDispatcher("/adminDashboard.jsp")
                .forward(request, response);
    }
}