<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Verify OTP | Ocean View Resort</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary: #00818A;
        --secondary: #20ADAD;
        --sand: #C2B280;
        --dark: #333333;
        --light-bg: #F4F9F9;
        --error: #d9534f;
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

    /* Left Side: Cinematic Visual */
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

    /* Right Side: OTP Form */
    .form-side {
        flex: 0.8;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: white;
        padding: 40px;
    }

    .otp-card {
        width: 100%;
        max-width: 440px;
        animation: fadeInRight 0.8s ease-out;
        text-align: center;
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

    .otp-header h2 {
        color: var(--dark);
        margin: 0;
        font-size: 1.8rem;
    }

    .otp-header p {
        color: #666;
        margin-top: 8px;
        font-size: 0.95rem;
    }

    /* OTP 6-Box Styling */
    .otp-container {
        display: flex;
        justify-content: space-between;
        margin: 30px 0;
        gap: 8px;
    }

    .otp-input {
        width: 55px;
        height: 65px;
        font-size: 24px;
        text-align: center;
        border: 2px solid #eee;
        border-radius: 12px;
        font-weight: bold;
        color: var(--primary);
        transition: all 0.3s ease;
        background: var(--light-bg);
    }

    .otp-input:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 10px rgba(0, 129, 138, 0.2);
        background: white;
        transform: translateY(-5px);
    }

    .btn-verify {
        width: 100%;
        padding: 15px;
        background: var(--primary);
        border: none;
        color: white;
        border-radius: 10px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .btn-verify:hover {
        background-color: #006d73;
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0, 129, 138, 0.3);
    }

    /* Timer and Resend Styling */
    .resend-container {
        margin-top: 30px;
        font-size: 0.9rem;
        color: #777;
    }

    #resendBtn {
        background: none;
        border: none;
        color: var(--primary);
        font-weight: bold;
        cursor: pointer;
        padding: 0;
        text-decoration: underline;
        display: none;
    }

    #timerDisplay {
        color: var(--error);
        font-weight: bold;
    }

    .error {
        color: var(--error);
        background: #fff5f5;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-size: 0.9rem;
        border-left: 4px solid var(--error);
        display: ${empty error ? 'none' : 'block'};
    }

    @keyframes fadeInRight {
        from { opacity: 0; transform: translateX(30px); }
        to { opacity: 1; transform: translateX(0); }
    }

    @media (max-width: 900px) {
        .visual-side { display: none; }
        .form-side { flex: 1; }
        .otp-input { width: 45px; height: 55px; }
    }
</style>
</head>
<body>

    <div class="split-container">
        <div class="visual-side">
            <div class="visual-content">
                <h2>OVR Secure</h2>
                <p>Verify Your Identity</p>
            </div>
        </div>

        <div class="form-side">
            <div class="otp-card">
                <div class="otp-header">
                    <div class="round-icon">
                        <i class="fa-solid fa-key"></i>
                    </div>
                    <h2>Enter Code</h2>
                    <p>We've sent a 6-digit code to your email. It will expire soon.</p>
                </div>

                <div class="error">${error}</div>

                <form action="verify-otp" method="post" id="otpForm">
                    <div class="otp-container">
                        <input type="text" class="otp-input" maxlength="1" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" inputmode="numeric" required>
                    </div>

                    <input type="hidden" name="otp" id="fullOtp">
                    <button type="submit" class="btn-verify">
                        Verify Account <i class="fa-solid fa-circle-check"></i>
                    </button>
                </form>

                <div class="resend-container">
                    Didn't receive the code? <br>
                    <span id="timerText">Resend available in <span id="timerDisplay">60</span>s</span>
                    <button type="button" id="resendBtn" onclick="resendOTP()">Resend New OTP</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const inputs = document.querySelectorAll('.otp-input');
        const hiddenInput = document.getElementById('fullOtp');
        const resendBtn = document.getElementById('resendBtn');
        const timerDisplay = document.getElementById('timerDisplay');
        const timerText = document.getElementById('timerText');

        // 1. Timer Logic
        let timeLeft = 60; 
        function startTimer() {
            const timer = setInterval(() => {
                if (timeLeft <= 0) {
                    clearInterval(timer);
                    resendBtn.style.display = 'inline-block';
                    timerText.style.display = 'none';
                } else {
                    timerDisplay.innerText = timeLeft;
                }
                timeLeft -= 1;
            }, 1000);
        }
        startTimer();

        function resendOTP() {
            window.location.href = "forgot-password"; 
        }

        // 2. OTP Input Logic
        inputs.forEach((input, index) => {
            input.addEventListener('keyup', (e) => {
                if (e.key >= 0 && e.key <= 9) {
                    if (index < inputs.length - 1) inputs[index + 1].focus();
                } else if (e.key === 'Backspace') {
                    if (index > 0) inputs[index - 1].focus();
                }
                updateFullValue();
            });

            input.addEventListener('paste', (e) => {
                const pasteData = e.clipboardData.getData('text').slice(0, 6);
                if (/[0-9]{6}/.test(pasteData)) {
                    pasteData.split('').forEach((char, i) => inputs[i].value = char);
                    updateFullValue();
                }
            });
        });

        function updateFullValue() {
            let val = "";
            inputs.forEach(input => val += input.value);
            hiddenInput.value = val;
        }
    </script>
</body>
</html>