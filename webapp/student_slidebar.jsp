<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <h2>Student Panel</h2>
    <ul>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="LogoutServlet">Logout</a></li>
    </ul>
    <div class="user-info">
        Logged in as: <%= session.getAttribute("userName") %>
    </div>
</div>