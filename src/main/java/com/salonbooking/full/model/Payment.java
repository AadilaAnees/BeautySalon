package com.salonbooking.full.model;


import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Payment implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String appointmentId;
    private String userId;
    private String userName;
    private double amount;
    private String cardNumber; // Last 4 digits only for security
    private String cardHolderName;
    private LocalDateTime paymentDate;
    private String status; // "SUCCESSFUL", "FAILED", "REFUNDED"
    private String serviceName;
    private String paymentMethod; // "CARD" or "CASH"


    // Date formatter for file storage
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public Payment() {
        this.paymentDate = LocalDateTime.now();
    }

    public Payment(String id, String appointmentId, String userId, String userName, double amount,
                   String cardNumber, String cardHolderName, LocalDateTime paymentDate, String status, String serviceName,String paymentMethod) {
        this.id = id;
        this.appointmentId = appointmentId;
        this.userId = userId;
        this.userName = userName;
        this.amount = amount;
        this.cardNumber = cardNumber;
        this.cardHolderName = cardHolderName;
        this.paymentDate = paymentDate;
        this.status = status;
        this.serviceName = serviceName;
        this.paymentMethod = paymentMethod;
        System.out.println("Creating Payment: ID=" + id + ", Method=" + paymentMethod);

    }

    // Getters and Setters

    public String getPaymentId() {
        return id;
    }

    public void setPaymentId(String paymentId) {
        this.id = paymentId;
    }
    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(String appointmentId) {
        this.appointmentId = appointmentId;
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

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        // Store only last 4 digits for security
        if (cardNumber != null && cardNumber.length() >= 4) {
            this.cardNumber = "****" + cardNumber.substring(cardNumber.length() - 4);
        } else {
            this.cardNumber = cardNumber;
        }
    }

    public String getCardHolderName() {
        return cardHolderName;
    }

    public void setCardHolderName(String cardHolderName) {
        this.cardHolderName = cardHolderName;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    // Format date as string for display
    public String getFormattedPaymentDate() {
        return paymentDate != null ? paymentDate.format(DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm")) : "";
    }



    // For storing in file - CSV format
    @Override
    public String toString() {
        String dateStr = paymentDate != null ? paymentDate.format(DATE_TIME_FORMATTER) : "";
        String safeServiceName = serviceName != null ? serviceName.replace(",", "\\,") : "";
        String safeCardHolderName = cardHolderName != null ? cardHolderName.replace(",", "\\,") : "";
        String safePaymentMethod = paymentMethod != null ? paymentMethod :
                (cardNumber != null && !cardNumber.isEmpty() ? "CARD" : "CASH");

        return id + "," + appointmentId + "," + userId + "," + userName + "," +
                amount + "," + cardNumber + "," + safeCardHolderName + "," +
                dateStr + "," + status + "," + safeServiceName + "," + safePaymentMethod;
    }

    // Factory method to create Payment from CSV string
    public static Payment fromString(String line) {
        if (line == null || line.trim().isEmpty()) {
            return null;
        }

        try {
            System.out.println("Parsing payment line: " + line);

            // Handle escaped commas
            String[] parts = line.split(",(?=(?:[^\\\\]|[^\\\\]\\\\\\\\)*$)");

            if (parts.length < 10) {
                System.out.println("Warning: Invalid payment format, expected at least 10 parts but got " + parts.length + ": " + line);
                return null; // Invalid format
            }

            Payment payment = new Payment();
            payment.setId(parts[0]);
            payment.setAppointmentId(parts[1]);
            payment.setUserId(parts[2]);
            payment.setUserName(parts[3]);

            try {
                payment.setAmount(Double.parseDouble(parts[4]));
            } catch (NumberFormatException e) {
                System.out.println("Error parsing amount: " + parts[4] + " - " + e.getMessage());
                payment.setAmount(0.0);
            }

            payment.setCardNumber(parts[5]);
            payment.setCardHolderName(parts[6].replace("\\,", ","));

            // Parse date and time
            if (parts[7] != null && !parts[7].isEmpty()) {
                try {
                    payment.setPaymentDate(LocalDateTime.parse(parts[7], DATE_TIME_FORMATTER));
                } catch (Exception e) {
                    System.out.println("Error parsing payment date: " + parts[7] + " - " + e.getMessage());
                    payment.setPaymentDate(LocalDateTime.now());
                }
            }

            payment.setStatus(parts[8]);
            payment.setServiceName(parts[9].replace("\\,", ","));

            // Handle paymentMethod if it exists (backward compatibility)
            if (parts.length > 10) {
                payment.setPaymentMethod(parts[10]);
                System.out.println("Found payment method in data: " + parts[10]);

            } else {
                // If paymentMethod is not in the data, infer it from cardNumber
                String inferredMethod = payment.getCardNumber() != null && !payment.getCardNumber().isEmpty() ? "CARD" : "CASH";
                payment.setPaymentMethod(inferredMethod);
                System.out.println("Inferred payment method: " + inferredMethod + " (card number: " + (payment.getCardNumber() != null ? "present" : "absent") + ")");
            }

            System.out.println("Successfully parsed payment: ID=" + payment.getId() +
                    ", Method=" + payment.getPaymentMethod() +
                    ", Status=" + payment.getStatus());

            return payment;
        } catch (Exception e) {
            System.out.println("Error parsing payment: " + e.getMessage() + " - Line: " + line);
            e.printStackTrace();

            return null;
        }
    }

}
