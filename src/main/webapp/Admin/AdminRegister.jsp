<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Registration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .container {
            max-width: 500px;
            margin-top: 50px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Admin Registration</h2>
    <form action="AdminRegisterServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="admin_name" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="admin_email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Contact No</label>
            <input type="text" name="admin_contact_no" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="admin_password" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Profile Image</label>
            <input type="file" name="admin_image" class="form-control" accept="image/*" required>
        </div>

        <button type="submit" class="btn btn-success w-100">Register</button>
        <p>Already Have an Account?<a href="AdminLogin.jsp"> Login Here</a></p>
    </form>
</div>

</body>
</html>
