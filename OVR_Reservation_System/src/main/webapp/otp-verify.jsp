<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP - OVR</title>
    <style>
        :root { --primary: #00818A; --bg: #f4f7f6; --disabled: #ccc; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 100%; max-width: 420px; text-align: center; }
        .logo { width: 70px; margin-bottom: 15px; }
        .otp-container { display: flex; justify-content: space-between; margin: 25px 0; }
        .otp-input { width: 50px; height: 60px; font-size: 26px; text-align: center; border: 2px solid #ddd; border-radius: 8px; font-weight: bold; color: var(--primary); transition: 0.3s; }
        .otp-input:focus { border-color: var(--primary); outline: none; box-shadow: 0 0 8px rgba(0,129,138,0.2); }
        
        .btn-verify { width: 100%; padding: 14px; background: var(--primary); border: none; color: white; border-radius: 8px; cursor: pointer; font-weight: bold; font-size: 16px; }
        
        .resend-container { margin-top: 25px; font-size: 14px; color: #666; }
        #resendBtn { background: none; border: none; color: var(--primary); font-weight: bold; cursor: pointer; padding: 0; text-decoration: underline; display: none; }
        #resendBtn:disabled { color: var(--disabled); cursor: not-allowed; text-decoration: none; }
        #timerDisplay { color: #d9534f; font-weight: bold; }
        
        .error { color: #d9534f; font-size: 13px; margin-bottom: 15px; font-weight: 500; }
    </style>
</head>
<body>
    <div class="card">
        <img src="assets/logo.png" alt="OVR Logo" class="logo">
        <h2>Verify OTP</h2>
        <p>Enter the 6-digit code sent to your email.</p>
        
        <%-- Display error if OTP is wrong or expired --%>
        <div class="error">${error}</div>

        <form action="verify-otp" method="post" id="otpForm">
            <div class="otp-container">
                <input type="text" class="otp-input" maxlength="1" inputmode="numeric" autocomplete="one-time-code">
                <input type="text" class="otp-input" maxlength="1" inputmode="numeric">
                <input type="text" class="otp-input" maxlength="1" inputmode="numeric">
                <input type="text" class="otp-input" maxlength="1" inputmode="numeric">
                <input type="text" class="otp-input" maxlength="1" inputmode="numeric">
                <input type="text" class="otp-input" maxlength="1" inputmode="numeric">
            </div>
            
            <input type="hidden" name="otp" id="fullOtp">
            <button type="submit" class="btn-verify">Verify Account</button>
        </form>

        <div class="resend-container">
            Didn't receive the code? <br>
            <span id="timerText">Resend available in <span id="timerDisplay">60</span>s</span>
            <button type="button" id="resendBtn" onclick="resendOTP()">Resend New OTP</button>
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

        // 2. Resend Functionality
        function resendOTP() {
            // This triggers your existing forgot-password servlet logic
            window.location.href = "forgot-password"; 
        }

        // 3. OTP Input Handling (Focus & Paste)
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