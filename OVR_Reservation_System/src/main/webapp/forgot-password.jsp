<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Forgot Password | Ocean View Resort</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary: #00818A;
        --secondary: #20ADAD;
        --sand: #C2B280;
        --dark: #333333;
        --light-bg: #F4F9F9;
    }

    body, html {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
        background-color: var(--light-bg);
    }

    .split-container {
        display: flex;
        height: 100vh;
        width: 100%;
    }

    /* Left Side: Visual/Ocean Side (Same as Login) */
    .visual-side {
        flex: 1.2;
        background: linear-gradient(rgba(0, 129, 138, 0.4), rgba(0, 0, 0, 0.5)), 
                    url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1350&q=80');
        background-size: cover;
        background-position: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: white;
        padding: 40px;
        text-align: center;
    }

    .visual-content h2 {
        font-size: 3rem;
        margin: 0;
        text-transform: uppercase;
        letter-spacing: 4px;
        text-shadow: 0 4px 10px rgba(0,0,0,0.3);
    }

    .visual-content p {
        font-size: 1.2rem;
        color: var(--sand);
        letter-spacing: 2px;
        margin-top: 10px;
    }

    /* Right Side: Recovery Form Side */
    .form-side {
        flex: 0.8;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: white;
        padding: 40px;
    }

    .recovery-card {
        width: 100%;
        max-width: 400px;
        animation: fadeInRight 1s ease-out;
    }

    .recovery-header {
        text-align: center;
        margin-bottom: 35px;
    }

    /* Circular Badge from Login Style */
    .round-icon {
        width: 80px;
        height: 80px;
        background: var(--primary);
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 auto 20px;
        color: white;
        font-size: 2rem;
        box-shadow: 0 10px 20px rgba(0, 129, 138, 0.2);
    }

    .recovery-header h2 {
        color: var(--dark);
        margin: 0;
        font-size: 1.8rem;
    }

    .recovery-header p {
        color: #777;
        margin-top: 8px;
        font-size: 0.95rem;
        line-height: 1.4;
    }

    /* Input Styling matched to Login */
    .input-group {
        position: relative;
        margin-bottom: 20px;
    }

    .input-group i {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--primary);
    }

    .input-group input {
        width: 100%;
        padding: 14px 14px 14px 45px;
        border: 2px solid #eee;
        border-radius: 8px;
        font-size: 1rem;
        box-sizing: border-box;
        transition: all 0.3s ease;
    }

    .input-group input:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 10px rgba(0, 129, 138, 0.1);
    }

    /* Recovery Button */
    .recovery-btn {
        width: 100%;
        padding: 14px;
        background-color: var(--primary);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        margin-top: 10px;
    }

    .recovery-btn:hover {
        background-color: #006d73;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 129, 138, 0.3);
    }

    .error {
        color: #d9534f;
        background: #fdf2f2;
        padding: 12px;
        border-radius: 8px;
        text-align: center;
        margin-bottom: 20px;
        font-size: 0.9rem;
        border-left: 4px solid #d9534f;
        display: ${empty error ? 'none' : 'block'};
    }

    .links {
        text-align: center;
        margin-top: 30px;
    }

    .links a {
        color: var(--primary);
        text-decoration: none;
        font-size: 0.95rem;
        font-weight: 600;
        transition: 0.3s;
    }

    .links a:hover {
        color: var(--secondary);
        text-decoration: underline;
    }

    @keyframes fadeInRight {
        from { opacity: 0; transform: translateX(30px); }
        to { opacity: 1; transform: translateX(0); }
    }

    @media (max-width: 900px) {
        .visual-side { display: none; }
        .form-side { flex: 1; }
    }
</style>
</head>

<body>

    <div class="split-container">
        <div class="visual-side">
            <div class="visual-content">
                <h2>OVR Secure</h2>
                <p>Account Recovery Center</p>
            </div>
        </div>

        <div class="form-side">
            <div class="recovery-card">
                <div class="recovery-header">
                    <div class="round-icon">
                        <i class="fa-solid fa-user-shield"></i>
                    </div>
                    <h2>Reset Password</h2>
                    <p>Enter your details to receive a 6-digit security code via email.</p>
                </div>

                <div class="error">${error}</div>

                <form action="forgot-password" method="post">
                    <div class="input-group">
                        <i class="fa-solid fa-user-large"></i>
                        <input type="text" name="username" placeholder="Username" required>
                    </div>

                    <div class="input-group">
                        <i class="fa-solid fa-envelope"></i>
                        <input type="email" name="email" placeholder="Registered Email" required>
                    </div>

                    <button type="submit" class="recovery-btn">
                        Send OTP Code <i class="fa-solid fa-paper-plane"></i>
                    </button>
                </form>

                <div class="links">
                    <a href="login.jsp"><i class="fa-solid fa-arrow-left"></i> Back to Login</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>