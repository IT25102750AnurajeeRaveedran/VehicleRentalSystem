<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – My Profile</title>
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
    .nav-links a:hover { color: var(--accent); }
    .nav-user { display: flex; align-items: center; gap: 8px; background: var(--card); border: 1px solid var(--border); padding: 6px 14px; border-radius: 20px; font-size: 13px; color: var(--accent); }

    .page { max-width: 900px; margin: 48px auto; padding: 0 24px; }

    /* Profile Header */
    .profile-header {
      background: linear-gradient(135deg, #1a1428, #0f0f1a);
      border: 1px solid var(--border); border-radius: 20px;
      padding: 40px; margin-bottom: 24px;
      display: flex; align-items: center; gap: 32px; position: relative; overflow: hidden;
    }
    .profile-header::before {
      content: ''; position: absolute; top: -40px; right: -40px;
      width: 200px; height: 200px; border-radius: 50%;
      background: radial-gradient(circle, #f0c04015, transparent 70%);
    }
    .avatar {
      width: 100px; height: 100px; border-radius: 50%;
      background: linear-gradient(135deg, var(--accent), #e05c2a);
      display: flex; align-items: center; justify-content: center;
      font-family: 'Syne', sans-serif; font-size: 36px; font-weight: 800;
      color: #000; flex-shrink: 0;
    }
    .profile-info h1 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 6px; }
    .profile-info p { color: var(--muted); font-size: 14px; margin-bottom: 4px; }
    .role-badge { display: inline-flex; align-items: center; gap: 6px; background: #f0c04015; border: 1px solid #f0c04030; color: var(--accent); font-size: 12px; font-weight: 600; padding: 4px 12px; border-radius: 20px; text-transform: uppercase; letter-spacing: 0.5px; margin-top: 8px; }

    /* Alert */
    .alert { padding: 12px 16px; border-radius: 8px; font-size: 13px; margin-bottom: 24px; }
    .alert-success { background: #40c08015; border: 1px solid #40c08040; color: var(--success); }
    .alert-error { background: #e0404015; border: 1px solid #e0404040; color: var(--danger); }

    /* Grid */
    .grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }

    /* Cards */
    .card { background: var(--card); border: 1px solid var(--border); border-radius: 16px; padding: 28px; }
    .card-title { font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; margin-bottom: 20px; display: flex; align-items: center; gap: 8px; }
    .card-title span { color: var(--accent); }

    .info-row { display: flex; justify-content: space-between; align-items: center; padding: 12px 0; border-bottom: 1px solid var(--border); }
    .info-row:last-child { border-bottom: none; }
    .info-label { font-size: 12px; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; }
    .info-value { font-size: 14px; font-weight: 500; }

    /* Action buttons */
    .actions { display: flex; flex-direction: column; gap: 12px; margin-top: 8px; }
    .btn { display: block; text-align: center; padding: 12px 24px; border-radius: 10px; font-family: 'Syne', sans-serif; font-size: 14px; font-weight: 700; text-decoration: none; transition: all 0.2s; cursor: pointer; border: none; width: 100%; }
    .btn-primary { background: var(--accent); color: #000; }
    .btn-primary:hover { background: #ffd060; transform: translateY(-1px); }
    .btn-secondary { background: var(--card); border: 1px solid var(--border); color: var(--text); }
    .btn-secondary:hover { border-color: var(--accent); color: var(--accent); }
    .btn-danger { background: #e0404015; border: 1px solid #e0404030; color: var(--danger); }
    .btn-danger:hover { background: #e0404025; }

    /* Delete confirm */
    .delete-section { margin-top: 24px; background: #e0404008; border: 1px solid #e0404025; border-radius: 16px; padding: 28px; }
    .delete-section h3 { font-family: 'Syne', sans-serif; font-size: 16px; color: var(--danger); margin-bottom: 8px; }
    .delete-section p { font-size: 13px; color: var(--muted); margin-bottom: 16px; line-height: 1.6; }

    footer { margin-top: 80px; padding: 24px 48px; border-top: 1px solid var(--border); background: var(--surface); text-align: center; color: var(--muted); font-size: 13px; }
    footer strong { color: var(--accent); }
  </style>
</head>
<body>

<%
  User user = (User) request.getAttribute("user");
  if (user == null) { response.sendRedirect("login.jsp"); return; }
  String initials = "";
  String[] nameParts = user.getFullName().split(" ");
  for (String part : nameParts) if (!part.isEmpty()) initials += part.charAt(0);
  if (initials.length() > 2) initials = initials.substring(0, 2);
  String msg = request.getParameter("msg");
%>

<nav>
  <a href="vehicles" class="logo">Easy Go<span> Drive</span></a>
  <ul class="nav-links">
    <li><a href="vehicles">Home</a></li>
    <li><a href="vehicles">Vehicles</a></li>
    <li><a href="userProfile">My Profile</a></li>
    <li><a href="logout" style="color:#e04040;">Logout</a></li>
  </ul>
</nav>

<div class="page">

  <% if ("updated".equals(msg)) { %>
    <div class="alert alert-success">✅ Profile updated successfully!</div>
  <% } %>

  <!-- Profile Header -->
  <div class="profile-header">
    <div class="avatar"><%= initials.toUpperCase() %></div>
    <div class="profile-info">
      <h1><%= user.getFullName() %></h1>
      <p>📧 <%= user.getEmail() %></p>
      <p>📞 <%= user.getPhone() %></p>
      <div class="role-badge">⭐ <%= user.getRole().toUpperCase() %></div>
    </div>
  </div>

  <div class="grid-2">

    <!-- Account Details -->
    <div class="card">
      <div class="card-title">👤 Account <span>Details</span></div>
      <div class="info-row">
        <span class="info-label">User ID</span>
        <span class="info-value" style="color:var(--accent)"><%= user.getUserId() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Full Name</span>
        <span class="info-value"><%= user.getFullName() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Email</span>
        <span class="info-value"><%= user.getEmail() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Phone</span>
        <span class="info-value"><%= user.getPhone() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Role</span>
        <span class="info-value"><%= user.getRole() %></span>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="card">
      <div class="card-title">⚡ Quick <span>Actions</span></div>
      <div class="actions">
        <a href="editProfile.jsp" class="btn btn-primary">✏️ Edit Profile</a>
        <a href="vehicles" class="btn btn-secondary">🚗 Browse Vehicles</a>
        <a href="logout" class="btn btn-secondary">🚪 Logout</a>
      </div>
    </div>

  </div>

  <!-- Delete Account -->
  <div class="delete-section">
    <h3>⚠️ Delete Account</h3>
    <p>Once you delete your account all your data will be permanently removed. This action cannot be undone. Please be certain before proceeding.</p>
    <form action="deleteAccount" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This cannot be undone!');">
      <button type="submit" class="btn btn-danger">🗑️ Delete My Account</button>
    </form>
  </div>

</div>

<footer>&copy; 2026 <strong>Easy Go Drive</strong> Vehicle Rental System</footer>

</body>
</html>