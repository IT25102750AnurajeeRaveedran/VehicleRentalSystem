<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.User, com.rental.model.Booking, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – Rental History</title>
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
    .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px 24px; color: var(--muted); text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; }
    .nav-item:hover { color: var(--text); background: #ffffff08; }
    .nav-item.active { color: var(--accent); background: #f0c04010; border-right: 3px solid var(--accent); }
    .nav-icon { font-size: 18px; width: 24px; }
    .nav-divider { height: 1px; background: var(--border); margin: 8px 24px; }
    .sidebar-footer { padding: 16px 24px; border-top: 1px solid var(--border); }
    .admin-info { display: flex; align-items: center; gap: 10px; margin-bottom: 12px; }
    .admin-avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--accent), #e05c2a); display: flex; align-items: center; justify-content: center; font-family: 'Syne', sans-serif; font-weight: 800; font-size: 14px; color: #000; }
    .admin-name { font-size: 13px; font-weight: 600; }
    .admin-role { font-size: 11px; color: var(--muted); }
    .btn-logout { display: block; width: 100%; padding: 8px; background: #e0404015; border: 1px solid #e0404030; color: var(--danger); border-radius: 8px; font-size: 13px; font-weight: 600; text-align: center; text-decoration: none; }
    .btn-logout:hover { background: #e0404025; }
    .main { margin-left: 240px; flex: 1; padding: 40px; }
    .page-header { margin-bottom: 32px; }
    .page-header h1 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 4px; }
    .page-header h1 span { color: var(--accent); }
    .page-header p { color: var(--muted); font-size: 14px; }
    .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 32px; }
    .stat-card { background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 20px; }
    .stat-val { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 4px; }
    .stat-val.yellow { color: var(--accent); }
    .stat-val.green { color: var(--success); }
    .stat-val.red { color: var(--danger); }
    .stat-val.blue { color: var(--info); }
    .stat-label { font-size: 12px; color: var(--muted); }
    .stat-icon { font-size: 20px; margin-bottom: 8px; }
    .revenue-banner { background: linear-gradient(135deg, #1a1428, #0f1a28); border: 1px solid #f0c04030; border-radius: 16px; padding: 28px 32px; margin-bottom: 32px; display: flex; align-items: center; justify-content: space-between; }
    .revenue-label { font-size: 14px; color: var(--muted); margin-bottom: 4px; }
    .revenue-val { font-family: 'Syne', sans-serif; font-size: 40px; font-weight: 800; color: var(--accent); }
    .revenue-icon { font-size: 48px; }
    .table-wrap { background: var(--card); border: 1px solid var(--border); border-radius: 16px; overflow: hidden; }
    table { width: 100%; border-collapse: collapse; }
    thead { background: #111118; border-bottom: 1px solid var(--border); }
    thead th { padding: 14px 16px; text-align: left; font-size: 11px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; }
    tbody tr { border-bottom: 1px solid var(--border); transition: background 0.15s; }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: #1f1f2e; }
    tbody td { padding: 14px 16px; font-size: 13px; }
    .id-badge { font-family: 'Syne', sans-serif; font-size: 11px; color: var(--accent); background: #f0c04012; border: 1px solid #f0c04030; padding: 2px 8px; border-radius: 6px; }
    .status-pill { font-size: 11px; font-weight: 600; padding: 3px 10px; border-radius: 20px; }
    .s-active { background: #40c08020; border: 1px solid #40c08050; color: var(--success); }
    .s-returned { background: #2a2a38; border: 1px solid var(--border); color: var(--muted); }
    .s-cancelled { background: #e0404015; border: 1px solid #e0404030; color: var(--danger); }
    .empty-table { text-align: center; padding: 48px; color: var(--muted); font-size: 14px; }
    .section-title { font-family: 'Syne', sans-serif; font-size: 18px; font-weight: 700; margin-bottom: 16px; }
    .section-title span { color: var(--accent); }
  </style>
</head>
<body>

<%
  User adminUser = (User) request.getAttribute("adminUser");
  List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
  if (adminUser == null) { response.sendRedirect("login.jsp"); return; }

  String initials = "";
  for (String p : adminUser.getFullName().split(" "))
    if (!p.isEmpty()) initials += p.charAt(0);
  if (initials.length() > 2) initials = initials.substring(0, 2);

  double totalRevenue  = (Double)  request.getAttribute("totalRevenue");
  int activeCount      = (Integer) request.getAttribute("activeCount");
  int returnedCount    = (Integer) request.getAttribute("returnedCount");
  int cancelledCount   = (Integer) request.getAttribute("cancelledCount");
  int totalBookings    = bookings != null ? bookings.size() : 0;
%>

<div class="sidebar">
  <div class="sidebar-logo">
    <div class="logo">Easy Go<span> Drive</span></div>
    <div class="admin-badge">Admin Panel</div>
  </div>
  <nav class="sidebar-nav">
    <a href="adminDashboard" class="nav-item"><span class="nav-icon">📊</span> Dashboard</a>
    <a href="manageUsers" class="nav-item"><span class="nav-icon">👥</span> Manage Users</a>
    <a href="vehicles" class="nav-item"><span class="nav-icon">🚗</span> Vehicles</a>
    <a href="rentalHistory" class="nav-item active"><span class="nav-icon">📋</span> Rental History</a>
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
  <div class="page-header">
    <h1>Rental <span>History</span></h1>
    <p>Complete overview of all vehicle rental transactions</p>
  </div>

  <div class="stats-grid">
    <div class="stat-card">
      <div class="stat-icon">📋</div>
      <div class="stat-val yellow"><%= totalBookings %></div>
      <div class="stat-label">Total Bookings</div>
    </div>
    <div class="stat-card">
      <div class="stat-icon">🔑</div>
      <div class="stat-val green"><%= activeCount %></div>
      <div class="stat-label">Active Rentals</div>
    </div>
    <div class="stat-card">
      <div class="stat-icon">✅</div>
      <div class="stat-val blue"><%= returnedCount %></div>
      <div class="stat-label">Returned</div>
    </div>
    <div class="stat-card">
      <div class="stat-icon">❌</div>
      <div class="stat-val red"><%= cancelledCount %></div>
      <div class="stat-label">Cancelled</div>
    </div>
  </div>

  <div class="revenue-banner">
    <div>
      <div class="revenue-label">💰 Total Revenue Earned</div>
      <div class="revenue-val">Rs. <%= String.format("%.2f", totalRevenue) %></div>
    </div>
    <div class="revenue-icon">💳</div>
  </div>

  <div class="section-title">All <span>Transactions</span></div>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Booking ID</th>
          <th>User ID</th>
          <th>Vehicle</th>
          <th>Vehicle ID</th>
          <th>Start Date</th>
          <th>End Date</th>
          <th>Total Price</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
      <%
        if (bookings != null && !bookings.isEmpty()) {
          for (Booking b : bookings) {
            String sc = "s-active";
            if ("returned".equals(b.getStatus())) sc = "s-returned";
            else if ("cancelled".equals(b.getStatus())) sc = "s-cancelled";
      %>
        <tr>
          <td><span class="id-badge">#<%= b.getBookingId() %></span></td>
          <td><%= b.getUserId() %></td>
          <td><strong><%= b.getBrand() %> <%= b.getModel() %></strong></td>
          <td><%= b.getVehicleId() %></td>
          <td><%= b.getStartDate() %></td>
          <td><%= b.getEndDate() %></td>
          <td><strong style="color:var(--accent)">Rs. <%= b.getTotalPrice() %></strong></td>
          <td><span class="status-pill <%= sc %>"><%= b.getStatus() %></span></td>
        </tr>
      <%
          }
        } else {
      %>
        <tr><td colspan="8" class="empty-table">📋 No rental history found</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>