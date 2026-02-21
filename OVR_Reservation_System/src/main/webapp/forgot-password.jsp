<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password - OVR</title>
    <style>
        :root { --primary: #00818A; --bg: #f4f7f6; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: var(--bg); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 100%; max-width: 400px; text-align: center; }
        .logo { width: 80px; margin-bottom: 20px; }
        h2 { color: #333; margin-bottom: 10px; }
        p { color: #666; font-size: 14px; margin-bottom: 25px; }
        input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background: var(--primary); border: none; color: white; border-radius: 6px; cursor: pointer; font-weight: bold; transition: 0.3s; }
        button:hover { background: #006a71; }
        .error { color: #d9534f; font-size: 13px; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="card">
        <img src="assets/logo.png" alt="OVR Logo" class="logo"> <h2>Reset Password</h2>
        <p>Enter your username and registered email to receive a secure OTP.</p>
        
        <form action="forgot-password" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email" placeholder="Email Address" required>
            <button type="submit">Send Security Code</button>
        </form>
        
        <div class="error">${error}</div>
        <a href="login.jsp" style="display:block; margin-top:20px; font-size:13px; color: var(--primary); text-decoration:none;">Back to Login</a>
    </div>
</body>
</html>