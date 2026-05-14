<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.User, com.rental.model.Booking, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go – Admin Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root { --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24; --border: #2a2a38; --accent: #f0c040; --text: #f0ede8; --muted: #7a7a8a; --danger: #e04040; --success: #40c080; --info: #4080e0; }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; display: flex; }
    .sidebar { width: 240px; background: var(--surface); border-right: 1px solid var(--border); min-height: 100vh; position: fixed; top: 0; left: 0; z-index: 100; display: flex; flex-direction: column; }
    .sidebar-logo { padding: 24px; border-bottom: 1px solid var(--border); }
    .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 20px; }
    .logo span { color: var(--accent); }
    .admin-badge { display: inline-block; background: #e0404020; border: 1px solid #e0404040; color: var(--danger); font-size: 10px; font-weight: 700; padding: 2px 8px; border-radius: 10px; text-transform: uppercase; margin-top: 4px; letter-spacing: 1px; }
    .sidebar-nav { padding: 16px 0; flex: 1; }
    .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px 24px; color: var(--muted); text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; cursor: pointer; border: none; background: none; width: 100%; text-align: left; }
    .nav-item:hover { color: var(--text); background: #ffffff08; }
    .nav-item.active { color: var(--accent); background: #f0c04010; border-right: 3px solid var(--accent); }
    .nav-icon { font-size: 18px; width: 24px; }
    .nav-divider { height: 1px; background: var(--border); margin: 8px 24px; }
    .sidebar-footer { padding: 16px 24px; border-top: 1px solid var(--border); }
    .admin-info { display: flex; align-items: center; gap: 10px; margin-bottom: 12px; }
    .admin-avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--accent), #e05c2a); display: flex; align-items: center; justify-content: center; font-family: 'Syne', sans-serif; font-weight: 800; font-size: 14px; color: #000; flex-shrink: 0; }
    .admin-name { font-size: 13px; font-weight: 600; }
    .admin-role { font-size: 11px; color: var(--muted); }
    .btn-logout { display: block; width: 100%; padding: 8px; background: #e0404015; border: 1px solid #e0404030; color: var(--danger); border-radius: 8px; font-size: 13px; font-weight: 600; text-align: center; text-decoration: none; transition: all 0.2s; }
    .btn-logout:hover { background: #e0404025; }
    .main { margin-left: 240px; flex: 1; padding: 28px 40px; }
    .topbar { display: flex; align-items: center; justify-content: space-between; gap: 12px; margin-bottom: 18px; }
    .search { display: flex; align-items: center; gap: 8px; background: #0f0f16; border: 1px solid var(--border); padding: 8px 12px; border-radius: 12px; }
    .search input { background: transparent; border: none; outline: none; color: var(--muted); width: 220px; }
    .top-actions { display: flex; align-items: center; gap: 12px; }
    .icon-btn { background: transparent; border: 1px solid transparent; padding: 8px 10px; border-radius: 10px; color: var(--muted); cursor: pointer; }
    .icon-btn:hover { background: #ffffff06; color: var(--text); }
    .profile { display: flex; align-items: center; gap: 10px; padding: 6px 10px; border-radius: 12px; background: #0f0f16; border: 1px solid var(--border); }
    .profile .name { font-size: 13px; font-weight: 600; }
    .page-header { margin-bottom: 8px; }
    .page-header h1 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 4px; }
    .page-header h1 span { color: var(--accent); }
    .page-header p { color: var(--muted); font-size: 14px; }
    .stats-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 32px; }
    .stat-card { background: var(--card); border: 1px solid var(--border); border-radius: 16px; padding: 24px; position: relative; overflow: hidden; transition: all 0.3s; }
    .stat-card:hover { transform: translateY(-2px); box-shadow: 0 8px 24px #00000040; }
    .stat-card::before { content: ''; position: absolute; top: -20px; right: -20px; width: 80px; height: 80px; border-radius: 50%; opacity: 0.1; }
    .stat-card.yellow::before { background: var(--accent); }
    .stat-card.green::before { background: var(--success); }
    .stat-card.red::before { background: var(--danger); }
    .stat-card.blue::before { background: var(--info); }
    .stat-icon { font-size: 28px; margin-bottom: 12px; }
    .stat-val { font-family: 'Syne', sans-serif; font-size: 36px; font-weight: 800; margin-bottom: 4px; }
    .stat-card.yellow .stat-val { color: var(--accent); }
    .stat-card.green .stat-val { color: var(--success); }
    .stat-card.red .stat-val { color: var(--danger); }
    .stat-card.blue .stat-val { color: var(--info); }
    .stat-label { font-size: 13px; color: var(--muted); }
    .section-title { font-family: 'Syne', sans-serif; font-size: 18px; font-weight: 700; margin-bottom: 16px; }
    .section-title span { color: var(--accent); }
    .quick-actions { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; margin-bottom: 28px; }
    .action-btn { background: linear-gradient(180deg,#171722,#111118); border: 1px solid rgba(255,255,255,0.04); border-radius: 12px; padding: 18px; text-align: center; text-decoration: none; color: var(--text); transition: transform 0.18s ease, box-shadow 0.18s ease; display: flex; flex-direction: column; gap: 8px; align-items: center; }
    .action-btn:hover { transform: translateY(-6px); box-shadow: 0 12px 30px rgba(0,0,0,0.45); }
    .action-icon { font-size: 26px; margin-bottom: 4px; }
    .action-label { font-size: 14px; font-weight: 700; }
    .table-wrap { background: var(--card); border: 1px solid var(--border); border-radius: 16px; overflow: hidden; }
    table { width: 100%; border-collapse: collapse; }
    thead { background: #111118; border-bottom: 1px solid var(--border); }
    thead th { padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; }
    tbody tr { border-bottom: 1px solid var(--border); transition: background 0.15s; }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: #1f1f2e; }
    tbody td { padding: 14px 16px; font-size: 13px; }
    .id-badge { font-family: 'Syne', sans-serif; font-size: 11px; color: var(--accent); background: #f0c04012; border: 1px solid #f0c04030; padding: 2px 8px; border-radius: 6px; }
    .status-pill { font-size: 11px; font-weight: 600; padding: 3px 10px; border-radius: 20px; }
    .s-active { background: #40c08020; border: 1px solid #40c08050; color: var(--success); }
    .s-returned { background: #2a2a38; border: 1px solid var(--border); color: var(--muted); }
    .s-cancelled { background: #e0404015; border: 1px solid #e0404030; color: var(--danger); }
    .empty-table { text-align: center; padding: 40px; color: var(--muted); font-size: 14px; }
    @media (max-width: 880px) {
      .sidebar { position: relative; width: 100%; height: auto; display: block; }
      .main { margin-left: 0; padding: 18px; }
      .stats-grid { grid-template-columns: repeat(2,1fr); }
      .quick-actions { grid-template-columns: repeat(2,1fr); }
    }
    @media (max-width: 560px) {
      .stats-grid { grid-template-columns: 1fr; }
      .quick-actions { grid-template-columns: 1fr; }
      .search input { width: 120px; }
    }
  </style>
</head>
<body>

<%
  User adminUser = (User) request.getAttribute("adminUser");
  if (adminUser == null) { response.sendRedirect("login.jsp"); return; }

  int totalUsers        = (Integer) request.getAttribute("totalUsers");
  int totalVehicles     = (Integer) request.getAttribute("totalVehicles");
  int totalBookings     = (Integer) request.getAttribute("totalBookings");
  int activeBookings    = (Integer) request.getAttribute("activeBookings");
  int availableVehicles = (Integer) request.getAttribute("availableVehicles");
  double totalRevenue   = (Double)  request.getAttribute("totalRevenue");

  List<Booking> recentBookings = (List<Booking>) request.getAttribute("recentBookings");

  String initials = "";
  for (String p : adminUser.getFullName().split(" "))
    if (!p.isEmpty()) initials += p.charAt(0);
  if (initials.length() > 2) initials = initials.substring(0, 2);
%>

<div class="sidebar">
  <div class="sidebar-logo">
    <div class="logo">Easy <span>Go</span></div>
    <div class="admin-badge">Admin Panel</div>
  </div>
  <nav class="sidebar-nav">
    <a href="adminDashboard" class="nav-item active"><span class="nav-icon">📊</span> Dashboard</a>
    <a href="manageUsers" class="nav-item"><span class="nav-icon">👥</span> Manage Users</a>
    <a href="vehicles" class="nav-item"><span class="nav-icon">🚗</span> Vehicles</a>
    <a href="rentalHistory" class="nav-item"><span class="nav-icon">📋</span> Rental History</a>
    <div class="nav-divider"></div>
    <a href="vehicles" class="nav-item"><span class="nav-icon">🏠</span> Main Site</a>
  </nav>
  <div class="sidebar-footer">
    <div class="admin-info">
      <div class="admin-avatar"><%= initials.toUpperCase() %></div>
      <div>
        <div class="admin-name"><%= adminUser.getFullName() %></div>
        <div class="admin-role">Administrator</div>
      </div>
    </div>
    <a href="logout" class="btn-logout">🚪 Logout</a>
  </div>
</div>

<div class="main">
  <div class="topbar">
    <div class="search">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M21 21l-4.35-4.35" stroke="#9aa0ad" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>
      <input type="text" placeholder="Search users, bookings, vehicles...">
    </div>
    <div class="top-actions">
      <button class="icon-btn" title="Notifications">🔔</button>
      <button class="icon-btn" title="Support">💬</button>
      <div class="profile">
        <div class="admin-avatar"><%= initials.toUpperCase() %></div>
        <div class="name"><%= adminUser.getFullName().split(" ")[0] %></div>
      </div>
    </div>
  </div>

  <div class="page-header">
    <h1>Admin <span>Dashboard</span></h1>
    <p>Welcome back, <%= adminUser.getFullName() %>! Here's your system overview.</p>
  </div>

  <div class="stats-grid">
    <div class="stat-card yellow">
      <div class="stat-icon">👥</div>
      <div class="stat-val"><%= totalUsers %></div>
      <div class="stat-label">Total Users</div>
    </div>
    <div class="stat-card green">
      <div class="stat-icon">🚗</div>
      <div class="stat-val"><%= totalVehicles %></div>
      <div class="stat-label">Total Vehicles</div>
    </div>
    <div class="stat-card blue">
      <div class="stat-icon">📋</div>
      <div class="stat-val"><%= totalBookings %></div>
      <div class="stat-label">Total Bookings</div>
    </div>
    <div class="stat-card green">
      <div class="stat-icon">✅</div>
      <div class="stat-val"><%= availableVehicles %></div>
      <div class="stat-label">Available Vehicles</div>
    </div>
    <div class="stat-card yellow">
      <div class="stat-icon">🔑</div>
      <div class="stat-val"><%= activeBookings %></div>
      <div class="stat-label">Active Rentals</div>
    </div>
  </div>

  <div class="section-title">Quick <span>Actions</span></div>
  <div class="quick-actions">
    <a href="manageUsers" class="action-btn">
      <div class="action-icon">👥</div>
      <div class="action-label">Manage Users</div>
    </a>
    <a href="addVehicle.jsp" class="action-btn">
      <div class="action-icon">➕</div>
      <div class="action-label">Add Vehicle</div>
    </a>
    <a href="rentalHistory" class="action-btn">
      <div class="action-icon">📋</div>
      <div class="action-label">Rental History</div>
    </a>
  </div>

  <div class="section-title">Recent <span>Bookings</span></div>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Booking ID</th>
          <th>User ID</th>
          <th>Vehicle</th>
          <th>Start Date</th>
          <th>End Date</th>
          <th>Total</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
      <%
        if (recentBookings != null && !recentBookings.isEmpty()) {
          for (Booking b : recentBookings) {
            String sc = "s-active";
            if ("returned".equals(b.getStatus())) sc = "s-returned";
            else if ("cancelled".equals(b.getStatus())) sc = "s-cancelled";
      %>
        <tr>
          <td><span class="id-badge">#<%= b.getBookingId() %></span></td>
          <td><%= b.getUserId() %></td>
          <td><%= b.getBrand() %> <%= b.getModel() %></td>
          <td><%= b.getStartDate() %></td>
          <td><%= b.getEndDate() %></td>
          <td><strong>Rs. <%= b.getTotalPrice() %></strong></td>
          <td><span class="status-pill <%= sc %>"><%= b.getStatus() %></span></td>
        </tr>
      <%
          }
        } else {
      %>
        <tr><td colspan="7" class="empty-table">No bookings yet</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>