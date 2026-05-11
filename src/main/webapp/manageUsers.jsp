<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.User, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – Manage Users</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root { --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24; --border: #2a2a38; --accent: #f0c040; --text: #f0ede8; --muted: #7a7a8a; --danger: #e04040; --success: #40c080; }
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
    .btn-logout { display: block; width: 100%; padding: 8px; background: #e0404015; border: 1px solid #e0404030; color: var(--danger); border-radius: 8px; font-size: 13px; font-weight: 600; text-align: center; text-decoration: none; transition: all 0.2s; }
    .btn-logout:hover { background: #e0404025; }

    .main { margin-left: 240px; flex: 1; padding: 40px; }
    .page-header { margin-bottom: 32px; }
    .page-header h1 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 4px; }
    .page-header h1 span { color: var(--accent); }
    .page-header p { color: var(--muted); font-size: 14px; }

    .alert { padding: 12px 16px; border-radius: 8px; font-size: 13px; margin-bottom: 24px; }
    .alert-success { background: #40c08015; border: 1px solid #40c08040; color: var(--success); }
    .alert-error { background: #e0404015; border: 1px solid #e0404040; color: var(--danger); }

    /* Stats */
    .stats-row { display: flex; gap: 16px; margin-bottom: 28px; }
    .stat-mini { background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 16px 24px; flex: 1; }
    .stat-mini-val { font-family: 'Syne', sans-serif; font-size: 24px; font-weight: 800; color: var(--accent); }
    .stat-mini-label { font-size: 12px; color: var(--muted); margin-top: 2px; }

    /* Table */
    .table-wrap { background: var(--card); border: 1px solid var(--border); border-radius: 16px; overflow: hidden; }
    table { width: 100%; border-collapse: collapse; }
    thead { background: #111118; border-bottom: 1px solid var(--border); }
    thead th { padding: 14px 16px; text-align: left; font-size: 11px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; }
    tbody tr { border-bottom: 1px solid var(--border); transition: background 0.15s; }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: #1f1f2e; }
    tbody td { padding: 16px; font-size: 13px; vertical-align: middle; }

    .user-cell { display: flex; align-items: center; gap: 12px; }
    .user-avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--accent), #e05c2a); display: flex; align-items: center; justify-content: center; font-family: 'Syne', sans-serif; font-weight: 800; font-size: 13px; color: #000; flex-shrink: 0; }
    .user-name { font-weight: 600; font-size: 14px; }
    .user-email { font-size: 12px; color: var(--muted); }

    .id-badge { font-family: 'Syne', sans-serif; font-size: 11px; color: var(--accent); background: #f0c04012; border: 1px solid #f0c04030; padding: 2px 8px; border-radius: 6px; }
    .role-badge { font-size: 11px; font-weight: 600; padding: 3px 10px; border-radius: 20px; }
    .role-admin { background: #e0404020; border: 1px solid #e0404040; color: var(--danger); }
    .role-user { background: #40c08015; border: 1px solid #40c08030; color: var(--success); }

    .btn-delete { padding: 6px 14px; background: #e0404015; border: 1px solid #e0404030; color: var(--danger); border-radius: 6px; font-size: 12px; font-weight: 600; text-decoration: none; transition: all 0.15s; }
    .btn-delete:hover { background: #e0404025; }
    .btn-self { padding: 6px 14px; background: #2a2a38; border: 1px solid var(--border); color: var(--muted); border-radius: 6px; font-size: 12px; cursor: not-allowed; }

    .empty-table { text-align: center; padding: 40px; color: var(--muted); }
  </style>
</head>
<body>

<%
  User adminUser = (User) request.getAttribute("adminUser");
  List<User> users = (List<User>) request.getAttribute("users");
  if (adminUser == null) { response.sendRedirect("login.jsp"); return; }

  String initials = "";
  for (String p : adminUser.getFullName().split(" "))
    if (!p.isEmpty()) initials += p.charAt(0);
  if (initials.length() > 2) initials = initials.substring(0, 2);

  String msg   = request.getParameter("msg");
  String error = request.getParameter("error");

  int totalUsers = users != null ? users.size() : 0;
  int adminCount = 0, userCount = 0;
  if (users != null) {
    for (User u : users) {
      if ("admin".equals(u.getRole())) adminCount++;
      else userCount++;
    }
  }
%>

<div class="sidebar">
  <div class="sidebar-logo">
    <div class="logo">Easy Go<span> Drive</span></div>
    <div class="admin-badge">Admin Panel</div>
  </div>
  <nav class="sidebar-nav">
    <a href="adminDashboard" class="nav-item"><span class="nav-icon">📊</span> Dashboard</a>
    <a href="manageUsers" class="nav-item active"><span class="nav-icon">👥</span> Manage Users</a>
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
  <div class="page-header">
    <h1>Manage <span>Users</span></h1>
    <p>View and manage all registered users in the system</p>
  </div>

  <% if ("deleted".equals(msg)) { %>
    <div class="alert alert-success">✅ User deleted successfully!</div>
  <% } %>
  <% if ("selfdelete".equals(error)) { %>
    <div class="alert alert-error">❌ You cannot delete your own account!</div>
  <% } %>

  <div class="stats-row">
    <div class="stat-mini"><div class="stat-mini-val"><%= totalUsers %></div><div class="stat-mini-label">Total Users</div></div>
    <div class="stat-mini"><div class="stat-mini-val"><%= adminCount %></div><div class="stat-mini-label">Admins</div></div>
    <div class="stat-mini"><div class="stat-mini-val"><%= userCount %></div><div class="stat-mini-label">Regular Users</div></div>
  </div>

  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>User</th>
          <th>User ID</th>
          <th>Phone</th>
          <th>Role</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
      <%
        if (users != null && !users.isEmpty()) {
          for (User u : users) {
            String ui = "";
            for (String p : u.getFullName().split(" "))
              if (!p.isEmpty()) ui += p.charAt(0);
            if (ui.length() > 2) ui = ui.substring(0, 2);
      %>
        <tr>
          <td>
            <div class="user-cell">
              <div class="user-avatar"><%= ui.toUpperCase() %></div>
              <div>
                <div class="user-name"><%= u.getFullName() %></div>
                <div class="user-email"><%= u.getEmail() %></div>
              </div>
            </div>
          </td>
          <td><span class="id-badge"><%= u.getUserId() %></span></td>
          <td><%= u.getPhone() %></td>
          <td><span class="role-badge <%= "admin".equals(u.getRole()) ? "role-admin" : "role-user" %>"><%= u.getRole() %></span></td>
          <td>
            <% if (u.getUserId().equals(adminUser.getUserId())) { %>
              <span class="btn-self">You</span>
            <% } else { %>
              <a href="deleteUser?userId=<%= u.getUserId() %>" class="btn-delete" onclick="return confirm('Delete this user?')">🗑️ Delete</a>
            <% } %>
          </td>
        </tr>
      <%
          }
        } else {
      %>
        <tr><td colspan="5" class="empty-table">No users found</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>