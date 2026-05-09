<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DriveEase – Register</title>
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
    .card { background: var(--card); border: 1px solid var(--border); border-radius: 24px; padding: 48px; width: 100%; max-width: 520px; }

    .card-header { text-align: center; margin-bottom: 36px; }
    .card-header h2 { font-family: 'Syne', sans-serif; font-size: 32px; font-weight: 800; margin-bottom: 8px; }
    .card-header h2 span { color: var(--accent); }
    .card-header p { color: var(--muted); font-size: 14px; }

    .alert { padding: 12px 16px; border-radius: 8px; font-size: 13px; margin-bottom: 20px; }
    .alert-error { background: #e0404015; border: 1px solid #e0404040; color: var(--danger); }

    .row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 12px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
    input { width: 100%; background: #111118; border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 15px; padding: 12px 16px; border-radius: 10px; outline: none; transition: border 0.2s; }
    input:focus { border-color: var(--accent); }

    .btn-submit { width: 100%; background: var(--accent); color: #000; border: none; font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; padding: 14px; border-radius: 10px; cursor: pointer; margin-top: 8px; transition: all 0.2s; }
    .btn-submit:hover { background: #ffd060; transform: translateY(-1px); }
    .login-link { text-align: center; margin-top: 20px; font-size: 14px; color: var(--muted); }
    .login-link a { color: var(--accent); text-decoration: none; font-weight: 600; }

    .terms { font-size: 12px; color: var(--muted); text-align: center; margin-top: 16px; line-height: 1.6; }
  </style>
</head>
<body>
<nav>
  <a href="#" class="logo">Drive<span>Ease</span></a>
  <a href="login.jsp" class="nav-link">Already have an account? Sign In</a>
</nav>

<div class="page">
  <div class="card">
    <div class="card-header">
      <h2>Create <span>Account</span></h2>
      <p>Join DriveEase and start renting vehicles today</p>
    </div>

    <% String error = request.getParameter("error"); %>
    <% if ("exists".equals(error)) { %>
      <div class="alert alert-error">❌ This email is already registered. Please login instead.</div>
    <% } %>

    <form action="register" method="post">
      <div class="form-group">
        <label>Full Name</label>
        <input type="text" name="fullName" placeholder="e.g. Anurajee Raveedran" required>
      </div>
      <div class="form-group">
        <label>Email Address</label>
        <input type="email" name="email" placeholder="your@email.com" required>
      </div>
      <div class="row">
        <div class="form-group">
          <label>Phone Number</label>
          <input type="tel" name="phone" placeholder="07X XXX XXXX" required>
        </div>
        <div class="form-group">
          <label>Password</label>
          <input type="password" name="password" placeholder="Min 6 characters" required>
        </div>
      </div>
      <button type="submit" class="btn-submit">Create Account</button>
    </form>

    <div class="login-link">
      Already have an account? <a href="login.jsp">Sign in here</a>
    </div>
    <div class="terms">
      By creating an account you agree to our Terms of Service and Privacy Policy.
    </div>
  </div>
</div>
</body>
</html>