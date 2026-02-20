<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Staff - OVR</title>

    <style>
        body {
            background-color: #F4F9F9;
            font-family: Arial;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-box {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.1);
            width: 350px;
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
    </style>
</head>

<body>

<div class="register-box">

    <h2>Staff Registration</h2>

    <form action="register" method="post">

        <input type="text" name="username" placeholder="Username" required>

        <input type="email" name="email" placeholder="Email" required>

        <input type="password" name="password" placeholder="Password" required>

        <input type="password" name="confirmPassword" placeholder="Confirm Password" required>

        <button type="submit">Register</button>

    </form>

    <div class="error">
        ${error}
    </div>

</div>

</body>
</html>
