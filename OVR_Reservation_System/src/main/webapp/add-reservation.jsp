<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OVR — Add Reservation</title>
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
  --input-border: #cde4e5;
  --shadow:     0 2px 16px rgba(0,129,138,.10);
  --shadow-lg:  0 8px 32px rgba(0,129,138,.15);
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text-dark); display: flex; min-height: 100vh; }

/* ── SIDEBAR ─────────────────────────────────────────────── */
.sidebar { width: 260px; background: var(--sidebar); min-height: 100vh; position: fixed; left: 0; top: 0; display: flex; flex-direction: column; z-index: 100; box-shadow: 4px 0 20px rgba(0,0,0,.18); }
.sidebar-brand { padding: 28px 22px 22px; border-bottom: 1px solid rgba(255,255,255,.08); }
.brand-icon { width: 44px; height: 44px; background: linear-gradient(135deg, var(--primary), var(--accent)); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; margin-bottom: 10px; box-shadow: 0 4px 12px rgba(0,129,138,.4); }
.brand-name { font-family: 'Playfair Display', serif; font-size: 1rem; font-weight: 700; color: var(--accent); letter-spacing: .5px; }
.brand-sub  { font-size: .72rem; color: rgba(255,255,255,.45); margin-top: 2px; }
.sidebar-nav { flex: 1; padding: 18px 0; }
.nav-section-label { font-size: .68rem; text-transform: uppercase; letter-spacing: 1.2px; color: rgba(255,255,255,.3); padding: 14px 22px 6px; font-weight: 600; }
.nav-item { display: flex; align-items: center; gap: 12px; padding: 11px 22px; text-decoration: none; color: rgba(255,255,255,.65); font-size: .88rem; font-weight: 500; border-left: 3px solid transparent; transition: all .2s; }
.nav-item:hover { background: rgba(255,255,255,.06); color: #fff; border-left-color: var(--accent); }
.nav-item.active { background: rgba(0,129,138,.18); color: #fff; border-left-color: var(--primary); }
.nav-icon { font-size: 1.05rem; width: 20px; text-align: center; flex-shrink: 0; }
.sidebar-footer { padding: 16px 22px 24px; border-top: 1px solid rgba(255,255,255,.08); }
.user-pill { display: flex; align-items: center; gap: 10px; background: rgba(255,255,255,.06); border-radius: 10px; padding: 10px 12px; margin-bottom: 12px; }
.user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--primary), var(--accent)); display: flex; align-items: center; justify-content: center; font-size: .85rem; font-weight: 700; color: #fff; flex-shrink: 0; }
.user-name { font-size: .85rem; font-weight: 600; color: #fff; }
.user-role { font-size: .7rem; color: rgba(255,255,255,.45); }
.btn-logout { display: flex; align-items: center; justify-content: center; gap: 8px; width: 100%; background: rgba(231,76,60,.15); color: #e74c3c; border: 1px solid rgba(231,76,60,.25); border-radius: 8px; padding: 9px; font-size: .84rem; font-weight: 600; text-decoration: none; transition: all .2s; }
.btn-logout:hover { background: rgba(231,76,60,.25); }

/* ── MAIN ────────────────────────────────────────────────── */
.main-wrapper { margin-left: 260px; display: flex; flex-direction: column; flex: 1; min-width: 0; }
.topbar { background: var(--card); border-bottom: 1px solid var(--border); padding: 0 32px; height: 64px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 50; box-shadow: 0 1px 8px rgba(0,0,0,.06); }
.topbar-left h1 { font-family: 'Playfair Display', serif; font-size: 1.3rem; color: var(--text-dark); font-weight: 700; }
.topbar-left p  { font-size: .8rem; color: var(--text-muted); margin-top: 1px; }
.breadcrumb { font-size: .8rem; color: var(--text-muted); display: flex; align-items: center; gap: 6px; }
.breadcrumb a { color: var(--primary); text-decoration: none; }
.breadcrumb a:hover { text-decoration: underline; }

.page-content { padding: 28px 32px; flex: 1; }

/* ── FORM CARD ───────────────────────────────────────────── */
.form-card {
  background: var(--card); border-radius: 20px;
  box-shadow: var(--shadow); overflow: hidden;
  max-width: 820px;
}
.form-card-header {
  background: linear-gradient(135deg, var(--sidebar), var(--primary));
  padding: 24px 32px; color: #fff;
  display: flex; align-items: center; gap: 14px;
}
.form-card-header .header-icon {
  width: 48px; height: 48px; background: rgba(255,255,255,.15);
  border-radius: 12px; display: flex; align-items: center; justify-content: center;
  font-size: 1.4rem;
}
.form-card-header h2 { font-family: 'Playfair Display', serif; font-size: 1.2rem; font-weight: 700; }
.form-card-header p  { font-size: .8rem; color: rgba(255,255,255,.65); margin-top: 2px; }
.form-card-body { padding: 32px; }

/* ── SECTION DIVIDER ─────────────────────────────────────── */
.form-section-title {
  font-size: .75rem; text-transform: uppercase; letter-spacing: 1px;
  color: var(--primary); font-weight: 600; margin-bottom: 16px;
  padding-bottom: 8px; border-bottom: 1.5px solid var(--border);
  display: flex; align-items: center; gap: 8px;
}

/* ── FORM ROWS ───────────────────────────────────────────── */
.form-row   { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
.form-row.three { grid-template-columns: 1fr 1fr 1fr; }
.form-group { display: flex; flex-direction: column; }
.form-group.full { grid-column: 1 / -1; }

.form-group label {
  font-size: .82rem; font-weight: 600; color: var(--text-dark);
  margin-bottom: 7px; display: flex; align-items: center; gap: 5px;
}
.form-group label .req { color: var(--danger); }

.form-control {
  padding: 11px 14px; border: 1.5px solid var(--input-border);
  border-radius: 10px; font-size: .92rem; font-family: 'DM Sans', sans-serif;
  background: #fafefe; color: var(--text-dark); outline: none;
  transition: border .2s, box-shadow .2s;
}
.form-control:focus {
  border-color: var(--primary);
  box-shadow: 0 0 0 3px rgba(0,129,138,.12);
  background: #fff;
}
.form-control.is-error  { border-color: var(--danger);  box-shadow: 0 0 0 3px rgba(231,76,60,.1); }
.form-control.is-valid  { border-color: var(--success); box-shadow: 0 0 0 3px rgba(39,174,96,.1); }

.field-hint  { font-size: .76rem; color: var(--text-muted); margin-top: 5px; }
.field-error { font-size: .76rem; color: var(--danger); margin-top: 5px; display: none; }
.field-error.show { display: block; }

/* ── ROOM INFO BOX ───────────────────────────────────────── */
.room-info-box {
  background: linear-gradient(135deg, #e0f5f5, #f0fafa);
  border: 1.5px solid #b3e5e6; border-radius: 10px;
  padding: 12px 16px; margin-top: 8px;
  display: none; font-size: .85rem;
}
.room-info-box.show { display: flex; align-items: center; gap: 10px; }
.room-info-box .price-badge {
  background: var(--primary); color: #fff;
  padding: 4px 12px; border-radius: 20px; font-weight: 600; font-size: .82rem;
  white-space: nowrap;
}

/* ── DATE CALCULATOR ─────────────────────────────────────── */
.nights-calc {
  background: linear-gradient(135deg, #fef9e7, #fffbf0);
  border: 1.5px solid #f8d89c; border-radius: 10px;
  padding: 14px 18px; margin-top: 14px; display: none;
  align-items: center; gap: 14px;
}
.nights-calc.show { display: flex; }
.nights-num {
  font-family: 'Playfair Display', serif;
  font-size: 2rem; font-weight: 700; color: var(--warning); line-height: 1;
}
.nights-info .nights-label { font-size: .78rem; color: var(--text-muted); }
.nights-info .nights-total { font-size: .9rem; font-weight: 600; color: var(--text-dark); margin-top: 2px; }

/* ── ALERTS ──────────────────────────────────────────────── */
.alert { padding: 13px 16px; border-radius: 10px; margin-bottom: 22px; font-size: .88rem; display: flex; align-items: flex-start; gap: 10px; }
.alert-danger  { background: #fdecea; color: #c0392b; border-left: 4px solid var(--danger); }
.alert-success { background: #eafaf1; color: #1e8449; border-left: 4px solid var(--success); }

/* ── SUBMIT BTN ──────────────────────────────────────────── */
.form-footer { margin-top: 28px; padding-top: 24px; border-top: 1px solid var(--border); display: flex; gap: 12px; align-items: center; }
.btn-primary {
  background: linear-gradient(135deg, var(--primary), var(--accent));
  color: #fff; border: none; padding: 13px 36px;
  border-radius: 10px; font-size: .95rem; font-family: 'DM Sans', sans-serif;
  font-weight: 600; cursor: pointer; transition: opacity .2s, transform .15s;
  display: flex; align-items: center; gap: 8px;
}
.btn-primary:hover { opacity: .9; transform: translateY(-1px); }
.btn-secondary {
  background: transparent; color: var(--text-muted);
  border: 1.5px solid var(--border); padding: 13px 24px;
  border-radius: 10px; font-size: .92rem; font-family: 'DM Sans', sans-serif;
  font-weight: 500; cursor: pointer; text-decoration: none;
  transition: all .2s; display: inline-flex; align-items: center; gap: 7px;
}
.btn-secondary:hover { border-color: var(--primary); color: var(--primary); }
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
    <a href="${pageContext.request.contextPath}/dashboard" class="nav-item"><span class="nav-icon">🏠</span> Dashboard</a>
    <a href="${pageContext.request.contextPath}/add-reservation" class="nav-item active"><span class="nav-icon">➕</span> Add Reservation</a>
    <a href="${pageContext.request.contextPath}/view-reservation" class="nav-item"><span class="nav-icon">🔍</span> View Reservation</a>
    <a href="${pageContext.request.contextPath}/bill" class="nav-item"><span class="nav-icon">🧾</span> Billing</a>
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

<!-- ══ MAIN WRAPPER ══════════════════════════════════════════ -->
<div class="main-wrapper">
  <header class="topbar">
    <div class="topbar-left">
      <h1>Add Reservation</h1>
      <p>Register a new guest booking</p>
    </div>
    <div class="breadcrumb">
      <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a> › Add Reservation
    </div>
  </header>

  <main class="page-content">

    <div class="form-card">
      <div class="form-card-header">
        <div class="header-icon">➕</div>
        <div>
          <h2>New Guest Reservation</h2>
          <p>Fill in the details below to create a reservation</p>
        </div>
      </div>

      <div class="form-card-body">

        <c:if test="${not empty error}">
          <div class="alert alert-danger">⚠️ <span>${error}</span></div>
        </c:if>

        <form id="reservationForm" method="POST"
              action="${pageContext.request.contextPath}/add-reservation"
              novalidate onsubmit="return validateForm(event)">

          <!-- GUEST INFO -->
          <div class="form-section-title">👤 Guest Information</div>
          <div class="form-row">
            <div class="form-group full">
              <label for="guestName">Guest Full Name <span class="req">*</span></label>
              <input type="text" id="guestName" name="guestName" class="form-control"
                     placeholder="e.g. Ashan Perera"
                     value="${param.guestName}" autocomplete="off">
              <span class="field-error" id="err-guestName">Please enter the guest's full name.</span>
            </div>
            <div class="form-group full">
              <label for="address">Address <span class="req">*</span></label>
              <input type="text" id="address" name="address" class="form-control"
                     placeholder="e.g. No. 12, Galle Road, Colombo 03"
                     value="${param.address}">
              <span class="field-error" id="err-address">Please enter the guest's address.</span>
            </div>
            <div class="form-group">
              <label for="contactNumber">Contact Number <span class="req">*</span></label>
              <input type="tel" id="contactNumber" name="contactNumber" class="form-control"
                     placeholder="07XXXXXXXX" maxlength="10"
                     value="${param.contactNumber}">
              <span class="field-hint">Must be exactly 10 digits (e.g. 0771234567)</span>
              <span class="field-error" id="err-contact">Enter a valid 10-digit phone number.</span>
            </div>
          </div>

          <!-- BOOKING INFO -->
          <div class="form-section-title" style="margin-top:8px;">🏨 Booking Details</div>
          <div class="form-row">
            <div class="form-group full">
              <label for="roomTypeId">Room Type <span class="req">*</span></label>
              <select id="roomTypeId" name="roomTypeId" class="form-control" onchange="onRoomTypeChange()">
                <option value="">— Select Room Type —</option>
                <c:forEach var="rt" items="${roomTypes}">
                  <option value="${rt.roomTypeId}"
                          data-price="${rt.pricePerNight}"
                          data-code="${rt.roomCode}"
                          data-name="${rt.typeName}"
                          <c:if test="${param.roomTypeId == rt.roomTypeId}">selected</c:if>>
                    ${rt.typeName} — Rs. <fmt:formatNumber value="${rt.pricePerNight}" pattern="#,##0"/> / night
                  </option>
                </c:forEach>
              </select>
              <div class="room-info-box" id="roomInfoBox">
                <span id="roomInfoText"></span>
                <span class="price-badge" id="roomPriceBadge"></span>
              </div>
              <span class="field-error" id="err-roomType">Please select a room type.</span>
            </div>

            <div class="form-group">
              <label for="checkIn">Check-In Date <span class="req">*</span></label>
              <input type="date" id="checkIn" name="checkIn" class="form-control"
                     value="${param.checkIn}" onchange="onCheckInChange()">
              <span class="field-hint">Cannot be in the past.</span>
              <span class="field-error" id="err-checkIn">Please select a valid check-in date.</span>
            </div>

            <div class="form-group">
              <label for="checkOut">Check-Out Date <span class="req">*</span></label>
              <input type="date" id="checkOut" name="checkOut" class="form-control"
                     value="${param.checkOut}" onchange="onCheckOutChange()" disabled>
              <span class="field-hint" id="checkOutHint">Select check-in date first.</span>
              <span class="field-error" id="err-checkOut">Check-out must be at least 1 day after check-in.</span>
            </div>
          </div>

          <!-- NIGHTS CALCULATOR -->
          <div class="nights-calc" id="nightsCalc">
            <div class="nights-num" id="nightsNum">0</div>
            <div class="nights-info">
              <div class="nights-label">ESTIMATED STAY</div>
              <div class="nights-total" id="nightsTotal">Select dates to see total</div>
            </div>
          </div>

          <!-- FOOTER -->
          <div class="form-footer">
            <button type="submit" class="btn-primary">💾 Save Reservation</button>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-secondary">✕ Cancel</a>
          </div>

        </form>
      </div>
    </div>

  </main>
</div>

<script>
  // ── TODAY STRING ────────────────────────────────────────────
  const today = new Date();
  const todayStr = today.toISOString().split('T')[0];
  document.getElementById('checkIn').min = todayStr;

  // ── ROOM TYPE CHANGE ─────────────────────────────────────────
  function onRoomTypeChange() {
    const sel = document.getElementById('roomTypeId');
    const opt = sel.options[sel.selectedIndex];
    const box = document.getElementById('roomInfoBox');

    clearError('roomType');

    if (opt.value) {
      document.getElementById('roomInfoText').textContent =
        '📌 ' + opt.dataset.name + ' · Code: ' + opt.dataset.code;
      document.getElementById('roomPriceBadge').textContent =
        'Rs. ' + parseFloat(opt.dataset.price).toLocaleString() + ' / night';
      box.classList.add('show');
      updateNightsCalc();
    } else {
      box.classList.remove('show');
    }
  }

  // ── CHECK-IN CHANGE ──────────────────────────────────────────
  function onCheckInChange() {
    const ci     = document.getElementById('checkIn').value;
    const coFld  = document.getElementById('checkOut');
    const hint   = document.getElementById('checkOutHint');

    clearError('checkIn');

    if (ci < todayStr) {
      showError('checkIn', 'Check-in date cannot be in the past.');
      coFld.disabled = true;
      coFld.value = '';
      return;
    }

    // Set checkout min = checkIn + 1 day
    const nextDay = new Date(ci);
    nextDay.setDate(nextDay.getDate() + 1);
    const nextDayStr = nextDay.toISOString().split('T')[0];
    coFld.min = nextDayStr;
    coFld.disabled = false;
    coFld.value = '';
    hint.textContent = 'Must be after ' + formatDate(ci);

    document.getElementById('nightsCalc').classList.remove('show');
  }

  // ── CHECK-OUT CHANGE ─────────────────────────────────────────
  function onCheckOutChange() {
    clearError('checkOut');
    const ci = document.getElementById('checkIn').value;
    const co = document.getElementById('checkOut').value;

    if (ci && co) {
      if (co <= ci) {
        showError('checkOut', 'Check-out must be at least 1 day after check-in.');
        document.getElementById('nightsCalc').classList.remove('show');
        return;
      }
      updateNightsCalc();
    }
  }

  // ── NIGHTS CALCULATOR ────────────────────────────────────────
  function updateNightsCalc() {
    const ci  = document.getElementById('checkIn').value;
    const co  = document.getElementById('checkOut').value;
    const sel = document.getElementById('roomTypeId');
    const opt = sel.options[sel.selectedIndex];

    if (!ci || !co || co <= ci) return;

    const msDay  = 86400000;
    const nights = Math.round((new Date(co) - new Date(ci)) / msDay);
    document.getElementById('nightsNum').textContent = nights;

    const calc = document.getElementById('nightsCalc');
    calc.classList.add('show');

    let totalText = nights + ' Night' + (nights !== 1 ? 's' : '');
    if (opt.value && opt.dataset.price) {
      const total = nights * parseFloat(opt.dataset.price);
      totalText += ' · Estimated: Rs. ' + total.toLocaleString();
    }
    document.getElementById('nightsTotal').textContent = totalText;
  }

  // ── FULL FORM VALIDATION ─────────────────────────────────────
  function validateForm(e) {
    let valid = true;

    // Guest Name
    const name = document.getElementById('guestName').value.trim();
    if (!name) { showError('guestName', 'Please enter the guest\'s full name.'); valid = false; }

    // Address
    const addr = document.getElementById('address').value.trim();
    if (!addr) { showError('address', 'Please enter the guest\'s address.'); valid = false; }

    // Contact number - exactly 10 digits
    const contact = document.getElementById('contactNumber').value.trim();
    if (!/^\d{10}$/.test(contact)) {
      showError('contact', 'Contact number must be exactly 10 digits.'); valid = false;
    }

    // Room type
    const room = document.getElementById('roomTypeId').value;
    if (!room) { showError('roomType', 'Please select a room type.'); valid = false; }

    // Check-in
    const ci = document.getElementById('checkIn').value;
    if (!ci) { showError('checkIn', 'Please select a check-in date.'); valid = false; }
    else if (ci < todayStr) { showError('checkIn', 'Check-in cannot be in the past.'); valid = false; }

    // Check-out
    const co = document.getElementById('checkOut').value;
    if (!co) { showError('checkOut', 'Please select a check-out date.'); valid = false; }
    else if (ci && co <= ci) { showError('checkOut', 'Check-out must be at least 1 day after check-in.'); valid = false; }

    if (!valid) e.preventDefault();
    return valid;
  }

  // ── HELPERS ──────────────────────────────────────────────────
  function showError(field, msg) {
    const el = document.getElementById('err-' + field);
    if (el) { el.textContent = msg; el.classList.add('show'); }
    const inp = document.getElementById(
      field === 'contact'  ? 'contactNumber' :
      field === 'roomType' ? 'roomTypeId'    :
      field === 'checkIn'  ? 'checkIn'       :
      field === 'checkOut' ? 'checkOut'      : field
    );
    if (inp) inp.classList.add('is-error');
  }
  function clearError(field) {
    const el  = document.getElementById('err-' + field);
    const inp = document.getElementById(
      field === 'contact'  ? 'contactNumber' :
      field === 'roomType' ? 'roomTypeId'    :
      field === 'checkIn'  ? 'checkIn'       :
      field === 'checkOut' ? 'checkOut'      : field
    );
    if (el)  { el.classList.remove('show'); }
    if (inp) { inp.classList.remove('is-error'); }
  }
  function formatDate(str) {
    const d = new Date(str + 'T00:00:00');
    return d.toLocaleDateString('en-GB', {day:'2-digit',month:'short',year:'numeric'});
  }

  // Restore room info if value was pre-selected (after server error redirect)
  window.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('roomTypeId').value) onRoomTypeChange();
    const ci = document.getElementById('checkIn').value;
    const co = document.getElementById('checkOut').value;
    if (ci) {
      const coFld = document.getElementById('checkOut');
      const nextDay = new Date(ci);
      nextDay.setDate(nextDay.getDate() + 1);
      coFld.min = nextDay.toISOString().split('T')[0];
      coFld.disabled = false;
    }
    if (ci && co) updateNightsCalc();
  });
</script>
</body>
</html>
