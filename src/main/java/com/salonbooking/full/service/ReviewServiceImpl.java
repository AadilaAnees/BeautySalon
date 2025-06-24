package com.salonbooking.full.service;

import com.salonbooking.full.model.Review;
import com.salonbooking.full.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewRepository reviewRepository;

    @Autowired
    public ReviewServiceImpl(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    @Override
    public Review saveReview(Review review) throws IOException {
        // Validate review
        if (review.getRating() < 1 || review.getRating() > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5 stars");
        }

        if (review.getComment() == null || review.getComment().trim().isEmpty()) {
            throw new IllegalArgumentException("Review comment cannot be empty");
        }

        if (review.getComment().length() > 1000) {
            throw new IllegalArgumentException("Review comment is too long (maximum 1000 characters)");
        }

        // Set review date
        review.setReviewDate(LocalDateTime.now());

        // New reviews are not approved by default unless updating an existing approved review
        if (review.getId() == null || review.getId().isEmpty()) {
            review.setApproved(false);
        } else {
            // When updating, check if it was already approved
            Optional<Review> existingReview = reviewRepository.findById(review.getId());
            if (existingReview.isPresent() && !existingReview.get().isApproved()) {
                // If the existing review wasn't approved, keep it that way
                review.setApproved(false);
            }
            // If it was approved, we keep the approved status
        }

        return reviewRepository.save(review);
    }

    @Override
    public List<Review> getAllReviews() throws IOException {
        return reviewRepository.findAll();
    }

    @Override
    public List<Review> getApprovedReviews() throws IOException {
        return reviewRepository.findApprovedReviews();
    }

    @Override
    public List<Review> getReviewsByUserId(String userId) throws IOException {
        return reviewRepository.findByUserId(userId);
    }

    @Override
    public List<Review> getReviewsByServiceId(String serviceId) throws IOException {
        return reviewRepository.findByServiceId(serviceId);
    }

    @Override
    public Optional<Review> getReviewById(String id) throws IOException {
        return reviewRepository.findById(id);
    }

    @Override
    public Review approveReview(String id) throws IOException {
        Optional<Review> optionalReview = reviewRepository.findById(id);
        if (!optionalReview.isPresent()) {
            throw new IllegalArgumentException("Review not found");
        }

        Review review = optionalReview.get();
        review.setApproved(true);

        return reviewRepository.save(review);
    }

    @Override
    public Review rejectReview(String id) throws IOException {
        Optional<Review> optionalReview = reviewRepository.findById(id);
        if (!optionalReview.isPresent()) {
            throw new IllegalArgumentException("Review not found");
        }

        Review review = optionalReview.get();
        review.setApproved(false);

        return reviewRepository.save(review);
    }

    @Override
    public void deleteReview(String id) throws IOException {
        reviewRepository.deleteById(id);
    }
}