<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | RentEasy</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../css/style.css"> <!-- Add your CSS file if needed -->
    
    <!-- SweetAlert for better popups -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        body {
            background: linear-gradient(to right, #2980B9, #6DD5FA);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .login-container {
            max-width: 400px;
            width: 100%;
            padding: 30px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .login-container h2 {
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
        }
        .form-control {
            border-radius: 6px;
        }
        .btn-login {
            background: #2980B9;
            color: white;
            font-weight: bold;
            border-radius: 6px;
        }
        .btn-login:hover {
            background: #2471A3;
        }
        .register-link {
            margin-top: 10px;
            font-size: 14px;
        }
        .register-link a {
            text-decoration: none;
            font-weight: bold;
            color: #2980B9;
        }
        .register-link a:hover {
            color: #2471A3;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="AdminLoginServlet" method="post">
            <div class="mb-3">
                <input type="email" class="form-control" id="email" name="admin_email" placeholder="Enter your email" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" id="password" name="admin_password" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-login w-100">Login</button>
        </form>

        <p class="register-link">Don't have an account? <a href="AdminRegister.jsp">Sign Up</a></p>

        <%-- Display error message if login fails --%>
        <% String message = (String) request.getAttribute("message");
           if (message != null) { %>
            <script>
                Swal.fire({
                    icon: '<%= message.contains("Invalid") ? "error" : "warning" %>',
                    title: "Login Failed",
                    text: "<%= message %>",
                    confirmButtonColor: "#2980B9"
                });
            </script>
        <% } %>
    </div>

</body>
</html>
