package com.assignment.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Assignment {
    private int id;
    private String title;
    private String subject;
    private String description;
    private Date dueDate;
    private String priority;
    private int createdBy;
    private Timestamp createdAt;
    private String status;
    private int saId; // student_assignments row id (needed for toggle/complete actions)

    public Assignment() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }
    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public int getSaId() { return saId; }
    public void setSaId(int saId) { this.saId = saId; }

    public boolean isOverdue() {
        if (dueDate == null) return false;
        return dueDate.before(new java.util.Date()) && !"Completed".equals(status);
    }
}