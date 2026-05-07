package com.rental.servlet;

import com.rental.model.Vehicle;
import com.rental.util.VehicleFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/updateVehicle")
public class UpdateVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vehicleId   = request.getParameter("vehicleId");
        String brand       = request.getParameter("brand");
        String model       = request.getParameter("model");
        String type        = request.getParameter("type");
        double pricePerDay = Double.parseDouble(request.getParameter("pricePerDay"));
        boolean available  = Boolean.parseBoolean(request.getParameter("available"));

        Vehicle updated = new Vehicle(vehicleId, brand, model, type, pricePerDay, available);
        VehicleFileHandler.updateVehicle(updated);

        response.sendRedirect("vehicles");
    }
}