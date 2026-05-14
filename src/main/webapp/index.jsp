<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Easy Go – Vehicle Rental</title>
	<link href="https://fonts.googleapis.com/css2?family=Syne:wght@500;600;700;800&family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
	<style>
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
		* { box-sizing: border-box; }
		body {
			margin: 0;
			font-family: 'DM Sans', sans-serif;
			background:
				radial-gradient(circle at top left, rgba(240, 192, 64, 0.16), transparent 28%),
				radial-gradient(circle at bottom right, rgba(124, 140, 255, 0.14), transparent 28%),
				var(--bg);
			color: var(--text);
			min-height: 100vh;
		}
		a { color: inherit; }
		.shell {
			max-width: 1200px;
			margin: 0 auto;
			padding: 24px;
		}
		nav {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 18px 22px;
			background: rgba(20, 20, 29, 0.78);
			backdrop-filter: blur(16px);
			border: 1px solid rgba(255, 255, 255, 0.08);
			border-radius: 20px;
			position: sticky;
			top: 20px;
			z-index: 10;
		}
		.brand {
			font-family: 'Syne', sans-serif;
			font-size: 22px;
			font-weight: 800;
			text-decoration: none;
			letter-spacing: -0.5px;
		}
		.brand span { color: var(--accent); }
		.nav-links {
			display: flex;
			gap: 14px;
			flex-wrap: wrap;
		}
		.nav-link {
			text-decoration: none;
			font-size: 14px;
			color: var(--muted);
			padding: 10px 14px;
			border-radius: 999px;
			border: 1px solid transparent;
		}
		.nav-link:hover {
			color: var(--text);
			border-color: rgba(255, 255, 255, 0.08);
			background: rgba(255, 255, 255, 0.04);
		}
		.hero {
			display: grid;
			grid-template-columns: 1.2fr 0.8fr;
			gap: 24px;
			align-items: stretch;
			padding: 28px 0 8px;
		}
		.hero-card,
		.side-card,
		.feature,
		.cta {
			background: linear-gradient(180deg, rgba(255,255,255,0.05), rgba(255,255,255,0.03));
			border: 1px solid rgba(255,255,255,0.08);
			border-radius: 24px;
			box-shadow: 0 18px 40px rgba(0,0,0,0.22);
		}
		.hero-card {
			padding: 42px;
			position: relative;
			overflow: hidden;
		}
		.hero-card::before {
			content: '';
			position: absolute;
			top: -80px;
			right: -80px;
			width: 240px;
			height: 240px;
			border-radius: 50%;
			background: radial-gradient(circle, rgba(240, 192, 64, 0.18), transparent 68%);
		}
		.badge {
			display: inline-flex;
			align-items: center;
			gap: 8px;
			padding: 8px 14px;
			border-radius: 999px;
			background: rgba(240, 192, 64, 0.12);
			color: var(--accent);
			font-size: 13px;
			font-weight: 700;
			margin-bottom: 18px;
		}
		.hero h1 {
			margin: 0;
			font-family: 'Syne', sans-serif;
			font-size: clamp(2.5rem, 5vw, 4.6rem);
			line-height: 0.98;
			letter-spacing: -1.5px;
			max-width: 9ch;
		}
		.hero h1 span { color: var(--accent); }
		.hero p {
			max-width: 58ch;
			margin: 18px 0 28px;
			color: var(--muted);
			line-height: 1.75;
			font-size: 16px;
		}
		.actions {
			display: flex;
			gap: 12px;
			flex-wrap: wrap;
		}
		.btn {
			display: inline-flex;
			align-items: center;
			justify-content: center;
			gap: 8px;
			padding: 13px 18px;
			border-radius: 14px;
			text-decoration: none;
			font-weight: 700;
			font-size: 14px;
			transition: transform 0.2s ease, background 0.2s ease;
		}
		.btn:hover { transform: translateY(-1px); }
		.btn-primary { background: var(--accent); color: #17120a; }
		.btn-secondary { background: rgba(255,255,255,0.06); color: var(--text); }
		.btn-outline { background: transparent; color: var(--text); border: 1px solid rgba(255,255,255,0.12); }
		.stats {
			display: grid;
			grid-template-columns: repeat(3, 1fr);
			gap: 14px;
			margin-top: 28px;
		}
		.stat {
			padding: 16px;
			border-radius: 18px;
			background: rgba(255,255,255,0.04);
			border: 1px solid rgba(255,255,255,0.06);
		}
		.stat strong {
			display: block;
			font-family: 'Syne', sans-serif;
			font-size: 24px;
			margin-bottom: 4px;
		}
		.stat span { color: var(--muted); font-size: 13px; }
		.side-card {
			padding: 24px;
			display: grid;
			gap: 14px;
			align-content: start;
		}
		.preview {
			padding: 20px;
			border-radius: 20px;
			background: linear-gradient(180deg, #1a1a24, #111118);
			border: 1px solid rgba(255,255,255,0.06);
		}
		.preview-title {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 14px;
			font-size: 14px;
			color: var(--muted);
		}
		.preview-list {
			display: grid;
			gap: 10px;
		}
		.preview-item {
			display: flex;
			justify-content: space-between;
			gap: 12px;
			padding: 12px 14px;
			border-radius: 14px;
			background: rgba(255,255,255,0.04);
			color: var(--text);
			font-size: 14px;
		}
		.preview-item small { color: var(--muted); }
		.section {
			display: grid;
			grid-template-columns: repeat(3, 1fr);
			gap: 18px;
			margin-top: 22px;
		}
		.feature {
			padding: 22px;
		}
		.feature .icon {
			width: 44px;
			height: 44px;
			border-radius: 14px;
			display: grid;
			place-items: center;
			margin-bottom: 16px;
			background: rgba(240, 192, 64, 0.12);
			color: var(--accent);
			font-size: 20px;
		}
		.feature h3 {
			margin: 0 0 8px;
			font-family: 'Syne', sans-serif;
			font-size: 18px;
		}
		.feature p {
			margin: 0;
			color: var(--muted);
			line-height: 1.7;
			font-size: 14px;
		}
		.cta {
			display: flex;
			align-items: center;
			justify-content: space-between;
			gap: 18px;
			margin: 24px 0 8px;
			padding: 24px 26px;
		}
		.cta h2 {
			margin: 0 0 8px;
			font-family: 'Syne', sans-serif;
			font-size: 24px;
		}
		.cta p { margin: 0; color: var(--muted); line-height: 1.6; }
		.footer-note {
			text-align: center;
			padding: 18px 0 8px;
			color: var(--muted);
			font-size: 13px;
		}
		@media (max-width: 900px) {
			.hero, .section, .cta { grid-template-columns: 1fr; display: grid; }
			.stats { grid-template-columns: 1fr; }
		}
		@media (max-width: 640px) {
			.shell { padding: 16px; }
			nav { padding: 16px; border-radius: 18px; }
			.hero-card { padding: 28px; }
			.hero p { font-size: 15px; }
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
			<a class="nav-link" href="<%= base %>/vehicles">Browse</a>
			<a class="nav-link" href="<%= base %>/login.jsp">Login</a>
			<a class="nav-link" href="<%= base %>/register.jsp">Register</a>
		</div>
	</nav>

	<section class="hero">
		<div class="hero-card">
			<div class="badge">Premium Rental Experience</div>
			<h1>Rent smarter with <span>Easy Go</span></h1>
			<p>
				Discover a simple, modern way to book vehicles, manage bookings, and keep your rental
				history in one place.
			</p>
			<div class="actions">
				<a class="btn btn-primary" href="<%= base %>/vehicles">Browse Vehicles</a>
				<a class="btn btn-secondary" href="<%= base %>/login.jsp">Login</a>
				<a class="btn btn-outline" href="<%= base %>/register.jsp">Create Account</a>
			</div>

			<div class="stats">
				<div class="stat">
					<strong>24/7</strong>
					<span>Support ready anytime</span>
				</div>
				<div class="stat">
					<strong>Fast</strong>
					<span>Simple booking flow</span>
				</div>
				<div class="stat">
					<strong>Safe</strong>
					<span>Reliable rental records</span>
				</div>
			</div>
		</div>

		<div class="side-card">
			<div class="preview">
				<div class="preview-title">
					<span>Why Easy Go?</span>
					<span>Simple</span>
				</div>
				<div class="preview-list">
					<div class="preview-item"><span>Modern interface</span><small>Easy to navigate</small></div>
					<div class="preview-item"><span>Bookings & history</span><small>All in one place</small></div>
					<div class="preview-item"><span>Account tools</span><small>Profile and feedback</small></div>
				</div>
			</div>
		</div>
	</section>

	<section class="section">
		<div class="feature">
			<div class="icon">🚗</div>
			<h3>Browse vehicles</h3>
			<p>View available cars, vans, and more with a clean and easy-to-use catalog.</p>
		</div>
		<div class="feature">
			<div class="icon">📅</div>
			<h3>Manage bookings</h3>
			<p>Track rentals, returns, cancellations, and your booking history in seconds.</p>
		</div>
		<div class="feature">
			<div class="icon">⭐</div>
			<h3>Share feedback</h3>
			<p>Tell us about your experience so the platform keeps improving for everyone.</p>
		</div>
	</section>

	<section class="cta">
		<div>
			<h2>Ready to start your ride?</h2>
			<p>Log in, register, or explore the fleet right away from your new home page.</p>
		</div>
		<div class="actions">
			<a class="btn btn-primary" href="<%= base %>/vehicles">Explore Now</a>
			<a class="btn btn-secondary" href="<%= base %>/login.jsp">Sign In</a>
		</div>
	</section>

	<div class="footer-note">Open <strong>http://localhost:8080/</strong> to land here first.</div>
</div>
</body>
</html>
