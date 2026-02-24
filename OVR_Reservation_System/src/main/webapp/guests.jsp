<%-- ═══════════════════════════════════════════════════════════════
     OVR – Guest Management View (guests.jsp)
     Controller : GuestServlet.java
     Attributes : guests (List<Guest>), totalGuests, searchKeyword,
                  successMsg, errorMsg
 ═══════════════════════════════════════════════════════════════ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="activePage" value="guests" scope="page" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OVR | Guest Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;600&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>

<style>
/* ════════════════════════════════════════════════════════════════
   OVR GLOBAL + GUEST PAGE STYLES
   ════════════════════════════════════════════════════════════════ */
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{
    --ocean-deep:#0a1628; --ocean-mid:#0d1f3c;
    --glass-bg:rgba(255,255,255,0.04); --glass-border:rgba(255,255,255,0.08);
    --teal:#00b4d8; --teal-glow:rgba(0,180,216,0.15);
    --gold:#c9a84c; --text-primary:#e8f4f8;
    --text-muted:#8899aa; --text-dim:#556677;
    --sidebar-w:260px; --header-h:80px;
    --radius-lg:16px; --radius-md:12px; --radius-sm:8px;
    --shadow-card:0 8px 32px rgba(0,0,0,0.3);
    --transition:all 0.3s cubic-bezier(0.4,0,0.2,1);
}
html,body{height:100%;background:var(--ocean-deep);color:var(--text-primary);font-family:'Inter',sans-serif;font-size:14px;line-height:1.6;overflow:hidden;}
body::before{content:'';position:fixed;inset:0;background:radial-gradient(ellipse 80% 60% at 20% 80%,rgba(0,100,150,.15) 0%,transparent 60%),radial-gradient(ellipse 60% 40% at 80% 20%,rgba(0,60,100,.12) 0%,transparent 50%),linear-gradient(160deg,#0a1628 0%,#0d1f3c 50%,#0a1a2e 100%);z-index:-1;}

/* Layout */
.ovr-layout{display:flex;height:100vh;overflow:hidden;}
.ovr-main{flex:1;display:flex;flex-direction:column;overflow:hidden;}

/* Header */
.ovr-header{height:var(--header-h);background:rgba(10,20,40,.6);backdrop-filter:blur(12px);border-bottom:1px solid var(--glass-border);display:flex;align-items:center;justify-content:space-between;padding:0 32px;flex-shrink:0;animation:slideDown .5s ease;}
@keyframes slideDown{from{opacity:0;transform:translateY(-20px)}to{opacity:1;transform:translateY(0)}}
.header-left h1{font-family:'Cormorant Garamond',serif;font-size:26px;font-weight:300;letter-spacing:1px;}
.header-left h1 span{color:var(--teal);font-weight:600;}
.breadcrumb{font-size:12px;color:var(--text-muted);margin-top:2px;}
.breadcrumb i{color:var(--teal);margin-right:6px;}
.header-right{display:flex;align-items:center;gap:16px;}
.live-clock .clock-time{font-size:20px;font-weight:300;letter-spacing:2px;}
.live-clock .clock-date{font-size:11px;color:var(--text-muted);}
.notif-btn{width:42px;height:42px;background:var(--glass-bg);border:1px solid var(--glass-border);border-radius:50%;display:flex;align-items:center;justify-content:center;color:var(--text-muted);font-size:16px;cursor:pointer;text-decoration:none;transition:var(--transition);}
.notif-btn:hover{background:var(--teal-glow);color:var(--teal);}
.user-chip{display:flex;align-items:center;gap:10px;background:var(--glass-bg);border:1px solid var(--glass-border);border-radius:30px;padding:8px 16px 8px 10px;}
.user-chip-avatar{width:30px;height:30px;background:linear-gradient(135deg,var(--teal),var(--ocean-mid));border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:13px;color:white;}
.user-chip-name{font-size:13px;font-weight:500;}
.user-chip-role{font-size:10px;color:var(--gold);display:block;}

/* Scrollable content */
.ovr-content{flex:1;overflow-y:auto;padding:32px;scrollbar-width:thin;scrollbar-color:rgba(0,180,216,.2) transparent;animation:fadeInUp .5s ease;}
@keyframes fadeInUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}

/* ── Page Top Bar ─────────────────────────────────────────── */
.page-topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:28px;flex-wrap:wrap;gap:16px;}
.page-title{font-family:'Cormorant Garamond',serif;font-size:28px;font-weight:300;color:var(--text-primary);}
.page-title span{color:var(--teal);}
.page-subtitle{font-size:12px;color:var(--text-muted);margin-top:2px;}
.topbar-actions{display:flex;align-items:center;gap:12px;}

/* Search bar */
.search-wrap{position:relative;}
.search-input{
    width:280px;height:42px;
    background:var(--glass-bg);
    border:1px solid var(--glass-border);
    border-radius:10px;
    padding:0 16px 0 42px;
    color:var(--text-primary);
    font-size:13px;outline:none;
    transition:var(--transition);
}
.search-input::placeholder{color:var(--text-dim);}
.search-input:focus{border-color:rgba(0,180,216,.35);background:rgba(0,180,216,.04);}
.search-icon{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:var(--text-dim);font-size:13px;}

/* Add Button */
.btn-add{
    display:flex;align-items:center;gap:8px;
    padding:10px 20px;border-radius:10px;
    background:linear-gradient(135deg,var(--teal),#0096b4);
    color:white;font-size:13px;font-weight:500;
    border:none;cursor:pointer;
    transition:var(--transition);white-space:nowrap;
}
.btn-add:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(0,180,216,.3);}

/* ── Summary stat chips ────────────────────────────────────── */
.guest-stats{display:flex;gap:12px;margin-bottom:24px;}
.stat-chip{
    display:flex;align-items:center;gap:8px;
    background:var(--glass-bg);border:1px solid var(--glass-border);
    border-radius:10px;padding:10px 16px;
    font-size:12px;color:var(--text-muted);
}
.stat-chip strong{font-size:16px;font-weight:600;color:var(--text-primary);margin-right:2px;}
.stat-chip i{color:var(--teal);}

/* ── Guest Table ──────────────────────────────────────────── */
.table-panel{
    background:var(--glass-bg);backdrop-filter:blur(12px);
    border:1px solid var(--glass-border);
    border-radius:var(--radius-lg);overflow:hidden;
}
.guest-table{width:100%;border-collapse:collapse;}
.guest-table th{
    padding:13px 16px;text-align:left;
    font-size:10px;font-weight:600;letter-spacing:1.5px;
    text-transform:uppercase;color:var(--text-dim);
    background:rgba(255,255,255,.02);
    border-bottom:1px solid var(--glass-border);
    white-space:nowrap;
}
.guest-table td{
    padding:14px 16px;font-size:13px;
    color:var(--text-primary);
    border-bottom:1px solid rgba(255,255,255,.03);
    vertical-align:middle;
}
.guest-table tr:last-child td{border-bottom:none;}
.guest-table tbody tr{transition:background .15s;}
.guest-table tbody tr:hover td{background:rgba(255,255,255,.025);}

/* Avatar column */
.guest-avatar-cell{display:flex;align-items:center;gap:12px;}
.guest-avatar{
    width:38px;height:38px;border-radius:50%;
    background:linear-gradient(135deg,rgba(0,180,216,.3),rgba(0,100,150,.2));
    border:1px solid rgba(0,180,216,.25);
    display:flex;align-items:center;justify-content:center;
    font-size:13px;font-weight:700;color:var(--teal);
    flex-shrink:0;letter-spacing:0.5px;
}
.guest-name{font-weight:500;color:var(--text-primary);}
.guest-id{font-size:11px;color:var(--text-muted);}

/* Country flag chip */
.country-chip{
    display:inline-flex;align-items:center;gap:6px;
    background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.07);
    border-radius:20px;padding:3px 10px;
    font-size:12px;color:var(--text-muted);
}
.country-chip i{color:var(--text-dim);font-size:11px;}

/* Phone */
.phone-text{font-family:monospace;font-size:12.5px;color:var(--teal-light, #48cae4);}

/* Date */
.date-text{font-size:12px;color:var(--text-dim);}

/* Action buttons */
.action-btns{display:flex;gap:8px;align-items:center;}
.btn-icon{
    width:34px;height:34px;border-radius:8px;
    display:flex;align-items:center;justify-content:center;
    font-size:13px;cursor:pointer;border:none;
    transition:var(--transition);
}
.btn-edit{background:rgba(0,180,216,.1);color:var(--teal);}
.btn-edit:hover{background:rgba(0,180,216,.2);transform:translateY(-1px);}
.btn-delete{background:rgba(248,113,113,.08);color:#f87171;}
.btn-delete:hover{background:rgba(248,113,113,.18);transform:translateY(-1px);}

/* Empty state */
.empty-state{text-align:center;padding:64px 24px;}
.empty-state i{font-size:48px;color:var(--text-dim);margin-bottom:16px;display:block;}
.empty-state h3{font-family:'Cormorant Garamond',serif;font-size:22px;font-weight:300;color:var(--text-muted);margin-bottom:8px;}
.empty-state p{font-size:13px;color:var(--text-dim);}

/* ── Flash Messages ──────────────────────────────────────── */
.flash-msg{
    display:flex;align-items:center;gap:12px;
    padding:14px 20px;border-radius:12px;
    font-size:13px;margin-bottom:20px;
    animation:flashIn .4s ease;
}
@keyframes flashIn{from{opacity:0;transform:translateY(-8px)}to{opacity:1;transform:translateY(0)}}
.flash-success{background:rgba(74,222,128,.08);border:1px solid rgba(74,222,128,.2);color:#4ade80;}
.flash-error  {background:rgba(248,113,113,.08);border:1px solid rgba(248,113,113,.2);color:#f87171;}
.flash-msg i{font-size:16px;flex-shrink:0;}

/* ════════════════════════════════════════════════════════════════
   MODALS — Add Guest & Edit Guest & Delete Confirm
   ════════════════════════════════════════════════════════════════ */
.modal-overlay{
    position:fixed;inset:0;
    background:rgba(0,0,0,.7);backdrop-filter:blur(6px);
    display:flex;align-items:center;justify-content:center;
    z-index:400;
    opacity:0;pointer-events:none;
    transition:opacity .3s ease;
}
.modal-overlay.active{opacity:1;pointer-events:all;}

.guest-modal{
    position:relative;width:540px;
    background:rgba(10,20,40,.97);
    border:1px solid rgba(0,180,216,.18);
    border-radius:20px;padding:0;
    transform:scale(.95) translateY(10px);
    transition:transform .3s ease;
    overflow:hidden;
    max-height:90vh;display:flex;flex-direction:column;
}
.modal-overlay.active .guest-modal{transform:scale(1) translateY(0);}

/* Modal Header */
.guest-modal-header{
    display:flex;align-items:center;gap:14px;
    padding:28px 32px 24px;
    border-bottom:1px solid rgba(255,255,255,.07);
    flex-shrink:0;
}
.guest-modal-icon{
    width:48px;height:48px;border-radius:14px;
    display:flex;align-items:center;justify-content:center;
    font-size:20px;flex-shrink:0;
}
.icon-add   {background:rgba(0,180,216,.12);color:var(--teal);}
.icon-edit  {background:rgba(201,168,76,.12);color:var(--gold);}
.icon-delete{background:rgba(248,113,113,.12);color:#f87171;}
.guest-modal-title{font-family:'Cormorant Garamond',serif;font-size:22px;font-weight:400;color:var(--text-primary);}
.guest-modal-sub{font-size:12px;color:var(--text-muted);margin-top:2px;}
.modal-x{position:absolute;top:20px;right:20px;width:32px;height:32px;background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);border-radius:50%;display:flex;align-items:center;justify-content:center;color:var(--text-muted);cursor:pointer;font-size:12px;transition:all .2s;}
.modal-x:hover{background:rgba(248,113,113,.1);color:#f87171;}

/* Modal Body */
.guest-modal-body{padding:28px 32px;overflow-y:auto;flex:1;scrollbar-width:thin;scrollbar-color:rgba(0,180,216,.15) transparent;}

/* Form */
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:16px;}
.form-group{display:flex;flex-direction:column;gap:7px;margin-bottom:18px;}
.form-group.full{grid-column:1/-1;}
.form-label{font-size:11px;font-weight:600;letter-spacing:1px;text-transform:uppercase;color:var(--text-muted);}
.form-label span{color:#f87171;}
.form-input,.form-select,.form-textarea{
    background:rgba(255,255,255,.04);
    border:1px solid rgba(255,255,255,.08);
    border-radius:10px;
    padding:11px 14px;
    color:var(--text-primary);
    font-size:13px;font-family:'Inter',sans-serif;
    outline:none;transition:var(--transition);width:100%;
}
.form-input::placeholder,.form-textarea::placeholder{color:var(--text-dim);}
.form-input:focus,.form-select:focus,.form-textarea:focus{border-color:rgba(0,180,216,.4);background:rgba(0,180,216,.04);box-shadow:0 0 0 3px rgba(0,180,216,.08);}
.form-select option{background:#0d1f3c;color:var(--text-primary);}
.form-textarea{resize:vertical;min-height:80px;}

/* Phone row — dial code + number */
.phone-row{display:flex;gap:10px;}
.phone-code-sel{width:120px;flex-shrink:0;}

/* Modal Footer */
.guest-modal-footer{
    display:flex;gap:12px;padding:20px 32px 28px;
    border-top:1px solid rgba(255,255,255,.06);flex-shrink:0;
}
.btn-cancel,.btn-submit,.btn-danger{
    padding:12px 24px;border-radius:10px;
    font-size:13.5px;font-weight:500;cursor:pointer;
    border:none;transition:var(--transition);
    display:flex;align-items:center;gap:8px;
}
.btn-cancel{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);color:var(--text-muted);}
.btn-cancel:hover{background:rgba(255,255,255,.08);color:var(--text-primary);}
.btn-submit{flex:1;background:linear-gradient(135deg,var(--teal),#0096b4);color:white;justify-content:center;}
.btn-submit:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(0,180,216,.3);}
.btn-danger{flex:1;background:linear-gradient(135deg,#f87171,#dc2626);color:white;justify-content:center;}
.btn-danger:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(248,113,113,.3);}

/* Delete confirmation modal body */
.delete-info{
    display:flex;flex-direction:column;align-items:center;
    text-align:center;padding:8px 0 16px;gap:12px;
}
.delete-icon-big{font-size:52px;color:#f87171;margin-bottom:4px;}
.delete-guest-name{font-size:18px;font-weight:600;color:var(--text-primary);}
.delete-warning{
    background:rgba(248,113,113,.07);border:1px solid rgba(248,113,113,.15);
    border-radius:10px;padding:12px 16px;
    font-size:12.5px;color:#f87171;
    display:flex;align-items:center;gap:8px;width:100%;text-align:left;
}
.delete-warning i{flex-shrink:0;}

/* scrollbar */
.ovr-content::-webkit-scrollbar{width:4px;}
.ovr-content::-webkit-scrollbar-thumb{background:rgba(0,180,216,.2);border-radius:2px;}
</style>
</head>
<body>
<div class="ovr-layout">

    <%-- SIDEBAR --%>
    <%@ include file="sidebar.jsp" %>

    <div class="ovr-main">

        <%-- HEADER --%>
        <header class="ovr-header">
            <div class="header-left">
                <h1>Guest <span>Management</span></h1>
                <div class="breadcrumb">
                    <i class="fas fa-home"></i>
                    Dashboard &nbsp;/&nbsp; Guest Management
                </div>
            </div>
            <div class="header-right">
                <div class="live-clock">
                    <div class="clock-time" id="clockTime">--:--:--</div>
                    <div class="clock-date" id="clockDate">Loading...</div>
                </div>
                <a href="${pageContext.request.contextPath}/notifications" class="notif-btn">
                    <i class="fas fa-bell"></i>
                </a>
                <div class="user-chip">
                    <div class="user-chip-avatar"><i class="fas fa-user"></i></div>
                    <div>
                        <span class="user-chip-name">${sessionScope.username}</span>
                        <span class="user-chip-role">Receptionist</span>
                    </div>
                </div>
            </div>
        </header>

        <div class="ovr-content">

            <%-- Flash Messages --%>
            <c:if test="${not empty successMsg}">
                <div class="flash-msg flash-success">
                    <i class="fas fa-circle-check"></i>
                    <span>${successMsg}</span>
                </div>
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="flash-msg flash-error">
                    <i class="fas fa-circle-exclamation"></i>
                    <span>${errorMsg}</span>
                </div>
            </c:if>

            <%-- Page Top Bar --%>
            <div class="page-topbar">
                <div>
                    <div class="page-title">Guest <span>Directory</span></div>
                    <div class="page-subtitle">Manage all resort guest records</div>
                </div>
                <div class="topbar-actions">
                    <%-- Search --%>
                    <form method="GET" action="${pageContext.request.contextPath}/guests"
                          style="display:inline;">
                        <div class="search-wrap">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" name="search" class="search-input"
                                   placeholder="Search by name, country, phone…"
                                   value="${searchKeyword}"
                                   oninput="this.form.submit()"/>
                        </div>
                    </form>
                    <%-- Add Guest --%>
                    <button class="btn-add" onclick="openAddModal()">
                        <i class="fas fa-plus"></i> Add Guest
                    </button>
                </div>
            </div>

            <%-- Summary Chips --%>
            <div class="guest-stats">
                <div class="stat-chip">
                    <i class="fas fa-users"></i>
                    <span><strong>${totalGuests}</strong> Total Guests</span>
                </div>
                <c:if test="${not empty searchKeyword}">
                    <div class="stat-chip">
                        <i class="fas fa-filter"></i>
                        <span>Filtered by: <strong>"${searchKeyword}"</strong></span>
                    </div>
                </c:if>
            </div>

            <%-- Guest Table --%>
            <div class="table-panel">
                <c:choose>
                    <c:when test="${not empty guests}">
                        <table class="guest-table">
                            <thead>
                                <tr>
                                    <th>Guest</th>
                                    <th>Country</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Registered</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="g" items="${guests}">
                                    <tr>
                                        <td>
                                            <div class="guest-avatar-cell">
                                                <div class="guest-avatar">${g.initials}</div>
                                                <div>
                                                    <div class="guest-name">${g.fullName}</div>
                                                    <div class="guest-id">#${g.guestId}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="country-chip">
                                                <i class="fas fa-globe"></i>
                                                ${g.country}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="phone-text">${g.fullPhone}</span>
                                        </td>
                                        <td>
                                            <span style="color:var(--text-muted);font-size:12.5px;">
                                                <c:choose>
                                                    <c:when test="${not empty g.address}">${g.address}</c:when>
                                                    <c:otherwise><em style="color:var(--text-dim);">Not provided</em></c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td><span class="date-text">${g.createdAt}</span></td>
                                        <td>
                                            <div class="action-btns">
                                                <button class="btn-icon btn-edit"
                                                        title="Edit Guest"
                                                        onclick="openEditModal(${g.guestId})">
                                                    <i class="fas fa-pen-to-square"></i>
                                                </button>
                                                <button class="btn-icon btn-delete"
                                                        title="Delete Guest"
                                                        onclick="openDeleteModal(${g.guestId}, '${g.fullName}')">
                                                    <i class="fas fa-trash-can"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-user-slash"></i>
                            <c:choose>
                                <c:when test="${not empty searchKeyword}">
                                    <h3>No guests found for "${searchKeyword}"</h3>
                                    <p>Try a different name, country, or phone number.</p>
                                </c:when>
                                <c:otherwise>
                                    <h3>No guests registered yet</h3>
                                    <p>Click "Add Guest" to register your first guest.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div><%-- /ovr-content --%>
    </div><%-- /ovr-main --%>
</div><%-- /ovr-layout --%>


<%-- ════════════════════════════════════════════════════════
     ADD GUEST MODAL
 ════════════════════════════════════════════════════════ --%>
<div class="modal-overlay" id="addOverlay">
    <div class="guest-modal">
        <div class="guest-modal-header">
            <div class="guest-modal-icon icon-add"><i class="fas fa-user-plus"></i></div>
            <div>
                <div class="guest-modal-title">Add New Guest</div>
                <div class="guest-modal-sub">Register a new guest into the OVR system</div>
            </div>
        </div>
        <button class="modal-x" onclick="closeModal('addOverlay')"><i class="fas fa-times"></i></button>

        <form method="POST" action="${pageContext.request.contextPath}/guests"
              onsubmit="return validateGuestForm('add')">
            <input type="hidden" name="action" value="add"/>
            <div class="guest-modal-body">
                <div class="form-row">
                    <div class="form-group full">
                        <label class="form-label">Full Name <span>*</span></label>
                        <input type="text" name="fullName" class="form-input"
                               placeholder="e.g. John Michael Doe" required maxlength="100"/>
                    </div>
                    <div class="form-group full">
                        <label class="form-label">Address</label>
                        <textarea name="address" class="form-textarea"
                                  placeholder="Street address, city…" maxlength="500"></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Country <span>*</span></label>
                        <select name="country" class="form-select" required>
                            <option value="" disabled selected>Select country…</option>
                            <option>Afghanistan</option><option>Albania</option><option>Algeria</option>
                            <option>Argentina</option><option>Australia</option><option>Austria</option>
                            <option>Bahrain</option><option>Bangladesh</option><option>Belgium</option>
                            <option>Brazil</option><option>Canada</option><option>Chile</option>
                            <option>China</option><option>Colombia</option><option>Croatia</option>
                            <option>Czech Republic</option><option>Denmark</option><option>Egypt</option>
                            <option>Finland</option><option>France</option><option>Germany</option>
                            <option>Ghana</option><option>Greece</option><option>Hong Kong</option>
                            <option>Hungary</option><option>India</option><option>Indonesia</option>
                            <option>Iran</option><option>Iraq</option><option>Ireland</option>
                            <option>Israel</option><option>Italy</option><option>Japan</option>
                            <option>Jordan</option><option>Kenya</option><option>Kuwait</option>
                            <option>Lebanon</option><option>Malaysia</option><option>Maldives</option>
                            <option>Mexico</option><option>Morocco</option><option>Myanmar</option>
                            <option>Nepal</option><option>Netherlands</option><option>New Zealand</option>
                            <option>Nigeria</option><option>Norway</option><option>Oman</option>
                            <option>Pakistan</option><option>Philippines</option><option>Poland</option>
                            <option>Portugal</option><option>Qatar</option><option>Romania</option>
                            <option>Russia</option><option>Saudi Arabia</option><option>Singapore</option>
                            <option>South Africa</option><option>South Korea</option><option>Spain</option>
                            <option>Sri Lanka</option><option>Sweden</option><option>Switzerland</option>
                            <option>Thailand</option><option>Turkey</option><option>UAE</option>
                            <option>Uganda</option><option>Ukraine</option>
                            <option>United Kingdom</option><option>United States</option>
                            <option>Vietnam</option><option>Zimbabwe</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Phone <span>*</span></label>
                        <div class="phone-row">
                            <select name="phoneCode" class="form-select phone-code-sel">
                                <option value="+94">🇱🇰 +94</option>
                                <option value="+1">🇺🇸 +1</option>
                                <option value="+44">🇬🇧 +44</option>
                                <option value="+91">🇮🇳 +91</option>
                                <option value="+61">🇦🇺 +61</option>
                                <option value="+49">🇩🇪 +49</option>
                                <option value="+33">🇫🇷 +33</option>
                                <option value="+971">🇦🇪 +971</option>
                                <option value="+65">🇸🇬 +65</option>
                                <option value="+60">🇲🇾 +60</option>
                                <option value="+81">🇯🇵 +81</option>
                                <option value="+86">🇨🇳 +86</option>
                                <option value="+966">🇸🇦 +966</option>
                                <option value="+92">🇵🇰 +92</option>
                                <option value="+880">🇧🇩 +880</option>
                            </select>
                            <input type="text" name="phoneNumber" class="form-input"
                                   placeholder="771234567" maxlength="15" inputmode="numeric"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="guest-modal-footer">
                <button type="button" class="btn-cancel" onclick="closeModal('addOverlay')">
                    <i class="fas fa-times"></i> Cancel
                </button>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-user-plus"></i> Add Guest
                </button>
            </div>
        </form>
    </div>
</div>


<%-- ════════════════════════════════════════════════════════
     EDIT GUEST MODAL
 ════════════════════════════════════════════════════════ --%>
<div class="modal-overlay" id="editOverlay">
    <div class="guest-modal">
        <div class="guest-modal-header">
            <div class="guest-modal-icon icon-edit"><i class="fas fa-pen-to-square"></i></div>
            <div>
                <div class="guest-modal-title">Edit Guest</div>
                <div class="guest-modal-sub">Update guest information</div>
            </div>
        </div>
        <button class="modal-x" onclick="closeModal('editOverlay')"><i class="fas fa-times"></i></button>

        <form method="POST" action="${pageContext.request.contextPath}/guests"
              onsubmit="return validateGuestForm('edit')">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="guestId" id="editGuestId"/>
            <div class="guest-modal-body">
                <div class="form-row">
                    <div class="form-group full">
                        <label class="form-label">Full Name <span>*</span></label>
                        <input type="text" name="fullName" id="editFullName" class="form-input"
                               required maxlength="100"/>
                    </div>
                    <div class="form-group full">
                        <label class="form-label">Address</label>
                        <textarea name="address" id="editAddress" class="form-textarea" maxlength="500"></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Country <span>*</span></label>
                        <select name="country" id="editCountry" class="form-select" required>
                            <option value="" disabled>Select country…</option>
                            <option>Afghanistan</option><option>Albania</option><option>Algeria</option>
                            <option>Argentina</option><option>Australia</option><option>Austria</option>
                            <option>Bahrain</option><option>Bangladesh</option><option>Belgium</option>
                            <option>Brazil</option><option>Canada</option><option>Chile</option>
                            <option>China</option><option>Colombia</option><option>Croatia</option>
                            <option>Czech Republic</option><option>Denmark</option><option>Egypt</option>
                            <option>Finland</option><option>France</option><option>Germany</option>
                            <option>Ghana</option><option>Greece</option><option>Hong Kong</option>
                            <option>Hungary</option><option>India</option><option>Indonesia</option>
                            <option>Iran</option><option>Iraq</option><option>Ireland</option>
                            <option>Israel</option><option>Italy</option><option>Japan</option>
                            <option>Jordan</option><option>Kenya</option><option>Kuwait</option>
                            <option>Lebanon</option><option>Malaysia</option><option>Maldives</option>
                            <option>Mexico</option><option>Morocco</option><option>Myanmar</option>
                            <option>Nepal</option><option>Netherlands</option><option>New Zealand</option>
                            <option>Nigeria</option><option>Norway</option><option>Oman</option>
                            <option>Pakistan</option><option>Philippines</option><option>Poland</option>
                            <option>Portugal</option><option>Qatar</option><option>Romania</option>
                            <option>Russia</option><option>Saudi Arabia</option><option>Singapore</option>
                            <option>South Africa</option><option>South Korea</option><option>Spain</option>
                            <option>Sri Lanka</option><option>Sweden</option><option>Switzerland</option>
                            <option>Thailand</option><option>Turkey</option><option>UAE</option>
                            <option>Uganda</option><option>Ukraine</option>
                            <option>United Kingdom</option><option>United States</option>
                            <option>Vietnam</option><option>Zimbabwe</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Phone <span>*</span></label>
                        <div class="phone-row">
                            <select name="phoneCode" id="editPhoneCode" class="form-select phone-code-sel">
                                <option value="+94">🇱🇰 +94</option>
                                <option value="+1">🇺🇸 +1</option>
                                <option value="+44">🇬🇧 +44</option>
                                <option value="+91">🇮🇳 +91</option>
                                <option value="+61">🇦🇺 +61</option>
                                <option value="+49">🇩🇪 +49</option>
                                <option value="+33">🇫🇷 +33</option>
                                <option value="+971">🇦🇪 +971</option>
                                <option value="+65">🇸🇬 +65</option>
                                <option value="+60">🇲🇾 +60</option>
                                <option value="+81">🇯🇵 +81</option>
                                <option value="+86">🇨🇳 +86</option>
                                <option value="+966">🇸🇦 +966</option>
                                <option value="+92">🇵🇰 +92</option>
                                <option value="+880">🇧🇩 +880</option>
                            </select>
                            <input type="text" name="phoneNumber" id="editPhoneNumber"
                                   class="form-input" maxlength="15" inputmode="numeric"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="guest-modal-footer">
                <button type="button" class="btn-cancel" onclick="closeModal('editOverlay')">
                    <i class="fas fa-times"></i> Cancel
                </button>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-floppy-disk"></i> Save Changes
                </button>
            </div>
        </form>
    </div>
</div>


<%-- ════════════════════════════════════════════════════════
     DELETE CONFIRM MODAL
 ════════════════════════════════════════════════════════ --%>
<div class="modal-overlay" id="deleteOverlay">
    <div class="guest-modal" style="width:440px;">
        <div class="guest-modal-header">
            <div class="guest-modal-icon icon-delete"><i class="fas fa-trash-can"></i></div>
            <div>
                <div class="guest-modal-title">Remove Guest</div>
                <div class="guest-modal-sub">This action cannot be undone</div>
            </div>
        </div>
        <button class="modal-x" onclick="closeModal('deleteOverlay')"><i class="fas fa-times"></i></button>

        <form method="POST" action="${pageContext.request.contextPath}/guests">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="guestId" id="deleteGuestId"/>
            <div class="guest-modal-body">
                <div class="delete-info">
                    <div class="delete-icon-big"><i class="fas fa-user-slash"></i></div>
                    <div>Are you sure you want to remove</div>
                    <div class="delete-guest-name" id="deleteGuestName">—</div>
                    <div style="font-size:12px;color:var(--text-muted);">from the guest directory?</div>
                </div>
                <div class="delete-warning">
                    <i class="fas fa-triangle-exclamation"></i>
                    Guests with existing reservations <strong>cannot</strong> be deleted.
                    Their booking history is protected.
                </div>
            </div>
            <div class="guest-modal-footer">
                <button type="button" class="btn-cancel" onclick="closeModal('deleteOverlay')">
                    <i class="fas fa-times"></i> Cancel
                </button>
                <button type="submit" class="btn-danger">
                    <i class="fas fa-trash-can"></i> Yes, Remove
                </button>
            </div>
        </form>
    </div>
</div>


<%-- ════════════════════════════════════════════════════════
     JAVASCRIPT
 ════════════════════════════════════════════════════════ --%>
<script>
// ── Live Clock ────────────────────────────────────────────
function updateClock() {
    const now = new Date();
    const days   = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    const h = String(now.getHours()).padStart(2,'0');
    const m = String(now.getMinutes()).padStart(2,'0');
    const s = String(now.getSeconds()).padStart(2,'0');
    document.getElementById('clockTime').textContent = h+':'+m+':'+s;
    document.getElementById('clockDate').textContent =
        days[now.getDay()]+', '+months[now.getMonth()]+' '+now.getDate()+' '+now.getFullYear();
}
updateClock(); setInterval(updateClock, 1000);

// ── Modal Open / Close ────────────────────────────────────
function openAddModal() {
    document.getElementById('addOverlay').classList.add('active');
    document.body.style.overflow = 'hidden';
}
function openDeleteModal(id, name) {
    document.getElementById('deleteGuestId').value = id;
    document.getElementById('deleteGuestName').textContent = name;
    document.getElementById('deleteOverlay').classList.add('active');
    document.body.style.overflow = 'hidden';
}
function closeModal(id) {
    document.getElementById(id).classList.remove('active');
    document.body.style.overflow = '';
}
// Close on overlay click
document.querySelectorAll('.modal-overlay').forEach(ov => {
    ov.addEventListener('click', e => {
        if (e.target === ov) closeModal(ov.id);
    });
});

// ── Edit Modal — AJAX pre-fill ────────────────────────────
function openEditModal(guestId) {
    fetch('${pageContext.request.contextPath}/guests?action=get&id=' + guestId)
        .then(r => r.json())
        .then(g => {
            if (g.error) { alert('Could not load guest data.'); return; }
            document.getElementById('editGuestId').value    = g.guestId;
            document.getElementById('editFullName').value   = g.fullName;
            document.getElementById('editAddress').value    = g.address;
            document.getElementById('editPhoneNumber').value= g.phoneNumber;
            // Country select
            const cSel = document.getElementById('editCountry');
            [...cSel.options].forEach(o => { o.selected = o.value === g.country; });
            // Phone code select
            const pSel = document.getElementById('editPhoneCode');
            [...pSel.options].forEach(o => { o.selected = o.value === g.phoneCode; });
            document.getElementById('editOverlay').classList.add('active');
            document.body.style.overflow = 'hidden';
        })
        .catch(() => alert('Network error. Please try again.'));
}

// ── Client-side validation ────────────────────────────────
function validateGuestForm(type) {
    const prefix = type === 'edit' ? 'edit' : '';
    const nameEl  = document.querySelector(`[name="fullName"]${prefix ? '#edit' + 'FullName' : ''}`);
    const phoneEl = document.querySelector(`[name="phoneNumber"]${prefix ? '#edit' + 'PhoneNumber' : ''}`);

    // Simpler universal check across both forms
    const form   = type === 'add'
        ? document.querySelector('#addOverlay form')
        : document.querySelector('#editOverlay form');
    const name   = form.querySelector('[name="fullName"]').value.trim();
    const phone  = form.querySelector('[name="phoneNumber"]').value.trim();
    const country= form.querySelector('[name="country"]').value;

    if (!name)    { alert('Full name is required.'); return false; }
    if (!country) { alert('Please select a country.'); return false; }
    if (!phone)   { alert('Phone number is required.'); return false; }
    if (!/^\d{6,15}$/.test(phone)) {
        alert('Phone number must be 6–15 digits only (no spaces or symbols).');
        return false;
    }
    return true;
}

// ── Auto-dismiss flash messages after 5 seconds ────────────
setTimeout(() => {
    document.querySelectorAll('.flash-msg').forEach(el => {
        el.style.transition = 'opacity .5s';
        el.style.opacity = '0';
        setTimeout(() => el.remove(), 500);
    });
}, 5000);
</script>
</body>
</html>
