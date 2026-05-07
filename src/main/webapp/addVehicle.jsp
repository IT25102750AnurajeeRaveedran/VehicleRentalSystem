<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Vehicle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5" style="max-width:500px">
    <div class="card shadow p-4">
        <h3 class="mb-4 text-center">➕ Add New Vehicle</h3>
        <form action="addVehicle" method="post">
            <div class="mb-3">
                <label>Brand</label>
                <input type="text" name="brand" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Model</label>
                <input type="text" name="model" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Type</label>
                <select name="type" class="form-control">
                    <option>Car</option>
                    <option>Van</option>
                    <option>Bike</option>
                    <option>SUV</option>
                </select>
            </div>
            <div class="mb-3">
                <label>Price Per Day (Rs.)</label>
                <input type="number" name="pricePerDay" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success w-100">Add Vehicle</button>
            <a href="vehicles" class="btn btn-secondary w-100 mt-2">Cancel</a>
        </form>
    </div>
</div>
</body>
</html>