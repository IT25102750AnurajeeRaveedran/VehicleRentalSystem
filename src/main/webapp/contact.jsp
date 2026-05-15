<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact | Easy Go</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@500;600;700;800&family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    * { box-sizing: border-box; }
    :root {
      --bg: #0a0a0f;
      --surface: rgba(255, 255, 255, 0.04);
      --surface-strong: #14141d;
      --card: #1a1a24;
      --border: #2a2a38;
      --accent: #f0c040;
      --accent-2: #7c8cff;
      --text: #f7f3ed;
      --muted: #a0a0b2;
    }
    body {
      margin: 0;
      font-family: 'DM Sans', sans-serif;
      background:
        radial-gradient(circle at top left, rgba(240, 192, 64, 0.14), transparent 30%),
        radial-gradient(circle at bottom right, rgba(124, 140, 255, 0.12), transparent 30%),
        var(--bg);
      color: var(--text);
      min-height: 100vh;
    }
    a { color: inherit; text-decoration: none; }
    .shell { max-width: 1200px; margin: 0 auto; padding: 24px; }
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 18px 22px; background: rgba(20, 20, 29, 0.82);
      backdrop-filter: blur(16px); border: 1px solid rgba(255, 255, 255, 0.08);
      border-radius: 20px; position: sticky; top: 20px; z-index: 10;
    }
    .brand { font-family: 'Syne', sans-serif; font-size: 22px; font-weight: 800; letter-spacing: -0.5px; }
    .brand span { color: var(--accent); }
    .nav-links { display: flex; gap: 14px; flex-wrap: wrap; }
    .nav-link {
      font-size: 14px; color: var(--muted); padding: 10px 14px;
      border-radius: 999px; border: 1px solid transparent;
    }
    .nav-link:hover, .nav-link.active {
      color: var(--text); border-color: rgba(255, 255, 255, 0.08); background: rgba(255, 255, 255, 0.04);
    }
    .hero, .contact-grid { display: grid; gap: 18px; }
    .hero {
      grid-template-columns: 1.1fr 0.9fr; align-items: stretch; padding: 30px 0 10px;
    }
    .card, .panel, .cta {
      background: linear-gradient(180deg, rgba(255,255,255,0.05), rgba(255,255,255,0.03));
      border: 1px solid rgba(255,255,255,0.08); border-radius: 24px;
      box-shadow: 0 18px 40px rgba(0,0,0,0.22);
    }
    .card { padding: 40px; position: relative; overflow: hidden; }
    .card::before {
      content: ''; position: absolute; right: -90px; top: -90px; width: 260px; height: 260px;
      border-radius: 50%; background: radial-gradient(circle, rgba(124, 140, 255, 0.16), transparent 66%);
    }
    .badge {
      display: inline-flex; align-items: center; gap: 8px; margin-bottom: 16px;
      padding: 8px 14px; border-radius: 999px; background: rgba(240, 192, 64, 0.12); color: var(--accent);
      font-size: 13px; font-weight: 700;
    }
    h1, h2, h3 { margin: 0; font-family: 'Syne', sans-serif; }
    h1 { font-size: clamp(2.4rem, 5vw, 4.4rem); line-height: 0.98; letter-spacing: -1.4px; max-width: 10ch; }
    h1 span, h2 span { color: var(--accent); }
    p { color: var(--muted); line-height: 1.75; }
    .actions { display: flex; gap: 12px; flex-wrap: wrap; margin-top: 24px; }
    .btn {
      display: inline-flex; align-items: center; justify-content: center; gap: 8px;
      padding: 13px 18px; border-radius: 14px; font-weight: 700; font-size: 14px;
      transition: transform 0.2s ease, background 0.2s ease;
    }
    .btn:hover { transform: translateY(-1px); }
    .btn-primary { background: var(--accent); color: #17120a; }
    .btn-secondary { background: rgba(255,255,255,0.06); color: var(--text); }
    .panel { padding: 24px; }
    .contact-grid {
      grid-template-columns: repeat(2, 1fr);
      margin-top: 18px;
    }
    .contact-card {
      padding: 20px; border-radius: 20px; background: rgba(255,255,255,0.04);
      border: 1px solid rgba(255,255,255,0.06);
    }
    .contact-card strong {
      display: block; margin-bottom: 6px; font-family: 'Syne', sans-serif; font-size: 18px;
    }
    .contact-card span { color: var(--muted); font-size: 14px; line-height: 1.6; }
    .icon {
      width: 46px; height: 46px; border-radius: 16px; display: grid; place-items: center;
      margin-bottom: 14px; background: rgba(240, 192, 64, 0.12); color: var(--accent); font-size: 20px;
    }
    .details {
      display: grid; gap: 12px; margin-top: 18px;
    }
    .detail-row {
      display: flex; justify-content: space-between; gap: 14px; padding: 14px 16px;
      border-radius: 16px; background: rgba(255,255,255,0.04); color: var(--text);
    }
    .detail-row small { color: var(--muted); }
    .cta {
      display: flex; align-items: center; justify-content: space-between; gap: 18px;
      margin: 24px 0 8px; padding: 24px 26px;
    }
    footer { text-align: center; color: var(--muted); padding: 18px 0 8px; font-size: 13px; }
    @media (max-width: 900px) {
      .hero, .contact-grid, .cta { grid-template-columns: 1fr; display: grid; }
    }
    @media (max-width: 640px) {
      .shell { padding: 16px; }
      nav { padding: 16px; border-radius: 18px; }
      .card { padding: 28px; }
      .actions { flex-direction: column; }
      .btn { width: 100%; }
    }
  </style>
</head>
<body>
<%
  String base = request.getContextPath();
%>
<div class="shell">
  <nav>
    <a class="brand" href="<%= base %>/">Easy <span>Go</span></a>
    <div class="nav-links">
      <a class="nav-link" href="<%= base %>/">Home</a>
      <a class="nav-link" href="<%= base %>/vehicles">Browse</a>
      <a class="nav-link" href="<%= base %>/about.jsp">About</a>
      <a class="nav-link active" href="<%= base %>/contact.jsp">Contact</a>
    </div>
  </nav>

  <section class="hero">
    <div class="card">
      <div class="badge">Contact Easy Go</div>
      <h1>Need help? <span>Reach out</span> anytime</h1>
      <p>
        If you have a question about bookings, vehicles, or your account, the Easy Go team is ready
        to help with a quick response.
      </p>
      <div class="actions">
        <a class="btn btn-primary" href="mailto:support@easygo.local">Email Support</a>
        <a class="btn btn-secondary" href="<%= base %>/vehicles">Browse Vehicles</a>
      </div>
    </div>

    <div class="panel">
      <div class="contact-grid">
        <div class="contact-card">
          <div class="icon">📧</div>
          <strong>Email</strong>
          <span>support@easygo.local</span>
        </div>
        <div class="contact-card">
          <div class="icon">📞</div>
          <strong>Phone</strong>
          <span>+94 11 234 5678</span>
        </div>
        <div class="contact-card">
          <div class="icon">📍</div>
          <strong>Office</strong>
          <span>Colombo, Sri Lanka</span>
        </div>
        <div class="contact-card">
          <div class="icon">🕒</div>
          <strong>Hours</strong>
          <span>Monday - Friday<br>9:00 AM - 6:00 PM</span>
        </div>
      </div>
    </div>
  </section>

  <section class="cta">
    <div>
      <h2>We’re here to <span>help</span></h2>
      <p>Use the contact details above or email us directly if you need assistance with the platform.</p>
    </div>
    <div class="actions">
      <a class="btn btn-primary" href="mailto:support@easygo.local">Send Email</a>
      <a class="btn btn-secondary" href="<%= base %>/about.jsp">About Easy Go</a>
    </div>
  </section>

  <footer>&copy; 2026 Easy Go Vehicle Rental System</footer>
</div>
</body>
</html>

