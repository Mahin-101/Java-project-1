<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    String error = (String) request.getAttribute("error");
    String regSuccess = request.getParameter("regSuccess");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Assignment Tracker</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <div class="auth-container">
        <h2>Login</h2>

        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <% if ("true".equals(regSuccess)) { %>
            <div class="alert alert-success">Registration successful! Please login.</div>
        <% } %>

        <form action="LoginServlet" method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Login</button>
        </form>

        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>