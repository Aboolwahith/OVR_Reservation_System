<%-- ═══════════════════════════════════════════════════════════════
     OVR – Sidebar Navigation + Help Panel (Shared Include)
     Usage: <%@ include file="sidebar.jsp" %>
     Set page variable before include:
        <c:set var="activePage" value="guests" scope="page" />
 ═══════════════════════════════════════════════════════════════ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="ovr-sidebar" id="ovrSidebar">

    <div class="sidebar-brand">
        <div class="brand-icon"><i class="fas fa-water"></i></div>
        <div class="brand-text">
            <span class="brand-name">OCEAN VIEW</span>
            <span class="brand-tagline">Resort &amp; Spa</span>
        </div>
    </div>

    <div class="sidebar-divider"></div>

    <ul class="sidebar-nav">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/dashboard"
               class="nav-link ${activePage == 'dashboard' ? 'active' : ''}">
                <span class="nav-icon"><i class="fas fa-chart-line"></i></span>
                <span class="nav-label">Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/guests"
               class="nav-link ${activePage == 'guests' ? 'active' : ''}">
                <span class="nav-icon"><i class="fas fa-user-tie"></i></span>
                <span class="nav-label">Guest Management</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/reservations"
               class="nav-link ${activePage == 'reservations' ? 'active' : ''}">
                <span class="nav-icon"><i class="fas fa-calendar-check"></i></span>
                <span class="nav-label">Reservations</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/billing"
               class="nav-link ${activePage == 'billing' ? 'active' : ''}">
                <span class="nav-icon"><i class="fas fa-credit-card"></i></span>
                <span class="nav-label">Billing</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/reports"
               class="nav-link ${activePage == 'reports' ? 'active' : ''}">
                <span class="nav-icon"><i class="fas fa-chart-bar"></i></span>
                <span class="nav-label">Reports</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-divider"></div>

    <ul class="sidebar-nav sidebar-bottom">
        <li class="nav-item">
            <a href="#" class="nav-link ${activePage == 'help' ? 'active' : ''}"
               onclick="openHelpPanel(event)">
                <span class="nav-icon"><i class="fas fa-circle-question"></i></span>
                <span class="nav-label">Help &amp; Guide</span>
                <span class="nav-badge help-badge">4</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link ${activePage == 'settings' ? 'active' : ''}"
               onclick="openAdminOtpModal(event)">
                <span class="nav-icon"><i class="fas fa-cog"></i></span>
                <span class="nav-label">Settings</span>
                <span class="nav-badge otp-badge">OTP</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/notifications"
               class="nav-link ${activePage == 'notifications' ? 'active' : ''}">
                <span class="nav-icon"><i class="fas fa-bell"></i></span>
                <span class="nav-label">Notifications</span>
                <c:if test="${sessionScope.unreadCount > 0}">
                    <span class="nav-badge notif-badge">${sessionScope.unreadCount}</span>
                </c:if>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/logout" class="nav-link logout-link">
                <span class="nav-icon"><i class="fas fa-sign-out-alt"></i></span>
                <span class="nav-label">Logout</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <div class="staff-info">
            <div class="staff-avatar"><i class="fas fa-user-circle"></i></div>
            <div class="staff-details">
                <span class="staff-name">${sessionScope.username}</span>
                <span class="staff-role">Receptionist</span>
            </div>
        </div>
    </div>
</nav>

<%-- ════════════════════════════════════════════════════════
     HELP SLIDE-OUT PANEL
 ════════════════════════════════════════════════════════ --%>
<div class="help-overlay" id="helpOverlay" onclick="closeHelpPanel()"></div>

<aside class="help-panel" id="helpPanel">
    <div class="help-panel-header">
        <div class="help-title">
            <i class="fas fa-circle-question"></i>
            <span>Help &amp; User Guide</span>
        </div>
        <button class="help-close-btn" onclick="closeHelpPanel()">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <div class="help-intro">
        <p>Welcome to the <strong>Ocean View Resort</strong> guide.
           Select a topic below for step-by-step instructions.</p>
    </div>

    <div class="help-accordion">

        <%-- Topic 1 --%>
        <div class="help-card" id="helpCard1">
            <button class="help-card-header" onclick="toggleHelpCard(1)">
                <div class="help-card-icon color-teal"><i class="fas fa-chart-line"></i></div>
                <span class="help-card-title">How to Access the Dashboard</span>
                <i class="fas fa-chevron-down help-chevron" id="chevron1"></i>
            </button>
            <div class="help-card-body" id="helpBody1">
                <ol class="help-steps">
                    <li>
                        <span class="step-num">1</span>
                        <div class="step-text"><strong>Log in</strong> using your receptionist username and password on the login page.</div>
                    </li>
                    <li>
                        <span class="step-num">2</span>
                        <div class="step-text">You are <strong>automatically redirected</strong> to the Dashboard after a successful login.</div>
                    </li>
                    <li>
                        <span class="step-num">3</span>
                        <div class="step-text">Click <strong>"Dashboard"</strong> in the left sidebar at any time to return to the overview.</div>
                    </li>
                    <li>
                        <span class="step-num">4</span>
                        <div class="step-text">The dashboard shows <strong>live stats</strong> — room counts, today's arrivals, departures, occupancy rate, and daily revenue. All data refreshes on every page load.</div>
                    </li>
                </ol>
                <div class="help-tip">
                    <i class="fas fa-lightbulb"></i>
                    <span><strong>Tip:</strong> The live clock in the header shows current server time — use it to verify check-in/out timings.</span>
                </div>
            </div>
        </div>

        <%-- Topic 2 --%>
        <div class="help-card" id="helpCard2">
            <button class="help-card-header" onclick="toggleHelpCard(2)">
                <div class="help-card-icon color-gold"><i class="fas fa-calendar-check"></i></div>
                <span class="help-card-title">How to Make a Reservation</span>
                <i class="fas fa-chevron-down help-chevron" id="chevron2"></i>
            </button>
            <div class="help-card-body" id="helpBody2">
                <ol class="help-steps">
                    <li>
                        <span class="step-num">1</span>
                        <div class="step-text">Go to <strong>Guest Management</strong> and add the guest if they don't exist yet. A Guest ID is required before making a reservation.</div>
                    </li>
                    <li>
                        <span class="step-num">2</span>
                        <div class="step-text">Navigate to <strong>Reservations</strong> and click <strong>"+ New Reservation"</strong>.</div>
                    </li>
                    <li>
                        <span class="step-num">3</span>
                        <div class="step-text">Select the <strong>Guest</strong>, choose an <strong>Available Room</strong>, and set <strong>Check-in</strong> and <strong>Check-out</strong> dates.</div>
                    </li>
                    <li>
                        <span class="step-num">4</span>
                        <div class="step-text">The system auto-calculates cost:
                            <code>Room Rate × Number of Nights</code>
                        </div>
                    </li>
                    <li>
                        <span class="step-num">5</span>
                        <div class="step-text">Click <strong>"Confirm Reservation"</strong>. Room status changes to <strong>OCCUPIED</strong> automatically.</div>
                    </li>
                </ol>
                <div class="help-tip">
                    <i class="fas fa-lightbulb"></i>
                    <span><strong>Tip:</strong> A unique Reservation Number (e.g. OVR-2026-001) is auto-generated — give this to the guest as their booking reference.</span>
                </div>
            </div>
        </div>

        <%-- Topic 3 --%>
        <div class="help-card" id="helpCard3">
            <button class="help-card-header" onclick="toggleHelpCard(3)">
                <div class="help-card-icon color-green"><i class="fas fa-file-invoice-dollar"></i></div>
                <span class="help-card-title">How to Generate a Bill</span>
                <i class="fas fa-chevron-down help-chevron" id="chevron3"></i>
            </button>
            <div class="help-card-body" id="helpBody3">
                <ol class="help-steps">
                    <li>
                        <span class="step-num">1</span>
                        <div class="step-text">Go to <strong>Billing</strong> and search by reservation number or guest name.</div>
                    </li>
                    <li>
                        <span class="step-num">2</span>
                        <div class="step-text">Click <strong>"Generate Bill"</strong>. Formula used:
                            <code>Total = Rate/Night × Total Nights</code>
                        </div>
                    </li>
                    <li>
                        <span class="step-num">3</span>
                        <div class="step-text">Early checkout refund is auto-calculated:
                            <code>Refund = Unused Days × Room Rate</code>
                        </div>
                    </li>
                    <li>
                        <span class="step-num">4</span>
                        <div class="step-text">Extended stay adds extra charges:
                            <code>Extra = Additional Days × Room Rate</code>
                        </div>
                    </li>
                    <li>
                        <span class="step-num">5</span>
                        <div class="step-text">Select <strong>Payment Method</strong> (Cash / Card / Online) and click <strong>"Confirm Payment"</strong>.</div>
                    </li>
                    <li>
                        <span class="step-num">6</span>
                        <div class="step-text">Click <strong>"Print Invoice"</strong> to generate a PDF receipt for the guest.</div>
                    </li>
                </ol>
                <div class="help-tip">
                    <i class="fas fa-lightbulb"></i>
                    <span><strong>Tip:</strong> Always generate the bill <em>before</em> marking the reservation as CHECKED OUT. Billing is locked after checkout.</span>
                </div>
            </div>
        </div>

        <%-- Topic 4 --%>
        <div class="help-card" id="helpCard4">
            <button class="help-card-header" onclick="toggleHelpCard(4)">
                <div class="help-card-icon color-purple"><i class="fas fa-shield-halved"></i></div>
                <span class="help-card-title">How to Use Admin OTP for Settings</span>
                <i class="fas fa-chevron-down help-chevron" id="chevron4"></i>
            </button>
            <div class="help-card-body" id="helpBody4">
                <ol class="help-steps">
                    <li>
                        <span class="step-num">1</span>
                        <div class="step-text">Click <strong>"Settings"</strong> in the sidebar. It will NOT open directly — it triggers an Admin OTP request for security.</div>
                    </li>
                    <li>
                        <span class="step-num">2</span>
                        <div class="step-text">A <strong>6-digit OTP</strong> is sent automatically to the <strong>Admin's registered email</strong>.</div>
                    </li>
                    <li>
                        <span class="step-num">3</span>
                        <div class="step-text"><strong>Contact your Admin</strong> to get the OTP code from their email. The Admin does not need to log into the system.</div>
                    </li>
                    <li>
                        <span class="step-num">4</span>
                        <div class="step-text">Enter the <strong>6 digits</strong> into the verification boxes — it auto-advances between boxes.</div>
                    </li>
                    <li>
                        <span class="step-num">5</span>
                        <div class="step-text">Click <strong>"Verify Access"</strong>. The OTP <strong>expires in 5 minutes</strong> — request a new one if it times out.</div>
                    </li>
                </ol>
                <div class="help-tip warning">
                    <i class="fas fa-triangle-exclamation"></i>
                    <span><strong>Important:</strong> Never share the OTP with unauthorized staff. Each OTP is single-use and expires automatically. Failed attempts are logged by the system.</span>
                </div>
            </div>
        </div>

    </div><%-- /help-accordion --%>

    <div class="help-panel-footer">
        <i class="fas fa-headset"></i>
        Need further help? Contact your system administrator.
    </div>
</aside>

<%-- ════════════════════════════════════════════════════════
     ADMIN OTP MODAL
 ════════════════════════════════════════════════════════ --%>
<div class="modal-overlay" id="adminOtpOverlay">
    <div class="otp-modal">
        <div class="modal-header">
            <div class="modal-icon"><i class="fas fa-shield-alt"></i></div>
            <h2>Admin Verification Required</h2>
            <p>Settings access requires Admin OTP authorization.</p>
        </div>
        <div class="otp-info-box">
            <i class="fas fa-envelope"></i>
            <span>A 6-digit OTP has been sent to the <strong>Admin's email</strong>.
                  Please ask your Admin for the code.</span>
        </div>
        <form action="${pageContext.request.contextPath}/settings/verify-otp" method="POST">
            <div class="otp-input-group">
                <input type="text" maxlength="1" class="otp-box" id="otpBox1" inputmode="numeric"/>
                <input type="text" maxlength="1" class="otp-box" id="otpBox2" inputmode="numeric"/>
                <input type="text" maxlength="1" class="otp-box" id="otpBox3" inputmode="numeric"/>
                <input type="text" maxlength="1" class="otp-box" id="otpBox4" inputmode="numeric"/>
                <input type="text" maxlength="1" class="otp-box" id="otpBox5" inputmode="numeric"/>
                <input type="text" maxlength="1" class="otp-box" id="otpBox6" inputmode="numeric"/>
                <input type="hidden" name="adminOtp" id="combinedOtp"/>
            </div>
            <div class="otp-timer">
                <i class="fas fa-clock"></i>
                Code expires in: <span id="otpCountdown">05:00</span>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-secondary" onclick="closeAdminOtpModal()">Cancel</button>
                <button type="submit" class="btn-primary" onclick="combineOtp()">
                    <i class="fas fa-unlock-alt"></i> Verify Access
                </button>
            </div>
        </form>
        <button class="modal-close" onclick="closeAdminOtpModal()"><i class="fas fa-times"></i></button>
    </div>
</div>

<%-- ════════════════════════════════════════════════════════
     SIDEBAR CSS
 ════════════════════════════════════════════════════════ --%>
<style>
.ovr-sidebar {
    width: var(--sidebar-w, 260px); height: 100vh;
    background: rgba(10,20,40,0.92);
    backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
    border-right: 1px solid rgba(255,255,255,0.07);
    display: flex; flex-direction: column;
    flex-shrink: 0; z-index: 100;
    overflow-y: auto; overflow-x: hidden; scrollbar-width: none;
}
.ovr-sidebar::-webkit-scrollbar { display: none; }
.sidebar-brand { display: flex; align-items: center; gap: 12px; padding: 28px 20px 20px; }
.brand-icon {
    width: 44px; height: 44px;
    background: linear-gradient(135deg,#00b4d8,#0d1f3c);
    border-radius: 12px; display: flex; align-items: center; justify-content: center;
    font-size: 20px; color: white; box-shadow: 0 4px 16px rgba(0,180,216,.3); flex-shrink: 0;
}
.brand-name { font-family:'Cormorant Garamond',serif; font-size:16px; font-weight:600; letter-spacing:2px; color:#e8f4f8; display:block; }
.brand-tagline { font-size:10px; color:#00b4d8; letter-spacing:1.5px; text-transform:uppercase; display:block; }
.sidebar-divider { height:1px; background:rgba(255,255,255,.07); margin:8px 20px; }
.sidebar-nav { list-style:none; padding:8px 12px; flex:1; }
.sidebar-bottom { flex:0; padding-bottom:8px; }
.nav-link {
    display:flex; align-items:center; gap:12px; padding:11px 14px;
    border-radius:8px; color:#8899aa; text-decoration:none;
    font-size:13.5px; font-weight:400;
    transition:all .3s cubic-bezier(.4,0,.2,1);
    position:relative; margin-bottom:2px;
}
.nav-link:hover { background:rgba(0,180,216,.1); color:#e8f4f8; }
.nav-link.active {
    background:linear-gradient(90deg,rgba(0,180,216,.2),rgba(0,180,216,.04));
    color:#00b4d8; border-left:2px solid #00b4d8; padding-left:12px; font-weight:500;
}
.nav-link.active .nav-icon { color:#00b4d8; }
.nav-icon { width:20px; text-align:center; font-size:14px; color:#556677; }
.nav-label { flex:1; }
.nav-badge { padding:2px 7px; border-radius:20px; font-size:10px; font-weight:600; letter-spacing:.5px; }
.help-badge  { background:rgba(167,139,250,.2); color:#a78bfa; }
.otp-badge   { background:rgba(201,168,76,.2);  color:#c9a84c; }
.notif-badge { background:rgba(0,180,216,.2);   color:#00b4d8; }
.logout-link:hover { background:rgba(255,80,80,.1); color:#ff6b6b; }
.logout-link:hover .nav-icon { color:#ff6b6b; }
.sidebar-footer { padding:16px 20px; border-top:1px solid rgba(255,255,255,.07); }
.staff-info { display:flex; align-items:center; gap:10px; }
.staff-avatar { font-size:32px; color:#00b4d8; }
.staff-name { display:block; font-size:13px; font-weight:500; color:#e8f4f8; }
.staff-role { display:block; font-size:11px; color:#c9a84c; letter-spacing:.5px; }

/* HELP PANEL */
.help-overlay {
    position:fixed; inset:0; background:rgba(0,0,0,.5);
    backdrop-filter:blur(4px); z-index:200;
    opacity:0; pointer-events:none; transition:opacity .35s ease;
}
.help-overlay.active { opacity:1; pointer-events:all; }
.help-panel {
    position:fixed; top:0; right:0; width:420px; height:100vh;
    background:rgba(8,18,36,.98); backdrop-filter:blur(24px);
    border-left:1px solid rgba(255,255,255,.08);
    z-index:300; display:flex; flex-direction:column;
    transform:translateX(100%);
    transition:transform .4s cubic-bezier(.4,0,.2,1);
    overflow:hidden;
}
.help-panel.open { transform:translateX(0); }
.help-panel-header {
    display:flex; align-items:center; justify-content:space-between;
    padding:24px 28px; border-bottom:1px solid rgba(255,255,255,.07); flex-shrink:0;
}
.help-title { display:flex; align-items:center; gap:10px; font-family:'Cormorant Garamond',serif; font-size:20px; font-weight:400; color:#e8f4f8; }
.help-title i { color:#a78bfa; font-size:18px; }
.help-close-btn {
    width:34px; height:34px; background:rgba(255,255,255,.05);
    border:1px solid rgba(255,255,255,.08); border-radius:50%;
    display:flex; align-items:center; justify-content:center;
    color:#8899aa; font-size:13px; cursor:pointer; transition:all .2s;
}
.help-close-btn:hover { background:rgba(248,113,113,.1); color:#f87171; border-color:rgba(248,113,113,.3); }
.help-intro { padding:18px 28px 14px; font-size:13px; color:#8899aa; border-bottom:1px solid rgba(255,255,255,.05); flex-shrink:0; }
.help-intro strong { color:#e8f4f8; }
.help-accordion { flex:1; overflow-y:auto; padding:12px 16px; scrollbar-width:thin; scrollbar-color:rgba(167,139,250,.2) transparent; }
.help-accordion::-webkit-scrollbar { width:4px; }
.help-accordion::-webkit-scrollbar-thumb { background:rgba(167,139,250,.2); border-radius:2px; }
.help-card { background:rgba(255,255,255,.03); border:1px solid rgba(255,255,255,.06); border-radius:12px; margin-bottom:10px; overflow:hidden; transition:border-color .2s; }
.help-card.open { border-color:rgba(167,139,250,.25); }
.help-card-header {
    display:flex; align-items:center; gap:12px; padding:15px 18px;
    background:none; border:none; width:100%; text-align:left; cursor:pointer; transition:background .2s;
}
.help-card-header:hover { background:rgba(255,255,255,.03); }
.help-card-icon { width:36px; height:36px; border-radius:10px; display:flex; align-items:center; justify-content:center; font-size:14px; flex-shrink:0; }
.color-teal   { background:rgba(0,180,216,.1);  color:#00b4d8; }
.color-gold   { background:rgba(201,168,76,.1); color:#c9a84c; }
.color-green  { background:rgba(74,222,128,.1); color:#4ade80; }
.color-purple { background:rgba(167,139,250,.1);color:#a78bfa; }
.help-card-title { flex:1; font-size:13.5px; font-weight:500; color:#e8f4f8; }
.help-chevron { font-size:11px; color:#556677; transition:transform .3s ease; }
.help-card.open .help-chevron { transform:rotate(180deg); color:#a78bfa; }
.help-card-body { max-height:0; overflow:hidden; transition:max-height .4s cubic-bezier(.4,0,.2,1); padding:0 18px; }
.help-card.open .help-card-body { max-height:700px; padding-bottom:18px; }
.help-steps { list-style:none; display:flex; flex-direction:column; gap:12px; margin-bottom:14px; padding-top:6px; }
.help-steps li { display:flex; gap:12px; align-items:flex-start; }
.step-num { width:24px; height:24px; background:rgba(167,139,250,.12); border:1px solid rgba(167,139,250,.25); border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:11px; font-weight:700; color:#a78bfa; flex-shrink:0; margin-top:1px; }
.step-text { font-size:12.5px; color:#8899aa; line-height:1.65; }
.step-text strong { color:#e8f4f8; }
.step-text em { color:#c9a84c; font-style:italic; }
.step-text code { display:inline-block; background:rgba(0,180,216,.08); border:1px solid rgba(0,180,216,.15); border-radius:5px; padding:2px 8px; font-family:monospace; font-size:11px; color:#00b4d8; margin-top:4px; }
.help-tip { display:flex; align-items:flex-start; gap:10px; background:rgba(0,180,216,.05); border:1px solid rgba(0,180,216,.12); border-radius:8px; padding:12px 14px; font-size:12px; color:#8899aa; line-height:1.55; }
.help-tip i { color:#00b4d8; margin-top:1px; flex-shrink:0; }
.help-tip strong { color:#e8f4f8; }
.help-tip.warning { background:rgba(251,146,60,.05); border-color:rgba(251,146,60,.15); }
.help-tip.warning i { color:#fb923c; }
.help-panel-footer { padding:16px 28px; border-top:1px solid rgba(255,255,255,.06); font-size:12px; color:#556677; display:flex; align-items:center; gap:8px; flex-shrink:0; }
.help-panel-footer i { color:#a78bfa; }

/* OTP MODAL */
.modal-overlay { position:fixed; inset:0; background:rgba(0,0,0,.75); backdrop-filter:blur(6px); display:flex; align-items:center; justify-content:center; z-index:500; opacity:0; pointer-events:none; transition:opacity .3s ease; }
.modal-overlay.active { opacity:1; pointer-events:all; }
.otp-modal { position:relative; width:480px; background:rgba(10,20,40,.97); border:1px solid rgba(0,180,216,.2); border-radius:20px; padding:40px; transform:scale(.95); transition:transform .3s ease; text-align:center; }
.modal-overlay.active .otp-modal { transform:scale(1); }
.modal-header { margin-bottom:24px; }
.modal-icon { width:60px; height:60px; background:rgba(0,180,216,.1); border:1px solid rgba(0,180,216,.25); border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:24px; color:#00b4d8; margin:0 auto 16px; }
.modal-header h2 { font-family:'Cormorant Garamond',serif; font-size:22px; font-weight:400; color:#e8f4f8; margin-bottom:6px; }
.modal-header p { font-size:13px; color:#8899aa; }
.otp-info-box { display:flex; align-items:center; gap:12px; background:rgba(0,180,216,.06); border:1px solid rgba(0,180,216,.14); border-radius:10px; padding:14px 16px; margin-bottom:28px; text-align:left; font-size:13px; color:#8899aa; }
.otp-info-box i { color:#00b4d8; font-size:18px; flex-shrink:0; }
.otp-info-box strong { color:#e8f4f8; }
.otp-input-group { display:flex; gap:10px; justify-content:center; margin-bottom:20px; }
.otp-box { width:50px; height:58px; background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.08); border-radius:10px; text-align:center; font-size:22px; font-weight:600; color:#00b4d8; caret-color:#00b4d8; outline:none; transition:all .2s; }
.otp-box:focus { border-color:#00b4d8; background:rgba(0,180,216,.07); box-shadow:0 0 0 3px rgba(0,180,216,.1); }
.otp-timer { font-size:12px; color:#8899aa; margin-bottom:28px; }
.otp-timer i { color:#c9a84c; margin-right:6px; }
#otpCountdown { color:#c9a84c; font-weight:600; }
.modal-actions { display:flex; gap:12px; }
.btn-primary,.btn-secondary { flex:1; padding:13px 20px; border-radius:10px; font-size:14px; font-weight:500; cursor:pointer; border:none; transition:all .25s; display:flex; align-items:center; justify-content:center; gap:8px; }
.btn-primary { background:linear-gradient(135deg,#00b4d8,#0096b4); color:white; }
.btn-primary:hover { transform:translateY(-1px); box-shadow:0 6px 20px rgba(0,180,216,.3); }
.btn-secondary { background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.08); color:#8899aa; }
.btn-secondary:hover { background:rgba(255,255,255,.08); color:#e8f4f8; }
.modal-close { position:absolute; top:16px; right:16px; width:32px; height:32px; background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.08); border-radius:50%; display:flex; align-items:center; justify-content:center; color:#8899aa; cursor:pointer; font-size:12px; transition:all .2s; }
.modal-close:hover { background:rgba(248,113,113,.1); color:#f87171; }
</style>

<%-- ════════════════════════════════════════════════════════
     JAVASCRIPT
 ════════════════════════════════════════════════════════ --%>
<script>
/* ── Help Panel ──────────────────────────────────────────── */
function openHelpPanel(e) {
    if (e) e.preventDefault();
    document.getElementById('helpPanel').classList.add('open');
    document.getElementById('helpOverlay').classList.add('active');
    document.body.style.overflow = 'hidden';
}
function closeHelpPanel() {
    document.getElementById('helpPanel').classList.remove('open');
    document.getElementById('helpOverlay').classList.remove('active');
    document.body.style.overflow = '';
}
/* Accordion — one card open at a time */
function toggleHelpCard(num) {
    const card = document.getElementById('helpCard' + num);
    const isOpen = card.classList.contains('open');
    document.querySelectorAll('.help-card').forEach(c => c.classList.remove('open'));
    if (!isOpen) card.classList.add('open');
}

/* ── Admin OTP Modal ─────────────────────────────────────── */
function openAdminOtpModal(e) {
    if (e) e.preventDefault();
    document.getElementById('adminOtpOverlay').classList.add('active');
    fetch('${pageContext.request.contextPath}/settings/send-otp', { method:'POST' }).catch(()=>{});
    startOtpTimer();
    setTimeout(() => document.getElementById('otpBox1').focus(), 300);
}
function closeAdminOtpModal() {
    document.getElementById('adminOtpOverlay').classList.remove('active');
    clearInterval(window._otpTimerInterval);
    document.querySelectorAll('.otp-box').forEach(b => b.value = '');
    const el = document.getElementById('otpCountdown');
    el.textContent = '05:00'; el.style.color = '';
}
function combineOtp() {
    document.getElementById('combinedOtp').value =
        [...document.querySelectorAll('.otp-box')].map(b => b.value).join('');
}
function startOtpTimer() {
    clearInterval(window._otpTimerInterval);
    let sec = 300;
    const el = document.getElementById('otpCountdown');
    window._otpTimerInterval = setInterval(() => {
        const m = String(Math.floor(sec/60)).padStart(2,'0');
        const s = String(sec%60).padStart(2,'0');
        el.textContent = m+':'+s;
        if (--sec < 0) {
            clearInterval(window._otpTimerInterval);
            el.textContent = 'EXPIRED'; el.style.color = '#f87171';
        }
    }, 1000);
}
/* OTP box auto-tab */
document.addEventListener('DOMContentLoaded', () => {
    const boxes = document.querySelectorAll('.otp-box');
    boxes.forEach((box,i) => {
        box.addEventListener('input', () => {
            box.value = box.value.replace(/\D/g,'');
            if (box.value && i < boxes.length - 1) boxes[i+1].focus();
        });
        box.addEventListener('keydown', e => {
            if (e.key === 'Backspace' && !box.value && i > 0) boxes[i-1].focus();
        });
    });
});
</script>
