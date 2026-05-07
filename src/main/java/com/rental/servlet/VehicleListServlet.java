package com.rental.servlet;

import com.rental.model.Vehicle;
import com.rental.util.VehicleFileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/vehicles")
public class VehicleListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Vehicle> vehicles = VehicleFileHandler.readAll();
        request.setAttribute("vehicles", vehicles);
        request.getRequestDispatcher("/vehicles.jsp")
                .forward(request, response);
    }
}