<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – Edit Profile</title>
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

    .page { flex: 1; max-width: 560px; margin: 48px auto; padding: 0 24px; width: 100%; }
    .back { color: var(--muted); font-size: 13px; text-decoration: none; display: flex; align-items: center; gap: 6px; margin-bottom: 28px; }
    .back:hover { color: var(--text); }

    .card { background: var(--card); border: 1px solid var(--border); border-radius: 20px; padding: 40px; }
    .card-header { margin-bottom: 32px; }
    .card-header h1 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 6px; }
    .card-header h1 span { color: var(--accent); }
    .card-header p { color: var(--muted); font-size: 14px; }

    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 12px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
    input { width: 100%; background: #111118; border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 15px; padding: 12px 16px; border-radius: 10px; outline: none; transition: border 0.2s; }
    input:focus { border-color: var(--accent); }
    input:disabled { opacity: 0.5; cursor: not-allowed; }

    .hint { font-size: 12px; color: var(--muted); margin-top: 6px; }

    .btn-submit { width: 100%; background: var(--accent); color: #000; border: none; font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; padding: 14px; border-radius: 10px; cursor: pointer; margin-top: 8px; transition: all 0.2s; }
    .btn-submit:hover { background: #ffd060; transform: translateY(-1px); }
    .btn-cancel { display: block; text-align: center; margin-top: 14px; color: var(--muted); font-size: 14px; text-decoration: none; }
    .btn-cancel:hover { color: var(--text); }

    .divider { height: 1px; background: var(--border); margin: 24px 0; }
    .section-label { font-size: 11px; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 16px; }

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
  User user = (User) sess.getAttribute("loggedUser");
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
  <a href="userProfile" class="back">&#8592; Back to Profile</a>

  <div class="card">
    <div class="card-header">
      <h1>Edit <span>Profile</span></h1>
      <p>Update your personal information below</p>
    </div>

    <form action="editProfile" method="post">

      <div class="section-label">Personal Information</div>

      <div class="form-group">
        <label>Full Name</label>
        <input type="text" name="fullName" value="<%= user.getFullName() %>" required>
      </div>

      <div class="form-group">
        <label>Email Address</label>
        <input type="email" value="<%= user.getEmail() %>" disabled>
        <div class="hint">💡 Email cannot be changed</div>
      </div>

      <div class="form-group">
        <label>Phone Number</label>
        <input type="tel" name="phone" value="<%= user.getPhone() %>" required>
      </div>

      <div class="divider"></div>
      <div class="section-label">Change Password (Optional)</div>

      <div class="form-group">
        <label>New Password</label>
        <input type="password" name="password" placeholder="Leave blank to keep current password">
        <div class="hint">💡 Leave blank if you don't want to change password</div>
      </div>

      <button type="submit" class="btn-submit">Save Changes</button>
    </form>

    <a href="userProfile" class="btn-cancel">Cancel</a>
  </div>
</div>

<footer>&copy; 2026 <strong>Easy Go Drive</strong> Vehicle Rental System</footer>

</body>
</html>