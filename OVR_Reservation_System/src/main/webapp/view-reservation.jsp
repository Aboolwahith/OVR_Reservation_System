<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OVR — View Reservation</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
:root {
  --primary:#00818A; --accent:#20ADAD; --sidebar:#2C3E50;
  --bg:#F4F7F6; --card:#FFFFFF; --success:#27AE60;
  --warning:#F39C12; --danger:#E74C3C;
  --text-dark:#1a252f; --text-muted:#7f8c8d;
  --border:#e8eeed;
  --shadow:0 2px 16px rgba(0,129,138,.10);
  --shadow-lg:0 8px 32px rgba(0,129,138,.15);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--text-dark);display:flex;min-height:100vh;}

/* ── SIDEBAR ─────────────────────────────────────────────── */
.sidebar{width:260px;background:var(--sidebar);min-height:100vh;position:fixed;left:0;top:0;display:flex;flex-direction:column;z-index:100;box-shadow:4px 0 20px rgba(0,0,0,.18);}
.sidebar-brand{padding:28px 22px 22px;border-bottom:1px solid rgba(255,255,255,.08);}
.brand-icon{width:44px;height:44px;background:linear-gradient(135deg,var(--primary),var(--accent));border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.3rem;margin-bottom:10px;box-shadow:0 4px 12px rgba(0,129,138,.4);}
.brand-name{font-family:'Playfair Display',serif;font-size:1rem;font-weight:700;color:var(--accent);letter-spacing:.5px;}
.brand-sub{font-size:.72rem;color:rgba(255,255,255,.45);margin-top:2px;}
.sidebar-nav{flex:1;padding:18px 0;}
.nav-section-label{font-size:.68rem;text-transform:uppercase;letter-spacing:1.2px;color:rgba(255,255,255,.3);padding:14px 22px 6px;font-weight:600;}
.nav-item{display:flex;align-items:center;gap:12px;padding:11px 22px;text-decoration:none;color:rgba(255,255,255,.65);font-size:.88rem;font-weight:500;border-left:3px solid transparent;transition:all .2s;}
.nav-item:hover{background:rgba(255,255,255,.06);color:#fff;border-left-color:var(--accent);}
.nav-item.active{background:rgba(0,129,138,.18);color:#fff;border-left-color:var(--primary);}
.nav-icon{font-size:1.05rem;width:20px;text-align:center;flex-shrink:0;}
.sidebar-footer{padding:16px 22px 24px;border-top:1px solid rgba(255,255,255,.08);}
.user-pill{display:flex;align-items:center;gap:10px;background:rgba(255,255,255,.06);border-radius:10px;padding:10px 12px;margin-bottom:12px;}
.user-avatar{width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,var(--primary),var(--accent));display:flex;align-items:center;justify-content:center;font-size:.85rem;font-weight:700;color:#fff;flex-shrink:0;}
.user-name{font-size:.85rem;font-weight:600;color:#fff;}
.user-role{font-size:.7rem;color:rgba(255,255,255,.45);}
.btn-logout{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;background:rgba(231,76,60,.15);color:#e74c3c;border:1px solid rgba(231,76,60,.25);border-radius:8px;padding:9px;font-size:.84rem;font-weight:600;text-decoration:none;transition:all .2s;}
.btn-logout:hover{background:rgba(231,76,60,.25);}

/* ── MAIN ────────────────────────────────────────────────── */
.main-wrapper{margin-left:260px;display:flex;flex-direction:column;flex:1;min-width:0;}
.topbar{background:var(--card);border-bottom:1px solid var(--border);padding:0 32px;height:64px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:50;box-shadow:0 1px 8px rgba(0,0,0,.06);}
.topbar-left h1{font-family:'Playfair Display',serif;font-size:1.3rem;color:var(--text-dark);font-weight:700;}
.topbar-left p{font-size:.8rem;color:var(--text-muted);margin-top:1px;}
.breadcrumb{font-size:.8rem;color:var(--text-muted);display:flex;align-items:center;gap:6px;}
.breadcrumb a{color:var(--primary);text-decoration:none;}
.page-content{padding:28px 32px;flex:1;}

/* ── SEARCH CARD ─────────────────────────────────────────── */
.search-card{background:var(--card);border-radius:16px;padding:26px 28px;box-shadow:var(--shadow);margin-bottom:24px;}
.search-card-title{font-family:'Playfair Display',serif;font-size:1rem;color:var(--text-dark);margin-bottom:16px;display:flex;align-items:center;gap:8px;}

/* tabs */
.search-tabs{display:flex;gap:0;margin-bottom:18px;border:1.5px solid var(--border);border-radius:10px;overflow:hidden;}
.tab-btn{flex:1;padding:10px;border:none;background:transparent;font-family:'DM Sans',sans-serif;font-size:.87rem;font-weight:500;color:var(--text-muted);cursor:pointer;transition:all .2s;}
.tab-btn.active{background:var(--primary);color:#fff;}
.tab-btn:hover:not(.active){background:#f0f9fa;color:var(--primary);}

/* tab panels */
.tab-panel{display:none;}
.tab-panel.active{display:block;}

/* manual search row */
.search-row{display:flex;gap:12px;}
.search-input{flex:1;padding:12px 16px;border:1.5px solid #cde4e5;border-radius:10px;font-size:.95rem;font-family:'DM Sans',sans-serif;outline:none;background:#fafefe;transition:border .2s,box-shadow .2s;}
.search-input:focus{border-color:var(--primary);box-shadow:0 0 0 3px rgba(0,129,138,.12);}
.btn-search{background:linear-gradient(135deg,var(--primary),var(--accent));color:#fff;border:none;padding:12px 28px;border-radius:10px;font-size:.92rem;font-family:'DM Sans',sans-serif;font-weight:600;cursor:pointer;white-space:nowrap;transition:opacity .2s;}
.btn-search:hover{opacity:.88;}

/* dropdown tab */
.dropdown-hint{font-size:.8rem;color:var(--text-muted);margin-bottom:10px;}
.res-dropdown-wrap{position:relative;}
.res-dropdown{width:100%;padding:12px 16px;border:1.5px solid #cde4e5;border-radius:10px;font-size:.9rem;font-family:'DM Sans',sans-serif;background:#fafefe;outline:none;color:var(--text-dark);cursor:pointer;transition:border .2s;}
.res-dropdown:focus{border-color:var(--primary);box-shadow:0 0 0 3px rgba(0,129,138,.12);}

/* ── EMPTY STATE ─────────────────────────────────────────── */
.empty-state{text-align:center;padding:48px 20px;color:var(--text-muted);}
.empty-state .empty-icon{font-size:3.5rem;margin-bottom:14px;opacity:.5;}
.empty-state h3{font-family:'Playfair Display',serif;font-size:1.05rem;color:var(--text-dark);margin-bottom:6px;}
.empty-state p{font-size:.85rem;}

/* ── ALERT ───────────────────────────────────────────────── */
.alert{padding:13px 16px;border-radius:10px;margin-bottom:20px;font-size:.88rem;display:flex;align-items:flex-start;gap:10px;}
.alert-danger{background:#fdecea;color:#c0392b;border-left:4px solid var(--danger);}
.alert-success{background:#eafaf1;color:#1e8449;border-left:4px solid var(--success);}

/* ── RESULT CARD ─────────────────────────────────────────── */
.result-card{background:var(--card);border-radius:20px;box-shadow:var(--shadow-lg);overflow:hidden;}
.result-header{background:linear-gradient(135deg,var(--sidebar),var(--primary));padding:22px 28px;display:flex;align-items:center;justify-content:space-between;}
.result-header-left h2{font-family:'Playfair Display',serif;font-size:1.1rem;color:#fff;}
.result-header-left p{font-size:.78rem;color:rgba(255,255,255,.65);margin-top:2px;}
.res-number-badge{background:rgba(255,255,255,.15);border:1px solid rgba(255,255,255,.3);border-radius:8px;padding:8px 16px;font-size:.85rem;color:#fff;font-weight:600;letter-spacing:.5px;}

.result-body{display:grid;grid-template-columns:1fr 1fr;}
.detail-section{padding:24px 28px;}
.detail-section:first-child{border-right:1px solid var(--border);}
.detail-section-title{font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:var(--primary);font-weight:600;margin-bottom:14px;}
.detail-row{display:flex;justify-content:space-between;align-items:flex-start;padding:9px 0;border-bottom:1px solid #f5f8f7;gap:12px;}
.detail-row:last-child{border-bottom:none;}
.dk{font-size:.83rem;color:var(--text-muted);font-weight:500;flex-shrink:0;}
.dv{font-size:.88rem;color:var(--text-dark);font-weight:500;text-align:right;}

.result-footer{padding:20px 28px;background:#fafefe;border-top:1px solid var(--border);display:flex;gap:12px;align-items:center;}
.btn-primary{background:linear-gradient(135deg,var(--primary),var(--accent));color:#fff;border:none;padding:12px 28px;border-radius:10px;font-size:.9rem;font-family:'DM Sans',sans-serif;font-weight:600;cursor:pointer;text-decoration:none;transition:opacity .2s,transform .15s;display:inline-flex;align-items:center;gap:7px;}
.btn-primary:hover{opacity:.9;transform:translateY(-1px);}
.btn-outline{background:transparent;color:var(--primary);border:1.5px solid var(--primary);padding:12px 24px;border-radius:10px;font-size:.9rem;font-family:'DM Sans',sans-serif;font-weight:600;text-decoration:none;transition:all .2s;display:inline-flex;align-items:center;gap:7px;}
.btn-outline:hover{background:var(--primary);color:#fff;}

/* ── RECENT LIST ─────────────────────────────────────────── */
.recent-card{background:var(--card);border-radius:16px;padding:22px 26px;box-shadow:var(--shadow);margin-top:24px;}
.recent-title{font-family:'Playfair Display',serif;font-size:1rem;color:var(--text-dark);margin-bottom:16px;display:flex;align-items:center;justify-content:space-between;}
.recent-count{background:#e0f5f5;color:var(--primary);font-size:.75rem;font-weight:600;padding:3px 10px;border-radius:20px;}
.res-table{width:100%;border-collapse:collapse;}
.res-table th{font-size:.75rem;text-transform:uppercase;letter-spacing:.7px;color:var(--text-muted);font-weight:600;padding:8px 12px;text-align:left;border-bottom:2px solid var(--border);}
.res-table td{padding:11px 12px;font-size:.86rem;border-bottom:1px solid #f5f8f7;color:var(--text-dark);}
.res-table tr:last-child td{border-bottom:none;}
.res-table tr:hover td{background:#f7fafa;cursor:pointer;}
.res-num-link{color:var(--primary);font-weight:600;text-decoration:none;font-family:'DM Sans',sans-serif;}
.res-num-link:hover{text-decoration:underline;}
.badge-room{background:#e0f5f5;color:var(--primary);padding:3px 10px;border-radius:20px;font-size:.78rem;font-weight:600;}
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
    <a href="${pageContext.request.contextPath}/dashboard"        class="nav-item"><span class="nav-icon">🏠</span> Dashboard</a>
    <a href="${pageContext.request.contextPath}/add-reservation"  class="nav-item"><span class="nav-icon">➕</span> Add Reservation</a>
    <a href="${pageContext.request.contextPath}/view-reservation" class="nav-item active"><span class="nav-icon">🔍</span> View Reservation</a>
    <a href="${pageContext.request.contextPath}/bill"             class="nav-item"><span class="nav-icon">🧾</span> Billing</a>
    <div class="nav-section-label" style="margin-top:8px;">Support</div>
    <a href="${pageContext.request.contextPath}/help"             class="nav-item"><span class="nav-icon">❓</span> Help & Guide</a>
  </nav>
  <div class="sidebar-footer">
    <div class="user-pill">
      <div class="user-avatar">${sessionScope.username.substring(0,1).toUpperCase()}</div>
      <div class="user-info">
        <div class="user-name">${sessionScope.username}</div>
        <div class="user-role">Receptionist</div>
      </div>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">🚪 Sign Out</a>
  </div>
</aside>

<!-- ══ MAIN WRAPPER ══════════════════════════════════════════ -->
<div class="main-wrapper">
  <header class="topbar">
    <div class="topbar-left">
      <h1>View Reservation</h1>
      <p>Search and view guest booking details</p>
    </div>
    <div class="breadcrumb">
      <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a> › View Reservation
    </div>
  </header>

  <main class="page-content">

    <!-- ── SEARCH CARD ─────────────────────────────────────── -->
    <div class="search-card">
      <div class="search-card-title">🔍 Find a Reservation</div>

      <!-- TABS -->
      <div class="search-tabs">
        <button class="tab-btn active" onclick="switchTab('manual')">✏️ Type Number</button>
        <button class="tab-btn"        onclick="switchTab('dropdown')">📋 Select from List</button>
      </div>

      <!-- TAB 1: Manual input -->
      <div class="tab-panel active" id="tab-manual">
        <form method="GET" action="${pageContext.request.contextPath}/view-reservation">
          <div class="search-row">
            <input type="text" class="search-input" name="number"
                   id="manualInput"
                   placeholder="Enter reservation number (e.g. OVR-20260305-AB12)"
                   value="${param.number}" autofocus>
            <button type="submit" class="btn-search">🔍 Search</button>
          </div>
        </form>
      </div>

      <!-- TAB 2: Dropdown of existing reservations -->
      <div class="tab-panel" id="tab-dropdown">
        <c:choose>
          <c:when test="${empty allReservations}">
            <div style="text-align:center;padding:20px;color:var(--text-muted);font-size:.88rem;">
              No reservations found in the system yet.
              <a href="${pageContext.request.contextPath}/add-reservation"
                 style="color:var(--primary);font-weight:600;"> Add one now →</a>
            </div>
          </c:when>
          <c:otherwise>
            <p class="dropdown-hint">Select a reservation number from the dropdown below:</p>
            <div class="res-dropdown-wrap">
              <select class="res-dropdown" id="resDropdown"
                      onchange="goToReservation(this.value)">
                <option value="">— Select Reservation Number —</option>
                <c:forEach var="r" items="${allReservations}">
                  <option value="${r.reservationNumber}"
                    <c:if test="${param.number == r.reservationNumber}">selected</c:if>>
                    ${r.reservationNumber} — ${r.guestName} (${r.checkIn} → ${r.checkOut})
                  </option>
                </c:forEach>
              </select>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <!-- ── ALERTS ──────────────────────────────────────────── -->
    <c:if test="${param.success == 'added'}">
      <div class="alert alert-success">✅ Reservation saved successfully!</div>
    </c:if>
    <c:if test="${not empty searchError}">
      <div class="alert alert-danger">❌ ${searchError}</div>
    </c:if>

    <!-- ── RESULT ──────────────────────────────────────────── -->
    <c:choose>
      <c:when test="${not empty reservation}">
        <div class="result-card">
          <div class="result-header">
            <div class="result-header-left">
              <h2>Reservation Found</h2>
              <p>Complete booking details for ${reservation.guestName}</p>
            </div>
            <div class="res-number-badge">🔖 ${reservation.reservationNumber}</div>
          </div>

          <div class="result-body">
            <!-- Guest Info -->
            <div class="detail-section">
              <div class="detail-section-title">👤 Guest Information</div>
              <div class="detail-row">
                <span class="dk">Guest Name</span>
                <span class="dv">${reservation.guestName}</span>
              </div>
              <div class="detail-row">
                <span class="dk">Address</span>
                <span class="dv">${reservation.address}</span>
              </div>
              <div class="detail-row">
                <span class="dk">Contact Number</span>
                <span class="dv">${reservation.contactNumber}</span>
              </div>
              <div class="detail-row">
                <span class="dk">Booked On</span>
                <span class="dv">${reservation.createdAt}</span>
              </div>
            </div>
            <!-- Booking Info -->
            <div class="detail-section">
              <div class="detail-section-title">🏨 Booking Details</div>
              <div class="detail-row">
                <span class="dk">Room Type</span>
                <span class="dv">${roomType.typeName}</span>
              </div>
              <div class="detail-row">
                <span class="dk">Room Code</span>
                <span class="dv">${roomType.roomCode}</span>
              </div>
              <div class="detail-row">
                <span class="dk">Rate / Night</span>
                <span class="dv">Rs. <fmt:formatNumber value="${roomType.pricePerNight}" pattern="#,##0"/></span>
              </div>
              <div class="detail-row">
                <span class="dk">Check-In</span>
                <span class="dv">${reservation.checkIn}</span>
              </div>
              <div class="detail-row">
                <span class="dk">Check-Out</span>
                <span class="dv">${reservation.checkOut}</span>
              </div>
            </div>
          </div>

          <div class="result-footer">
            <a href="${pageContext.request.contextPath}/bill?number=${reservation.reservationNumber}"
               class="btn-primary">🧾 Generate Bill</a>
            <a href="${pageContext.request.contextPath}/add-reservation"
               class="btn-outline">➕ New Reservation</a>
          </div>
        </div>
      </c:when>
      <c:when test="${empty param.number}">
        <!-- No search yet — show recent reservations table -->
        <c:if test="${not empty allReservations}">
          <div class="recent-card">
            <div class="recent-title">
              📋 All Reservations
              <span class="recent-count">${fn:length(allReservations)} total</span>
            </div>
            <table class="res-table">
              <thead>
                <tr>
                  <th>Reservation No.</th>
                  <th>Guest Name</th>
                  <th>Room Type</th>
                  <th>Check-In</th>
                  <th>Check-Out</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="r" items="${allReservations}">
                  <tr onclick="window.location='${pageContext.request.contextPath}/view-reservation?number=${r.reservationNumber}'"
                      title="Click to view details">
                    <td>
                      <a href="${pageContext.request.contextPath}/view-reservation?number=${r.reservationNumber}"
                         class="res-num-link">${r.reservationNumber}</a>
                    </td>
                    <td>${r.guestName}</td>
                    <td>
                      <span class="badge-room">Room #${r.roomTypeId}</span>
                    </td>
                    <td>${r.checkIn}</td>
                    <td>${r.checkOut}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:if>
        <c:if test="${empty allReservations}">
          <div class="empty-state">
            <div class="empty-icon">📭</div>
            <h3>No Reservations Yet</h3>
            <p>No bookings have been made. <a href="${pageContext.request.contextPath}/add-reservation"
               style="color:var(--primary);font-weight:600;">Add the first reservation →</a></p>
          </div>
        </c:if>
      </c:when>
    </c:choose>

  </main>
</div>

<script>
  const CTX = '${pageContext.request.contextPath}';

  // ── TAB SWITCHING ────────────────────────────────────────
  function switchTab(tab) {
    document.querySelectorAll('.tab-btn').forEach((b, i) => {
      b.classList.toggle('active', (i === 0 && tab === 'manual') || (i === 1 && tab === 'dropdown'));
    });
    document.getElementById('tab-manual')  .classList.toggle('active', tab === 'manual');
    document.getElementById('tab-dropdown').classList.toggle('active', tab === 'dropdown');
  }

  // ── DROPDOWN NAVIGATION ──────────────────────────────────
  function goToReservation(number) {
    if (number) {
      window.location.href = CTX + '/view-reservation?number=' + encodeURIComponent(number);
    }
  }

  // ── AUTO SWITCH TAB if came via dropdown ─────────────────
  window.addEventListener('DOMContentLoaded', () => {
    const selected = document.getElementById('resDropdown');
    if (selected && selected.value) {
      switchTab('dropdown');
    }
  });
</script>
</body>
</html>
