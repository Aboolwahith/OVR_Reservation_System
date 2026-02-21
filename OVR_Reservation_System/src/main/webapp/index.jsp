<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ocean View Resort | Welcome</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
:root {
	--primary: #00818A;
	--sand: #C2B280;
	--white: #ffffff;
}

body, html {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
	font-family: 'Segoe UI', Roboto, sans-serif;
}

/* Video Background Styling */
#bg-video {
	position: fixed;
	right: 0;
	bottom: 0;
	min-width: 100%;
	min-height: 100%;
	z-index: -1;
	filter: brightness(50%); /* Darken video for text readability */
	object-fit: cover;
}

/* Overlay Content */
.hero-section {
	height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	color: var(--white);
	text-align: center;
	background: rgba(0, 0, 0, 0.2); /* Extra layer of contrast */
}

.logo-container img {
border-radius:50%;
	width: 120px;
	margin-bottom: 20px;
	filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.3));
	animation: slideDown 1.5s ease-out;
}

.welcome-text h1 {
	font-size: 3.5rem;
	letter-spacing: 3px;
	margin: 0;
	text-transform: uppercase;
	font-weight: 800;
	animation: fadeInUp 1.5s ease-out;
}

.welcome-text p {
	font-size: 1.2rem;
	margin-top: 10px;
	font-weight: 300;
	color: var(--sand);
	letter-spacing: 2px;
	animation: fadeInUp 2s ease-out;
}

/* Professional "GO" Button */
.btn-wrapper {
	margin-top: 40px;
	animation: fadeIn 3s ease-in;
}

.go-btn {
	background: transparent;
	color: var(--white);
	border: 2px solid var(--white);
	padding: 15px 50px;
	font-size: 1.1rem;
	font-weight: bold;
	text-transform: uppercase;
	border-radius: 50px;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 15px;
	transition: all 0.4s ease;
	backdrop-filter: blur(5px);
}

.go-btn:hover {
	background: var(--primary);
	border-color: var(--primary);
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 129, 138, 0.4);
}

.go-btn i {
	font-size: 1.2rem;
	transition: transform 0.4s ease;
}

.go-btn:hover i {
	transform: translateX(8px);
}

/* Animations */
@
keyframes fadeInUp {from { opacity:0;
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@
keyframes slideDown {from { opacity:0;
	transform: translateY(-30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* Footer Branding */
.footer-brand {
	position: absolute;
	bottom: 30px;
	font-size: 0.9rem;
	opacity: 0.8;
}
</style>
</head>
<body>

	<video autoplay muted loop id="bg-video">
		<source src="assets/video/bg-video.mp4" type="video/mp4">
		Your browser does not support HTML5 video.
	</video>

	<audio id="welcomeAudio">
		<source src="assets/audio/welcome.mp3" type="audio/mpeg">
	</audio>

	<div class="hero-section">
		<div class="logo-container">
			<img src="assets/img/logo.png" alt="OVR Logo">
		</div>

		<div class="welcome-text">
			<h1>Ocean View Resort</h1>
			<p>Experience Luxury in the Heart of Galle</p>
		</div>

		<div class="btn-wrapper">
			<form action="login.jsp">
				<button type="submit" class="go-btn" id="startBtn">
					Enter System <i class="fa-solid fa-arrow-right-long"></i>
				</button>
			</form>
		</div>

		<div class="footer-brand">&copy; 2026 OVR Enterprise Solutions |
			Secure Access</div>
	</div>

	<script>
        // Audio Logic: Browsers block auto-play audio unless user interacts
        // This will play the welcome sound as soon as the mouse moves or clicks
        document.body.addEventListener('mouseenter', function() {
            const audio = document.getElementById('welcomeAudio');
            audio.play().catch(error => {
                console.log("Audio autoplay waited for user interaction.");
            });
        }, { once: true });
    </script>

</body>
</html>