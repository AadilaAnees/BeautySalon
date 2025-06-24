package com.salonbooking.full.service;

import com.salonbooking.full.model.Review;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

public interface ReviewService {
    // Create and update operations
    Review saveReview(Review review) throws IOException;

    // Read operations
    List<Review> getAllReviews() throws IOException;
    List<Review> getApprovedReviews() throws IOException;
    List<Review> getReviewsByUserId(String userId) throws IOException;
    List<Review> getReviewsByServiceId(String serviceId) throws IOException;
    Optional<Review> getReviewById(String id) throws IOException;

    // Admin operations
    Review approveReview(String id) throws IOException;
    Review rejectReview(String id) throws IOException;

    // Delete operation
    void deleteReview(String id) throws IOException;
}