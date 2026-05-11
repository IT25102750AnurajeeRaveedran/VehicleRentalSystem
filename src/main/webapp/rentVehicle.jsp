<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – Rent Vehicle</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root { --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24; --border: #2a2a38; --accent: #f0c040; --text: #f0ede8; --muted: #7a7a8a; --danger: #e04040; --success: #40c080; }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }

    nav { display: flex; align-items: center; justify-content: space-between; padding: 0 48px; height: 68px; background: var(--surface); border-bottom: 1px solid var(--border); }
    .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 24px; letter-spacing: -1px; text-decoration: none; color: var(--text); }
    .logo span { color: var(--accent); }
    .nav-links { display: flex; gap: 32px; list-style: none; align-items: center; }
    .nav-links a { color: var(--muted); text-decoration: none; font-size: 13px; font-weight: 500; text-transform: uppercase; transition: color 0.2s; }
    .nav-links a:hover { color: var(--accent); }

    .page { flex: 1; max-width: 580px; margin: 48px auto; padding: 0 24px; width: 100%; }
    .back { color: var(--muted); font-size: 13px; text-decoration: none; display: flex; align-items: center; gap: 6px; margin-bottom: 28px; }
    .back:hover { color: var(--text); }

    /* Vehicle summary card */
    .vehicle-summary {
      background: linear-gradient(135deg, #1a1428, #0f0f1a);
      border: 1px solid #f0c04030; border-radius: 16px;
      padding: 24px; margin-bottom: 24px;
      display: flex; align-items: center; gap: 20px;
    }
    .vehicle-icon { font-size: 56px; }
    .vehicle-info h2 { font-family: 'Syne', sans-serif; font-size: 22px; font-weight: 800; margin-bottom: 4px; }
    .vehicle-info p { color: var(--muted); font-size: 13px; }
    .vehicle-price { margin-left: auto; text-align: right; }
    .price-val { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; color: var(--accent); }
    .price-label { font-size: 12px; color: var(--muted); }

    .card { background: var(--card); border: 1px solid var(--border); border-radius: 20px; padding: 40px; }
    .card-header { margin-bottom: 28px; }
    .card-header h1 { font-family: 'Syne', sans-serif; font-size: 24px; font-weight: 800; margin-bottom: 6px; }
    .card-header h1 span { color: var(--accent); }
    .card-header p { color: var(--muted); font-size: 14px; }

    .row-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 12px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
    input { width: 100%; background: #111118; border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 15px; padding: 12px 16px; border-radius: 10px; outline: none; transition: border 0.2s; }
    input:focus { border-color: var(--accent); }
    input:read-only { opacity: 0.6; cursor: not-allowed; }

    /* Price calculator */
    .price-calc { background: #111118; border: 1px solid var(--border); border-radius: 12px; padding: 20px; margin-bottom: 20px; }
    .calc-row { display: flex; justify-content: space-between; padding: 8px 0; font-size: 14px; border-bottom: 1px solid var(--border); }
    .calc-row:last-child { border-bottom: none; font-family: 'Syne', sans-serif; font-size: 18px; font-weight: 800; color: var(--accent); }
    .calc-label { color: var(--muted); }

    .btn-submit { width: 100%; background: var(--accent); color: #000; border: none; font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; padding: 14px; border-radius: 10px; cursor: pointer; margin-top: 8px; transition: all 0.2s; }
    .btn-submit:hover { background: #ffd060; transform: translateY(-1px); box-shadow: 0 8px 24px #f0c04030; }
    .btn-cancel { display: block; text-align: center; margin-top: 14px; color: var(--muted); font-size: 14px; text-decoration: none; }
    .btn-cancel:hover { color: var(--text); }

    footer { padding: 24px 48px; border-top: 1px solid var(--border); background: var(--surface); text-align: center; color: var(--muted); font-size: 13px; }
    footer strong { color: var(--accent); }
  </style>
</head>
<body>

<%
  HttpSession sess = request.getSession(false);
  if (sess == null || sess.getAttribute("loggedUser") == null) {
    response.sendRedirect("login.jsp");
    return;
  }
  String vehicleId  = (String) request.getAttribute("vehicleId");
  String brand      = (String) request.getAttribute("brand");
  String model      = (String) request.getAttribute("model");
  String price      = (String) request.getAttribute("price");
  if (vehicleId == null) vehicleId = "";
  if (brand == null)     brand = "";
  if (model == null)     model = "";
  if (price == null)     price = "0";
%>

<nav>
  <a href="vehicles" class="logo">Easy Go<span> Drive</span></a>
  <ul class="nav-links">
    <li><a href="vehicles">Vehicles</a></li>
    <li><a href="myBookings">My Bookings</a></li>
    <li><a href="userProfile">My Profile</a></li>
    <li><a href="logout" style="color:#e04040;">Logout</a></li>
  </ul>
</nav>

<div class="page">
  <a href="vehicles" class="back">&#8592; Back to Vehicles</a>

  <!-- Vehicle Summary -->
  <div class="vehicle-summary">
    <div class="vehicle-icon">🚗</div>
    <div class="vehicle-info">
      <h2><%= brand %> <%= model %></h2>
      <p>Vehicle ID: <%= vehicleId %></p>
      <p>Automatic &bull; Petrol &bull; 2024</p>
    </div>
    <div class="vehicle-price">
      <div class="price-val">Rs. <%= price %></div>
      <div class="price-label">per day</div>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <h1>Book Your <span>Ride</span></h1>
      <p>Select your rental dates to complete the booking</p>
    </div>

    <form action="rentVehicle" method="post" onsubmit="return validateDates()">
      <input type="hidden" name="vehicleId"   value="<%= vehicleId %>">
      <input type="hidden" name="brand"       value="<%= brand %>">
      <input type="hidden" name="model"       value="<%= model %>">
      <input type="hidden" name="pricePerDay" value="<%= price %>">

      <div class="row-2">
        <div class="form-group">
          <label>Start Date</label>
          <input type="date" name="startDate" id="startDate" required onchange="calcPrice()">
        </div>
        <div class="form-group">
          <label>End Date</label>
          <input type="date" name="endDate" id="endDate" required onchange="calcPrice()">
        </div>
      </div>

      <div class="form-group">
        <label>Vehicle ID</label>
        <input type="text" value="<%= vehicleId %>" readonly>
      </div>

      <!-- Price Calculator -->
      <div class="price-calc">
        <div class="calc-row">
          <span class="calc-label">Price Per Day</span>
          <span>Rs. <%= price %></span>
        </div>
        <div class="calc-row">
          <span class="calc-label">Number of Days</span>
          <span id="daysCount">0</span>
        </div>
        <div class="calc-row">
          <span class="calc-label">Total Price</span>
          <span id="totalPrice">Rs. 0</span>
        </div>
      </div>

      <button type="submit" class="btn-submit">🚗 Confirm Booking</button>
    </form>
    <a href="vehicles" class="btn-cancel">Cancel</a>
  </div>
</div>

<footer>&copy; 2026 <strong>Easy Go Drive</strong> Vehicle Rental System</footer>

<script>
  const pricePerDay = <%= price %>;

  // Set minimum date to today
  const today = new Date().toISOString().split('T')[0];
  document.getElementById('startDate').min = today;
  document.getElementById('endDate').min = today;

  function calcPrice() {
    const start = document.getElementById('startDate').value;
    const end   = document.getElementById('endDate').value;
    if (start && end) {
      const days = Math.max(1, Math.ceil((new Date(end) - new Date(start)) / (1000 * 60 * 60 * 24)));
      document.getElementById('daysCount').textContent = days;
      document.getElementById('totalPrice').textContent = 'Rs. ' + (days * pricePerDay).toFixed(2);
    }
  }

  function validateDates() {
    const start = new Date(document.getElementById('startDate').value);
    const end   = new Date(document.getElementById('endDate').value);
    if (end <= start) {
      alert('End date must be after start date!');
      return false;
    }
    return true;
  }
</script>

</body>
</html>