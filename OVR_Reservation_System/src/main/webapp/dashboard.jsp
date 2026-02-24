<%-- ═══════════════════════════════════════════════════════════════
     OVR – Dashboard View (dashboard.jsp)
     Controller : DashboardServlet.java
     Attributes : stats (DashboardStats), recentReservations (List)
                  loggedInUser, loggedInRole
 ═══════════════════════════════════════════════════════════════ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="activePage" value="dashboard" scope="page" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>OVR | Dashboard</title>

    <%-- Font Awesome 6 --%>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <%-- Google Fonts --%>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;600&family=Inter:wght@300;400;500;600&display=swap"
          rel="stylesheet" />

<style>
/* ════════════════════════════════════════════════════════════════
   OVR DASHBOARD — CINEMATIC LUXURY THEME
   Color Palette: Deep Ocean (#0a1628) · Teal (#00b4d8) · Gold (#c9a84c)
   Typography: Cormorant Garamond (headings) + Inter (body)
   Effects: Glassmorphism · Frosted panels · Wave animations
   ════════════════════════════════════════════════════════════════ */

/* ── Reset & Base ──────────────────────────────────────────── */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
    --ocean-deep:   #0a1628;
    --ocean-mid:    #0d1f3c;
    --ocean-light:  #112240;
    --ocean-card:   rgba(255,255,255,0.05);
    --teal:         #00b4d8;
    --teal-light:   #48cae4;
    --teal-glow:    rgba(0,180,216,0.15);
    --gold:         #c9a84c;
    --gold-light:   #f0d080;
    --gold-glow:    rgba(201,168,76,0.2);
    --text-primary: #e8f4f8;
    --text-muted:   #8899aa;
    --text-dim:     #556677;
    --sidebar-w:    260px;
    --header-h:     80px;
    --glass-bg:     rgba(255,255,255,0.04);
    --glass-border: rgba(255,255,255,0.08);
    --radius-lg:    16px;
    --radius-md:    12px;
    --radius-sm:    8px;
    --shadow-card:  0 8px 32px rgba(0,0,0,0.3);
    --shadow-glow:  0 0 24px rgba(0,180,216,0.2);
    --transition:   all 0.3s cubic-bezier(0.4,0,0.2,1);
}

html, body {
    height: 100%;
    background: var(--ocean-deep);
    color: var(--text-primary);
    font-family: 'Inter', sans-serif;
    font-size: 14px;
    line-height: 1.6;
    overflow: hidden;
}

/* ── Animated Ocean Background ─────────────────────────────── */
body::before {
    content: '';
    position: fixed;
    inset: 0;
    background:
        radial-gradient(ellipse 80% 60% at 20% 80%, rgba(0,100,150,0.15) 0%, transparent 60%),
        radial-gradient(ellipse 60% 40% at 80% 20%, rgba(0,60,100,0.12) 0%, transparent 50%),
        linear-gradient(160deg, #0a1628 0%, #0d1f3c 50%, #0a1a2e 100%);
    z-index: -1;
    animation: oceanPulse 8s ease-in-out infinite alternate;
}

@keyframes oceanPulse {
    0%  { opacity: 1; }
    100%{ opacity: 0.85; }
}

/* ════════════════════════════════════════════════════════════════
   LAYOUT — Sidebar + Main
   ════════════════════════════════════════════════════════════════ */
.ovr-layout {
    display: flex;
    height: 100vh;
    overflow: hidden;
}

/* ════════════════════════════════════════════════════════════════
   SIDEBAR
   ════════════════════════════════════════════════════════════════ */
.ovr-sidebar {
    width: var(--sidebar-w);
    height: 100vh;
    background: rgba(10, 20, 40, 0.85);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-right: 1px solid var(--glass-border);
    display: flex;
    flex-direction: column;
    flex-shrink: 0;
    z-index: 100;
    overflow-y: auto;
    overflow-x: hidden;
    scrollbar-width: none;
}
.ovr-sidebar::-webkit-scrollbar { display: none; }

/* Brand */
.sidebar-brand {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 28px 20px 20px;
}
.brand-icon {
    width: 44px; height: 44px;
    background: linear-gradient(135deg, var(--teal), var(--ocean-mid));
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 20px; color: white;
    box-shadow: 0 4px 16px rgba(0,180,216,0.3);
    flex-shrink: 0;
}
.brand-name {
    font-family: 'Cormorant Garamond', serif;
    font-size: 16px;
    font-weight: 600;
    letter-spacing: 2px;
    color: var(--text-primary);
    display: block;
}
.brand-tagline {
    font-size: 10px;
    color: var(--teal);
    letter-spacing: 1.5px;
    text-transform: uppercase;
    display: block;
}

.sidebar-divider {
    height: 1px;
    background: var(--glass-border);
    margin: 8px 20px;
}

/* Nav Links */
.sidebar-nav {
    list-style: none;
    padding: 8px 12px;
    flex: 1;
}
.sidebar-bottom {
    flex: 0;
    padding-bottom: 8px;
}

.nav-link {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 11px 14px;
    border-radius: var(--radius-sm);
    color: var(--text-muted);
    text-decoration: none;
    font-size: 13.5px;
    font-weight: 400;
    transition: var(--transition);
    position: relative;
    margin-bottom: 2px;
}
.nav-link:hover {
    background: var(--teal-glow);
    color: var(--text-primary);
}
.nav-link.active {
    background: linear-gradient(90deg, rgba(0,180,216,0.2), rgba(0,180,216,0.05));
    color: var(--teal);
    border-left: 2px solid var(--teal);
    padding-left: 12px;
    font-weight: 500;
}
.nav-link.active .nav-icon { color: var(--teal); }
.nav-icon { width: 20px; text-align: center; font-size: 14px; color: var(--text-dim); }
.nav-label { flex: 1; }

.nav-badge {
    padding: 2px 7px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 600;
    letter-spacing: 0.5px;
}
.otp-badge { background: rgba(201,168,76,0.2); color: var(--gold); }
.notif-badge { background: rgba(0,180,216,0.2); color: var(--teal); }

.logout-link:hover { background: rgba(255,80,80,0.1); color: #ff6b6b; }
.logout-link:hover .nav-icon { color: #ff6b6b; }

/* Sidebar Footer */
.sidebar-footer {
    padding: 16px 20px;
    border-top: 1px solid var(--glass-border);
}
.staff-info {
    display: flex; align-items: center; gap: 10px;
}
.staff-avatar { font-size: 32px; color: var(--teal); }
.staff-name {
    display: block;
    font-size: 13px;
    font-weight: 500;
    color: var(--text-primary);
}
.staff-role {
    display: block;
    font-size: 11px;
    color: var(--gold);
    letter-spacing: 0.5px;
}

/* ════════════════════════════════════════════════════════════════
   MAIN CONTENT AREA
   ════════════════════════════════════════════════════════════════ */
.ovr-main {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

/* ── Header ──────────────────────────────────────────────────── */
.ovr-header {
    height: var(--header-h);
    background: rgba(10, 20, 40, 0.6);
    backdrop-filter: blur(12px);
    border-bottom: 1px solid var(--glass-border);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 32px;
    flex-shrink: 0;
    animation: slideDown 0.5s ease;
}

@keyframes slideDown {
    from { opacity:0; transform: translateY(-20px); }
    to   { opacity:1; transform: translateY(0); }
}

.header-left h1 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 26px;
    font-weight: 300;
    letter-spacing: 1px;
    color: var(--text-primary);
}
.header-left h1 span { color: var(--teal); font-weight: 600; }
.header-left .breadcrumb {
    font-size: 12px;
    color: var(--text-muted);
    margin-top: 2px;
}
.breadcrumb i { color: var(--teal); margin-right: 6px; }

.header-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

/* Live Clock */
.live-clock {
    text-align: right;
}
.clock-time {
    font-size: 20px;
    font-weight: 300;
    color: var(--text-primary);
    letter-spacing: 2px;
    font-variant-numeric: tabular-nums;
}
.clock-date {
    font-size: 11px;
    color: var(--text-muted);
    letter-spacing: 0.5px;
}

/* Notification Bell */
.notif-btn {
    position: relative;
    width: 42px; height: 42px;
    background: var(--glass-bg);
    border: 1px solid var(--glass-border);
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    color: var(--text-muted);
    font-size: 16px;
    cursor: pointer;
    transition: var(--transition);
    text-decoration: none;
}
.notif-btn:hover {
    background: var(--teal-glow);
    color: var(--teal);
    border-color: rgba(0,180,216,0.3);
}
.notif-dot {
    position: absolute;
    top: 8px; right: 9px;
    width: 8px; height: 8px;
    background: var(--teal);
    border-radius: 50%;
    border: 1px solid var(--ocean-deep);
    animation: pulse 2s infinite;
}
@keyframes pulse {
    0%,100%{ transform: scale(1); opacity:1; }
    50%     { transform: scale(1.3); opacity:0.7; }
}

/* User Chip */
.user-chip {
    display: flex;
    align-items: center;
    gap: 10px;
    background: var(--glass-bg);
    border: 1px solid var(--glass-border);
    border-radius: 30px;
    padding: 8px 16px 8px 10px;
}
.user-chip-avatar {
    width: 30px; height: 30px;
    background: linear-gradient(135deg, var(--teal), var(--ocean-mid));
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 13px; color: white;
}
.user-chip-name {
    font-size: 13px;
    font-weight: 500;
    color: var(--text-primary);
}
.user-chip-role {
    font-size: 10px;
    color: var(--gold);
    display: block;
    letter-spacing: 0.5px;
}

/* ── Scrollable Content ──────────────────────────────────────── */
.ovr-content {
    flex: 1;
    overflow-y: auto;
    padding: 32px;
    scrollbar-width: thin;
    scrollbar-color: rgba(0,180,216,0.2) transparent;
    animation: fadeInUp 0.6s ease;
}
@keyframes fadeInUp {
    from { opacity:0; transform: translateY(24px); }
    to   { opacity:1; transform: translateY(0); }
}

/* ════════════════════════════════════════════════════════════════
   STATS CARDS — Section B
   ════════════════════════════════════════════════════════════════ */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 32px;
}

.stat-card {
    background: var(--glass-bg);
    backdrop-filter: blur(12px);
    border: 1px solid var(--glass-border);
    border-radius: var(--radius-lg);
    padding: 24px;
    position: relative;
    overflow: hidden;
    transition: var(--transition);
    animation: cardPop 0.5s ease both;
}
@keyframes cardPop {
    from { opacity:0; transform: scale(0.95) translateY(10px); }
    to   { opacity:1; transform: scale(1) translateY(0); }
}
.stat-card:nth-child(1){ animation-delay: 0.1s; }
.stat-card:nth-child(2){ animation-delay: 0.15s; }
.stat-card:nth-child(3){ animation-delay: 0.2s; }
.stat-card:nth-child(4){ animation-delay: 0.25s; }
.stat-card:nth-child(5){ animation-delay: 0.3s; }
.stat-card:nth-child(6){ animation-delay: 0.35s; }
.stat-card:nth-child(7){ animation-delay: 0.4s; }

.stat-card:hover {
    transform: translateY(-4px);
    border-color: rgba(0,180,216,0.25);
    box-shadow: var(--shadow-glow);
}

/* Glowing top border per card theme */
.stat-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: var(--card-accent, var(--teal));
    opacity: 0.7;
}

.stat-card.teal    { --card-accent: var(--teal); }
.stat-card.gold    { --card-accent: var(--gold); }
.stat-card.green   { --card-accent: #4ade80; }
.stat-card.red     { --card-accent: #f87171; }
.stat-card.purple  { --card-accent: #a78bfa; }
.stat-card.orange  { --card-accent: #fb923c; }
.stat-card.blue    { --card-accent: #60a5fa; }

.card-icon-wrap {
    width: 44px; height: 44px;
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 18px;
    margin-bottom: 16px;
    background: rgba(255,255,255,0.05);
}
.stat-card.teal   .card-icon-wrap { background: rgba(0,180,216,0.1);  color: var(--teal); }
.stat-card.gold   .card-icon-wrap { background: rgba(201,168,76,0.1); color: var(--gold); }
.stat-card.green  .card-icon-wrap { background: rgba(74,222,128,0.1); color: #4ade80; }
.stat-card.red    .card-icon-wrap { background: rgba(248,113,113,0.1);color: #f87171; }
.stat-card.purple .card-icon-wrap { background: rgba(167,139,250,0.1);color: #a78bfa; }
.stat-card.orange .card-icon-wrap { background: rgba(251,146,60,0.1); color: #fb923c; }
.stat-card.blue   .card-icon-wrap { background: rgba(96,165,250,0.1); color: #60a5fa; }

.card-label {
    font-size: 11px;
    font-weight: 600;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    color: var(--text-muted);
    margin-bottom: 6px;
}
.card-value {
    font-family: 'Cormorant Garamond', serif;
    font-size: 36px;
    font-weight: 300;
    color: var(--text-primary);
    line-height: 1;
}
.card-sub {
    font-size: 11px;
    color: var(--text-muted);
    margin-top: 6px;
}

/* Occupancy bar */
.occupancy-bar {
    height: 4px;
    background: rgba(255,255,255,0.08);
    border-radius: 2px;
    margin-top: 10px;
    overflow: hidden;
}
.occupancy-fill {
    height: 100%;
    border-radius: 2px;
    transition: width 1.2s ease;
}
.fill-HIGH     { background: linear-gradient(90deg,#f87171,#ef4444); }
.fill-MODERATE { background: linear-gradient(90deg,#fbbf24,#f59e0b); }
.fill-LOW      { background: linear-gradient(90deg,#4ade80,#22c55e); }

/* ════════════════════════════════════════════════════════════════
   BOTTOM SECTION — Two columns: Recent Reservations + Room Status
   ════════════════════════════════════════════════════════════════ */
.dashboard-bottom {
    display: grid;
    grid-template-columns: 1fr 340px;
    gap: 20px;
    margin-bottom: 24px;
}

/* Glass Panel (shared by table + donut panel) */
.glass-panel {
    background: var(--glass-bg);
    backdrop-filter: blur(12px);
    border: 1px solid var(--glass-border);
    border-radius: var(--radius-lg);
    overflow: hidden;
}

.panel-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px 24px;
    border-bottom: 1px solid var(--glass-border);
}
.panel-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 18px;
    font-weight: 400;
    color: var(--text-primary);
}
.panel-title i { color: var(--teal); margin-right: 8px; }
.panel-action {
    font-size: 12px;
    color: var(--teal);
    text-decoration: none;
    opacity: 0.8;
    transition: opacity 0.2s;
}
.panel-action:hover { opacity: 1; }

/* ── Recent Reservations Table ──────────────────────────────── */
.res-table {
    width: 100%;
    border-collapse: collapse;
}
.res-table th {
    padding: 12px 16px;
    text-align: left;
    font-size: 10px;
    font-weight: 600;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    color: var(--text-dim);
    background: rgba(255,255,255,0.02);
    border-bottom: 1px solid var(--glass-border);
}
.res-table td {
    padding: 14px 16px;
    font-size: 13px;
    color: var(--text-primary);
    border-bottom: 1px solid rgba(255,255,255,0.03);
    white-space: nowrap;
}
.res-table tr:last-child td { border-bottom: none; }
.res-table tr:hover td { background: rgba(255,255,255,0.02); }

.res-number {
    font-family: monospace;
    font-size: 12px;
    color: var(--teal);
}
.guest-name { font-weight: 500; }
.room-type-badge {
    display: inline-flex;
    padding: 3px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 600;
    letter-spacing: 0.5px;
    background: rgba(0,180,216,0.1);
    color: var(--teal);
}

/* Status badges */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 600;
    letter-spacing: 0.5px;
    text-transform: uppercase;
}
.status-badge::before {
    content: '';
    width: 5px; height: 5px;
    border-radius: 50%;
    background: currentColor;
}
.status-BOOKED      { background: rgba(96,165,250,0.1); color: #60a5fa; }
.status-CHECKED_IN  { background: rgba(74,222,128,0.1); color: #4ade80; }
.status-CHECKED_OUT { background: rgba(148,163,184,0.1);color: #94a3b8; }
.status-CANCELLED   { background: rgba(248,113,113,0.1);color: #f87171; }

.empty-state {
    text-align: center;
    padding: 48px 24px;
    color: var(--text-muted);
}
.empty-state i { font-size: 40px; margin-bottom: 12px; opacity: 0.3; display: block; }
.empty-state p { font-size: 13px; }

/* ── Room Status Panel (right column) ───────────────────────── */
.room-status-panel {
    padding: 0;
}

.room-donut-wrap {
    padding: 24px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* SVG Donut Chart */
.donut-svg {
    width: 160px;
    height: 160px;
    transform: rotate(-90deg);
}
.donut-bg    { fill: none; stroke: rgba(255,255,255,0.05); stroke-width: 20; }
.donut-avail { fill: none; stroke: #4ade80; stroke-width: 20; stroke-linecap: round; transition: stroke-dasharray 1.2s ease; }
.donut-occ   { fill: none; stroke: var(--teal); stroke-width: 20; stroke-linecap: round; transition: stroke-dasharray 1.2s ease; }
.donut-maint { fill: none; stroke: var(--gold); stroke-width: 20; stroke-linecap: round; transition: stroke-dasharray 1.2s ease; }

.donut-center {
    position: absolute;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
}
.donut-value {
    font-family: 'Cormorant Garamond', serif;
    font-size: 28px;
    font-weight: 300;
    color: var(--text-primary);
    display: block;
    line-height: 1;
}
.donut-label {
    font-size: 10px;
    color: var(--text-muted);
    letter-spacing: 1px;
    text-transform: uppercase;
}

.donut-container {
    position: relative;
    width: 160px;
    height: 160px;
    margin-bottom: 20px;
}

/* Room Legend */
.room-legend {
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 12px;
    padding: 0 24px 24px;
}
.legend-item {
    display: flex;
    align-items: center;
    gap: 10px;
}
.legend-dot {
    width: 10px; height: 10px;
    border-radius: 50%;
    flex-shrink: 0;
}
.legend-dot.avail { background: #4ade80; }
.legend-dot.occ   { background: var(--teal); }
.legend-dot.maint { background: var(--gold); }
.legend-name  { flex: 1; font-size: 12px; color: var(--text-muted); }
.legend-count { font-size: 14px; font-weight: 600; color: var(--text-primary); }
.legend-pct   { font-size: 11px; color: var(--text-dim); margin-left: 4px; }

/* ════════════════════════════════════════════════════════════════
   ADMIN OTP MODAL
   ════════════════════════════════════════════════════════════════ */
.modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.7);
    backdrop-filter: blur(6px);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.3s ease;
}
.modal-overlay.active { opacity: 1; pointer-events: all; }

.otp-modal {
    position: relative;
    width: 480px;
    background: rgba(10, 20, 40, 0.95);
    border: 1px solid rgba(0,180,216,0.2);
    border-radius: 20px;
    padding: 40px;
    transform: scale(0.95);
    transition: transform 0.3s ease;
    text-align: center;
}
.modal-overlay.active .otp-modal { transform: scale(1); }

.modal-header { margin-bottom: 24px; }
.modal-icon {
    width: 60px; height: 60px;
    background: linear-gradient(135deg, rgba(0,180,216,0.2), rgba(0,100,150,0.1));
    border: 1px solid rgba(0,180,216,0.3);
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 24px; color: var(--teal);
    margin: 0 auto 16px;
}
.modal-header h2 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 22px;
    font-weight: 400;
    color: var(--text-primary);
    margin-bottom: 6px;
}
.modal-header p { font-size: 13px; color: var(--text-muted); }

.otp-info-box {
    display: flex;
    align-items: center;
    gap: 12px;
    background: rgba(0,180,216,0.07);
    border: 1px solid rgba(0,180,216,0.15);
    border-radius: 10px;
    padding: 14px 16px;
    margin-bottom: 28px;
    text-align: left;
    font-size: 13px;
    color: var(--text-muted);
}
.otp-info-box i { color: var(--teal); font-size: 18px; flex-shrink: 0; }
.otp-info-box strong { color: var(--text-primary); }

.otp-input-group {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-bottom: 20px;
}
.otp-box {
    width: 50px; height: 58px;
    background: rgba(255,255,255,0.05);
    border: 1px solid var(--glass-border);
    border-radius: 10px;
    text-align: center;
    font-size: 22px;
    font-weight: 600;
    color: var(--teal);
    caret-color: var(--teal);
    outline: none;
    transition: var(--transition);
}
.otp-box:focus {
    border-color: var(--teal);
    background: rgba(0,180,216,0.08);
    box-shadow: 0 0 0 3px rgba(0,180,216,0.1);
}

.otp-timer {
    font-size: 12px;
    color: var(--text-muted);
    margin-bottom: 28px;
}
.otp-timer i { color: var(--gold); margin-right: 6px; }
#otpCountdown { color: var(--gold); font-weight: 600; }

.modal-actions {
    display: flex;
    gap: 12px;
}
.btn-primary, .btn-secondary {
    flex: 1;
    padding: 13px 20px;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    border: none;
    transition: var(--transition);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}
.btn-primary {
    background: linear-gradient(135deg, var(--teal), #0096b4);
    color: white;
}
.btn-primary:hover { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(0,180,216,0.3); }
.btn-secondary {
    background: rgba(255,255,255,0.05);
    border: 1px solid var(--glass-border);
    color: var(--text-muted);
}
.btn-secondary:hover { background: rgba(255,255,255,0.08); color: var(--text-primary); }

.modal-close {
    position: absolute;
    top: 16px; right: 16px;
    width: 32px; height: 32px;
    background: rgba(255,255,255,0.05);
    border: 1px solid var(--glass-border);
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    color: var(--text-muted);
    cursor: pointer;
    font-size: 12px;
    transition: var(--transition);
}
.modal-close:hover { background: rgba(248,113,113,0.1); color: #f87171; border-color: rgba(248,113,113,0.3); }

/* ── Scrollbar Styling ──────────────────────────────────────── */
.ovr-content::-webkit-scrollbar { width: 4px; }
.ovr-content::-webkit-scrollbar-track { background: transparent; }
.ovr-content::-webkit-scrollbar-thumb { background: rgba(0,180,216,0.2); border-radius: 2px; }

/* ── Responsive ─────────────────────────────────────────────── */
@media (max-width: 1200px) {
    .dashboard-bottom { grid-template-columns: 1fr; }
}
@media (max-width: 900px) {
    .ovr-sidebar { width: 220px; }
    .stats-grid { grid-template-columns: repeat(2, 1fr); }
}
</style>
</head>

<body>
<div class="ovr-layout">

    <%-- ══════════════════════════════════════════════
         SIDEBAR — shared include
         ══════════════════════════════════════════════ --%>
    <%@ include file="/sidebar.jsp" %>

    <%-- ══════════════════════════════════════════════
         MAIN AREA
         ══════════════════════════════════════════════ --%>
    <div class="ovr-main">

        <%-- ── HEADER ─────────────────────────────────── --%>
        <header class="ovr-header">
            <div class="header-left">
                <h1>Welcome back, <span>${loggedInUser}</span></h1>
                <div class="breadcrumb">
                    <i class="fas fa-home"></i>
                    Dashboard &nbsp;/&nbsp; Ocean View Resort
                </div>
            </div>

            <div class="header-right">
                <div class="live-clock">
                    <div class="clock-time" id="clockTime">--:--:--</div>
                    <div class="clock-date" id="clockDate">Loading...</div>
                </div>

                <a href="${pageContext.request.contextPath}/notifications"
                   class="notif-btn" title="Notifications">
                    <i class="fas fa-bell"></i>
                    <c:if test="${stats.unreadNotifications > 0}">
                        <span class="notif-dot"></span>
                    </c:if>
                </a>

                <div class="user-chip">
                    <div class="user-chip-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div>
                        <span class="user-chip-name">${loggedInUser}</span>
                        <span class="user-chip-role">Receptionist</span>
                    </div>
                </div>
            </div>
        </header>

        <%-- ── SCROLLABLE CONTENT ─────────────────────── --%>
        <div class="ovr-content">

            <%-- ════════════════════════════════════════
                 SECTION B — STATISTICS CARDS
                 ════════════════════════════════════════ --%>
            <div class="stats-grid">

                <%-- Card 1 : Total Rooms --%>
                <div class="stat-card teal">
                    <div class="card-icon-wrap"><i class="fas fa-hotel"></i></div>
                    <div class="card-label">Total Rooms</div>
                    <div class="card-value">${stats.totalRooms}</div>
                    <div class="card-sub">All room inventory</div>
                </div>

                <%-- Card 2 : Available Rooms --%>
                <div class="stat-card green">
                    <div class="card-icon-wrap"><i class="fas fa-door-open"></i></div>
                    <div class="card-label">Available</div>
                    <div class="card-value">${stats.availableRooms}</div>
                    <div class="card-sub">Ready for booking</div>
                </div>

                <%-- Card 3 : Occupied Rooms --%>
                <div class="stat-card blue">
                    <div class="card-icon-wrap"><i class="fas fa-bed"></i></div>
                    <div class="card-label">Occupied</div>
                    <div class="card-value">${stats.occupiedRooms}</div>
                    <div class="card-sub">Currently checked in</div>
                </div>

                <%-- Card 4 : Occupancy Rate — with visual bar --%>
                <div class="stat-card ${stats.occupancyStatus == 'HIGH' ? 'red' : stats.occupancyStatus == 'MODERATE' ? 'orange' : 'green'}">
                    <div class="card-icon-wrap"><i class="fas fa-percent"></i></div>
                    <div class="card-label">Occupancy Rate</div>
                    <div class="card-value">${stats.occupancyRateFormatted}</div>
                    <div class="occupancy-bar">
                        <div class="occupancy-fill fill-${stats.occupancyStatus}"
                             id="occupancyFill"
                             style="width: 0%"></div>
                    </div>
                </div>

                <%-- Card 5 : Today's Revenue --%>
                <div class="stat-card gold">
                    <div class="card-icon-wrap"><i class="fas fa-coins"></i></div>
                    <div class="card-label">Today's Revenue</div>
                    <div class="card-value">${stats.todayRevenueFormatted}</div>
                    <div class="card-sub">From today's check-ins</div>
                </div>

                <%-- Card 6 : Today Check-ins --%>
                <div class="stat-card purple">
                    <div class="card-icon-wrap"><i class="fas fa-sign-in-alt"></i></div>
                    <div class="card-label">Today Check-ins</div>
                    <div class="card-value">${stats.todayCheckIns}</div>
                    <div class="card-sub">Arrivals today</div>
                </div>

                <%-- Card 7 : Today Check-outs --%>
                <div class="stat-card orange">
                    <div class="card-icon-wrap"><i class="fas fa-sign-out-alt"></i></div>
                    <div class="card-label">Today Check-outs</div>
                    <div class="card-value">${stats.todayCheckOuts}</div>
                    <div class="card-sub">Departures today</div>
                </div>

            </div>
            <%-- / stats-grid --%>

            <%-- ════════════════════════════════════════
                 SECTION C — Recent Reservations + Room Status
                 ════════════════════════════════════════ --%>
            <div class="dashboard-bottom">

                <%-- ── Recent Reservations Table ──────── --%>
                <div class="glass-panel">
                    <div class="panel-header">
                        <span class="panel-title">
                            <i class="fas fa-list-alt"></i>Recent Reservations
                        </span>
                        <a href="${pageContext.request.contextPath}/reservations"
                           class="panel-action">View All →</a>
                    </div>

                    <c:choose>
                        <c:when test="${not empty recentReservations}">
                            <table class="res-table">
                                <thead>
                                    <tr>
                                        <th>Reservation #</th>
                                        <th>Guest</th>
                                        <th>Room Type</th>
                                        <th>Check-in</th>
                                        <th>Check-out</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="res" items="${recentReservations}">
                                        <tr>
                                            <td><span class="res-number">${res.reservationNumber}</span></td>
                                            <td><span class="guest-name">${res.guestName}</span></td>
                                            <td><span class="room-type-badge">${res.roomType}</span></td>
                                            <td>${res.checkIn}</td>
                                            <td>${res.checkOut}</td>
                                            <td>
                                                <span class="status-badge status-${res.status}">
                                                    ${res.status.replace('_', ' ')}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-calendar-times"></i>
                                <p>No reservations yet.<br>Start by adding your first guest!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- ── Room Status Donut Chart ─────────── --%>
                <div class="glass-panel room-status-panel">
                    <div class="panel-header">
                        <span class="panel-title">
                            <i class="fas fa-chart-pie"></i>Room Status
                        </span>
                    </div>

                    <div class="room-donut-wrap">
                        <div class="donut-container">
                            <svg class="donut-svg" viewBox="0 0 100 100">
                                <circle class="donut-bg"  cx="50" cy="50" r="35" />
                                <circle class="donut-avail" cx="50" cy="50" r="35"
                                        id="donutAvail"
                                        stroke-dasharray="0 220" />
                                <circle class="donut-occ" cx="50" cy="50" r="35"
                                        id="donutOcc"
                                        stroke-dasharray="0 220" />
                                <circle class="donut-maint" cx="50" cy="50" r="35"
                                        id="donutMaint"
                                        stroke-dasharray="0 220" />
                            </svg>
                            <div class="donut-center">
                                <span class="donut-value">${stats.totalRooms}</span>
                                <span class="donut-label">Total</span>
                            </div>
                        </div>
                    </div>

                    <div class="room-legend">
                        <div class="legend-item">
                            <div class="legend-dot avail"></div>
                            <span class="legend-name">Available</span>
                            <span class="legend-count">${stats.availableRooms}</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-dot occ"></div>
                            <span class="legend-name">Occupied</span>
                            <span class="legend-count">${stats.occupiedRooms}</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-dot maint"></div>
                            <span class="legend-name">Maintenance</span>
                            <span class="legend-count">${stats.maintenanceRooms}</span>
                        </div>
                    </div>
                </div>
                <%-- / room-status-panel --%>

            </div>
            <%-- / dashboard-bottom --%>

        </div>
        <%-- / ovr-content --%>

    </div>
    <%-- / ovr-main --%>

</div>
<%-- / ovr-layout --%>

<%-- ═══════════════════════════════════════════════════════
     JAVASCRIPT — Clock, Donut Chart, Occupancy Bar
 ═══════════════════════════════════════════════════════ --%>
<script>
// ── Constants from JSP (server data passed to JS) ────────────
const TOTAL_ROOMS   = parseInt('${stats.totalRooms}')   || 0;
const AVAIL_ROOMS   = parseInt('${stats.availableRooms}')|| 0;
const OCC_ROOMS     = parseInt('${stats.occupiedRooms}') || 0;
const MAINT_ROOMS   = parseInt('${stats.maintenanceRooms}')|| 0;
const OCCUPANCY_PCT = parseFloat('${stats.occupancyRate}') || 0;

// ════════════════════════════════════════════════════════
//  LIVE CLOCK
// ════════════════════════════════════════════════════════
function updateClock() {
    const now    = new Date();
    const days   = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

    const h = String(now.getHours()).padStart(2,'0');
    const m = String(now.getMinutes()).padStart(2,'0');
    const s = String(now.getSeconds()).padStart(2,'0');

    document.getElementById('clockTime').textContent = h + ':' + m + ':' + s;
    document.getElementById('clockDate').textContent =
        days[now.getDay()] + ', ' + months[now.getMonth()] + ' ' +
        now.getDate() + ' ' + now.getFullYear();
}
updateClock();
setInterval(updateClock, 1000);

// ════════════════════════════════════════════════════════
//  SVG DONUT CHART
//  Circumference of circle r=35 → 2π×35 ≈ 219.9
// ════════════════════════════════════════════════════════
const CIRC = 2 * Math.PI * 35;   // ≈ 219.9

function buildDonut() {
    if (TOTAL_ROOMS === 0) return;

    const availArc = (AVAIL_ROOMS / TOTAL_ROOMS) * CIRC;
    const occArc   = (OCC_ROOMS   / TOTAL_ROOMS) * CIRC;
    const maintArc = (MAINT_ROOMS / TOTAL_ROOMS) * CIRC;

    // Each arc starts where the previous ended (using stroke-dashoffset)
    const donutAvail = document.getElementById('donutAvail');
    const donutOcc   = document.getElementById('donutOcc');
    const donutMaint = document.getElementById('donutMaint');

    // Slight delay for animation effect
    setTimeout(() => {
        donutAvail.style.strokeDasharray  = availArc + ' ' + CIRC;
        donutAvail.style.strokeDashoffset = 0;

        donutOcc.style.strokeDasharray  = occArc + ' ' + CIRC;
        donutOcc.style.strokeDashoffset = -availArc;

        donutMaint.style.strokeDasharray  = maintArc + ' ' + CIRC;
        donutMaint.style.strokeDashoffset = -(availArc + occArc);
    }, 400);
}
buildDonut();

// ════════════════════════════════════════════════════════
//  OCCUPANCY BAR — Animated fill on load
// ════════════════════════════════════════════════════════
setTimeout(() => {
    const fill = document.getElementById('occupancyFill');
    if (fill) fill.style.width = Math.min(OCCUPANCY_PCT, 100) + '%';
}, 600);

</script>

</body>
</html>
