package com.salonbooking.full.controller;

import com.salonbooking.full.model.Review;
import com.salonbooking.full.model.Service;
import com.salonbooking.full.model.User;
import com.salonbooking.full.service.ReviewService;
import com.salonbooking.full.service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class ReviewController {

    private final ReviewService reviewService;


    @Autowired
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }


    // Client review pages

    @GetMapping("/client/reviews")
    public String clientReviews(HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            List<Review> reviews = reviewService.getReviewsByUserId(client.getId());
            model.addAttribute("reviews", reviews);
            return "client/reviews";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load reviews: " + e.getMessage());
            return "client/reviews";
        }
    }

    @GetMapping("/client/review/add")
    public String showAddReviewForm(HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        // Create a new review object
        Review review = new Review();
        review.setUserId(client.getId());
        review.setUserName(client.getUsername());



        model.addAttribute("review", review);
        model.addAttribute("isNewReview", true);

        // You might want to add services list here for selection

        return "client/review-form";
    }

    @GetMapping("/client/review/edit/{id}")
    public String showEditReviewForm(@PathVariable String id, HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            Optional<Review> optionalReview = reviewService.getReviewById(id);
            if (!optionalReview.isPresent() || !optionalReview.get().getUserId().equals(client.getId())) {
                return "redirect:/client/reviews";
            }

            model.addAttribute("review", optionalReview.get());
            model.addAttribute("isNewReview", false);

            return "client/review-form";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load review: " + e.getMessage());
            return "redirect:/client/reviews";
        }
    }

    @PostMapping("/client/review/save")
    public String saveReview(@ModelAttribute Review review,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            // Ensure the review belongs to the logged-in user
            review.setUserId(client.getId());
            review.setUserName(client.getUsername());

            reviewService.saveReview(review);
            redirectAttributes.addFlashAttribute("success", "Review saved successfully. It will be visible after administrator approval.");
            return "redirect:/client/reviews";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to save review: " + e.getMessage());
            return "redirect:/client/review/add";
        }
    }

    @GetMapping("/client/review/delete/{id}")
    public String deleteClientReview(@PathVariable String id,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            // Verify the review belongs to the logged-in user
            Optional<Review> optionalReview = reviewService.getReviewById(id);
            if (!optionalReview.isPresent() || !optionalReview.get().getUserId().equals(client.getId())) {
                redirectAttributes.addFlashAttribute("error", "You can only delete your own reviews");
                return "redirect:/client/reviews";
            }

            reviewService.deleteReview(id);
            redirectAttributes.addFlashAttribute("success", "Review deleted successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete review: " + e.getMessage());
        }
        return "redirect:/client/reviews";
    }

    // Admin review pages

    @GetMapping("/admin/reviews")
    public String adminReviews(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            List<Review> reviews = reviewService.getAllReviews();
            model.addAttribute("reviews", reviews);
            return "admin/reviews";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load reviews: " + e.getMessage());
            return "admin/reviews";
        }
    }

    /*@GetMapping("/admin/review/edit/{id}")
    public String showAdminEditReviewForm(@PathVariable String id, HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<Review> optionalReview = reviewService.getReviewById(id);
            if (!optionalReview.isPresent()) {
                return "redirect:/admin/reviews";
            }

            model.addAttribute("review", optionalReview.get());
            return "admin/review-form";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load review: " + e.getMessage());
            return "redirect:/admin/reviews";
        }
    }

    @PostMapping("/admin/review/save")
    public String saveAdminReview(@ModelAttribute Review review,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            // Retrieve the existing review to maintain user info
            Optional<Review> existingReview = reviewService.getReviewById(review.getId());
            if (existingReview.isPresent()) {
                // Keep original user data
                review.setUserId(existingReview.get().getUserId());
                review.setUserName(existingReview.get().getUserName());
            }

            reviewService.saveReview(review);
            redirectAttributes.addFlashAttribute("success", "Review updated successfully");
            return "redirect:/admin/reviews";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update review: " + e.getMessage());
            return "redirect:/admin/review/edit/" + review.getId();
        }
    }

     */

    @GetMapping("/admin/review/approve/{id}")
    public String approveReview(@PathVariable String id,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            reviewService.approveReview(id);
            redirectAttributes.addFlashAttribute("success", "Review approved successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to approve review: " + e.getMessage());
        }
        return "redirect:/admin/reviews";
    }

    @GetMapping("/admin/review/reject/{id}")
    public String rejectReview(@PathVariable String id,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            reviewService.rejectReview(id);
            redirectAttributes.addFlashAttribute("success", "Review rejected successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to reject review: " + e.getMessage());
        }
        return "redirect:/admin/reviews";
    }

    @GetMapping("/admin/review/delete/{id}")
    public String deleteAdminReview(@PathVariable String id,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            reviewService.deleteReview(id);
            redirectAttributes.addFlashAttribute("success", "Review deleted successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete review: " + e.getMessage());
        }
        return "redirect:/admin/reviews";
    }

    // Public reviews page (for services)

    @GetMapping("/service/reviews/{serviceId}")
    public String serviceReviews(@PathVariable String serviceId, Model model) {
        try {
            // Only show approved reviews for public viewing
            List<Review> reviews = reviewService.getReviewsByServiceId(serviceId)
                    .stream()
                    .filter(Review::isApproved)
                    .toList();

            model.addAttribute("reviews", reviews);
            model.addAttribute("serviceId", serviceId);

            // You might want to fetch service details here too

            return "service/reviews";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load reviews: " + e.getMessage());
            return "service/reviews";
        }
    }
}