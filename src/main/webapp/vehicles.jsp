<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.Vehicle, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicle Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <h2 class="mb-4">🚗 Vehicle Management</h2>

    <a href="addVehicle.jsp" class="btn btn-success mb-3">+ Add New Vehicle</a>

    <table class="table table-bordered table-hover bg-white">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Brand</th>
                <th>Model</th>
                <th>Type</th>
                <th>Price/Day</th>
                <th>Available</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
            if (vehicles != null) {
                for (Vehicle v : vehicles) {
        %>
            <tr>
                <td><%= v.getVehicleId() %></td>
                <td><%= v.getBrand() %></td>
                <td><%= v.getModel() %></td>
                <td><%= v.getType() %></td>
                <td>Rs. <%= v.getPricePerDay() %></td>
                <td><%= v.isAvailable() ? "Yes" : "No" %></td>
                <td>
                    <a href="updateVehicle.jsp?vehicleId=<%= v.getVehicleId() %>&brand=<%= v.getBrand() %>&model=<%= v.getModel() %>&type=<%= v.getType() %>&price=<%= v.getPricePerDay() %>&available=<%= v.isAvailable() %>"
                       class="btn btn-warning btn-sm">Edit</a>
                    <a href="deleteVehicle?vehicleId=<%= v.getVehicleId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>