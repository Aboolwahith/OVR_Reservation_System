<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OVR — Bill / Invoice</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
:root{--primary:#00818A;--accent:#20ADAD;--sidebar:#2C3E50;--bg:#F4F7F6;--card:#FFFFFF;--success:#27AE60;--warning:#F39C12;--danger:#E74C3C;--text-dark:#1a252f;--text-muted:#7f8c8d;--border:#e8eeed;--shadow:0 2px 16px rgba(0,129,138,.10);--shadow-lg:0 8px 32px rgba(0,129,138,.15);}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--text-dark);display:flex;min-height:100vh;}
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
.user-name{font-size:.85rem;font-weight:600;color:#fff;}.user-role{font-size:.7rem;color:rgba(255,255,255,.45);}
.btn-logout{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;background:rgba(231,76,60,.15);color:#e74c3c;border:1px solid rgba(231,76,60,.25);border-radius:8px;padding:9px;font-size:.84rem;font-weight:600;text-decoration:none;transition:all .2s;}
.btn-logout:hover{background:rgba(231,76,60,.25);}
.main-wrapper{margin-left:260px;display:flex;flex-direction:column;flex:1;min-width:0;}
.topbar{background:var(--card);border-bottom:1px solid var(--border);padding:0 32px;height:64px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:50;box-shadow:0 1px 8px rgba(0,0,0,.06);}
.topbar-left h1{font-family:'Playfair Display',serif;font-size:1.3rem;color:var(--text-dark);font-weight:700;}
.topbar-left p{font-size:.8rem;color:var(--text-muted);margin-top:1px;}
.breadcrumb{font-size:.8rem;color:var(--text-muted);display:flex;align-items:center;gap:6px;}
.breadcrumb a{color:var(--primary);text-decoration:none;}
.page-content{padding:28px 32px 40px;flex:1;}

/* ── BILL CARD ───────────────────────────────────────────── */
.bill-wrapper{max-width:640px;margin:0 auto;}
.bill-actions{display:flex;gap:12px;margin-bottom:20px;}
.btn-print{background:linear-gradient(135deg,var(--success),#2ecc71);color:#fff;border:none;padding:12px 28px;border-radius:10px;font-size:.9rem;font-family:'DM Sans',sans-serif;font-weight:600;cursor:pointer;transition:opacity .2s;display:inline-flex;align-items:center;gap:7px;}
.btn-print:hover{opacity:.88;}
.btn-back{background:transparent;color:var(--primary);border:1.5px solid var(--primary);padding:12px 24px;border-radius:10px;font-size:.9rem;font-family:'DM Sans',sans-serif;font-weight:600;text-decoration:none;transition:all .2s;display:inline-flex;align-items:center;gap:7px;}
.btn-back:hover{background:var(--primary);color:#fff;}

/* ── PRINTABLE INVOICE ───────────────────────────────────── */
.invoice{background:var(--card);border-radius:20px;box-shadow:var(--shadow-lg);overflow:hidden;}

.invoice-header{background:linear-gradient(135deg,var(--sidebar) 0%,var(--primary) 100%);padding:36px 36px 28px;text-align:center;position:relative;overflow:hidden;}
.invoice-header::before{content:'🌊';position:absolute;right:-10px;bottom:-20px;font-size:8rem;opacity:.08;transform:rotate(-15deg);}
.invoice-logo{font-family:'Playfair Display',serif;font-size:1.6rem;font-weight:800;color:#fff;letter-spacing:.5px;}
.invoice-logo span{color:var(--accent);}
.invoice-tagline{font-size:.8rem;color:rgba(255,255,255,.55);margin-top:4px;letter-spacing:.3px;}
.invoice-meta{margin-top:20px;display:flex;justify-content:center;gap:20px;}
.meta-chip{background:rgba(255,255,255,.12);border:1px solid rgba(255,255,255,.2);border-radius:8px;padding:8px 16px;font-size:.8rem;color:rgba(255,255,255,.85);}
.meta-chip strong{color:#fff;}

.invoice-body{padding:32px 36px;}

.inv-section{margin-bottom:24px;}
.inv-section-title{font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:var(--primary);font-weight:600;margin-bottom:12px;padding-bottom:7px;border-bottom:1.5px solid #eef5f5;}

.inv-row{display:flex;justify-content:space-between;padding:8px 0;font-size:.88rem;}
.inv-row:not(:last-child){border-bottom:1px solid #f5f9f8;}
.inv-k{color:var(--text-muted);font-weight:500;}
.inv-v{color:var(--text-dark);font-weight:500;text-align:right;}

.inv-divider{border:none;border-top:2px dashed #d0eaea;margin:20px 0;}

.inv-calc-row{display:flex;justify-content:space-between;padding:8px 0;font-size:.88rem;}
.inv-calc-row.subtotal{color:var(--text-muted);font-size:.84rem;}

.inv-total{background:linear-gradient(135deg,var(--sidebar),var(--primary));border-radius:14px;padding:20px 24px;display:flex;justify-content:space-between;align-items:center;margin-top:16px;}
.inv-total-label{color:rgba(255,255,255,.8);font-size:.9rem;font-weight:600;}
.inv-total-amount{font-family:'Playfair Display',serif;font-size:1.8rem;font-weight:700;color:var(--accent);}

.invoice-footer{background:#fafefe;border-top:1px solid var(--border);padding:22px 36px;text-align:center;}
.invoice-footer p{font-size:.82rem;color:var(--text-muted);margin-top:4px;}
.invoice-footer .thank-you{font-family:'Playfair Display',serif;font-size:1.05rem;color:var(--text-dark);font-weight:600;}

.alert{padding:13px 16px;border-radius:10px;margin-bottom:22px;font-size:.88rem;}
.alert-danger{background:#fdecea;color:#c0392b;border-left:4px solid var(--danger);}

/* ── PRINT ───────────────────────────────────────────────── */
@media print {
  .sidebar,.topbar,.bill-actions{display:none!important;}
  body{background:#fff;}
  .main-wrapper{margin-left:0;}
  .page-content{padding:0;}
  .invoice{box-shadow:none;border-radius:0;}
  .bill-wrapper{max-width:100%;}
}
</style>
</head>
<body>

<aside class="sidebar">
  <div class="sidebar-brand">
    <div class="brand-icon">🌊</div>
    <div class="brand-name">OCEAN VIEW RESORT</div>
    <div class="brand-sub">Reservation Management System</div>
  </div>
  <nav class="sidebar-nav">
    <div class="nav-section-label">Main Menu</div>
    <a href="${pageContext.request.contextPath}/dashboard" class="nav-item"><span class="nav-icon">🏠</span> Dashboard</a>
    <a href="${pageContext.request.contextPath}/add-reservation" class="nav-item"><span class="nav-icon">➕</span> Add Reservation</a>
    <a href="${pageContext.request.contextPath}/view-reservation" class="nav-item"><span class="nav-icon">🔍</span> View Reservation</a>
    <a href="${pageContext.request.contextPath}/bill" class="nav-item active"><span class="nav-icon">🧾</span> Billing</a>
    <div class="nav-section-label" style="margin-top:8px;">Support</div>
    <a href="${pageContext.request.contextPath}/help" class="nav-item"><span class="nav-icon">❓</span> Help & Guide</a>
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

<div class="main-wrapper">
  <header class="topbar">
    <div class="topbar-left">
      <h1>Billing & Invoice</h1>
      <p>Generate and print guest bill</p>
    </div>
    <div class="breadcrumb">
      <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a> › Billing
    </div>
  </header>

  <main class="page-content">
    <div class="bill-wrapper">

      <c:if test="${not empty error}">
        <div class="alert alert-danger">❌ ${error}</div>
      </c:if>

      <!-- SEARCH FORM (shown when no reservation loaded) -->
      <c:if test="${empty reservation}">
        <div style="background:var(--card);border-radius:16px;padding:28px;box-shadow:var(--shadow);max-width:640px;">
          <h3 style="font-family:'Playfair Display',serif;margin-bottom:14px;color:var(--text-dark);">🧾 Generate Bill</h3>
          <form method="GET" action="${pageContext.request.contextPath}/bill">
            <div style="display:flex;gap:12px;">
              <input type="text" name="number" class="search-input"
                     placeholder="Enter reservation number (e.g. OVR-20260305-AB12)"
                     style="flex:1;padding:12px 16px;border:1.5px solid #cde4e5;border-radius:10px;font-size:.95rem;font-family:'DM Sans',sans-serif;outline:none;"
                     value="${param.number}" autofocus>
              <button type="submit" style="background:linear-gradient(135deg,var(--primary),var(--accent));color:#fff;border:none;padding:12px 28px;border-radius:10px;font-size:.92rem;font-family:'DM Sans',sans-serif;font-weight:600;cursor:pointer;">
                Generate
              </button>
            </div>
          </form>
        </div>
      </c:if>

      <!-- INVOICE -->
      <c:if test="${not empty reservation}">

        <div class="bill-actions">
          <button class="btn-print" onclick="window.print()">🖨️ Print Invoice</button>
          <a href="${pageContext.request.contextPath}/view-reservation?number=${reservation.reservationNumber}" class="btn-back">← Back</a>
        </div>

        <div class="invoice">
          <!-- HEADER -->
          <div class="invoice-header">
            <div class="invoice-logo"><span>OCEAN VIEW</span> RESORT</div>
            <div class="invoice-tagline">Beachside Luxury · Galle, Sri Lanka</div>
            <div class="invoice-meta">
              <div class="meta-chip">📋 <strong>${reservation.reservationNumber}</strong></div>
              <div class="meta-chip">📅 Printed: <%= java.time.LocalDate.now() %></div>
            </div>
          </div>

          <!-- BODY -->
          <div class="invoice-body">

            <!-- Guest -->
            <div class="inv-section">
              <div class="inv-section-title">👤 Guest Information</div>
              <div class="inv-row"><span class="inv-k">Guest Name</span>    <span class="inv-v">${reservation.guestName}</span></div>
              <div class="inv-row"><span class="inv-k">Address</span>       <span class="inv-v">${reservation.address}</span></div>
              <div class="inv-row"><span class="inv-k">Contact</span>       <span class="inv-v">${reservation.contactNumber}</span></div>
            </div>

            <!-- Booking -->
            <div class="inv-section">
              <div class="inv-section-title">🏨 Booking Details</div>
              <div class="inv-row"><span class="inv-k">Room Type</span>     <span class="inv-v">${roomType.typeName} (${roomType.roomCode})</span></div>
              <div class="inv-row"><span class="inv-k">Check-In</span>      <span class="inv-v">${reservation.checkIn}</span></div>
              <div class="inv-row"><span class="inv-k">Check-Out</span>     <span class="inv-v">${reservation.checkOut}</span></div>
              <div class="inv-row"><span class="inv-k">Duration</span>      <span class="inv-v">${nights} Night(s)</span></div>
            </div>

            <hr class="inv-divider">

            <!-- Bill Calc -->
            <div class="inv-section-title">💰 Billing Summary</div>
            <div class="inv-calc-row subtotal">
              <span>Rate per Night</span>
              <span>Rs. <fmt:formatNumber value="${roomType.pricePerNight}" pattern="#,##0.00"/></span>
            </div>
            <div class="inv-calc-row subtotal">
              <span>Number of Nights</span>
              <span>× ${nights}</span>
            </div>

            <div class="inv-total">
              <span class="inv-total-label">TOTAL AMOUNT DUE</span>
              <span class="inv-total-amount">Rs. <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
            </div>

          </div>

          <!-- FOOTER -->
          <div class="invoice-footer">
            <div class="thank-you">Thank you for choosing Ocean View Resort! 🙏</div>
            <p>We hope you enjoyed your stay and look forward to welcoming you again.</p>
            <p style="margin-top:8px;font-size:.75rem;color:#bbb;">This is a computer-generated invoice. No signature required.</p>
          </div>
        </div>

      </c:if>
    </div>
  </main>
</div>

</body>
</html>
