package com.salonbooking.full.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String role; // "ADMIN" or "CLIENT"
    private LocalDateTime createdDate;

    // Default constructor
    public User() {
        this.createdDate = LocalDateTime.now();
    }

    // Constructor for parsing from file
    public User(String id, String username, String password, String email, String phone, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.createdDate = LocalDateTime.now();
    }

    // Full constructor
    public User(String id, String username, String password, String email, String phone, String role, LocalDateTime createdDate) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.createdDate = createdDate != null ? createdDate : LocalDateTime.now();
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public String getFormattedCreatedDate() {
        if (createdDate != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
            return createdDate.format(formatter);
        }
        return "";
    }

    @Override
    public String toString() {
        return id + "," + username + "," + password + "," + email + "," + phone + "," + role;
    }
}