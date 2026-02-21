<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Staff Registration | Ocean View Resort</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary: #00818A;
        --secondary: #20ADAD;
        --sand: #C2B280;
        --dark: #333333;
        --light-bg: #F4F9F9;
        --success: #28a745;
        --gray: #888;
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

    /* Left Side: Professional Onboarding Visual */
    .visual-side {
        flex: 1.2;
        background: linear-gradient(rgba(0, 129, 138, 0.5), rgba(0, 0, 0, 0.6)), 
                    url('https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1350&q=80');
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
        text-transform: uppercase;
        letter-spacing: 4px;
        margin: 0;
        text-shadow: 0 4px 10px rgba(0,0,0,0.3);
    }

    .visual-content p {
        font-size: 1.2rem;
        color: var(--sand);
        margin-top: 10px;
        letter-spacing: 2px;
    }

    /* Right Side: Form */
    .form-side {
        flex: 0.8;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: white;
        padding: 40px;
    }

    .register-card {
        width: 100%;
        max-width: 420px;
        animation: fadeInRight 0.8s ease-out;
    }

    .round-badge {
        width: 70px;
        height: 70px;
        background: var(--primary);
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 auto 15px;
        color: white;
        font-size: 1.8rem;
        box-shadow: 0 8px 15px rgba(0, 129, 138, 0.2);
    }

    .register-header {
        text-align: center;
        margin-bottom: 25px;
    }

    .register-header h2 {
        color: var(--dark);
        margin: 0;
        font-size: 1.8rem;
    }

    /* Input Styling */
    .input-group {
        position: relative;
        margin-bottom: 15px;
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
        border-radius: 10px;
        font-size: 0.95rem;
        box-sizing: border-box;
        transition: all 0.3s ease;
    }

    .input-group input:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 10px rgba(0, 129, 138, 0.1);
    }

    /* Visual Validation Checklist */
    .validation-box {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 20px;
        border: 1px solid #eee;
        text-align: left;
    }

    .val-item {
        font-size: 0.85rem;
        color: var(--gray);
        display: flex;
        align-items: center;
        gap: 8px;
        margin: 4px 0;
        transition: 0.3s;
    }

    .val-item.valid {
        color: var(--success);
        font-weight: 600;
    }

    .val-item i {
        font-size: 0.9rem;
    }

    /* Button Styling */
    .register-btn {
        width: 100%;
        padding: 15px;
        background-color: var(--primary);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 12px;
    }

    .register-btn:disabled {
        background-color: #ccc;
        cursor: not-allowed;
        transform: none;
    }

    .register-btn:not(:disabled):hover {
        background-color: #006d73;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 129, 138, 0.3);
    }

    .error-msg {
        color: #d9534f;
        background: #fff5f5;
        padding: 10px;
        border-radius: 8px;
        text-align: center;
        margin-bottom: 15px;
        font-size: 0.85rem;
        border-left: 4px solid #d9534f;
        display: ${empty error ? 'none' : 'block'};
    }

    @keyframes fadeInRight {
        from { opacity: 0; transform: translateX(30px); }
        to { opacity: 1; transform: translateX(0); }
    }

    @media (max-width: 900px) {
        .visual-side { display: none; }
    }
</style>
</head>

<body>

    <div class="split-container">
        <div class="visual-side">
            <div class="visual-content">
                <h2>Join The Team</h2>
                <p>OVR Staff Onboarding Portal</p>
            </div>
        </div>

        <div class="form-side">
            <div class="register-card">
                <div class="register-header">
                    <div class="round-badge">
                        <i class="fa-solid fa-user-plus"></i>
                    </div>
                    <h2>Create Account</h2>
                </div>

                <div class="error-msg">${error}</div>

                <form action="register" method="post" id="regForm">
                    <div class="input-group">
                        <i class="fa-solid fa-user-tag"></i>
                        <input type="text" name="username" placeholder="Username" required>
                    </div>

                    <div class="input-group">
                        <i class="fa-solid fa-envelope"></i>
                        <input type="email" name="email" placeholder="Official Email" required>
                    </div>

                    <div class="input-group">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" name="password" id="password" placeholder="Password" required onkeyup="validateForm()">
                    </div>

                    <div class="input-group">
                        <i class="fa-solid fa-shield-check"></i>
                        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" required onkeyup="validateForm()">
                    </div>

                    <div class="validation-box">
                        <div id="len-req" class="val-item">
                            <i class="fa-solid fa-circle-dot"></i> Minimum 6 characters
                        </div>
                        <div id="match-req" class="val-item">
                            <i class="fa-solid fa-circle-dot"></i> Passwords must match
                        </div>
                    </div>

                    <button type="submit" class="register-btn" id="regBtn" disabled>
                        Register Staff <i class="fa-solid fa-check-double"></i>
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            const pass = document.getElementById('password').value;
            const confirm = document.getElementById('confirmPassword').value;
            const regBtn = document.getElementById('regBtn');
            
            const lenReq = document.getElementById('len-req');
            const matchReq = document.getElementById('match-req');

            // Validate Length
            if (pass.length >= 6) {
                lenReq.classList.add('valid');
                lenReq.querySelector('i').className = "fa-solid fa-circle-check";
            } else {
                lenReq.classList.remove('valid');
                lenReq.querySelector('i').className = "fa-solid fa-circle-dot";
            }

            // Validate Match
            if (confirm.length > 0 && pass === confirm) {
                matchReq.classList.add('valid');
                matchReq.querySelector('i').className = "fa-solid fa-circle-check";
            } else {
                matchReq.classList.remove('valid');
                matchReq.querySelector('i').className = "fa-solid fa-circle-dot";
            }

            // Enable/Disable Button
            regBtn.disabled = !(pass.length >= 6 && pass === confirm);
        }
    </script>
</body>
</html>