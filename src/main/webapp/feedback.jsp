<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – Feedback</title>
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

    /* Vehicle info box */
    .vehicle-info { background: #f0c04010; border: 1px solid #f0c04030; border-radius: 12px; padding: 16px 20px; margin-bottom: 24px; display: flex; align-items: center; gap: 16px; }
    .vehicle-emoji { font-size: 36px; }
    .vehicle-details h3 { font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; }
    .vehicle-details p { font-size: 12px; color: var(--muted); margin-top: 4px; }

    .card { background: var(--card); border: 1px solid var(--border); border-radius: 20px; padding: 40px; }
    .card-header { margin-bottom: 32px; }
    .card-header h1 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 6px; }
    .card-header h1 span { color: var(--accent); }
    .card-header p { color: var(--muted); font-size: 14px; }

    .form-group { margin-bottom: 24px; }
    label { display: block; font-size: 12px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
    input, textarea { width: 100%; background: #111118; border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 14px; padding: 12px 16px; border-radius: 10px; outline: none; transition: border 0.2s; }
    input:focus, textarea:focus { border-color: var(--accent); }
    textarea { resize: vertical; min-height: 120px; }

    /* Star rating */
    .star-container { display: flex; gap: 12px; margin-top: 4px; }
    .star-btn { background: none; border: none; font-size: 36px; cursor: pointer; color: #2a2a38; transition: all 0.2s; line-height: 1; }
    .star-btn:hover { transform: scale(1.2); }
    .star-btn.active { color: var(--accent); }
    .rating-text { font-size: 13px; color: var(--muted); margin-top: 8px; }

    .btn-submit { width: 100%; background: var(--accent); color: #000; border: none; font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; padding: 14px; border-radius: 10px; cursor: pointer; transition: all 0.2s; }
    .btn-submit:hover { background: #ffd060; transform: translateY(-1px); }
    .btn-cancel { display: block; text-align: center; margin-top: 14px; color: var(--muted); font-size: 14px; text-decoration: none; }
    .btn-cancel:hover { color: var(--text); }

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
  String vehicleId = request.getParameter("vehicleId");
  String brand     = request.getParameter("brand");
  String model     = request.getParameter("model");
  if (vehicleId == null) vehicleId = "";
  if (brand == null) brand = "";
  if (model == null) model = "";
%>

<nav>
  <a href="vehicles" class="logo">Easy Go<span> Drive</span></a>
  <ul class="nav-links">
    <li><a href="vehicles">Vehicles</a></li>
    <li><a href="myBookings">My Bookings</a></li>
    <li><a href="userProfile">My Profile</a></li>
    <li><a href="logout" style="color:#e04040;">Logout</a></li>
  </ul>
</nav>

<div class="page">
  <a href="myBookings" class="back">&#8592; Back to My Bookings</a>

  <% if (!brand.isEmpty()) { %>
  <div class="vehicle-info">
    <div class="vehicle-emoji">🚗</div>
    <div class="vehicle-details">
      <h3><%= brand %> <%= model %></h3>
      <p>Vehicle ID: <%= vehicleId %></p>
    </div>
  </div>
  <% } %>

  <div class="card">
    <div class="card-header">
      <h1>Leave <span>Feedback</span></h1>
      <p>Share your experience to help other customers</p>
    </div>

    <form action="submitFeedback" method="post">
      <input type="hidden" name="vehicleId" value="<%= vehicleId %>">
      <input type="hidden" name="rating" id="ratingInput" value="5">

      <div class="form-group">
        <label>Your Rating</label>
        <div class="star-container">
          <button type="button" class="star-btn active" onclick="setRating(1)">★</button>
          <button type="button" class="star-btn active" onclick="setRating(2)">★</button>
          <button type="button" class="star-btn active" onclick="setRating(3)">★</button>
          <button type="button" class="star-btn active" onclick="setRating(4)">★</button>
          <button type="button" class="star-btn active" onclick="setRating(5)">★</button>
        </div>
        <div class="rating-text" id="ratingText">5 out of 5 — Excellent!</div>
      </div>

      <div class="form-group">
        <label>Your Comment</label>
        <textarea name="comment" placeholder="Tell us about your experience with this vehicle. Was it clean? Comfortable? Good value?" required></textarea>
      </div>

      <button type="submit" class="btn-submit">⭐ Submit Feedback</button>
    </form>
    <a href="myBookings" class="btn-cancel">Cancel</a>
  </div>
</div>

<footer>&copy; 2026 <strong>Easy Go Drive</strong> Vehicle Rental System</footer>

<script>
  const labels = ['', 'Poor', 'Fair', 'Good', 'Very Good', 'Excellent!'];

  function setRating(val) {
    document.getElementById('ratingInput').value = val;
    document.getElementById('ratingText').textContent = val + ' out of 5 — ' + labels[val];
    const stars = document.querySelectorAll('.star-btn');
    stars.forEach((s, i) => {
      s.classList.toggle('active', i < val);
    });
  }
</script>

</body>
</html>