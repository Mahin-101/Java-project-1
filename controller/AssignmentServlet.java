package com.assignment.controller;

import com.assignment.dao.AssignmentDAO;
import com.assignment.model.Assignment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/AssignmentServlet")
public class AssignmentServlet extends HttpServlet {

    private final AssignmentDAO dao = new AssignmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String action = request.getParameter("action");
        int adminId = (int) session.getAttribute("userId");

        if ("add".equals(action)) {
            Assignment a = buildAssignmentFromRequest(request, adminId);
            boolean ok = dao.addAssignment(a);
            String msg = ok ? "Assignment added successfully!" : "Failed to add assignment.";
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Assignment a = buildAssignmentFromRequest(request, adminId);
            a.setId(id);
            boolean ok = dao.updateAssignment(a);
            String msg = ok ? "Assignment updated successfully!" : "Failed to update assignment.";
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteAssignment(id);
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp?msg=Assignment+deleted+successfully!");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
    }

    private Assignment buildAssignmentFromRequest(HttpServletRequest request, int adminId) {
        Assignment a = new Assignment();
        a.setTitle(request.getParameter("title").trim());
        a.setSubject(request.getParameter("subject").trim());
        a.setDescription(request.getParameter("description").trim());
        a.setDueDate(Date.valueOf(request.getParameter("dueDate")));
        a.setPriority(request.getParameter("priority"));
        a.setCreatedBy(adminId);
        return a;
    }
}