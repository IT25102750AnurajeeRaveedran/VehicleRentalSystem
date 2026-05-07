package com.rental.servlet;

import com.rental.util.VehicleFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/deleteVehicle")
public class DeleteVehicleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vehicleId = request.getParameter("vehicleId");
        VehicleFileHandler.deleteVehicle(vehicleId);
        response.sendRedirect("vehicles");
    }
}