<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.Vehicle, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DriveEase – Vehicle Management</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg: #0a0a0f;
      --surface: #13131a;
      --card: #1a1a24;
      --border: #2a2a38;
      --accent: #f0c040;
      --accent2: #e05c2a;
      --text: #f0ede8;
      --muted: #7a7a8a;
      --danger: #e04040;
      --success: #40c080;
    }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'DM Sans', sans-serif;
      min-height: 100vh;
    }

    /* Top nav */
    nav {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 48px;
      height: 64px;
      border-bottom: 1px solid var(--border);
      background: var(--surface);
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .logo {
      font-family: 'Syne', sans-serif;
      font-weight: 800;
      font-size: 22px;
      letter-spacing: -0.5px;
    }

    .logo span { color: var(--accent); }

    .nav-badge {
      background: var(--accent);
      color: #000;
      font-size: 11px;
      font-weight: 600;
      padding: 2px 10px;
      border-radius: 20px;
      letter-spacing: 0.5px;
    }

    /* Hero strip */
    .hero {
      background: linear-gradient(135deg, #13131a 0%, #1e1a2e 100%);
      border-bottom: 1px solid var(--border);
      padding: 48px 48px 32px;
      position: relative;
      overflow: hidden;
    }

    .hero::before {
      content: 'FLEET';
      position: absolute;
      right: 40px;
      top: -10px;
      font-family: 'Syne', sans-serif;
      font-size: 120px;
      font-weight: 800;
      color: #ffffff06;
      letter-spacing: -4px;
      pointer-events: none;
    }

    .hero h1 {
      font-family: 'Syne', sans-serif;
      font-size: 36px;
      font-weight: 800;
      letter-spacing: -1px;
      margin-bottom: 6px;
    }

    .hero h1 span { color: var(--accent); }

    .hero p {
      color: var(--muted);
      font-size: 15px;
      margin-bottom: 28px;
    }

    /* Stats row */
    .stats {
      display: flex;
      gap: 24px;
      margin-bottom: 0;
    }

    .stat {
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 12px;
      padding: 16px 24px;
      min-width: 130px;
    }

    .stat-val {
      font-family: 'Syne', sans-serif;
      font-size: 28px;
      font-weight: 700;
      color: var(--accent);
    }

    .stat-label {
      font-size: 12px;
      color: var(--muted);
      margin-top: 2px;
    }

    /* Main content */
    .main { padding: 36px 48px; }

    .toolbar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 24px;
    }

    .toolbar h2 {
      font-family: 'Syne', sans-serif;
      font-size: 20px;
      font-weight: 700;
    }

    .btn-add {
      display: flex;
      align-items: center;
      gap: 8px;
      background: var(--accent);
      color: #000;
      font-family: 'DM Sans', sans-serif;
      font-weight: 600;
      font-size: 14px;
      padding: 10px 22px;
      border-radius: 8px;
      text-decoration: none;
      transition: all 0.2s;
      border: none;
      cursor: pointer;
    }

    .btn-add:hover {
      background: #ffd060;
      transform: translateY(-1px);
    }

    /* Table */
    .table-wrap {
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 16px;
      overflow: hidden;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    thead {
      background: #111118;
      border-bottom: 1px solid var(--border);
    }

    thead th {
      padding: 14px 20px;
      text-align: left;
      font-size: 11px;
      font-weight: 600;
      color: var(--muted);
      text-transform: uppercase;
      letter-spacing: 0.8px;
    }

    tbody tr {
      border-bottom: 1px solid var(--border);
      transition: background 0.15s;
    }

    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: #1f1f2e; }

    tbody td {
      padding: 16px 20px;
      font-size: 14px;
      vertical-align: middle;
    }

    .id-badge {
      font-family: 'Syne', sans-serif;
      font-size: 12px;
      font-weight: 600;
      color: var(--accent);
      background: #f0c04012;
      border: 1px solid #f0c04030;
      padding: 3px 8px;
      border-radius: 6px;
    }

    .type-pill {
      font-size: 12px;
      font-weight: 500;
      padding: 4px 12px;
      border-radius: 20px;
      background: #2a2a38;
      color: var(--text);
    }

    .avail-yes {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      font-size: 12px;
      font-weight: 500;
      color: var(--success);
      background: #40c08015;
      border: 1px solid #40c08030;
      padding: 3px 10px;
      border-radius: 20px;
    }

    .avail-no {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      font-size: 12px;
      font-weight: 500;
      color: var(--danger);
      background: #e0404015;
      border: 1px solid #e0404030;
      padding: 3px 10px;
      border-radius: 20px;
    }

    .price {
      font-family: 'Syne', sans-serif;
      font-weight: 600;
      font-size: 14px;
    }

    .actions { display: flex; gap: 8px; }

    .btn-edit {
      padding: 6px 16px;
      background: #2a2a38;
      border: 1px solid var(--border);
      color: var(--text);
      border-radius: 6px;
      font-size: 13px;
      text-decoration: none;
      transition: all 0.15s;
      cursor: pointer;
    }

    .btn-edit:hover {
      background: #353548;
      border-color: var(--accent);
      color: var(--accent);
    }

    .btn-delete {
      padding: 6px 16px;
      background: #e0404015;
      border: 1px solid #e0404030;
      color: var(--danger);
      border-radius: 6px;
      font-size: 13px;
      text-decoration: none;
      transition: all 0.15s;
      cursor: pointer;
    }

    .btn-delete:hover {
      background: #e0404030;
    }

    .empty {
      text-align: center;
      padding: 60px 20px;
      color: var(--muted);
    }

    .empty-icon { font-size: 48px; margin-bottom: 12px; }
    .empty p { font-size: 15px; }
  </style>
</head>
<body>

<nav>
  <div class="logo">Drive<span>Ease</span></div>
  <span class="nav-badge">VEHICLE MANAGEMENT</span>
</nav>

<div class="hero">
  <h1>Fleet <span>Dashboard</span></h1>
  <p>Manage your entire vehicle inventory from one place</p>

  <%
    List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
    int total = vehicles != null ? vehicles.size() : 0;
    int available = 0;
    if (vehicles != null) {
      for (Vehicle v : vehicles) {
        if (v.isAvailable()) available++;
      }
    }
    int rented = total - available;
  %>

  <div class="stats">
    <div class="stat">
      <div class="stat-val"><%= total %></div>
      <div class="stat-label">Total Vehicles</div>
    </div>
    <div class="stat">
      <div class="stat-val"><%= available %></div>
      <div class="stat-label">Available</div>
    </div>
    <div class="stat">
      <div class="stat-val"><%= rented %></div>
      <div class="stat-label">Rented Out</div>
    </div>
  </div>
</div>

<div class="main">
  <div class="toolbar">
    <h2>All Vehicles</h2>
    <a href="addVehicle.jsp" class="btn-add">&#43; Add New Vehicle</a>
  </div>

  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Brand</th>
          <th>Model</th>
          <th>Type</th>
          <th>Price / Day</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
      <%
        if (vehicles != null && !vehicles.isEmpty()) {
          for (Vehicle v : vehicles) {
      %>
        <tr>
          <td><span class="id-badge"><%= v.getVehicleId() %></span></td>
          <td><strong><%= v.getBrand() %></strong></td>
          <td><%= v.getModel() %></td>
          <td><span class="type-pill"><%= v.getType() %></span></td>
          <td><span class="price">Rs. <%= v.getPricePerDay() %></span></td>
          <td>
            <% if (v.isAvailable()) { %>
              <span class="avail-yes">&#9679; Available</span>
            <% } else { %>
              <span class="avail-no">&#9679; Rented</span>
            <% } %>
          </td>
          <td>
            <div class="actions">
              <a href="updateVehicle.jsp?vehicleId=<%= v.getVehicleId() %>&brand=<%= v.getBrand() %>&model=<%= v.getModel() %>&type=<%= v.getType() %>&price=<%= v.getPricePerDay() %>&available=<%= v.isAvailable() %>" class="btn-edit">Edit</a>
              <a href="deleteVehicle?vehicleId=<%= v.getVehicleId() %>" class="btn-delete" onclick="return confirm('Delete this vehicle?')">Delete</a>
            </div>
          </td>
        </tr>
      <%
          }
        } else {
      %>
        <tr>
          <td colspan="7">
            <div class="empty">
              <div class="empty-icon">&#128663;</div>
              <p>No vehicles found. Add your first vehicle!</p>
            </div>
          </td>
        </tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>