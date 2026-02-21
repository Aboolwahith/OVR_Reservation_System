<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>New Password - OVR</title>
    <style>
        :root { --primary: #00818A; --bg: #f4f7f6; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 100%; max-width: 400px; text-align: center; }
        input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background: var(--primary); border: none; color: white; border-radius: 6px; cursor: pointer; font-weight: bold; }
        .success-msg { color: #28a745; font-size: 13px; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="card">
        <h2>Secure Reset</h2>
        <p>Choose a strong password to protect your account.</p>
        
        <form action="reset-password" method="post">
            <input type="password" name="password" placeholder="New Password" required minlength="6">
            <input type="password" name="confirmPassword" placeholder="Confirm New Password" required>
            <button type="submit">Update Password</button>
        </form>
        
        <p style="color:red; font-size:13px;">${error}</p>
    </div>
</body>
</html>