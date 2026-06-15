package com.assignment.controller;

import com.assignment.dao.AssignmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/StudentAssignmentServlet")
public class StudentAssignmentServlet extends HttpServlet {

    private final AssignmentDAO dao = new AssignmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"student".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");

        if ("complete".equals(action)) {
            int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
            dao.markAsCompleted(studentId, assignmentId);
        } else if ("toggleStatus".equals(action)) {
            int saId = Integer.parseInt(request.getParameter("saId"));
            String curr = request.getParameter("curr");
            dao.toggleStatus(saId, studentId, curr);
        }

        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
    }
}