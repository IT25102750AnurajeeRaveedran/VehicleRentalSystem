package com.rental.servlet;

import com.rental.model.Vehicle;
import com.rental.util.VehicleFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/addVehicle")
public class AddVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String brand       = request.getParameter("brand");
        String model       = request.getParameter("model");
        String type        = request.getParameter("type");
        double pricePerDay = Double.parseDouble(request.getParameter("pricePerDay"));

        String vehicleId = "V" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();

        Vehicle vehicle = new Vehicle(vehicleId, brand, model, type, pricePerDay, true);
        VehicleFileHandler.addVehicle(vehicle);

        response.sendRedirect("vehicles");
    }
}