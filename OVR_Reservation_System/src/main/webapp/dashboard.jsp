<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OVR — Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
:root {
  --primary:    #00818A;
  --accent:     #20ADAD;
  --sidebar:    #2C3E50;
  --sidebar-hover: #34495e;
  --bg:         #F4F7F6;
  --card:       #FFFFFF;
  --success:    #27AE60;
  --warning:    #F39C12;
  --danger:     #E74C3C;
  --text-dark:  #1a252f;
  --text-muted: #7f8c8d;
  --border:     #e8eeed;
  --shadow:     0 2px 16px rgba(0,129,138,.10);
  --shadow-lg:  0 8px 32px rgba(0,129,138,.15);
}

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
  font-family: 'DM Sans', sans-serif;
  background: var(--bg);
  color: var(--text-dark);
  display: flex;
  min-height: 100vh;
  overflow-x: hidden;
}

/* ── SIDEBAR ─────────────────────────────────────────────── */
.sidebar {
  width: 260px;
  background: var(--sidebar);
  min-height: 100vh;
  position: fixed;
  left: 0; top: 0;
  display: flex;
  flex-direction: column;
  z-index: 100;
  box-shadow: 4px 0 20px rgba(0,0,0,.18);
  transition: width .3s;
}

.sidebar-brand {
  padding: 28px 22px 22px;
  border-bottom: 1px solid rgba(255,255,255,.08);
}
.sidebar-brand .brand-icon {
  width: 44px; height: 44px;
  background: linear-gradient(135deg, var(--primary), var(--accent));
  border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  font-size: 1.3rem; margin-bottom: 10px;
  box-shadow: 0 4px 12px rgba(0,129,138,.4);
}
.sidebar-brand .brand-name {
  font-family: 'Playfair Display', serif;
  font-size: 1rem; font-weight: 700;
  color: var(--accent);
  letter-spacing: .5px;
}
.sidebar-brand .brand-sub {
  font-size: .72rem; color: rgba(255,255,255,.45);
  margin-top: 2px; letter-spacing: .3px;
}

.sidebar-nav { flex: 1; padding: 18px 0; }
.nav-section-label {
  font-size: .68rem; text-transform: uppercase; letter-spacing: 1.2px;
  color: rgba(255,255,255,.3); padding: 14px 22px 6px; font-weight: 600;
}
.nav-item {
  display: flex; align-items: center; gap: 12px;
  padding: 11px 22px; text-decoration: none;
  color: rgba(255,255,255,.65); font-size: .88rem; font-weight: 500;
  border-left: 3px solid transparent;
  transition: all .2s; position: relative;
}
.nav-item:hover {
  background: rgba(255,255,255,.06);
  color: #fff; border-left-color: var(--accent);
}
.nav-item.active {
  background: rgba(0,129,138,.18);
  color: #fff; border-left-color: var(--primary);
}
.nav-item .nav-icon { font-size: 1.05rem; width: 20px; text-align: center; flex-shrink: 0; }

.sidebar-footer {
  padding: 16px 22px 24px;
  border-top: 1px solid rgba(255,255,255,.08);
}
.user-pill {
  display: flex; align-items: center; gap: 10px;
  background: rgba(255,255,255,.06); border-radius: 10px;
  padding: 10px 12px; margin-bottom: 12px;
}
.user-avatar {
  width: 34px; height: 34px; border-radius: 50%;
  background: linear-gradient(135deg, var(--primary), var(--accent));
  display: flex; align-items: center; justify-content: center;
  font-size: .85rem; font-weight: 700; color: #fff; flex-shrink: 0;
}
.user-info .user-name { font-size: .85rem; font-weight: 600; color: #fff; }
.user-info .user-role { font-size: .7rem; color: rgba(255,255,255,.45); }
.btn-logout {
  display: flex; align-items: center; justify-content: center; gap: 8px;
  width: 100%; background: rgba(231,76,60,.15); color: #e74c3c;
  border: 1px solid rgba(231,76,60,.25); border-radius: 8px;
  padding: 9px; font-size: .84rem; font-weight: 600; text-decoration: none;
  transition: all .2s; cursor: pointer;
}
.btn-logout:hover { background: rgba(231,76,60,.25); }

/* ── TOPBAR ──────────────────────────────────────────────── */
.main-wrapper { margin-left: 260px; display: flex; flex-direction: column; flex: 1; min-width: 0; }

.topbar {
  background: var(--card);
  border-bottom: 1px solid var(--border);
  padding: 0 32px;
  height: 64px;
  display: flex; align-items: center; justify-content: space-between;
  position: sticky; top: 0; z-index: 50;
  box-shadow: 0 1px 8px rgba(0,0,0,.06);
}
.topbar-left h1 {
  font-family: 'Playfair Display', serif;
  font-size: 1.3rem; color: var(--text-dark); font-weight: 700;
}
.topbar-left p { font-size: .8rem; color: var(--text-muted); margin-top: 1px; }
.topbar-right { display: flex; align-items: center; gap: 14px; }
.topbar-date {
  background: #f0f9fa; border: 1px solid #cce8ea;
  color: var(--primary); font-size: .8rem; font-weight: 500;
  padding: 6px 14px; border-radius: 20px;
}

/* ── PAGE CONTENT ────────────────────────────────────────── */
.page-content { padding: 28px 32px; flex: 1; }

/* ── STAT CARDS ──────────────────────────────────────────── */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px; margin-bottom: 28px;
}
.stat-card {
  background: var(--card); border-radius: 16px;
  padding: 22px 20px 20px;
  box-shadow: var(--shadow); position: relative; overflow: hidden;
  transition: transform .25s, box-shadow .25s;
}
.stat-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-lg); }
.stat-card::before {
  content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px;
}
.stat-card.teal::before   { background: linear-gradient(90deg, var(--primary), var(--accent)); }
.stat-card.green::before  { background: var(--success); }
.stat-card.orange::before { background: var(--warning); }
.stat-card.red::before    { background: var(--danger); }
.stat-card .stat-icon {
  width: 44px; height: 44px; border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  font-size: 1.2rem; margin-bottom: 14px;
}
.stat-card.teal   .stat-icon { background: #e0f5f5; }
.stat-card.green  .stat-icon { background: #eafaf1; }
.stat-card.orange .stat-icon { background: #fef9e7; }
.stat-card.red    .stat-icon { background: #fdedec; }
.stat-card .stat-num {
  font-size: 1.9rem; font-weight: 700; line-height: 1;
  font-family: 'Playfair Display', serif;
}
.stat-card.teal   .stat-num { color: var(--primary); }
.stat-card.green  .stat-num { color: var(--success); }
.stat-card.orange .stat-num { color: var(--warning); }
.stat-card.red    .stat-num { color: var(--danger); }
.stat-card .stat-label {
  font-size: .77rem; color: var(--text-muted);
  text-transform: uppercase; letter-spacing: .6px;
  margin-top: 6px; font-weight: 500;
}

/* ── SECTION HEADING ─────────────────────────────────────── */
.section-heading {
  font-family: 'Playfair Display', serif;
  font-size: 1.1rem; color: var(--text-dark);
  margin-bottom: 16px; display: flex; align-items: center; gap: 8px;
}
.section-heading::after {
  content: ''; flex: 1; height: 1px; background: var(--border);
}

/* ── QUICK ACTIONS ───────────────────────────────────────── */
.action-grid {
  display: grid; grid-template-columns: repeat(3, 1fr);
  gap: 18px; margin-bottom: 28px;
}
.action-card {
  background: var(--card); border-radius: 16px;
  padding: 22px; text-decoration: none;
  border: 1.5px solid var(--border);
  display: flex; align-items: center; gap: 16px;
  transition: all .25s; box-shadow: var(--shadow);
}
.action-card:hover {
  border-color: var(--primary); box-shadow: var(--shadow-lg);
  transform: translateY(-3px);
}
.action-card:hover .action-arrow { transform: translateX(4px); color: var(--primary); }
.action-icon-wrap {
  width: 50px; height: 50px; border-radius: 14px;
  display: flex; align-items: center; justify-content: center;
  font-size: 1.3rem; flex-shrink: 0;
}
.action-card.add  .action-icon-wrap { background: linear-gradient(135deg,#e0f5f5,#b3e8e8); }
.action-card.view .action-icon-wrap { background: linear-gradient(135deg,#eafaf1,#c5ead5); }
.action-card.bill .action-icon-wrap { background: linear-gradient(135deg,#fef9e7,#fde8a0); }
.action-card h3 { font-size: .95rem; font-weight: 600; color: var(--text-dark); margin-bottom: 3px; }
.action-card p  { font-size: .78rem; color: var(--text-muted); }
.action-arrow   { margin-left: auto; font-size: 1rem; color: var(--border); transition: all .2s; }

/* ── WELCOME BANNER ──────────────────────────────────────── */
.welcome-banner {
  background: linear-gradient(135deg, var(--sidebar) 0%, var(--primary) 100%);
  border-radius: 18px; padding: 28px 32px;
  color: #fff; margin-bottom: 28px;
  display: flex; align-items: center; justify-content: space-between;
  box-shadow: var(--shadow-lg); overflow: hidden; position: relative;
}
.welcome-banner::before {
  content: '🌊';
  position: absolute; right: 32px; bottom: -10px;
  font-size: 6rem; opacity: .12; transform: rotate(-10deg);
}
.welcome-banner h2 { font-family: 'Playfair Display', serif; font-size: 1.45rem; margin-bottom: 6px; }
.welcome-banner p  { font-size: .87rem; color: rgba(255,255,255,.7); }
.welcome-badge {
  background: rgba(255,255,255,.15); border: 1px solid rgba(255,255,255,.25);
  border-radius: 8px; padding: 10px 18px; text-align: center; flex-shrink: 0;
}
.welcome-badge .badge-val { font-family: 'Playfair Display', serif; font-size: 1.4rem; font-weight: 700; }
.welcome-badge .badge-lbl { font-size: .72rem; color: rgba(255,255,255,.65); letter-spacing: .4px; }
</style>
</head>
<body>

<!-- ══ SIDEBAR ══════════════════════════════════════════════ -->
<aside class="sidebar">
  <div class="sidebar-brand">
    <div class="brand-icon">🌊</div>
    <div class="brand-name">OCEAN VIEW RESORT</div>
    <div class="brand-sub">Reservation Management System</div>
  </div>

  <nav class="sidebar-nav">
    <div class="nav-section-label">Main Menu</div>
    <a href="${pageContext.request.contextPath}/dashboard" class="nav-item active">
      <span class="nav-icon">🏠</span> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/add-reservation" class="nav-item">
      <span class="nav-icon">➕</span> Add Reservation
    </a>
    <a href="${pageContext.request.contextPath}/view-reservation" class="nav-item">
      <span class="nav-icon">🔍</span> View Reservation
    </a>
    <a href="${pageContext.request.contextPath}/bill" class="nav-item">
      <span class="nav-icon">🧾</span> Billing
    </a>
    <div class="nav-section-label" style="margin-top:8px;">Support</div>
    <a href="${pageContext.request.contextPath}/help" class="nav-item">
      <span class="nav-icon">❓</span> Help & Guide
    </a>
  </nav>

  <div class="sidebar-footer">
    <div class="user-pill">
      <div class="user-avatar">${sessionScope.username.substring(0,1).toUpperCase()}</div>
      <div class="user-info">
        <div class="user-name">${sessionScope.username}</div>
        <div class="user-role">Receptionist</div>
      </div>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
      🚪 Sign Out
    </a>
  </div>
</aside>

<!-- ══ MAIN WRAPPER ══════════════════════════════════════════ -->
<div class="main-wrapper">

  <!-- TOPBAR -->
  <header class="topbar">
    <div class="topbar-left">
      <h1>Dashboard</h1>
      <p>Welcome back, here's your resort overview</p>
    </div>
    <div class="topbar-right">
      <span class="topbar-date">📅 <%= java.time.LocalDate.now().toString() %></span>
    </div>
  </header>

  <!-- PAGE CONTENT -->
  <main class="page-content">

    <!-- WELCOME BANNER -->
    <div class="welcome-banner">
      <div>
        <h2>Good day, ${sessionScope.username}! 👋</h2>
        <p>Here's what's happening at Ocean View Resort today.</p>
      </div>
      <div class="welcome-badge">
        <div class="badge-val">${stats.totalReservations}</div>
        <div class="badge-lbl">TOTAL BOOKINGS</div>
      </div>
    </div>

    <!-- STATS -->
    <div class="stats-grid">
      <div class="stat-card teal">
        <div class="stat-icon">📋</div>
        <div class="stat-num">${stats.totalReservations}</div>
        <div class="stat-label">Total Reservations</div>
      </div>
      <div class="stat-card green">
        <div class="stat-icon">🏨</div>
        <div class="stat-num">${stats.todayCheckIns}</div>
        <div class="stat-label">Today's Check-Ins</div>
      </div>
      <div class="stat-card orange">
        <div class="stat-icon">🚪</div>
        <div class="stat-num">${stats.todayCheckOuts}</div>
        <div class="stat-label">Today's Check-Outs</div>
      </div>
      <div class="stat-card red">
        <div class="stat-icon">💰</div>
        <div class="stat-num" style="font-size:1.4rem;">
          Rs.<fmt:formatNumber value="${stats.todayRevenue}" pattern="#,##0"/>
        </div>
        <div class="stat-label">Today's Revenue</div>
      </div>
    </div>

    <!-- QUICK ACTIONS -->
    <div class="section-heading">Quick Actions</div>
    <div class="action-grid">
      <a href="${pageContext.request.contextPath}/add-reservation" class="action-card add">
        <div class="action-icon-wrap">➕</div>
        <div>
          <h3>Add Reservation</h3>
          <p>Register a new guest booking</p>
        </div>
        <span class="action-arrow">→</span>
      </a>
      <a href="${pageContext.request.contextPath}/view-reservation" class="action-card view">
        <div class="action-icon-wrap">🔍</div>
        <div>
          <h3>View Reservation</h3>
          <p>Search &amp; manage bookings</p>
        </div>
        <span class="action-arrow">→</span>
      </a>
      <a href="${pageContext.request.contextPath}/bill" class="action-card bill">
        <div class="action-icon-wrap">🧾</div>
        <div>
          <h3>Generate Bill</h3>
          <p>Calculate &amp; print guest invoice</p>
        </div>
        <span class="action-arrow">→</span>
      </a>
    </div>

  </main>
</div>

</body>
</html>