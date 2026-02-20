<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - OVR</title>

    <style>
        body {
            background-color: #F4F9F9;
            font-family: Arial;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-box {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.1);
            width: 300px;
        }

        h2 {
            text-align: center;
            color: #00818A;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 15px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #00818A;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #006d73;
        }

        .error {
            color: red;
            text-align: center;
        }

        .links {
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>

<div class="login-box">

    <h2>Login</h2>

    <form action="login" method="post">
        <input type="text" name="username" placeholder="Username" required>

        <input type="password" name="password" placeholder="Password" required>

        <button type="submit">Login</button>
    </form>

    <div class="error">
        ${error}
    </div>

    <div class="links">
        <a href="forgot-password.jsp">Forgot Password?</a>
    </div>

</div>

</body>
</html>
