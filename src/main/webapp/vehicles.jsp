<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.Vehicle, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – Fleet</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24;
      --border: #2a2a38; --accent: #f0c040; --text: #f0ede8;
      --muted: #7a7a8a; --danger: #e04040; --success: #40c080;
    }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; }

    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 48px; height: 68px; background: var(--surface);
      border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100;
    }
    .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 24px; letter-spacing: -1px; }
    .logo span { color: var(--accent); }
    .nav-links { display: flex; gap: 32px; list-style: none; align-items: center; }
    .nav-links a { color: var(--muted); text-decoration: none; font-size: 13px; font-weight: 500; letter-spacing: 0.5px; text-transform: uppercase; transition: color 0.2s; }
    .nav-links a:hover, .nav-links a.active { color: var(--accent); }
    .nav-user { display: flex; align-items: center; gap: 8px; background: var(--card); border: 1px solid var(--border); padding: 6px 14px; border-radius: 20px; font-size: 13px; color: var(--accent); }
    .nav-logout { color: var(--danger) !important; }

    .hero {
      background: linear-gradient(160deg, #0f0f1a 0%, #1a1428 60%, #0a0a0f 100%);
      padding: 64px 48px 48px; border-bottom: 1px solid var(--border); position: relative; overflow: hidden;
    }
    .hero::after {
      content: ''; position: absolute; top: -60px; right: -60px;
      width: 400px; height: 400px; border-radius: 50%;
      background: radial-gradient(circle, #f0c04018 0%, transparent 70%); pointer-events: none;
    }
    .breadcrumb { font-size: 13px; color: var(--muted); margin-bottom: 16px; }
    .breadcrumb span { color: var(--accent); }
    .hero h1 { font-family: 'Syne', sans-serif; font-size: 48px; font-weight: 800; letter-spacing: -2px; line-height: 1; margin-bottom: 12px; }
    .hero h1 em { color: var(--accent); font-style: normal; }
    .hero p { color: var(--muted); font-size: 16px; max-width: 500px; margin-bottom: 36px; }
    .steps { display: flex; gap: 32px; }
    .step { display: flex; align-items: center; gap: 12px; }
    .step-num { width: 32px; height: 32px; border-radius: 50%; background: var(--accent); color: #000; font-family: 'Syne', sans-serif; font-weight: 800; font-size: 14px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .step-text { font-size: 13px; color: var(--muted); max-width: 120px; line-height: 1.4; }

    .stats-bar { display: flex; background: var(--surface); border-bottom: 1px solid var(--border); padding: 0 48px; }
    .stat-item { padding: 20px 40px 20px 0; margin-right: 40px; border-right: 1px solid var(--border); }
    .stat-item:last-child { border-right: none; }
    .stat-num { font-family: 'Syne', sans-serif; font-size: 32px; font-weight: 800; color: var(--accent); }
    .stat-label { font-size: 12px; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; }

    .main { padding: 48px; }
    .section-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 32px; }
    .section-header h2 { font-family: 'Syne', sans-serif; font-size: 24px; font-weight: 700; }
    .section-header h2 span { color: var(--accent); }
    .btn-add { display: flex; align-items: center; gap: 8px; background: var(--accent); color: #000; font-family: 'Syne', sans-serif; font-weight: 700; font-size: 14px; padding: 12px 24px; border-radius: 8px; text-decoration: none; transition: all 0.2s; }
    .btn-add:hover { background: #ffd060; transform: translateY(-2px); box-shadow: 0 8px 24px #f0c04030; }

    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 24px; }

    .vehicle-card { background: var(--card); border: 1px solid var(--border); border-radius: 16px; overflow: hidden; transition: all 0.3s; }
    .vehicle-card:hover { border-color: #f0c04040; transform: translateY(-4px); box-shadow: 0 16px 40px #00000040; }

    .car-img { width: 100%; height: 200px; position: relative; overflow: hidden; background: #111118; }
    .car-img img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.4s; display: block; }
    .vehicle-card:hover .car-img img { transform: scale(1.05); }
    .car-img-overlay { position: absolute; inset: 0; background: linear-gradient(to top, #1a1a24 0%, transparent 60%); pointer-events: none; }
    .car-fallback { position: absolute; inset: 0; display: none; align-items: center; justify-content: center; font-size: 72px; background: linear-gradient(135deg, #1f1f2e, #151520); }

    .car-type-badge { position: absolute; top: 12px; left: 12px; background: #000000bb; backdrop-filter: blur(8px); border: 1px solid var(--border); color: var(--text); font-size: 11px; font-weight: 600; padding: 4px 12px; border-radius: 20px; text-transform: uppercase; letter-spacing: 0.5px; z-index: 2; }
    .avail-badge { position: absolute; top: 12px; right: 12px; font-size: 11px; font-weight: 600; padding: 4px 12px; border-radius: 20px; z-index: 2; }
    .avail-yes { background: #40c08025; border: 1px solid #40c08060; color: var(--success); }
    .avail-no  { background: #e0404025; border: 1px solid #e0404060; color: var(--danger); }

    .card-body { padding: 20px; }
    .car-name { font-family: 'Syne', sans-serif; font-size: 20px; font-weight: 700; margin-bottom: 4px; }
    .car-id { font-size: 12px; color: var(--muted); margin-bottom: 16px; }
    .car-id strong { color: var(--accent); }
    .car-meta { display: flex; gap: 16px; margin-bottom: 16px; padding-bottom: 16px; border-bottom: 1px solid var(--border); }
    .meta-item { text-align: center; }
    .meta-val { font-size: 13px; font-weight: 600; }
    .meta-key { font-size: 10px; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-top: 2px; }
    .price-row { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; }
    .price { font-family: 'Syne', sans-serif; font-size: 24px; font-weight: 800; color: var(--accent); }
    .price-label { font-size: 11px; color: var(--muted); }

    .card-actions { display: flex; gap: 8px; }
    .btn-edit { flex: 1; padding: 10px; background: #2a2a38; border: 1px solid var(--border); color: var(--text); border-radius: 8px; font-size: 13px; font-weight: 600; text-decoration: none; text-align: center; transition: all 0.15s; }
    .btn-edit:hover { border-color: var(--accent); color: var(--accent); }
    .btn-delete { flex: 1; padding: 10px; background: #e0404015; border: 1px solid #e0404030; color: var(--danger); border-radius: 8px; font-size: 13px; font-weight: 600; text-decoration: none; text-align: center; transition: all 0.15s; }
    .btn-delete:hover { background: #e0404025; }

    .empty { grid-column: 1/-1; text-align: center; padding: 80px 20px; background: var(--card); border: 1px solid var(--border); border-radius: 16px; }
    .empty-icon { font-size: 64px; margin-bottom: 16px; }
    .empty h3 { font-family: 'Syne', sans-serif; font-size: 20px; margin-bottom: 8px; }

    footer { margin-top: 80px; padding: 32px 48px; border-top: 1px solid var(--border); background: var(--surface); text-align: center; color: var(--muted); font-size: 13px; }
    footer strong { color: var(--accent); }
  </style>
</head>
<body>

<%
  List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
  int total = vehicles != null ? vehicles.size() : 0;
  int available = 0;
  if (vehicles != null) for (Vehicle v : vehicles) if (v.isAvailable()) available++;
  int rented = total - available;
  String userName = (String) session.getAttribute("userName");

  String[] carImgs = {
    "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=600&q=80",
    "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=600&q=80",
    "https://images.unsplash.com/photo-1542362567-b07e54358753?w=600&q=80",
    "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=600&q=80",
    "https://images.unsplash.com/photo-1555215695-3004980ad54e?w=600&q=80"
  };
%>

<nav>
  <div class="logo">Easy Go<span> Drive</span></div>
  <ul class="nav-links">
    <li><a href="#">Home</a></li>
    <li><a href="vehicles" class="active">Vehicles</a></li>
    <li><a href="#">About</a></li>
    <li><a href="#">Contact</a></li>
    <% if (userName != null) { %>
      <li><span class="nav-user">👤 <%= userName %></span></li>
      <li><a href="logout" class="nav-logout">Logout</a></li>
    <% } else { %>
      <li><a href="login.jsp" style="color:var(--accent);">Login</a></li>
    <% } %>
  </ul>
</nav>

<div class="hero">
  <div class="breadcrumb">Home &rsaquo; <span>Vehicles</span></div>
  <h1>Rent Vehicles in<br><em>3 Easy Steps</em></h1>
  <p>Premium vehicles available for daily rental. Choose your ride and drive today.</p>
  <div class="steps">
    <div class="step"><div class="step-num">1</div><div class="step-text">Select your vehicle</div></div>
    <div class="step"><div class="step-num">2</div><div class="step-text">Complete booking form</div></div>
    <div class="step"><div class="step-num">3</div><div class="step-text">Collect &amp; drive</div></div>
  </div>
</div>

<div class="stats-bar">
  <div class="stat-item"><div class="stat-num"><%= total %></div><div class="stat-label">Total Fleet</div></div>
  <div class="stat-item"><div class="stat-num"><%= available %></div><div class="stat-label">Available Now</div></div>
  <div class="stat-item"><div class="stat-num"><%= rented %></div><div class="stat-label">Currently Rented</div></div>
</div>

<div class="main">
  <div class="section-header">
    <h2>Our <span>Fleet</span></h2>
    <a href="addVehicle.jsp" class="btn-add">&#43; Add Vehicle</a>
  </div>

  <div class="grid">
  <%
    if (vehicles != null && !vehicles.isEmpty()) {
      int carIndex = 0;
      for (Vehicle v : vehicles) {
        String img;
        String emoji;
        String t = v.getType().toLowerCase();

        if (t.equals("van")) {
          img = "https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=600&q=80";
          emoji = "🚐";
        } else if (t.equals("suv")) {
          img = "https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=600&q=80";
          emoji = "🚙";
        } else if (t.equals("bike")) {
          img = "https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=600&q=80";
          emoji = "🏍️";
        } else if (t.equals("bus")) {
          img = "https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=600&q=80";
          emoji = "🚌";
        } else {
          img = carImgs[carIndex % carImgs.length];
          carIndex++;
          emoji = "🚗";
        }
  %>
    <div class="vehicle-card">
      <div class="car-img">
        <img
          src="<%= img %>"
          alt="<%= v.getBrand() %> <%= v.getModel() %>"
          loading="lazy"
          onerror="this.style.display='none'; this.parentElement.querySelector('.car-img-overlay').style.display='none'; this.parentElement.querySelector('.car-fallback').style.display='flex';"
        >
        <div class="car-img-overlay"></div>
        <div class="car-fallback"><%= emoji %></div>
        <span class="car-type-badge"><%= v.getType() %></span>
        <% if (v.isAvailable()) { %>
          <span class="avail-badge avail-yes">&#9679; Available</span>
        <% } else { %>
          <span class="avail-badge avail-no">&#9679; Rented</span>
        <% } %>
      </div>
      <div class="card-body">
        <div class="car-name"><%= v.getBrand() %> <%= v.getModel() %></div>
        <div class="car-id">Vehicle ID: <strong><%= v.getVehicleId() %></strong></div>
        <div class="car-meta">
          <div class="meta-item"><div class="meta-val"><%= v.getType() %></div><div class="meta-key">Type</div></div>
          <div class="meta-item"><div class="meta-val">Automatic</div><div class="meta-key">Gearbox</div></div>
          <div class="meta-item"><div class="meta-val">Petrol</div><div class="meta-key">Fuel</div></div>
          <div class="meta-item"><div class="meta-val">2024</div><div class="meta-key">Year</div></div>
        </div>
        <div class="price-row">
          <div>
            <div class="price">Rs. <%= v.getPricePerDay() %></div>
            <div class="price-label">per day</div>
          </div>
        </div>
        <div class="card-actions">
          <a href="updateVehicle.jsp?vehicleId=<%= v.getVehicleId() %>&brand=<%= v.getBrand() %>&model=<%= v.getModel() %>&type=<%= v.getType() %>&price=<%= v.getPricePerDay() %>&available=<%= v.isAvailable() %>" class="btn-edit">&#9998; Edit</a>
          <a href="deleteVehicle?vehicleId=<%= v.getVehicleId() %>" class="btn-delete" onclick="return confirm('Delete this vehicle?')">&#128465; Delete</a>
        </div>
      </div>
    </div>
  <%
      }
    } else {
  %>
    <div class="empty">
      <div class="empty-icon">🚗</div>
      <h3>No vehicles in fleet</h3>
      <p style="color:var(--muted); margin-bottom:24px">Add your first vehicle to get started</p>
      <a href="addVehicle.jsp" class="btn-add" style="display:inline-flex">&#43; Add First Vehicle</a>
    </div>
  <% } %>
  </div>
</div>

<footer>&copy; 2026 <strong>Easy Go Drive</strong> Vehicle Rental System &mdash; All Rights Reserved</footer>

<script>
  document.querySelectorAll('.car-img img').forEach(img => {
    img.addEventListener('error', function() {
      this.style.display = 'none';
      const overlay = this.parentElement.querySelector('.car-img-overlay');
      const fallback = this.parentElement.querySelector('.car-fallback');
      if (overlay) overlay.style.display = 'none';
      if (fallback) fallback.style.display = 'flex';
    });
  });
</script>

</body>
</html>