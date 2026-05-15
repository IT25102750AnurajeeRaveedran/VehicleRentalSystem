<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rental.model.ChatMessage, com.rental.model.User, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Easy Go Drive – Admin Chat</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root { --bg: #0a0a0f; --surface: #13131a; --card: #1a1a24; --border: #2a2a38; --accent: #f0c040; --text: #f0ede8; --muted: #7a7a8a; --danger: #e04040; --success: #40c080; }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; display: flex; }

    /* Sidebar */
    .sidebar { width: 240px; background: var(--surface); border-right: 1px solid var(--border); min-height: 100vh; position: fixed; top: 0; left: 0; z-index: 100; display: flex; flex-direction: column; }
    .sidebar-logo { padding: 24px; border-bottom: 1px solid var(--border); }
    .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 20px; }
    .logo span { color: var(--accent); }
    .admin-badge { display: inline-block; background: #e0404020; border: 1px solid #e0404040; color: var(--danger); font-size: 10px; font-weight: 700; padding: 2px 8px; border-radius: 10px; text-transform: uppercase; margin-top: 4px; letter-spacing: 1px; }
    .sidebar-nav { padding: 16px 0; flex: 1; }
    .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px 24px; color: var(--muted); text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; }
    .nav-item:hover { color: var(--text); background: #ffffff08; }
    .nav-item.active { color: var(--accent); background: #f0c04010; border-right: 3px solid var(--accent); }
    .nav-icon { font-size: 18px; width: 24px; }
    .nav-divider { height: 1px; background: var(--border); margin: 8px 24px; }
    .sidebar-footer { padding: 16px 24px; border-top: 1px solid var(--border); }
    .admin-info { display: flex; align-items: center; gap: 10px; margin-bottom: 12px; }
    .admin-avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--accent), #e05c2a); display: flex; align-items: center; justify-content: center; font-family: 'Syne', sans-serif; font-weight: 800; font-size: 14px; color: #000; }
    .admin-name { font-size: 13px; font-weight: 600; }
    .admin-role { font-size: 11px; color: var(--muted); }
    .btn-logout { display: block; width: 100%; padding: 8px; background: #e0404015; border: 1px solid #e0404030; color: var(--danger); border-radius: 8px; font-size: 13px; font-weight: 600; text-align: center; text-decoration: none; }
    .btn-logout:hover { background: #e0404025; }

    /* Main */
    .main { margin-left: 240px; flex: 1; padding: 40px; display: flex; gap: 24px; }

    /* Users list */
    .users-panel { width: 280px; flex-shrink: 0; }
    .users-panel h2 { font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; margin-bottom: 16px; }
    .users-panel h2 span { color: var(--accent); }
    .user-item { display: flex; align-items: center; gap: 12px; padding: 14px 16px; background: var(--card); border: 1px solid var(--border); border-radius: 12px; margin-bottom: 8px; text-decoration: none; color: var(--text); transition: all 0.2s; cursor: pointer; }
    .user-item:hover { border-color: var(--accent); }
    .user-item.selected { border-color: var(--accent); background: #f0c04010; }
    .user-av { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, #4080e0, #2050a0); display: flex; align-items: center; justify-content: center; font-family: 'Syne', sans-serif; font-weight: 800; font-size: 13px; color: #fff; flex-shrink: 0; }
    .user-item-name { font-size: 13px; font-weight: 600; }
    .user-item-id { font-size: 11px; color: var(--muted); }
    .no-chats { text-align: center; padding: 32px 16px; color: var(--muted); font-size: 13px; background: var(--card); border: 1px solid var(--border); border-radius: 12px; }

    /* Chat panel */
    .chat-panel { flex: 1; display: flex; flex-direction: column; }
    .chat-panel h2 { font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; margin-bottom: 16px; }
    .chat-panel h2 span { color: var(--accent); }

    .chat-box { background: var(--card); border: 1px solid var(--border); border-radius: 20px; overflow: hidden; display: flex; flex-direction: column; flex: 1; min-height: 500px; }
    .chat-topbar { padding: 16px 20px; background: #111118; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 10px; }
    .support-icon { font-size: 24px; }
    .chat-title { font-family: 'Syne', sans-serif; font-size: 14px; font-weight: 700; }
    .chat-subtitle { font-size: 12px; color: var(--muted); }

    .messages-area { flex: 1; overflow-y: auto; padding: 20px; display: flex; flex-direction: column; gap: 12px; }
    .messages-area::-webkit-scrollbar { width: 4px; }
    .messages-area::-webkit-scrollbar-thumb { background: var(--border); border-radius: 4px; }

    .message { display: flex; flex-direction: column; max-width: 70%; }
    .message.user-msg { align-self: flex-start; align-items: flex-start; }
    .message.admin-msg { align-self: flex-end; align-items: flex-end; }
    .bubble { padding: 10px 14px; border-radius: 14px; font-size: 13px; line-height: 1.5; }
    .user-msg .bubble { background: #2a2a38; border: 1px solid var(--border); color: var(--text); border-bottom-left-radius: 4px; }
    .admin-msg .bubble { background: var(--accent); color: #000; border-bottom-right-radius: 4px; }
    .msg-meta { font-size: 11px; color: var(--muted); margin-top: 3px; }

    .empty-chat { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; color: var(--muted); text-align: center; padding: 40px; }
    .empty-chat-icon { font-size: 40px; margin-bottom: 12px; }

    /* Reply input */
    .reply-area { padding: 16px 20px; border-top: 1px solid var(--border); background: #111118; }
    .reply-row { display: flex; gap: 10px; }
    .reply-input { flex: 1; background: var(--card); border: 1px solid var(--border); color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 14px; padding: 10px 14px; border-radius: 10px; outline: none; transition: border 0.2s; }
    .reply-input:focus { border-color: var(--accent); }
    .reply-input::placeholder { color: var(--muted); }
    .btn-reply { background: var(--accent); color: #000; border: none; padding: 10px 20px; border-radius: 10px; font-family: 'Syne', sans-serif; font-size: 13px; font-weight: 700; cursor: pointer; transition: all 0.2s; }
    .btn-reply:hover { background: #ffd060; }

    .no-select { flex: 1; display: flex; align-items: center; justify-content: center; color: var(--muted); font-size: 14px; text-align: center; padding: 40px; background: var(--card); border: 1px solid var(--border); border-radius: 20px; }
  </style>
</head>
<body>

<%
  User adminUser = (User) request.getAttribute("adminUser");
  List<User> chatUsers = (List<User>) request.getAttribute("chatUsers");
  List<ChatMessage> messages = (List<ChatMessage>) request.getAttribute("messages");
  String selectedUserId = (String) request.getAttribute("selectedUserId");
  if (adminUser == null) { response.sendRedirect("login.jsp"); return; }

  String initials = "";
  for (String p : adminUser.getFullName().split(" "))
    if (!p.isEmpty()) initials += p.charAt(0);
  if (initials.length() > 2) initials = initials.substring(0, 2);
%>

<div class="sidebar">
  <div class="sidebar-logo">
    <div class="logo">Easy Go<span> Drive</span></div>
    <div class="admin-badge">Admin Panel</div>
  </div>
  <nav class="sidebar-nav">
    <a href="adminDashboard" class="nav-item"><span class="nav-icon">📊</span> Dashboard</a>
    <a href="manageUsers" class="nav-item"><span class="nav-icon">👥</span> Manage Users</a>
    <a href="vehicles" class="nav-item"><span class="nav-icon">🚗</span> Vehicles</a>
    <a href="rentalHistory" class="nav-item"><span class="nav-icon">📋</span> Rental History</a>
    <a href="adminChat" class="nav-item active"><span class="nav-icon">💬</span> Support Chat</a>
    <div class="nav-divider"></div>
    <a href="vehicles" class="nav-item"><span class="nav-icon">🏠</span> Main Site</a>
  </nav>
  <div class="sidebar-footer">
    <div class="admin-info">
      <div class="admin-avatar"><%= initials.toUpperCase() %></div>
      <div>
        <div class="admin-name"><%= adminUser.getFullName() %></div>
        <div class="admin-role">Administrator</div>
      </div>
    </div>
    <a href="logout" class="btn-logout">🚪 Logout</a>
  </div>
</div>

<div class="main">

  <!-- Users Panel -->
  <div class="users-panel">
    <h2>Active <span>Chats</span></h2>
    <%
      if (chatUsers == null || chatUsers.isEmpty()) {
    %>
      <div class="no-chats">💬 No active chats yet</div>
    <%
      } else {
        for (User u : chatUsers) {
          String ui = "";
          for (String p : u.getFullName().split(" "))
            if (!p.isEmpty()) ui += p.charAt(0);
          if (ui.length() > 2) ui = ui.substring(0, 2);
          boolean isSelected = u.getUserId().equals(selectedUserId);
    %>
      <a href="adminChat?userId=<%= u.getUserId() %>"
         class="user-item <%= isSelected ? "selected" : "" %>">
        <div class="user-av"><%= ui.toUpperCase() %></div>
        <div>
          <div class="user-item-name"><%= u.getFullName() %></div>
          <div class="user-item-id"><%= u.getUserId() %></div>
        </div>
      </a>
    <%
        }
      }
    %>
  </div>

  <!-- Chat Panel -->
  <div class="chat-panel">
    <h2>Chat <span>Window</span></h2>
    <%
      if (selectedUserId == null || selectedUserId.isEmpty()) {
    %>
      <div class="no-select">
        <div>
          <div style="font-size:40px;margin-bottom:12px">💬</div>
          <div>Select a user from the left to view their chat</div>
        </div>
      </div>
    <%
      } else {
    %>
      <div class="chat-box">
        <div class="chat-topbar">
          <span class="support-icon">🎧</span>
          <div>
            <div class="chat-title">Chat with User: <%= selectedUserId %></div>
            <div class="chat-subtitle">Support conversation</div>
          </div>
        </div>

        <div class="messages-area" id="messagesArea">
          <%
            if (messages == null || messages.isEmpty()) {
          %>
            <div class="empty-chat">
              <div class="empty-chat-icon">💬</div>
              <p>No messages yet</p>
            </div>
          <%
            } else {
              for (ChatMessage m : messages) {
                boolean isAdmin = "admin".equals(m.getType());
          %>
            <div class="message <%= isAdmin ? "admin-msg" : "user-msg" %>">
              <div class="bubble"><%= m.getMessage() %></div>
              <div class="msg-meta">
                <%= isAdmin ? "You (Admin)" : m.getUserName() %>
                &bull; <%= m.getDateTime() %>
              </div>
            </div>
          <%
              }
            }
          %>
        </div>

        <div class="reply-area">
          <form action="sendMessage" method="post">
            <input type="hidden" name="type" value="admin">
            <input type="hidden" name="targetUserId" value="<%= selectedUserId %>">
            <div class="reply-row">
              <input type="text" name="message" class="reply-input" placeholder="Type your reply..." required autocomplete="off">
              <button type="submit" class="btn-reply">Send ➤</button>
            </div>
          </form>
        </div>
      </div>
    <% } %>
  </div>
</div>

<script>
  const area = document.getElementById('messagesArea');
  if (area) area.scrollTop = area.scrollHeight;
</script>

</body>
</html>