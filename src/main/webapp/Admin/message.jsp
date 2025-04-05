<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Message</title>
    <script>
        window.onload = function () {
            alert("<%= request.getAttribute("message") %>"); // Show popup message
            window.location.href = "<%= request.getAttribute("redirect") %>"; // Redirect
        };
    </script>
</head>
<body>
</body>
</html>
