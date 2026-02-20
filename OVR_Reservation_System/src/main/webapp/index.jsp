<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>OVR Reservation System</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #00818A, #A3D2CA);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }

        .container {
            animation: fadeIn 2s ease-in-out;
        }

        h1 {
            font-size: 40px;
            margin-bottom: 10px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .go-btn {
            background-color: white;
            color: #00818A;
            border: none;
            padding: 15px 40px;
            font-size: 18px;
            border-radius: 30px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .go-btn:hover {
            background-color: #F4F9F9;
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>

<body>

<div class="container">
    <h1>Welcome to OVR</h1>
    <p>Online Villa Reservation System</p>

    <form action="login.jsp">
        <button class="go-btn">GO</button>
    </form>
</div>

</body>
</html>
