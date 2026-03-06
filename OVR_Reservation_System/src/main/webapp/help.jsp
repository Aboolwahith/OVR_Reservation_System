<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OVR — Help & AI Assistant</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
:root{--primary:#00818A;--accent:#20ADAD;--sidebar:#2C3E50;--bg:#F4F7F6;--card:#FFFFFF;--success:#27AE60;--warning:#F39C12;--danger:#E74C3C;--text-dark:#1a252f;--text-muted:#7f8c8d;--border:#e8eeed;--shadow:0 2px 16px rgba(0,129,138,.10);--shadow-lg:0 8px 32px rgba(0,129,138,.18);--shadow-xl:0 20px 60px rgba(0,0,0,.22);}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--text-dark);display:flex;min-height:100vh;}

/* SIDEBAR */
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

/* MAIN */
.main-wrapper{margin-left:260px;display:flex;flex-direction:column;flex:1;min-width:0;}
.topbar{background:var(--card);border-bottom:1px solid var(--border);padding:0 32px;height:64px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:50;box-shadow:0 1px 8px rgba(0,0,0,.06);}
.topbar-left h1{font-family:'Playfair Display',serif;font-size:1.3rem;color:var(--text-dark);font-weight:700;}
.topbar-left p{font-size:.8rem;color:var(--text-muted);margin-top:1px;}
.breadcrumb{font-size:.8rem;color:var(--text-muted);display:flex;align-items:center;gap:6px;}
.breadcrumb a{color:var(--primary);text-decoration:none;}
.page-content{padding:32px;flex:1;}

/* HERO */
.help-hero{background:linear-gradient(135deg,var(--sidebar) 0%,var(--primary) 60%,var(--accent) 100%);border-radius:20px;padding:38px 36px;color:#fff;display:flex;align-items:center;gap:28px;position:relative;overflow:hidden;margin-bottom:24px;}
.help-hero::before{content:'';position:absolute;right:-40px;top:-40px;width:200px;height:200px;border-radius:50%;background:rgba(255,255,255,.05);}
.hero-icon{width:80px;height:80px;background:rgba(255,255,255,.15);border:2px solid rgba(255,255,255,.25);border-radius:20px;display:flex;align-items:center;justify-content:center;font-size:2.5rem;flex-shrink:0;animation:heroFloat 3s ease-in-out infinite;}
@keyframes heroFloat{0%,100%{transform:translateY(0);}50%{transform:translateY(-8px);}}
.hero-text h2{font-family:'Playfair Display',serif;font-size:1.55rem;font-weight:700;margin-bottom:6px;}
.hero-text p{font-size:.88rem;color:rgba(255,255,255,.7);line-height:1.6;}
.hero-badge{margin-left:auto;flex-shrink:0;background:rgba(255,255,255,.12);border:1px solid rgba(255,255,255,.2);border-radius:12px;padding:14px 20px;text-align:center;}
.hero-badge .badge-icon{font-size:1.8rem;margin-bottom:4px;}
.hero-badge .badge-text{font-size:.72rem;color:rgba(255,255,255,.65);letter-spacing:.4px;line-height:1.4;}

/* TOPIC CARDS GRID */
.topics-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:24px;}
.topic-card{background:var(--card);border-radius:14px;padding:20px 14px;display:flex;flex-direction:column;align-items:center;gap:8px;cursor:pointer;border:2px solid transparent;box-shadow:var(--shadow);transition:all .25s;text-align:center;}
.topic-card:hover{border-color:var(--primary);transform:translateY(-4px);box-shadow:var(--shadow-lg);}
.topic-card:hover .t-card-icon{transform:scale(1.15);}
.t-card-icon{font-size:1.9rem;transition:transform .2s;}
.t-card-label{font-size:.82rem;font-weight:600;color:var(--text-dark);}
.t-card-desc{font-size:.72rem;color:var(--text-muted);}

/* ROOM TABLE */
.section-card{background:var(--card);border-radius:16px;padding:22px 26px;box-shadow:var(--shadow);}
.section-title{font-family:'Playfair Display',serif;font-size:1rem;color:var(--text-dark);margin-bottom:14px;display:flex;align-items:center;gap:8px;}
.room-table{width:100%;border-collapse:collapse;}
.room-table th{background:linear-gradient(135deg,var(--sidebar),var(--primary));color:#fff;padding:11px 16px;font-size:.8rem;text-align:left;font-weight:600;}
.room-table td{padding:10px 16px;font-size:.85rem;border-bottom:1px solid var(--border);}
.room-table tr:last-child td{border-bottom:none;}
.room-table tr:hover td{background:#f7fafa;}
.price-tag{background:#e0f5f5;color:var(--primary);padding:3px 10px;border-radius:20px;font-weight:600;font-size:.8rem;}

/* ══════════════════════════════════════════
   FLOATING ROBOT LAUNCHER
══════════════════════════════════════════ */
.robot-launcher{position:fixed;bottom:28px;right:28px;z-index:9999;display:flex;flex-direction:column;align-items:center;gap:6px;cursor:pointer;}
.robot-btn{width:70px;height:70px;background:linear-gradient(135deg,var(--primary),var(--accent));border-radius:50%;border:none;display:flex;align-items:center;justify-content:center;box-shadow:0 6px 28px rgba(0,129,138,.5);cursor:pointer;transition:transform .2s,box-shadow .2s;position:relative;}
.robot-btn:hover{transform:scale(1.1);box-shadow:0 10px 36px rgba(0,129,138,.6);}
.robot-btn.open{background:linear-gradient(135deg,#c0392b,var(--danger));}
.robot-svg{width:38px;height:38px;}
.robot-ping{position:absolute;top:-3px;right:-3px;width:18px;height:18px;}
.robot-ping::before{content:'';position:absolute;inset:0;border-radius:50%;background:var(--success);animation:pingOut 1.8s ease-out infinite;}
.robot-ping::after{content:'';position:absolute;inset:3px;border-radius:50%;background:var(--success);}
@keyframes pingOut{0%{transform:scale(1);opacity:1;}70%{transform:scale(2.3);opacity:0;}100%{transform:scale(2.3);opacity:0;}}
.notif-badge{position:absolute;top:-5px;left:-5px;width:22px;height:22px;border-radius:50%;background:var(--danger);color:#fff;font-size:.7rem;font-weight:700;display:none;align-items:center;justify-content:center;border:2px solid #fff;}
.robot-label{font-size:.73rem;font-weight:700;color:var(--primary);background:#fff;padding:4px 12px;border-radius:20px;box-shadow:0 2px 10px rgba(0,0,0,.12);white-space:nowrap;animation:labelBob 2.5s ease-in-out infinite;}
@keyframes labelBob{0%,100%{transform:translateY(0);}50%{transform:translateY(-4px);}}

/* ══════════════════════════════════════════
   CHAT WINDOW
══════════════════════════════════════════ */
.chat-window{position:fixed;bottom:118px;right:28px;width:370px;background:var(--card);border-radius:20px;box-shadow:var(--shadow-xl);z-index:9998;display:flex;flex-direction:column;overflow:hidden;transform:scale(0) translateY(20px);transform-origin:bottom right;opacity:0;transition:transform .35s cubic-bezier(.34,1.56,.64,1),opacity .25s;max-height:570px;}
.chat-window.open{transform:scale(1) translateY(0);opacity:1;}

/* Chat header */
.chat-header{background:linear-gradient(135deg,var(--sidebar),var(--primary));padding:15px 18px;display:flex;align-items:center;gap:12px;}
.chat-av{width:44px;height:44px;background:rgba(255,255,255,.15);border:2px solid rgba(255,255,255,.3);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.3rem;flex-shrink:0;position:relative;}
.status-dot{width:11px;height:11px;background:#2ecc71;border:2px solid #fff;border-radius:50%;position:absolute;bottom:1px;right:1px;animation:blink 2s infinite;}
@keyframes blink{0%,100%{opacity:1;}50%{opacity:.4;}}
.chat-header-info{flex:1;}
.chat-header-info h3{font-size:.95rem;font-weight:700;color:#fff;}
.chat-header-info p{font-size:.72rem;color:rgba(255,255,255,.6);margin-top:1px;}
.btn-close{background:rgba(255,255,255,.15);border:none;color:#fff;width:30px;height:30px;border-radius:50%;font-size:.95rem;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:background .2s;flex-shrink:0;}
.btn-close:hover{background:rgba(255,255,255,.28);}

/* Greeting strip */
.greet-strip{background:linear-gradient(135deg,#e0f5f5,#f0fafa);border-bottom:1px solid #cde8e8;padding:10px 15px;font-size:.82rem;color:var(--primary);font-weight:500;display:flex;align-items:center;gap:7px;}

/* Messages */
.chat-msgs{flex:1;overflow-y:auto;padding:14px;display:flex;flex-direction:column;gap:10px;min-height:180px;max-height:270px;scroll-behavior:smooth;}
.chat-msgs::-webkit-scrollbar{width:3px;}
.chat-msgs::-webkit-scrollbar-thumb{background:#cde4e5;border-radius:10px;}

.cmsg{display:flex;gap:8px;animation:msgIn .3s ease;}
@keyframes msgIn{from{opacity:0;transform:translateY(8px);}to{opacity:1;transform:translateY(0);}}
.cmsg.umsg{flex-direction:row-reverse;}
.cmsg-av{width:28px;height:28px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:.8rem;font-weight:700;flex-shrink:0;}
.cmsg.bmsg .cmsg-av{background:linear-gradient(135deg,var(--primary),var(--accent));color:#fff;}
.cmsg.umsg .cmsg-av{background:linear-gradient(135deg,var(--sidebar),#3d5a73);color:#fff;}
.cmsg-body{max-width:84%;display:block;}
.cmsg-bubble{display:block;padding:9px 13px;font-size:.83rem;line-height:1.6;border-radius:14px;word-break:break-word;}
.bmsg .cmsg-bubble{background:#f0fafa !important;border:1px solid #cde8e8;border-top-left-radius:4px;color:#1a252f !important;}
.umsg .cmsg-bubble{background:linear-gradient(135deg,#00818A,#20ADAD) !important;color:#ffffff !important;border-top-right-radius:4px;}
.cmsg-bubble strong{font-weight:700;color:inherit;}
.cmsg-bubble ol{padding-left:18px;margin-top:7px;}
.cmsg-bubble ol li{margin-bottom:5px;font-size:.81rem;color:inherit;}
.cmsg-bubble em{font-style:italic;opacity:.85;}
.cmsg-time{font-size:.66rem;color:#7f8c8d;margin-top:4px;padding:0 3px;display:block;}
.umsg .cmsg-time{text-align:right;}

/* Typing */
.typing-row{display:none;}
.typing-row.show{display:flex;}
.typing-dots{display:flex;align-items:center;gap:4px;padding:10px 13px;background:#f0fafa;border:1px solid #cde8e8;border-radius:14px;border-top-left-radius:4px;}
.typing-dots span{width:6px;height:6px;background:var(--primary);border-radius:50%;animation:tBounce .9s infinite;}
.typing-dots span:nth-child(2){animation-delay:.2s;}
.typing-dots span:nth-child(3){animation-delay:.4s;}
@keyframes tBounce{0%,60%,100%{transform:translateY(0);}30%{transform:translateY(-6px);}}

/* Topic buttons */
.topic-btns-panel{padding:10px 12px;border-top:1px solid var(--border);display:flex;flex-direction:column;gap:5px;max-height:200px;overflow-y:auto;}
.topic-btns-panel::-webkit-scrollbar{width:3px;}
.topic-btns-panel::-webkit-scrollbar-thumb{background:#cde4e5;border-radius:10px;}
.panel-label{font-size:.68rem;font-weight:600;color:var(--text-muted);text-transform:uppercase;letter-spacing:.8px;margin-bottom:3px;}
.tbtn{width:100%;padding:8px 13px;background:#f8fafa;border:1.5px solid #cde4e5;border-radius:9px;text-align:left;font-size:.83rem;font-family:'DM Sans',sans-serif;font-weight:500;color:var(--text-dark);cursor:pointer;transition:all .2s;display:flex;align-items:center;gap:8px;}
.tbtn:hover{background:var(--primary);color:#fff;border-color:var(--primary);transform:translateX(3px);}
.tbtn .ti{font-size:.95rem;flex-shrink:0;}
</style>
</head>
<body>

<!-- SIDEBAR -->
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
    <a href="${pageContext.request.contextPath}/view-reservation" class="nav-item"><span class="nav-icon">🔍</span> View Reservation</a>
    <a href="${pageContext.request.contextPath}/bill"             class="nav-item"><span class="nav-icon">🧾</span> Billing</a>
    <div class="nav-section-label" style="margin-top:8px;">Support</div>
    <a href="${pageContext.request.contextPath}/help"             class="nav-item active"><span class="nav-icon">❓</span> Help & Guide</a>
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

<!-- MAIN -->
<div class="main-wrapper">
  <header class="topbar">
    <div class="topbar-left">
      <h1>Help & AI Assistant</h1>
      <p>Click the floating robot at the bottom-right to chat with OVR Assistant</p>
    </div>
    <div class="breadcrumb"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a> › Help & Guide</div>
  </header>

  <main class="page-content">

    <!-- HERO -->
    <div class="help-hero">
      <div class="hero-icon">🤖</div>
      <div class="hero-text">
        <h2>Meet OVR Assistant</h2>
        <p>Your intelligent guide to the Ocean View Resort system.<br>
        Click the <strong>floating robot button</strong> at the bottom-right to start a conversation, or click any topic card below!</p>
      </div>
      <div class="hero-badge">
        <div class="badge-icon">💬</div>
        <div class="badge-text">AI POWERED<br>GUIDE</div>
      </div>
    </div>

    <!-- TOPIC CARDS -->
    <div class="topics-grid">
      <div class="topic-card" onclick="openAndAsk('login')">
        <div class="t-card-icon">🔐</div>
        <div class="t-card-label">Login & Security</div>
        <div class="t-card-desc">Authentication guide</div>
      </div>
      <div class="topic-card" onclick="openAndAsk('add')">
        <div class="t-card-icon">➕</div>
        <div class="t-card-label">Add Reservation</div>
        <div class="t-card-desc">Step-by-step booking</div>
      </div>
      <div class="topic-card" onclick="openAndAsk('view')">
        <div class="t-card-icon">🔍</div>
        <div class="t-card-label">View Reservation</div>
        <div class="t-card-desc">Search & retrieve</div>
      </div>
      <div class="topic-card" onclick="openAndAsk('bill')">
        <div class="t-card-icon">🧾</div>
        <div class="t-card-label">Billing Guide</div>
        <div class="t-card-desc">Calculate & print bill</div>
      </div>
      <div class="topic-card" onclick="openAndAsk('dashboard')">
        <div class="t-card-icon">📊</div>
        <div class="t-card-label">Dashboard Guide</div>
        <div class="t-card-desc">Stats & overview</div>
      </div>
      <div class="topic-card" onclick="openAndAsk('validation')">
        <div class="t-card-icon">⚠️</div>
        <div class="t-card-label">Validation Rules</div>
        <div class="t-card-desc">Input requirements</div>
      </div>
      <div class="topic-card" onclick="openAndAsk('troubleshoot')">
        <div class="t-card-icon">🛠️</div>
        <div class="t-card-label">Troubleshooting</div>
        <div class="t-card-desc">Fix common issues</div>
      </div>
      <div class="topic-card" onclick="openAndAsk('contact')">
        <div class="t-card-icon">📞</div>
        <div class="t-card-label">Contact Developer</div>
        <div class="t-card-desc">System information</div>
      </div>
    </div>

    <!-- ROOM REFERENCE TABLE -->
    <div class="section-card">
      <div class="section-title">🏨 Room Types & Rates Quick Reference</div>
      <table class="room-table">
        <thead><tr><th>Code</th><th>Room Type</th><th>Rate / Night</th><th>Description</th></tr></thead>
        <tbody>
          <tr><td>OVR_001</td><td><strong>STANDARD</strong></td><td><span class="price-tag">Rs. 8,000</span></td><td>Garden view · Solo or couples</td></tr>
          <tr><td>OVR_002</td><td><strong>DELUXE</strong></td><td><span class="price-tag">Rs. 12,000</span></td><td>Partial ocean view · Premium amenities</td></tr>
          <tr><td>OVR_003</td><td><strong>SUITE</strong></td><td><span class="price-tag">Rs. 18,000</span></td><td>Full ocean view · Luxury living area</td></tr>
        </tbody>
      </table>
    </div>

  </main>
</div>

<!-- FLOATING ROBOT -->
<div class="robot-launcher" onclick="toggleChat()">
  <button class="robot-btn" id="robotBtn">
    <svg class="robot-svg" viewBox="0 0 38 38" fill="none" xmlns="http://www.w3.org/2000/svg">
      <line x1="19" y1="4" x2="19" y2="9" stroke="white" stroke-width="2" stroke-linecap="round"/>
      <circle cx="19" cy="3" r="2" fill="white">
        <animate attributeName="r" values="2;3;2" dur="1.2s" repeatCount="indefinite"/>
        <animate attributeName="opacity" values="1;0.4;1" dur="1.2s" repeatCount="indefinite"/>
      </circle>
      <rect x="8" y="9" width="22" height="15" rx="4" fill="white" opacity="0.95"/>
      <ellipse cx="14" cy="16" rx="2.8" ry="2.8" fill="#00818A">
        <animate attributeName="ry" values="2.8;0.3;2.8" dur="3.5s" repeatCount="indefinite"/>
      </ellipse>
      <ellipse cx="24" cy="16" rx="2.8" ry="2.8" fill="#00818A">
        <animate attributeName="ry" values="2.8;0.3;2.8" dur="3.5s" begin="0.15s" repeatCount="indefinite"/>
      </ellipse>
      <path d="M14 21.5 Q19 24.5 24 21.5" stroke="#00818A" stroke-width="1.8" stroke-linecap="round" fill="none">
        <animate attributeName="d" values="M14 21.5 Q19 24.5 24 21.5;M14 21.5 Q19 22.5 24 21.5;M14 21.5 Q19 24.5 24 21.5" dur="2s" repeatCount="indefinite"/>
      </path>
      <rect x="11" y="25" width="16" height="11" rx="3" fill="white" opacity="0.88"/>
      <circle cx="16" cy="30.5" r="1.6" fill="#20ADAD"><animate attributeName="opacity" values="1;0.2;1" dur="1s" repeatCount="indefinite"/></circle>
      <circle cx="19" cy="30.5" r="1.6" fill="#27AE60"><animate attributeName="opacity" values="1;0.2;1" dur="1s" begin="0.33s" repeatCount="indefinite"/></circle>
      <circle cx="22" cy="30.5" r="1.6" fill="#F39C12"><animate attributeName="opacity" values="1;0.2;1" dur="1s" begin="0.66s" repeatCount="indefinite"/></circle>
    </svg>
    <div class="notif-badge" id="notifBadge">1</div>
    <div class="robot-ping"></div>
  </button>
  <span class="robot-label">OVR Assistant</span>
</div>

<!-- CHAT WINDOW -->
<div class="chat-window" id="chatWindow">
  <div class="chat-header">
    <div class="chat-av">🤖<div class="status-dot"></div></div>
    <div class="chat-header-info">
      <h3>OVR Assistant</h3>
      <p id="hStatus">Online · Ready to help</p>
    </div>
    <button class="btn-close" onclick="toggleChat()">✕</button>
  </div>
  <div class="greet-strip" id="greetStrip">👋 Welcome! Select a topic to get started.</div>
  <div class="chat-msgs" id="chatMsgs">
    <div class="typing-row" id="typingRow">
      <div class="cmsg-av" style="background:linear-gradient(135deg,var(--primary),var(--accent));color:#fff;width:28px;height:28px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:.8rem;">🤖</div>
      <div class="typing-dots"><span></span><span></span><span></span></div>
    </div>
  </div>
  <div class="topic-btns-panel">
    <div class="panel-label">Choose a topic:</div>
    <button class="tbtn" onclick="askTopic('login')"><span class="ti">🔐</span> Login Help</button>
    <button class="tbtn" onclick="askTopic('add')"><span class="ti">➕</span> Add Reservation</button>
    <button class="tbtn" onclick="askTopic('view')"><span class="ti">🔍</span> View Reservation</button>
    <button class="tbtn" onclick="askTopic('bill')"><span class="ti">🧾</span> Billing Guide</button>
    <button class="tbtn" onclick="askTopic('dashboard')"><span class="ti">📊</span> Dashboard Guide</button>
    <button class="tbtn" onclick="askTopic('validation')"><span class="ti">⚠️</span> Validation Rules</button>
    <button class="tbtn" onclick="askTopic('troubleshoot')"><span class="ti">🛠️</span> Troubleshooting</button>
    <button class="tbtn" onclick="askTopic('contact')"><span class="ti">📞</span> Contact Developer</button>
  </div>
</div>

<script>
const USERNAME = '${sessionScope.username}' || 'Receptionist';

const KB = {
  login:{label:"Login & Security",answer:`Here is everything about <strong>Login & Security:</strong><br><br><ol><li>Use your assigned <strong>username and password</strong> at the login page</li><li>Only <strong>RECEPTIONIST</strong> role accounts can access this system</li><li>Passwords use <strong>SHA-256 encryption</strong> — never stored in plain text</li><li>Use <strong>Forgot Password</strong> to receive a one-time OTP to your email</li><li>OTP codes expire in <strong>5 minutes</strong> — request a new one if needed</li><li>Always click <strong>Sign Out</strong> when leaving your workstation</li><li>Never share your credentials with anyone</li></ol><br>💡 <em>Tip: Check CapsLock if login fails!</em>`},
  add:{label:"Add Reservation",answer:`Steps to <strong>Add a New Reservation:</strong><br><br><ol><li>Click <strong>Add Reservation</strong> in the sidebar</li><li>Enter guest's <strong>full name</strong> as on their ID</li><li>Enter <strong>address</strong> and <strong>10-digit contact number</strong></li><li>Select <strong>room type</strong> — price appears automatically</li><li>Set <strong>Check-In date</strong> (today or future only)</li><li>Check-Out unlocks <strong>only after</strong> Check-In is selected</li><li>Live <strong>nights calculator</strong> shows estimated total cost</li><li>Click <strong>Save</strong> — unique reservation number is auto-generated!</li></ol><br>💡 <em>Tip: The reservation number is auto-generated — no need to type it!</em>`},
  view:{label:"View Reservation",answer:`How to <strong>View a Reservation:</strong><br><br><ol><li>Click <strong>View Reservation</strong> in the sidebar</li><li><strong>Tab 1:</strong> Type Number — enter reservation number manually</li><li><strong>Tab 2:</strong> Select from List — dropdown of all bookings</li><li>Dropdown shows reservation number, guest name, dates</li><li>Selecting from list <strong>instantly loads</strong> that reservation</li><li>Results show all guest info, room type, dates, booking time</li><li>Click <strong>Generate Bill</strong> directly from results page</li></ol><br>💡 <em>Tip: Click any row in the table to view full details!</em>`},
  bill:{label:"Billing Guide",answer:`How to <strong>Generate a Bill:</strong><br><br><ol><li>Go to <strong>Billing</strong> in sidebar or click 'Generate Bill' from reservation</li><li>Enter reservation number if prompted</li><li>Formula: <strong>Total = Nights × Room Rate per Night</strong></li><li>Example: 3 nights × Rs.12,000 = <strong>Rs.36,000</strong></li><li>Minimum charge is always <strong>1 night</strong></li><li>Invoice shows: guest info, room, duration, total amount due</li><li>Click <strong>Print Invoice</strong> — sidebar hides automatically when printing</li></ol><br>💡 <em>Tip: The invoice is computer-generated — no signature required!</em>`},
  dashboard:{label:"Dashboard Guide",answer:`What the <strong>Dashboard Shows:</strong><br><br><ol><li>📋 <strong>Total Reservations</strong> — all bookings ever made</li><li>🏨 <strong>Today's Check-Ins</strong> — guests arriving today</li><li>🚪 <strong>Today's Check-Outs</strong> — guests departing today</li><li>💰 <strong>Today's Revenue</strong> — income from today's departures</li><li>Quick Action cards for fast one-click navigation</li><li>Welcome banner shows current username and total bookings</li><li>All data refreshes on every page load from the live database</li></ol><br>💡 <em>Tip: Revenue shows Rs.0 if no check-outs today — that is normal!</em>`},
  validation:{label:"Validation Rules",answer:`<strong>Validation Rules</strong> to follow:<br><br><ol><li>📱 Contact: exactly <strong>10 digits</strong>, no spaces (e.g. 0771234567)</li><li>📅 Check-In: <strong>today or future only</strong> — past dates are blocked</li><li>📅 Check-Out: must be <strong>at least 1 day after Check-In</strong></li><li>Check-Out field is <strong>disabled</strong> until Check-In is chosen</li><li>All fields are <strong>mandatory</strong> — nothing can be left empty</li><li>Duplicate reservations for same guest and dates are <strong>blocked</strong></li><li>Red error messages appear <strong>instantly</strong> below invalid fields</li></ol><br>💡 <em>Tip: The nights calculator appears automatically when both dates are valid!</em>`},
  troubleshoot:{label:"Troubleshooting",answer:`Common <strong>Issues and Solutions:</strong><br><br><ol><li>❌ <strong>Login fails</strong> → Check CapsLock, verify username, use Forgot Password</li><li>❌ <strong>404 Not Found</strong> → Right-click project → Run As → Run on Server</li><li>❌ <strong>Contact error</strong> → Must be exactly 10 digits, no spaces or dashes</li><li>❌ <strong>Check-out disabled</strong> → You must select check-in date first</li><li>❌ <strong>Reservation not found</strong> → Check exact number spelling carefully</li><li>❌ <strong>Database error</strong> → Ensure XAMPP MySQL is running</li><li>❌ <strong>Page not loading</strong> → Restart Tomcat from Eclipse Servers tab</li></ol><br>💡 <em>Tip: Always start XAMPP MySQL before launching Tomcat!</em>`},
  contact:{label:"Contact Developer",answer:`<strong>System Information:</strong><br><br><ol><li>🏗️ System: <strong>Ocean View Resort Reservation System v1.0</strong></li><li>⚙️ Built with: Java EE · Jakarta Servlet · JSP · MySQL</li><li>🖥️ Server: Apache Tomcat 11 · XAMPP MariaDB</li><li>🏛️ Architecture: MVC · DAO Pattern · Service Layer · Singleton</li><li>🧪 Testing: JUnit 5 · Test-Driven Development</li><li>📧 Module: CIS6003 Advanced Programming</li><li>🎓 Institution: Cardiff Metropolitan University / ICBT Campus</li></ol><br>💡 <em>For urgent issues, contact your system administrator or module leader.</em>`}
};

let isOpen=false, welcomed=false;

function toggleChat(){
  isOpen=!isOpen;
  document.getElementById('chatWindow').classList.toggle('open',isOpen);
  document.getElementById('robotBtn').classList.toggle('open',isOpen);
  document.getElementById('notifBadge').style.display='none';
  if(isOpen && !welcomed){ welcomed=true; setTimeout(sendWelcome,400); }
}

function openAndAsk(k){
  if(!isOpen){isOpen=true;document.getElementById('chatWindow').classList.add('open');document.getElementById('robotBtn').classList.add('open');document.getElementById('notifBadge').style.display='none';}
  if(!welcomed){welcomed=true;setTimeout(()=>{sendWelcome();setTimeout(()=>askTopic(k),1800);},400);}
  else{setTimeout(()=>askTopic(k),200);}
}

function sendWelcome(){
  const h=new Date().getHours();
  const n=USERNAME.charAt(0).toUpperCase()+USERNAME.slice(1);
  let g,icon;
  if(h>=5&&h<12){g=`Good Morning, <strong>${n}!</strong> ☀️`;icon='☀️';}
  else if(h>=12&&h<17){g=`Good Afternoon, <strong>${n}!</strong> 🌤️`;icon='🌤️';}
  else if(h>=17&&h<20){g=`Good Evening, <strong>${n}!</strong> 🌅`;icon='🌅';}
  else{g=`Good Night, <strong>${n}!</strong> 🌙`;icon='🌙';}
  document.getElementById('greetStrip').innerHTML=icon+' '+g.replace(/<[^>]+>/g,'').replace('!','')+' — How can I help you today?';
  addBot(`${g}<br>Welcome to the <strong>Ocean View Resort Assistant</strong>! 🌊<br>I'm here to guide you through the reservation system. Select a topic from the buttons below to get started!`,false);
}

function askTopic(k){
  const d=KB[k]; if(!d)return;
  addUser(d.label);
  showTyping();
  setTimeout(()=>{hideTyping();addBot(d.answer,true);},1300);
}

function addUser(txt){
  const ini = USERNAME.charAt(0).toUpperCase();
  const t = getTime();
  const div = document.createElement('div');
  div.style.cssText = 'display:flex;flex-direction:row-reverse;gap:8px;align-items:flex-start;animation:msgIn .3s ease;margin-bottom:4px;';

  const av = document.createElement('div');
  av.style.cssText = 'width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,#2C3E50,#3d5a73);color:#fff;display:flex;align-items:center;justify-content:center;font-size:.8rem;font-weight:700;flex-shrink:0;';
  av.textContent = ini;

  const body = document.createElement('div');
  body.style.cssText = 'max-width:82%;display:flex;flex-direction:column;align-items:flex-end;';

  const bubble = document.createElement('div');
  bubble.style.cssText = 'background:linear-gradient(135deg,#00818A,#20ADAD);color:#ffffff;padding:10px 14px;border-radius:14px;border-top-right-radius:4px;font-size:.83rem;line-height:1.6;word-break:break-word;font-family:DM Sans,sans-serif;';
  bubble.textContent = txt;

  const time = document.createElement('div');
  time.style.cssText = 'font-size:.64rem;color:#7f8c8d;margin-top:3px;text-align:right;';
  time.textContent = t;

  body.appendChild(bubble);
  body.appendChild(time);
  div.appendChild(body);
  div.appendChild(av);
  document.getElementById('chatMsgs').insertBefore(div, document.getElementById('typingRow'));
  scrollDown();
}

function addBot(html, sound){
  const t = getTime();
  const div = document.createElement('div');
  div.style.cssText = 'display:flex;gap:8px;align-items:flex-start;animation:msgIn .3s ease;margin-bottom:4px;';

  const av = document.createElement('div');
  av.style.cssText = 'width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,#00818A,#20ADAD);color:#fff;display:flex;align-items:center;justify-content:center;font-size:.85rem;flex-shrink:0;';
  av.textContent = '🤖';

  const body = document.createElement('div');
  body.style.cssText = 'max-width:82%;display:flex;flex-direction:column;';

  const bubble = document.createElement('div');
  bubble.style.cssText = 'background:#f0fafa;border:1px solid #cde8e8;color:#1a252f;padding:10px 14px;border-radius:14px;border-top-left-radius:4px;font-size:.83rem;line-height:1.6;word-break:break-word;font-family:DM Sans,sans-serif;';
  bubble.innerHTML = html;

  const time = document.createElement('div');
  time.style.cssText = 'font-size:.64rem;color:#7f8c8d;margin-top:3px;';
  time.textContent = 'OVR Assistant · ' + t;

  body.appendChild(bubble);
  body.appendChild(time);
  div.appendChild(av);
  div.appendChild(body);
  document.getElementById('chatMsgs').insertBefore(div, document.getElementById('typingRow'));
  scrollDown();
  if(sound) playSound();
}

function showTyping(){
  document.getElementById('hStatus').textContent='OVR Assistant is typing...';
  document.getElementById('typingRow').classList.add('show');
  scrollDown();
}
function hideTyping(){
  document.getElementById('hStatus').textContent='Online · Ready to help';
  document.getElementById('typingRow').classList.remove('show');
}
function scrollDown(){setTimeout(()=>{const c=document.getElementById('chatMsgs');c.scrollTop=c.scrollHeight;},60);}
function getTime(){return new Date().toLocaleTimeString('en-US',{hour:'2-digit',minute:'2-digit'});}

function playSound(){
  try{
    const ctx=new(window.AudioContext||window.webkitAudioContext)();
    const o=ctx.createOscillator(), g=ctx.createGain();
    o.connect(g);g.connect(ctx.destination);
    o.type='sine';
    o.frequency.setValueAtTime(880,ctx.currentTime);
    o.frequency.setValueAtTime(1100,ctx.currentTime+0.12);
    g.gain.setValueAtTime(0.15,ctx.currentTime);
    g.gain.exponentialRampToValueAtTime(0.001,ctx.currentTime+0.45);
    o.start(ctx.currentTime);o.stop(ctx.currentTime+0.45);
  }catch(e){}
}

// Show notification badge after 2s
window.addEventListener('DOMContentLoaded',()=>{
  setTimeout(()=>{ if(!isOpen) document.getElementById('notifBadge').style.display='flex'; },2000);
});
</script>
</body>
</html>
