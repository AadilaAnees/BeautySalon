package com.salonbooking.full.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Review implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String userId;
    private String userName;
    private String serviceId;
    private String serviceName;
    private int rating;  // 1-5 stars
    private String comment;
    private LocalDateTime reviewDate;
    private boolean approved; // For admin moderation

    // Date formatter for file storage
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public Review() {
        this.reviewDate = LocalDateTime.now();
        this.approved = false; // Reviews are not approved by default
    }

    public Review(String id, String userId, String userName, String serviceId, String serviceName,
                  int rating, String comment, LocalDateTime reviewDate, boolean approved) {
        this.id = id;
        this.userId = userId;
        this.userName = userName;
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.approved = approved;
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

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        // Ensure rating is between 1 and 5
        if (rating < 1) {
            this.rating = 1;
        } else if (rating > 5) {
            this.rating = 5;
        } else {
            this.rating = rating;
        }
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(LocalDateTime reviewDate) {
        this.reviewDate = reviewDate;
    }

    public boolean isApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    // Format date as string for display
    public String getFormattedReviewDate() {
        return reviewDate != null ? reviewDate.format(DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm")) : "";
    }

    // For storing in file - CSV format
    @Override
    public String toString() {
        String dateStr = reviewDate != null ? reviewDate.format(DATE_TIME_FORMATTER) : "";
        String safeComment = comment != null ? comment.replace(",", "\\,").replace("\n", "\\n") : "";
        String safeServiceName = serviceName != null ? serviceName.replace(",", "\\,") : "";

        return id + "," + userId + "," + userName + "," + serviceId + "," +
                safeServiceName + "," + rating + "," + safeComment + "," +
                dateStr + "," + approved;
    }

    // Factory method to create Review from CSV string
    public static Review fromString(String line) {
        if (line == null || line.trim().isEmpty()) {
            return null;
        }

        try {
            // Handle escaped commas
            String[] parts = line.split(",(?=(?:[^\\\\]|[^\\\\]\\\\\\\\)*$)");

            if (parts.length < 9) {
                System.out.println("Warning: Invalid review format, expected 9 parts but got " + parts.length + ": " + line);
                return null; // Invalid format
            }

            Review review = new Review();
            review.setId(parts[0]);
            review.setUserId(parts[1]);
            review.setUserName(parts[2]);
            review.setServiceId(parts[3]);
            review.setServiceName(parts[4].replace("\\,", ","));

            try {
                review.setRating(Integer.parseInt(parts[5]));
            } catch (NumberFormatException e) {
                System.out.println("Error parsing rating: " + parts[5] + " - " + e.getMessage());
                review.setRating(1); // Default to 1 star on error
            }

            review.setComment(parts[6].replace("\\,", ",").replace("\\n", "\n"));

            // Parse date and time
            if (parts[7] != null && !parts[7].isEmpty()) {
                try {
                    review.setReviewDate(LocalDateTime.parse(parts[7], DATE_TIME_FORMATTER));
                } catch (Exception e) {
                    System.out.println("Error parsing review date: " + parts[7] + " - " + e.getMessage());
                    review.setReviewDate(LocalDateTime.now());
                }
            }

            review.setApproved(Boolean.parseBoolean(parts[8]));

            return review;
        } catch (Exception e) {
            System.out.println("Error parsing review: " + e.getMessage() + " - Line: " + line);
            return null;
        }
    }
}