<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DriveEase – Login</title>
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
    .container { display: grid; grid-template-columns: 1fr 1fr; max-width: 900px; width: 100%; background: var(--card); border: 1px solid var(--border); border-radius: 24px; overflow: hidden; }

    /* Left panel */
    .left-panel { background: linear-gradient(160deg, #1a1428, #0f0f1a); padding: 48px; display: flex; flex-direction: column; justify-content: center; position: relative; overflow: hidden; }
    .left-panel::before { content: ''; position: absolute; top: -80px; right: -80px; width: 300px; height: 300px; border-radius: 50%; background: radial-gradient(circle, #f0c04015, transparent 70%); }
    .left-panel h2 { font-family: 'Syne', sans-serif; font-size: 36px; font-weight: 800; letter-spacing: -1px; margin-bottom: 12px; line-height: 1.1; }
    .left-panel h2 span { color: var(--accent); }
    .left-panel p { color: var(--muted); font-size: 14px; line-height: 1.7; margin-bottom: 32px; }
    .feature { display: flex; align-items: center; gap: 12px; margin-bottom: 16px; }
    .feature-dot { width: 8px; height: 8px; border-radius: 50%; background: var(--accent); flex-shrink: 0; }
    .feature span { font-size: 13px; color: var(--muted); }

    /* Right panel - form */
    .right-panel { padding: 48px; }
    .form-header { margin-bottom: 32px; }
    .form-header h3 { font-family: 'Syne', sans-serif; font-size: 24px; font-weight: 700; margin-bottom: 6px; }
    .form-header p { color: var(--muted); font-size: 14px; }

    .alert { padding: 12px 16px; border-radius: 8px; font-size: 13px; margin-bottom: 20px; }
    .alert-error { background: #e0404015; border: 1px solid #e0404040; color: var(--danger); }
    .alert-success { background: #40c08015; border: 1px solid #40c08040; color: var(--success); }

    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 12px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
    input { width: 100%; background: #111118; border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 15px; padding: 12px 16px; border-radius: 10px; outline: none; transition: border 0.2s; }
    input:focus { border-color: var(--accent); }
    .forgot-link { display: block; text-align: right; font-size: 12px; color: var(--muted); text-decoration: none; margin-top: 6px; }
    .forgot-link:hover { color: var(--accent); }
    .btn-submit { width: 100%; background: var(--accent); color: #000; border: none; font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; padding: 14px; border-radius: 10px; cursor: pointer; margin-top: 8px; transition: all 0.2s; }
    .btn-submit:hover { background: #ffd060; transform: translateY(-1px); }
    .register-link { text-align: center; margin-top: 20px; font-size: 14px; color: var(--muted); }
    .register-link a { color: var(--accent); text-decoration: none; font-weight: 600; }
  </style>
</head>
<body>
<nav>
  <a href="#" class="logo">Drive<span>Ease</span></a>
  <a href="register.jsp" class="nav-link">Create Account</a>
</nav>

<div class="page">
  <div class="container">
    <div class="left-panel">
      <h2>Welcome<br>Back to<br><span>DriveEase</span></h2>
      <p>Your premium vehicle rental platform. Access your account to manage bookings and explore our fleet.</p>
      <div class="feature"><div class="feature-dot"></div><span>Wide range of vehicles</span></div>
      <div class="feature"><div class="feature-dot"></div><span>Easy online booking</span></div>
      <div class="feature"><div class="feature-dot"></div><span>Affordable daily rates</span></div>
      <div class="feature"><div class="feature-dot"></div><span>24/7 customer support</span></div>
    </div>

    <div class="right-panel">
      <div class="form-header">
        <h3>Sign In</h3>
        <p>Enter your credentials to access your account</p>
      </div>

      <% String error = request.getParameter("error");
         String msg   = request.getParameter("msg"); %>
      <% if ("invalid".equals(error)) { %>
        <div class="alert alert-error">❌ Invalid email or password. Please try again.</div>
      <% } %>
      <% if ("registered".equals(msg)) { %>
        <div class="alert alert-success">✅ Account created! Please login.</div>
      <% } %>
      <% if ("reset".equals(msg)) { %>
        <div class="alert alert-success">✅ Password reset successfully!</div>
      <% } %>
      <% if ("loggedout".equals(msg)) { %>
        <div class="alert alert-success">✅ Logged out successfully.</div>
      <% } %>

      <form action="login" method="post">
        <div class="form-group">
          <label>Email Address</label>
          <input type="email" name="email" placeholder="your@email.com" required>
        </div>
        <div class="form-group">
          <label>Password</label>
          <input type="password" name="password" placeholder="Enter your password" required>
          <a href="forgotPassword.jsp" class="forgot-link">Forgot password?</a>
        </div>
        <button type="submit" class="btn-submit">Sign In</button>
      </form>

      <div class="register-link">
        Don't have an account? <a href="register.jsp">Register here</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>