package com.salonbooking.full.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class Appointment implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String userId;
    private String userName; // To display client name in appointment list
    private String serviceId;
    private String serviceName; // To display service name in appointment list
    private LocalDate appointmentDate;
    private LocalTime appointmentTime;
    private String status; // "PENDING", "CONFIRMED", "CANCELLED", "COMPLETED"
    private double price; // Storing price at booking time in case service price changes later
    private String notes;

    // Date and time formatters for file storage and retrieval
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");

    public Appointment() {}

    public Appointment(String id, String userId, String userName, String serviceId,
                       String serviceName, LocalDate appointmentDate, LocalTime appointmentTime,
                       String status, double price, String notes) {
        this.id = id;
        this.userId = userId;
        this.userName = userName;
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.price = price;
        this.notes = notes;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public LocalDate getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(LocalDate appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public LocalTime getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(LocalTime appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    // Format date as string for display
    public String getFormattedDate() {
        return appointmentDate != null ? appointmentDate.format(DateTimeFormatter.ofPattern("MMM dd, yyyy")) : "";
    }

    // Format time as string for display
    public String getFormattedTime() {
        return appointmentTime != null ? appointmentTime.format(DateTimeFormatter.ofPattern("h:mm a")) : "";
    }

    // For storing in file - CSV format
    @Override
    public String toString() {
        String dateStr = appointmentDate != null ? appointmentDate.format(DATE_FORMATTER) : "";
        String timeStr = appointmentTime != null ? appointmentTime.format(TIME_FORMATTER) : "";
        String safeNotes = notes != null ? notes.replace(",", "\\,") : "";

        return id + "," + userId + "," + userName + "," + serviceId + "," +
                serviceName.replace(",", "\\,") + "," + dateStr + "," + timeStr + "," +
                status + "," + price + "," + safeNotes;
    }

    // Factory method to create Appointment from CSV string
    public static Appointment fromString(String line) {
        if (line == null || line.trim().isEmpty()) {
            return null;
        }

        try {
            // Handle escaped commas in description and service name
            String[] parts = line.split(",(?=(?:[^\\\\]|[^\\\\]\\\\\\\\)*$)");

            if (parts.length < 10) {
                System.out.println("Warning: Invalid appointment format, expected 10 parts but got " + parts.length + ": " + line);
                return null; // Invalid format
            }

            Appointment appointment = new Appointment();
            appointment.setId(parts[0]);
            appointment.setUserId(parts[1]);
            appointment.setUserName(parts[2]);
            appointment.setServiceId(parts[3]);
            appointment.setServiceName(parts[4].replace("\\,", ","));

            // Parse date and time
            if (parts[5] != null && !parts[5].isEmpty()) {
                try {
                    appointment.setAppointmentDate(LocalDate.parse(parts[5], DATE_FORMATTER));
                } catch (Exception e) {
                    System.out.println("Error parsing date: " + parts[5] + " - " + e.getMessage());
                }
            }

            if (parts[6] != null && !parts[6].isEmpty()) {
                try {
                    appointment.setAppointmentTime(LocalTime.parse(parts[6], TIME_FORMATTER));
                } catch (Exception e) {
                    System.out.println("Error parsing time: " + parts[6] + " - " + e.getMessage());
                }
            }

            appointment.setStatus(parts[7]);

            try {
                appointment.setPrice(Double.parseDouble(parts[8]));
            } catch (NumberFormatException e) {
                System.out.println("Error parsing price: " + parts[8] + " - " + e.getMessage());
                appointment.setPrice(0.0);
            }

            if (parts.length > 9) {
                appointment.setNotes(parts[9].replace("\\,", ","));
            }

            return appointment;
        } catch (Exception e) {
            System.out.println("Error parsing appointment: " + e.getMessage() + " - Line: " + line);
            return null;
        }
    }
}
