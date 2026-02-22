<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Ocean View Resort</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #00818A;
            --accent: #20ADAD;
            --dark: #2C3E50;
            --light: #F4F7F6;
            --white: #ffffff;
            --success: #27ae60;
            --warning: #f39c12;
            --danger: #e74c3c;
            --sidebar-width: 260px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background-color: var(--light); display: flex; overflow-x: hidden; }

        /* --- SIDEBAR (Fixed Position) --- */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background: var(--dark);
            color: var(--white);
            position: fixed;
            left: 0;
            top: 0;
            display: flex;
            flex-direction: column;
            z-index: 100;
        }

        .sidebar-header {
            padding: 30px 20px;
            text-align: center;
            background: rgba(0,0,0,0.2);
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        .sidebar-header h2 { font-size: 1.1rem; letter-spacing: 2px; color: var(--accent); text-transform: uppercase; }

        .nav-links { list-style: none; padding: 20px 0; flex-grow: 1; overflow-y: auto; }
        .nav-links li { transition: 0.3s; }
        .nav-links a { 
            text-decoration: none; 
            color: rgba(255,255,255,0.7); 
            font-size: 0.9rem; 
            display: flex; 
            align-items: center; 
            gap: 15px; 
            padding: 12px 25px;
            width: 100%; 
        }

        .nav-links li:hover a, .nav-links li.active a { 
            background: var(--primary); 
            color: white; 
        }

        .logout-btn { padding: 20px; border-top: 1px solid rgba(255,255,255,0.1); }
        .logout-btn a { color: #ff7675; text-decoration: none; font-size: 0.9rem; display: flex; align-items: center; gap: 10px; }

        /* --- MAIN CONTENT (Pushed by Sidebar) --- */
        .main-content {
            margin-left: var(--sidebar-width);
            width: calc(100% - var(--sidebar-width));
            padding: 30px;
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: var(--white);
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }

        .welcome-msg h1 { font-size: 1.3rem; color: var(--dark); }
        .role-badge { 
            font-size: 0.7rem; 
            background: var(--accent); 
            color: white; 
            padding: 2px 8px; 
            border-radius: 4px; 
            vertical-align: middle; 
            margin-left: 10px;
        }

        /* --- STATS GRID --- */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--white);
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 15px rgba(0,0,0,0.04);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: 0.3s;
            border-bottom: 4px solid transparent;
        }

        .card:hover { transform: translateY(-3px); }
        .card-icon {
            width: 45px;
            height: 45px;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.1rem;
        }

        .total { border-color: var(--primary); }
        .total .card-icon { background: rgba(0, 129, 138, 0.1); color: var(--primary); }
        .available { border-color: var(--success); }
        .available .card-icon { background: rgba(39, 174, 96, 0.1); color: var(--success); }
        .occupied { border-color: var(--danger); }
        .occupied .card-icon { background: rgba(231, 76, 60, 0.1); color: var(--danger); }

        .card-info h3 { font-size: 1.4rem; color: var(--dark); }
        .card-info p { font-size: 0.7rem; color: #888; text-transform: uppercase; font-weight: 600; }

        /* --- CHARTS & TABLES --- */
        .content-grid {
            display: grid;
            grid-template-columns: 1.6fr 1fr;
            gap: 20px;
        }

        .panel {
            background: var(--white);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            min-height: 350px;
        }

        .panel-title { font-size: 0.95rem; font-weight: 600; margin-bottom: 20px; color: var(--dark); }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; font-size: 0.75rem; color: #888; padding: 12px; border-bottom: 2px solid var(--light); }
        td { padding: 12px; font-size: 0.85rem; border-bottom: 1px solid var(--light); }

        .no-data { text-align: center; color: #ccc; margin-top: 50px; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">
            <h2>Ocean View</h2>
        </div>
        <ul class="nav-links">
            <li class="active"><a href="dashboard"><i class="fa-solid fa-gauge-high"></i> Dashboard</a></li>
            <li><a href="guest-management"><i class="fa-solid fa-users-gear"></i> Guest Management</a></li>
            <li><a href="reservation-management"><i class="fa-solid fa-calendar-check"></i> Reservations</a></li>
            <li><a href="billing"><i class="fa-solid fa-file-invoice-dollar"></i> Billing & Payment</a></li>
            <li><a href="reports"><i class="fa-solid fa-chart-line"></i> Reports</a></li>
            <li><a href="settings"><i class="fa-solid fa-sliders"></i> Settings</a></li>
            <li><a href="notifications"><i class="fa-solid fa-bell"></i> Notification</a></li>
            <li><a href="help"><i class="fa-solid fa-circle-question"></i> Help</a></li>
        </ul>
        <div class="logout-btn">
            <a href="logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="header-top">
            <div class="welcome-msg">
                <h1>Welcome, ${sessionScope.user.username} 
                    <span class="role-badge">${sessionScope.user.role}</span>
                </h1>
                <p style="font-size: 0.8rem; color: #999;">Manage your resort operations effectively today.</p>
            </div>
            <div id="liveClock" style="text-align: right;">
                </div>
        </div>

        <div class="stats-grid">
            <div class="card total">
                <div class="card-icon"><i class="fa-solid fa-bed"></i></div>
                <div class="card-info"><h3>${stats.totalRooms}</h3><p>Total Rooms</p></div>
            </div>
            <div class="card available">
                <div class="card-icon"><i class="fa-solid fa-check-circle"></i></div>
                <div class="card-info"><h3>${stats.availableRooms}</h3><p>Available</p></div>
            </div>
            <div class="card occupied">
                <div class="card-icon"><i class="fa-solid fa-user-tag"></i></div>
                <div class="card-info"><h3>${stats.occupiedRooms}</h3><p>Occupied</p></div>
            </div>
            <div class="card total" style="border-color: var(--accent);">
                <div class="card-icon" style="color:var(--accent); background:rgba(32,173,173,0.1)"><i class="fa-solid fa-sign-in"></i></div>
                <div class="card-info"><h3>${stats.todayCheckIns}</h3><p>Today Check-Ins</p></div>
            </div>
        </div>

        <div class="content-grid">
            <div class="panel">
                <div class="panel-title"><i class="fa-solid fa-chart-simple"></i> Monthly Reservation Overview</div>
                <c:choose>
                    <c:when test="${not empty chartValues}">
                        <canvas id="occChart" height="200"></canvas>
                    </c:when>
                    <c:otherwise><div class="no-data">No data available for chart</div></c:otherwise>
                </c:choose>
            </div>

            <div class="panel">
                <div class="panel-title"><i class="fa-solid fa-clock-rotate-left"></i> Upcoming Check-Outs</div>
                <c:choose>
                    <c:when test="${not empty stats.upcomingCheckOuts}">
                        <table>
                            <thead><tr><th>Guest</th><th>Room</th><th>Date</th></tr></thead>
                            <tbody>
                                <c:forEach var="res" items="${stats.upcomingCheckOuts}">
                                    <tr><td><strong>${res.guest}</strong></td><td>${res.room}</td><td>${res.date}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise><div class="no-data">No check-outs scheduled today</div></c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Dynamic Live Clock Logic
        function updateClock() {
            const now = new Date();
            const time = now.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true });
            const date = now.toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric', year: 'numeric' });
            document.getElementById('liveClock').innerHTML = 
                `<div style="font-weight:600; color:var(--primary); font-size:1.1rem;">` + time + `</div>` +
                `<div style="font-size:0.75rem; color:#888;">` + date + `</div>`;
        }
        setInterval(updateClock, 1000);
        updateClock();

        // Dynamic Chart.js Logic
        <c:if test="${not empty chartValues}">
        const ctx = document.getElementById('occChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [<c:forEach var="l" items="${chartLabels}" varStatus="s">"${l}"${!s.last ? ',' : ''}</c:forEach>],
                datasets: [{
                    label: 'Reservations',
                    data: [<c:forEach var="v" items="${chartValues}" varStatus="s">${v}${!s.last ? ',' : ''}</c:forEach>],
                    backgroundColor: '#00818A',
                    borderRadius: 5
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } } }
        });
        </c:if>

        // Alert Sound
        window.onload = function() {
            if (${stats.todayCheckOuts > 0}) {
                new Audio('assets/notification.mp3').play().catch(() => console.log("Sound enabled for next interaction"));
            }
        }
    </script>
</body>
</html>