<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Notifications</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    body{font-family:'DM Sans',sans-serif;background:#0a0a0f;color:#f7f3ed;margin:0}
    .shell{max-width:1100px;margin:24px auto;padding:20px}
    .card{background:#14141d;border:1px solid rgba(255,255,255,0.04);padding:18px;border-radius:12px}
    h1{font-family:'Syne',sans-serif;margin:0 0 12px}
    ul{list-style:none;padding:0;margin:12px 0}
    li{padding:12px;border-radius:8px;background:#111118;border:1px solid rgba(255,255,255,0.02);margin-bottom:8px}
    .empty{color:#a0a0b2}
    a.back{display:inline-block;margin-top:12px;color:#f0c040;text-decoration:none}
  </style>
</head>
<body>
<div class="shell">
  <div class="card">
    <h1>Notifications</h1>
    <%
      List<String> notifications = (List<String>) request.getAttribute("notifications");
      if (notifications == null || notifications.isEmpty()) {
    %>
      <div class="empty">No notifications</div>
    <%
      } else {
    %>
      <ul>
      <% for (String n : notifications) { %>
        <li><%= n %></li>
      <% } %>
      </ul>
    <% } %>
    <a href="adminDashboard" class="back">← Back to Dashboard</a>
  </div>
</div>
</body>
</html>

