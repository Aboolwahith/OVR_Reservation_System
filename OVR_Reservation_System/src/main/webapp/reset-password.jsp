<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reset Password | Ocean View Resort</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary: #00818A;
        --secondary: #20ADAD;
        --sand: #C2B280;
        --dark: #333333;
        --light-bg: #F4F9F9;
        --success: #28a745;
    }

    body, html {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: 'Segoe UI', Roboto, sans-serif;
        background-color: var(--light-bg);
    }

    .split-container {
        display: flex;
        height: 100vh;
        width: 100%;
    }

    /* Left Side: Cinematic Visual (Consistent with OVR Theme) */
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

    /* Right Side: Form Side */
    .form-side {
        flex: 0.8;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: white;
        padding: 40px;
    }

    .reset-card {
        width: 100%;
        max-width: 400px;
        animation: fadeInRight 0.8s ease-out;
    }

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

    .reset-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .reset-header h2 {
        color: var(--dark);
        margin: 0;
        font-size: 1.8rem;
    }

    .reset-header p {
        color: #666;
        font-size: 0.95rem;
        margin-top: 10px;
    }

    /* Input Styling */
    .input-group {
        position: relative;
        margin-bottom: 20px;
    }

    .input-group i.field-icon {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--primary);
    }

    .input-group input {
        width: 100%;
        padding: 14px 45px 14px 45px; /* Space for icons on both sides */
        border: 2px solid #eee;
        border-radius: 10px;
        font-size: 1rem;
        box-sizing: border-box;
        transition: all 0.3s ease;
    }

    .input-group input:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 10px rgba(0, 129, 138, 0.1);
    }

    .toggle-pass {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        color: #999;
    }

    /* Password Strength Bar */
    .strength-meter {
        height: 4px;
        width: 100%;
        background: #eee;
        margin-top: -15px;
        margin-bottom: 20px;
        border-radius: 2px;
        overflow: hidden;
    }

    .strength-bar {
        height: 100%;
        width: 0%;
        transition: all 0.3s ease;
    }

    .btn-update {
        width: 100%;
        padding: 15px;
        background: var(--primary);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: 0.3s;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .btn-update:hover {
        background: #006d73;
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0, 129, 138, 0.3);
    }

    .error {
        color: #d9534f;
        background: #fff5f5;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-size: 0.9rem;
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
            <h2>Access Secured</h2>
            <p>Final Step to Account Recovery</p>
        </div>
    </div>

    <div class="form-side">
        <div class="reset-card">
            <div class="reset-header">
                <div class="round-icon">
                    <i class="fa-solid fa-lock-open"></i>
                </div>
                <h2>Set New Password</h2>
                <p>Ensure your password is at least 6 characters long for maximum security.</p>
            </div>

            <div class="error">${error}</div>

            <form action="reset-password" method="post" id="resetForm">
                <div class="input-group">
                    <i class="fa-solid fa-key field-icon"></i>
                    <input type="password" name="password" id="pass" placeholder="New Password" required minlength="6" oninput="checkStrength(this.value)">
                    <i class="fa-solid fa-eye toggle-pass" onclick="toggleVisibility('pass')"></i>
                </div>

                <div class="strength-meter">
                    <div id="strengthBar" class="strength-bar"></div>
                </div>

                <div class="input-group">
                    <i class="fa-solid fa-shield-check field-icon"></i>
                    <input type="password" name="confirmPassword" id="confirmPass" placeholder="Confirm New Password" required>
                    <i class="fa-solid fa-eye toggle-pass" onclick="toggleVisibility('confirmPass')"></i>
                </div>

                <button type="submit" class="btn-update">
                    Update Password <i class="fa-solid fa-circle-check"></i>
                </button>
            </form>
        </div>
    </div>
</div>

<script>
    function toggleVisibility(id) {
        const input = document.getElementById(id);
        const icon = input.nextElementSibling;
        if (input.type === "password") {
            input.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    }

    function checkStrength(val) {
        const bar = document.getElementById('strengthBar');
        if (val.length === 0) {
            bar.style.width = "0%";
        } else if (val.length < 6) {
            bar.style.width = "30%";
            bar.style.background = "#d9534f";
        } else if (val.length < 10) {
            bar.style.width = "60%";
            bar.style.background = "#f0ad4e";
        } else {
            bar.style.width = "100%";
            bar.style.background = "#28a745";
        }
    }
</script>

</body>
</html>