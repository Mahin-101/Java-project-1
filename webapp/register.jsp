<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Assignment Tracker</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <div class="auth-container">
        <h2>Register</h2>

        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <form action="RegisterServlet" method="post">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required minlength="6">

            <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="index.jsp">Login here</a></p>
    </div>
</body>
</html>