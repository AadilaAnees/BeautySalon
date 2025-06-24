package com.salonbooking.full.repository;

import com.salonbooking.full.model.Review;
import com.salonbooking.full.util.FileUtil;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
public class ReviewRepository {
    private static final String REVIEWS_FILE = "reviews.txt";

    public Review save(Review review) throws IOException {
        if (review.getId() == null || review.getId().isEmpty()) {
            // Generate a simple numeric ID
            List<Review> existingReviews = findAll();
            int maxId = 0;
            for (Review existingReview : existingReviews) {
                try {
                    int id = Integer.parseInt(existingReview.getId());
                    if (id > maxId) {
                        maxId = id;
                    }
                } catch (NumberFormatException e) {
                    // Skip non-numeric IDs
                }
            }
            review.setId(String.valueOf(maxId + 1));
        }

        // Set review date if not already set
        if (review.getReviewDate() == null) {
            review.setReviewDate(LocalDateTime.now());
        }

        List<Review> reviews = findAll();

        // Remove existing review if updating
        reviews = reviews.stream()
                .filter(r -> !r.getId().equals(review.getId()))
                .collect(Collectors.toList());

        // Add the new/updated review
        reviews.add(review);

        // Save all reviews back to file
        FileUtil.writeToFile(REVIEWS_FILE, reviews.stream()
                .map(Review::toString)
                .collect(Collectors.toList()));

        return review;
    }

    public List<Review> findAll() throws IOException {
        List<String> lines = FileUtil.readFromFile(REVIEWS_FILE);
        List<Review> reviews = new ArrayList<>();

        for (String line : lines) {
            Review review = Review.fromString(line);
            if (review != null) {
                reviews.add(review);
            }
        }

        // Sort by review date (most recent first)
        reviews.sort(Comparator.comparing(Review::getReviewDate, Comparator.nullsLast(Comparator.reverseOrder())));

        return reviews;
    }

    public Optional<Review> findById(String id) throws IOException {
        return findAll().stream()
                .filter(review -> review.getId().equals(id))
                .findFirst();
    }

    public List<Review> findByUserId(String userId) throws IOException {
        return findAll().stream()
                .filter(review -> review.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    public List<Review> findByServiceId(String serviceId) throws IOException {
        return findAll().stream()
                .filter(review -> review.getServiceId().equals(serviceId))
                .collect(Collectors.toList());
    }

    public List<Review> findApprovedReviews() throws IOException {
        return findAll().stream()
                .filter(Review::isApproved)
                .collect(Collectors.toList());
    }

    public void deleteById(String id) throws IOException {
        List<Review> reviews = findAll();

        // Remove the review with the given ID
        reviews = reviews.stream()
                .filter(r -> !r.getId().equals(id))
                .collect(Collectors.toList());

        // Save the updated list back to file
        FileUtil.writeToFile(REVIEWS_FILE, reviews.stream()
                .map(Review::toString)
                .collect(Collectors.toList()));
    }
}