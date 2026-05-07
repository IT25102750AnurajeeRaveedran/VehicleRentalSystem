<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DriveEase – Update Vehicle</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24;
      --border: #2a2a38; --accent: #f0c040; --text: #f0ede8; --muted: #7a7a8a;
    }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; }
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 48px; height: 64px; border-bottom: 1px solid var(--border);
      background: var(--surface);
    }
    .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 22px; }
    .logo span { color: var(--accent); }
    .page { max-width: 600px; margin: 60px auto; padding: 0 24px; }
    .back { color: var(--muted); font-size: 13px; text-decoration: none; display: flex; align-items: center; gap: 6px; margin-bottom: 28px; }
    .back:hover { color: var(--text); }
    .id-display {
      background: #f0c04012; border: 1px solid #f0c04030;
      border-radius: 10px; padding: 12px 16px; margin-bottom: 20px;
      font-size: 13px; color: var(--muted);
    }
    .id-display strong { color: var(--accent); font-family: 'Syne', sans-serif; }
    .card { background: var(--card); border: 1px solid var(--border); border-radius: 20px; padding: 40px; }
    .card-header { margin-bottom: 32px; }
    .card-header h1 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; }
    .card-header h1 span { color: var(--accent); }
    .card-header p { color: var(--muted); font-size: 14px; margin-top: 6px; }
    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 12px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
    input, select {
      width: 100%; background: #111118; border: 1px solid var(--border);
      color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 15px;
      padding: 12px 16px; border-radius: 10px; outline: none; transition: border 0.2s;
    }
    input:focus, select:focus { border-color: var(--accent); }
    select option { background: #111118; }
    .row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    .btn-submit {
      width: 100%; background: var(--accent); color: #000; border: none;
      font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700;
      padding: 14px; border-radius: 10px; cursor: pointer; margin-top: 8px; transition: all 0.2s;
    }
    .btn-submit:hover { background: #ffd060; transform: translateY(-1px); }
    .btn-cancel {
      display: block; text-align: center; margin-top: 14px;
      color: var(--muted); font-size: 14px; text-decoration: none;
    }
    .btn-cancel:hover { color: var(--text); }
  </style>
</head>
<body>
<nav>
  <div class="logo">Drive<span>Ease</span></div>
</nav>
<div class="page">
  <a href="vehicles" class="back">&#8592; Back to Fleet</a>
  <div class="id-display">
    Editing vehicle: <strong><%= request.getParameter("vehicleId") %></strong>
  </div>
  <div class="card">
    <div class="card-header">
      <h1>Update <span>Vehicle</span></h1>
      <p>Modify the details for this vehicle</p>
    </div>
    <form action="updateVehicle" method="post">
      <input type="hidden" name="vehicleId" value="<%= request.getParameter("vehicleId") %>">
      <div class="row">
        <div class="form-group">
          <label>Brand</label>
          <input type="text" name="brand" value="<%= request.getParameter("brand") %>" required>
        </div>
        <div class="form-group">
          <label>Model</label>
          <input type="text" name="model" value="<%= request.getParameter("model") %>" required>
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label>Vehicle Type</label>
          <select name="type">
            <option>Car</option>
            <option>Van</option>
            <option>SUV</option>
            <option>Bike</option>
            <option>Bus</option>
          </select>
        </div>
        <div class="form-group">
          <label>Price Per Day (Rs.)</label>
          <input type="number" name="pricePerDay" value="<%= request.getParameter("price") %>" required>
        </div>
      </div>
      <div class="form-group">
        <label>Availability Status</label>
        <select name="available">
          <option value="true">Available</option>
          <option value="false">Rented Out</option>
        </select>
      </div>
      <button type="submit" class="btn-submit">Save Changes</button>
      <a href="vehicles" class="btn-cancel">Cancel</a>
    </form>
  </div>
</div>
</body>
</html>