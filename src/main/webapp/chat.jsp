<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.ChatMessage, com.rental.model.User, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – Support Chat</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root { --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24; --border: #2a2a38; --accent: #f0c040; --text: #f0ede8; --muted: #7a7a8a; --danger: #e04040; --success: #40c080; }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }

    nav { display: flex; align-items: center; justify-content: space-between; padding: 0 48px; height: 68px; background: var(--surface); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; }
    .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 24px; letter-spacing: -1px; text-decoration: none; color: var(--text); }
    .logo span { color: var(--accent); }
    .nav-links { display: flex; gap: 32px; list-style: none; align-items: center; }
    .nav-links a { color: var(--muted); text-decoration: none; font-size: 13px; font-weight: 500; text-transform: uppercase; transition: color 0.2s; }
    .nav-links a:hover, .nav-links a.active { color: var(--accent); }
    .nav-user { display: flex; align-items: center; gap: 8px; background: var(--card); border: 1px solid var(--border); padding: 6px 14px; border-radius: 20px; font-size: 13px; color: var(--accent); }

    .page { flex: 1; max-width: 800px; margin: 40px auto; padding: 0 24px; width: 100%; }
    .chat-header { margin-bottom: 24px; }
    .chat-header h1 { font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800; margin-bottom: 4px; }
    .chat-header h1 span { color: var(--accent); }
    .chat-header p { color: var(--muted); font-size: 14px; }

    /* Chat container */
    .chat-container { background: var(--card); border: 1px solid var(--border); border-radius: 20px; overflow: hidden; display: flex; flex-direction: column; height: 600px; }

    /* Chat top bar */
    .chat-topbar { padding: 16px 24px; background: #111118; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 12px; }
    .support-avatar { width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, var(--accent), #e05c2a); display: flex; align-items: center; justify-content: center; font-size: 18px; flex-shrink: 0; }
    .support-info h3 { font-family: 'Syne', sans-serif; font-size: 15px; font-weight: 700; }
    .support-info p { font-size: 12px; color: var(--success); }
    .online-dot { width: 8px; height: 8px; border-radius: 50%; background: var(--success); display: inline-block; margin-right: 4px; }

    /* Messages area */
    .messages-area { flex: 1; overflow-y: auto; padding: 24px; display: flex; flex-direction: column; gap: 16px; }
    .messages-area::-webkit-scrollbar { width: 4px; }
    .messages-area::-webkit-scrollbar-track { background: transparent; }
    .messages-area::-webkit-scrollbar-thumb { background: var(--border); border-radius: 4px; }

    /* Message bubbles */
    .message { display: flex; flex-direction: column; max-width: 70%; }
    .message.user-msg { align-self: flex-end; align-items: flex-end; }
    .message.admin-msg { align-self: flex-start; align-items: flex-start; }

    .bubble { padding: 12px 16px; border-radius: 16px; font-size: 14px; line-height: 1.5; }
    .user-msg .bubble { background: var(--accent); color: #000; border-bottom-right-radius: 4px; }
    .admin-msg .bubble { background: #2a2a38; color: var(--text); border-bottom-left-radius: 4px; border: 1px solid var(--border); }

    .msg-meta { font-size: 11px; color: var(--muted); margin-top: 4px; }
    .msg-sender { font-weight: 600; }

    /* Empty state */
    .empty-chat { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; color: var(--muted); text-align: center; padding: 40px; }
    .empty-chat-icon { font-size: 48px; margin-bottom: 16px; }
    .empty-chat h3 { font-family: 'Syne', sans-serif; font-size: 18px; margin-bottom: 8px; color: var(--text); }
    .empty-chat p { font-size: 14px; }

    /* Input area */
    .chat-input { padding: 16px 24px; border-top: 1px solid var(--border); background: #111118; }
    .input-row { display: flex; gap: 12px; align-items: center; }
    .msg-input { flex: 1; background: var(--card); border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 14px; padding: 12px 16px; border-radius: 12px; outline: none; transition: border 0.2s; }
    .msg-input:focus { border-color: var(--accent); }
    .msg-input::placeholder { color: var(--muted); }
    .btn-send { background: var(--accent); color: #000; border: none; width: 44px; height: 44px; border-radius: 12px; font-size: 20px; cursor: pointer; transition: all 0.2s; flex-shrink: 0; display: flex; align-items: center; justify-content: center; }
    .btn-send:hover { background: #ffd060; transform: scale(1.05); }

    footer { padding: 24px 48px; border-top: 1px solid var(--border); background: var(--surface); text-align: center; color: var(--muted); font-size: 13px; }
    footer strong { color: var(--accent); }
  </style>
</head>
<body>

<%
  User user = (User) request.getAttribute("user");
  List<ChatMessage> messages = (List<ChatMessage>) request.getAttribute("messages");
  if (user == null) { response.sendRedirect("login.jsp"); return; }
  String userName = user.getFullName();
%>

<nav>
  <a href="vehicles" class="logo">Easy Go<span> Drive</span></a>
  <ul class="nav-links">
    <li><a href="vehicles">Vehicles</a></li>
    <li><a href="myBookings">My Bookings</a></li>
    <li><a href="chat" class="active">Support</a></li>
    <li><a href="userProfile">My Profile</a></li>
    <li><span class="nav-user">👤 <%= userName %></span></li>
    <li><a href="logout" style="color:#e04040;">Logout</a></li>
  </ul>
</nav>

<div class="page">
  <div class="chat-header">
    <h1>Support <span>Chat</span></h1>
    <p>Chat with our support team for help with your bookings</p>
  </div>

  <div class="chat-container">
    <!-- Top bar -->
    <div class="chat-topbar">
      <div class="support-avatar">🎧</div>
      <div class="support-info">
        <h3>Easy Go Drive Support</h3>
        <p><span class="online-dot"></span>Online — We typically reply within minutes</p>
      </div>
    </div>

    <!-- Messages -->
    <div class="messages-area" id="messagesArea">
      <%
        if (messages == null || messages.isEmpty()) {
      %>
        <div class="empty-chat">
          <div class="empty-chat-icon">💬</div>
          <h3>Start a Conversation</h3>
          <p>Send us a message and our support team will get back to you shortly!</p>
        </div>
      <%
        } else {
          for (ChatMessage m : messages) {
            boolean isUser = "user".equals(m.getType());
      %>
        <div class="message <%= isUser ? "user-msg" : "admin-msg" %>">
          <div class="bubble"><%= m.getMessage() %></div>
          <div class="msg-meta">
            <span class="msg-sender"><%= isUser ? "You" : "Support" %></span>
            &bull; <%= m.getDateTime() %>
          </div>
        </div>
      <%
          }
        }
      %>
    </div>

    <!-- Input -->
    <div class="chat-input">
      <form action="sendMessage" method="post">
        <input type="hidden" name="type" value="user">
        <div class="input-row">
          <input type="text" name="message" class="msg-input" placeholder="Type your message here..." required autocomplete="off">
          <button type="submit" class="btn-send">➤</button>
        </div>
      </form>
    </div>
  </div>
</div>

<footer>&copy; 2026 <strong>Easy Go Drive</strong> Vehicle Rental System</footer>

<script>
  // Auto scroll to bottom
  const area = document.getElementById('messagesArea');
  if (area) area.scrollTop = area.scrollHeight;
</script>

</body>
</html>