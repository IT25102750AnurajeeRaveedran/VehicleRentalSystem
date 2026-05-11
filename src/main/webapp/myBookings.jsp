<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.Booking, com.rental.model.User, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – My Bookings</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root { --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24; --border: #2a2a38; --accent: #f0c040; --text: #f0ede8; --muted: #7a7a8a; --danger: #e04040; --success: #40c080; }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; }

    nav { display: flex; align-items: center; justify-content: space-between; padding: 0 48px; height: 68px; background: var(--surface); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; }
    .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 24px; letter-spacing: -1px; text-decoration: none; color: var(--text); }
    .logo span { color: var(--accent); }
    .nav-links { display: flex; gap: 32px; list-style: none; align-items: center; }
    .nav-links a { color: var(--muted); text-decoration: none; font-size: 13px; font-weight: 500; text-transform: uppercase; transition: color 0.2s; }
    .nav-links a:hover, .nav-links a.active { color: var(--accent); }
    .nav-user { display: flex; align-items: center; gap: 8px; background: var(--card); border: 1px solid var(--border); padding: 6px 14px; border-radius: 20px; font-size: 13px; color: var(--accent); }

    /* Hero */
    .hero { background: linear-gradient(160deg, #0f0f1a 0%, #1a1428 60%, #0a0a0f 100%); padding: 48px; border-bottom: 1px solid var(--border); }
    .breadcrumb { font-size: 13px; color: var(--muted); margin-bottom: 12px; }
    .breadcrumb span { color: var(--accent); }
    .hero h1 { font-family: 'Syne', sans-serif; font-size: 36px; font-weight: 800; letter-spacing: -1px; }
    .hero h1 em { color: var(--accent); font-style: normal; }
    .hero p { color: var(--muted); font-size: 15px; margin-top: 8px; }

    /* Stats */
    .stats-bar { display: flex; background: var(--surface); border-bottom: 1px solid var(--border); padding: 0 48px; }
    .stat-item { padding: 20px 40px 20px 0; margin-right: 40px; border-right: 1px solid var(--border); }
    .stat-item:last-child { border-right: none; }
    .stat-num { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; color: var(--accent); }
    .stat-label { font-size: 12px; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; }

    /* Main */
    .main { padding: 48px; }
    .section-title { font-family: 'Syne', sans-serif; font-size: 20px; font-weight: 700; margin-bottom: 24px; }
    .section-title span { color: var(--accent); }

    /* Alert */
    .alert { padding: 12px 16px; border-radius: 8px; font-size: 13px; margin-bottom: 24px; }
    .alert-success { background: #40c08015; border: 1px solid #40c08040; color: var(--success); }

    /* Booking cards */
    .bookings-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 20px; margin-bottom: 48px; }

    .booking-card { background: var(--card); border: 1px solid var(--border); border-radius: 16px; overflow: hidden; transition: all 0.3s; }
    .booking-card:hover { border-color: #f0c04030; transform: translateY(-2px); }

    .booking-header { padding: 16px 20px; border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; background: #111118; }
    .booking-id { font-family: 'Syne', sans-serif; font-size: 13px; font-weight: 700; color: var(--accent); }
    .status-badge { font-size: 11px; font-weight: 600; padding: 4px 12px; border-radius: 20px; text-transform: uppercase; }
    .status-active { background: #40c08020; border: 1px solid #40c08050; color: var(--success); }
    .status-returned { background: #2a2a38; border: 1px solid var(--border); color: var(--muted); }
    .status-cancelled { background: #e0404015; border: 1px solid #e0404030; color: var(--danger); }

    .booking-body { padding: 20px; }
    .vehicle-name { font-family: 'Syne', sans-serif; font-size: 18px; font-weight: 700; margin-bottom: 12px; }
    .booking-detail { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid var(--border); font-size: 13px; }
    .booking-detail:last-of-type { border-bottom: none; }
    .detail-label { color: var(--muted); }
    .detail-value { font-weight: 500; }
    .total-price { font-family: 'Syne', sans-serif; font-size: 20px; font-weight: 800; color: var(--accent); margin-top: 16px; }

    .booking-actions { padding: 16px 20px; border-top: 1px solid var(--border); display: flex; gap: 8px; }
    .btn-feedback { flex: 1; padding: 8px; background: var(--accent); color: #000; border: none; border-radius: 8px; font-size: 13px; font-weight: 700; cursor: pointer; text-decoration: none; text-align: center; transition: all 0.2s; }
    .btn-feedback:hover { background: #ffd060; }

    /* Feedback form */
    .feedback-section { background: var(--card); border: 1px solid var(--border); border-radius: 16px; padding: 32px; }
    .feedback-section h3 { font-family: 'Syne', sans-serif; font-size: 18px; font-weight: 700; margin-bottom: 20px; }
    .feedback-section h3 span { color: var(--accent); }
    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 12px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
    input, select, textarea { width: 100%; background: #111118; border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 14px; padding: 12px 16px; border-radius: 10px; outline: none; transition: border 0.2s; }
    input:focus, select:focus, textarea:focus { border-color: var(--accent); }
    textarea { resize: vertical; min-height: 100px; }
    select option { background: #111118; }

    .stars { display: flex; gap: 8px; margin-top: 4px; }
    .star-btn { background: none; border: none; font-size: 28px; cursor: pointer; color: var(--border); transition: all 0.2s; }
    .star-btn:hover, .star-btn.active { color: var(--accent); transform: scale(1.1); }

    .btn-submit { background: var(--accent); color: #000; border: none; font-family: 'Syne', sans-serif; font-size: 15px; font-weight: 700; padding: 14px 32px; border-radius: 10px; cursor: pointer; transition: all 0.2s; }
    .btn-submit:hover { background: #ffd060; transform: translateY(-1px); }

    /* Empty state */
    .empty { text-align: center; padding: 60px 20px; background: var(--card); border: 1px solid var(--border); border-radius: 16px; margin-bottom: 48px; }
    .empty-icon { font-size: 56px; margin-bottom: 16px; }
    .empty h3 { font-family: 'Syne', sans-serif; font-size: 18px; margin-bottom: 8px; }
    .empty p { color: var(--muted); margin-bottom: 20px; }
    .btn-browse { display: inline-flex; background: var(--accent); color: #000; font-family: 'Syne', sans-serif; font-weight: 700; font-size: 14px; padding: 12px 24px; border-radius: 8px; text-decoration: none; }

    footer { margin-top: 80px; padding: 24px 48px; border-top: 1px solid var(--border); background: var(--surface); text-align: center; color: var(--muted); font-size: 13px; }
    footer strong { color: var(--accent); }
  </style>
</head>
<body>

<%
  User user = (User) request.getAttribute("user");
  List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
  if (user == null) { response.sendRedirect("login.jsp"); return; }

  int total = bookings != null ? bookings.size() : 0;
  int active = 0, returned = 0;
  if (bookings != null) {
    for (Booking b : bookings) {
      if ("active".equals(b.getStatus())) active++;
      else if ("returned".equals(b.getStatus())) returned++;
    }
  }
  String msg = request.getParameter("msg");
  String userName = user.getFullName();
%>

<nav>
  <a href="vehicles" class="logo">Easy Go<span> Drive</span></a>
  <ul class="nav-links">
    <li><a href="vehicles">Vehicles</a></li>
    <li><a href="myBookings" class="active">My Bookings</a></li>
    <li><a href="userProfile">My Profile</a></li>
    <li><span class="nav-user">👤 <%= userName %></span></li>
    <li><a href="logout" style="color:#e04040;">Logout</a></li>
  </ul>
</nav>

<div class="hero">
  <div class="breadcrumb">Home &rsaquo; <span>My Bookings</span></div>
  <h1>My <em>Bookings</em></h1>
  <p>View and manage all your vehicle rental bookings</p>
</div>

<div class="stats-bar">
  <div class="stat-item"><div class="stat-num"><%= total %></div><div class="stat-label">Total Bookings</div></div>
  <div class="stat-item"><div class="stat-num"><%= active %></div><div class="stat-label">Active</div></div>
  <div class="stat-item"><div class="stat-num"><%= returned %></div><div class="stat-label">Returned</div></div>
</div>

<div class="main">

  <% if ("feedback".equals(msg)) { %>
    <div class="alert alert-success">✅ Feedback submitted successfully! Thank you.</div>
  <% } %>

  <!-- Bookings -->
  <div class="section-title">My <span>Rental History</span></div>

  <div class="bookings-grid">
  <%
    if (bookings != null && !bookings.isEmpty()) {
      for (Booking b : bookings) {
        String statusClass = "status-active";
        if ("returned".equals(b.getStatus())) statusClass = "status-returned";
        else if ("cancelled".equals(b.getStatus())) statusClass = "status-cancelled";
  %>
    <div class="booking-card">
      <div class="booking-header">
        <span class="booking-id">#<%= b.getBookingId() %></span>
        <span class="status-badge <%= statusClass %>"><%= b.getStatus() %></span>
      </div>
      <div class="booking-body">
        <div class="vehicle-name">🚗 <%= b.getBrand() %> <%= b.getModel() %></div>
        <div class="booking-detail">
          <span class="detail-label">Vehicle ID</span>
          <span class="detail-value"><%= b.getVehicleId() %></span>
        </div>
        <div class="booking-detail">
          <span class="detail-label">Start Date</span>
          <span class="detail-value"><%= b.getStartDate() %></span>
        </div>
        <div class="booking-detail">
          <span class="detail-label">End Date</span>
          <span class="detail-value"><%= b.getEndDate() %></span>
        </div>
        <div class="total-price">Rs. <%= b.getTotalPrice() %></div>
      </div>
      <div class="booking-actions">
        <a href="feedback.jsp?vehicleId=<%= b.getVehicleId() %>&brand=<%= b.getBrand() %>&model=<%= b.getModel() %>" class="btn-feedback">⭐ Leave Feedback</a>
      </div>
    </div>
  <%
      }
    } else {
  %>
    <div class="empty">
      <div class="empty-icon">📋</div>
      <h3>No bookings yet</h3>
      <p>You haven't made any bookings. Browse our fleet to get started!</p>
      <a href="vehicles" class="btn-browse">🚗 Browse Vehicles</a>
    </div>
  <% } %>
  </div>

  <!-- Feedback Form -->
  <div class="section-title">Share Your <span>Experience</span></div>
  <div class="feedback-section">
    <h3>Submit <span>Feedback</span></h3>
    <form action="submitFeedback" method="post">
      <div class="form-group">
        <label>Vehicle ID</label>
        <input type="text" name="vehicleId" placeholder="Enter Vehicle ID (e.g. VEE355)" required>
      </div>
      <div class="form-group">
        <label>Your Rating</label>
        <input type="hidden" name="rating" id="ratingInput" value="5">
        <div class="stars">
          <button type="button" class="star-btn active" onclick="setRating(1)">★</button>
          <button type="button" class="star-btn active" onclick="setRating(2)">★</button>
          <button type="button" class="star-btn active" onclick="setRating(3)">★</button>
          <button type="button" class="star-btn active" onclick="setRating(4)">★</button>
          <button type="button" class="star-btn active" onclick="setRating(5)">★</button>
        </div>
      </div>
      <div class="form-group">
        <label>Your Comment</label>
        <textarea name="comment" placeholder="Tell us about your experience with this vehicle..." required></textarea>
      </div>
      <button type="submit" class="btn-submit">Submit Feedback</button>
    </form>
  </div>

</div>

<footer>&copy; 2026 <strong>Easy Go Drive</strong> Vehicle Rental System</footer>

<script>
  function setRating(val) {
    document.getElementById('ratingInput').value = val;
    const stars = document.querySelectorAll('.star-btn');
    stars.forEach((s, i) => {
      s.classList.toggle('active', i < val);
    });
  }
</script>

</body>
</html>