<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DriveEase – Forgot Password</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root { --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24; --border: #2a2a38; --accent: #f0c040; --text: #f0ede8; --muted: #7a7a8a; --danger: #e04040; --success: #40c080; }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
    nav { display: flex; align-items: center; justify-content: space-between; padding: 0 48px; height: 68px; background: var(--surface); border-bottom: 1px solid var(--border); }
    .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 24px; letter-spacing: -1px; text-decoration: none; color: var(--text); }
    .logo span { color: var(--accent); }
    .nav-link { color: var(--muted); text-decoration: none; font-size: 13px; }
    .nav-link:hover { color: var(--accent); }

    .page { flex: 1; display: flex; align-items: center; justify-content: center; padding: 48px 24px; }
    .card { background: var(--card); border: 1px solid var(--border); border-radius: 24px; padding: 48px; width: 100%; max-width: 460px; }

    .icon { width: 64px; height: 64px; background: #f0c04015; border: 1px solid #f0c04030; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 28px; margin: 0 auto 24px; }
    .card-header { text-align: center; margin-bottom: 32px; }
    .card-header h2 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 8px; }
    .card-header h2 span { color: var(--accent); }
    .card-header p { color: var(--muted); font-size: 14px; line-height: 1.6; }

    .alert { padding: 12px 16px; border-radius: 8px; font-size: 13px; margin-bottom: 20px; }
    .alert-error { background: #e0404015; border: 1px solid #e0404040; color: var(--danger); }

    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 12px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
    input { width: 100%; background: #111118; border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 15px; padding: 12px 16px; border-radius: 10px; outline: none; transition: border 0.2s; }
    input:focus { border-color: var(--accent); }

    .btn-submit { width: 100%; background: var(--accent); color: #000; border: none; font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; padding: 14px; border-radius: 10px; cursor: pointer; margin-top: 8px; transition: all 0.2s; }
    .btn-submit:hover { background: #ffd060; transform: translateY(-1px); }
    .back-link { display: block; text-align: center; margin-top: 20px; color: var(--muted); font-size: 14px; text-decoration: none; }
    .back-link:hover { color: var(--accent); }

    .divider { height: 1px; background: var(--border); margin: 24px 0; }
    .hint { font-size: 12px; color: var(--muted); background: #111118; border: 1px solid var(--border); border-radius: 8px; padding: 12px 16px; line-height: 1.6; }
    .hint strong { color: var(--accent); }
  </style>
</head>
<body>
<nav>
  <a href="#" class="logo">Drive<span>Ease</span></a>
  <a href="login.jsp" class="nav-link">&#8592; Back to Login</a>
</nav>

<div class="page">
  <div class="card">
    <div class="icon">🔑</div>
    <div class="card-header">
      <h2>Reset <span>Password</span></h2>
      <p>Enter your registered email and choose a new password to regain access to your account.</p>
    </div>

    <% String error = request.getParameter("error"); %>
    <% if ("mismatch".equals(error)) { %>
      <div class="alert alert-error">❌ Passwords do not match. Please try again.</div>
    <% } else if ("notfound".equals(error)) { %>
      <div class="alert alert-error">❌ Email not found. Please check your email address.</div>
    <% } else if ("failed".equals(error)) { %>
      <div class="alert alert-error">❌ Password reset failed. Please try again.</div>
    <% } %>

    <form action="forgotPassword" method="post">
      <div class="form-group">
        <label>Registered Email</label>
        <input type="email" name="email" placeholder="your@email.com" required>
      </div>
      <div class="form-group">
        <label>New Password</label>
        <input type="password" name="newPassword" placeholder="Enter new password" required>
      </div>
      <div class="form-group">
        <label>Confirm New Password</label>
        <input type="password" name="confirmPassword" placeholder="Confirm new password" required>
      </div>
      <button type="submit" class="btn-submit">Reset Password</button>
    </form>

    <div class="divider"></div>
    <div class="hint">
      💡 <strong>Remember:</strong> Make sure to use the email address you registered with. Your new password must be at least 6 characters.
    </div>

    <a href="login.jsp" class="back-link">&#8592; Back to Sign In</a>
  </div>
</div>
</body>
</html>