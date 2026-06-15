<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.assignment.dao.AssignmentDAO" %>
<%@ page import="com.assignment.model.Assignment" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String role = (String) session.getAttribute("userRole");
    int userId = (int) session.getAttribute("userId");
    AssignmentDAO dao = new AssignmentDAO();
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Assignment Tracker</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <% if ("admin".equals(role)) { %>
        <jsp:include page="admin_slidebar.jsp" />
    <% } else { %>
        <jsp:include page="student_slidebar.jsp" />
    <% } %>

    <div class="main-content">
        <h1>Dashboard</h1>

        <% if (msg != null) { %>
            <div class="alert alert-success"><%= msg %></div>
        <% } %>

        <% if ("admin".equals(role)) { %>

            <div class="stats">
                <div class="stat-card">Total Assignments: <%= dao.getTotalAssignments() %></div>
                <div class="stat-card">Pending: <%= dao.getAdminPendingCount() %></div>
                <div class="stat-card">Completed: <%= dao.getAdminCompletedCount() %></div>
                <div class="stat-card">Overdue: <%= dao.getAdminOverdueCount() %></div>
            </div>

            <h2>Add New Assignment</h2>
            <form action="AssignmentServlet" method="post">
                <input type="hidden" name="action" value="add">

                <label for="title">Title</label>
                <input type="text" id="title" name="title" required>

                <label for="subject">Subject</label>
                <input type="text" id="subject" name="subject" required>

                <label for="description">Description</label>
                <textarea id="description" name="description" required></textarea>

                <label for="dueDate">Due Date</label>
                <input type="date" id="dueDate" name="dueDate" required>

                <label for="priority">Priority</label>
                <select id="priority" name="priority" required>
                    <option value="Low">Low</option>
                    <option value="Medium">Medium</option>
                    <option value="High">High</option>
                </select>

                <button type="submit">Add Assignment</button>
            </form>

            <h2>All Assignments</h2>
            <table>
                <tr>
                    <th>Title</th>
                    <th>Subject</th>
                    <th>Due Date</th>
                    <th>Priority</th>
                    <th>Actions</th>
                </tr>
                <%
                    List<Assignment> allAssignments = dao.getAllAssignments();
                    for (Assignment a : allAssignments) {
                %>
                <tr>
                    <td><%= a.getTitle() %></td>
                    <td><%= a.getSubject() %></td>
                    <td><%= a.getDueDate() %></td>
                    <td><%= a.getPriority() %></td>
                    <td>
                        <form action="AssignmentServlet" method="post" style="display:inline">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= a.getId() %>">
                            <button type="submit" onclick="return confirm('Delete this assignment?')">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>

        <% } else { %>

            <div class="stats">
                <div class="stat-card">Pending: <%= dao.getStudentPendingCount(userId) %></div>
                <div class="stat-card">Completed: <%= dao.getStudentCompletedCount(userId) %></div>
                <div class="stat-card">Overdue: <%= dao.getStudentOverdueCount(userId) %></div>
            </div>

            <h2>My Assignments</h2>

            <form action="dashboard.jsp" method="get" class="search-form">
                <input type="text" name="search" placeholder="Search by title or subject"
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit">Search</button>
            </form>

            <table>
                <tr>
                    <th>Title</th>
                    <th>Subject</th>
                    <th>Due Date</th>
                    <th>Priority</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <%
                    String search = request.getParameter("search");
                    List<Assignment> studentAssignments;
                    if (search != null && !search.trim().isEmpty()) {
                        studentAssignments = dao.searchAssignments(userId, search.trim());
                    } else {
                        studentAssignments = dao.getAssignmentsForStudent(userId);
                    }
                    for (Assignment a : studentAssignments) {
                %>
                <tr class="<%= "Overdue".equals(a.getStatus()) ? "row-overdue" : "" %>">
                    <td><%= a.getTitle() %></td>
                    <td><%= a.getSubject() %></td>
                    <td><%= a.getDueDate() %></td>
                    <td><%= a.getPriority() %></td>
                    <td><%= a.getStatus() %></td>
                    <td>
                        <form action="StudentAssignmentServlet" method="post" style="display:inline">
                            <input type="hidden" name="action" value="toggleStatus">
                            <input type="hidden" name="saId" value="<%= a.getSaId() %>">
                            <input type="hidden" name="curr" value="<%= a.getStatus() %>">
                            <button type="submit">
                                <%= "Completed".equals(a.getStatus()) ? "Mark Pending" : "Mark Completed" %>
                            </button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>

        <% } %>
    </div>
</body>
</html>