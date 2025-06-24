package com.salonbooking.full.controller;

import com.salonbooking.full.model.User;
import com.salonbooking.full.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

@Controller
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password,
                        HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Optional<User> user = userService.loginUser(username, password);
            if (!user.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Invalid username or password");
                return "redirect:/login";
            }

            session.setAttribute("user", user.get());
            session.setAttribute("username", user.get().getUsername()); // ✅ add this

            if ("ADMIN".equals(user.get().getRole())) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/client/dashboard";
            }

        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "System error: " + e.getMessage());
            return "redirect:/login";
        }
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "client/client-register";
    }

    @PostMapping("/register")
    public String registerClient(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        try {
            user.setRole("CLIENT");
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute("success", "Registration successful. Please login.");
            return "redirect:/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Registration failed: " + e.getMessage());
            return "redirect:/register";
        }
    }

    @GetMapping("/admin/user-dashboard")
    public String adminUserDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            model.addAttribute("clients", userService.getAllClients());
            model.addAttribute("admins", userService.getAllAdmins());
            return "admin/users";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load users: " + e.getMessage());
            return "admin/users";
        }
    }

    @GetMapping("/client/dashboard")
    public String clientDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"CLIENT".equals(user.getRole())) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        return "client/client-dashboard";
    }

    @GetMapping("/admin/user/edit/{id}")
    public String editUserForm(@PathVariable String id, Model model, HttpSession session) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<User> user = userService.getUserById(id);
            if (!user.isPresent()) {
                return "redirect:/admin/user-dashboard";
            }
            model.addAttribute("user", user.get());
            return "admin/edit-user";
        } catch (IOException e) {
            return "redirect:/admin/user-dashboard";
        }
    }

    @PostMapping("/admin/user/update")
    public String updateUser(@ModelAttribute User user, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            userService.updateUser(user);
            redirectAttributes.addFlashAttribute("success", "User updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update user: " + e.getMessage());
        }
        return "redirect:/admin/user-dashboard";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String deleteUser(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("success", "User deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete user: " + e.getMessage());
        }
        return "redirect:/admin/user-dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/admin/user/add")
    public String addUserForm(Model model, HttpSession session) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        model.addAttribute("user", new User());
        return "admin/add-user";
    }

    @PostMapping("/admin/user/add")
    public String addUser(@ModelAttribute User user, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute("success", "User added successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add user: " + e.getMessage());
        }
        return "redirect:/admin/user-dashboard";
    }
    @GetMapping("/client/profile")
    public String showProfilePage(HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", client);

        // Try using a working view path that you know exists
        return "client/profile"; // Assuming this view works
    }
    @PostMapping("/client/profile/update")
    public String updateProfile(
            @RequestParam String email,
            @RequestParam String phone,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // Get current user from session
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            // Get the current user from database to ensure we have all fields
            Optional<User> currentUserOpt = userService.getUserById(client.getId());
            if (!currentUserOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "User not found");
                return "redirect:/client/profile";
            }

            User currentUser = currentUserOpt.get();

            // Print debug information
            System.out.println("Current user before update - ID: " + currentUser.getId()
                    + ", Username: " + currentUser.getUsername()
                    + ", Role: " + currentUser.getRole());

            // Only update the fields we want to change
            currentUser.setEmail(email);
            currentUser.setPhone(phone);

            // Explicitly ensure the role is set correctly
            if (!"CLIENT".equals(currentUser.getRole())) {
                System.out.println("WARNING: Role was not CLIENT. Setting it correctly.");
                currentUser.setRole("CLIENT");
            }

            System.out.println("User to save - ID: " + currentUser.getId()
                    + ", Username: " + currentUser.getUsername()
                    + ", Role: " + currentUser.getRole());

            // Save the updated user
            User updatedUser = userService.updateUser(currentUser);

            // Update session
            session.setAttribute("user", updatedUser);

            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to update profile: " + e.getMessage());
        }

        return "redirect:/client/profile";
    }
    @GetMapping("/client/profile/password")
    public String showChangePasswordForm(HttpSession session) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        return "client/password";
    }

    @PostMapping("/client/profile/password/update")
    public String updatePassword(
            @RequestParam String currentPassword,
            @RequestParam String newPassword,
            @RequestParam String confirmPassword,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        // Validate that the new password and confirmation match
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "New password and confirmation do not match");
            return "redirect:/client/profile/password";
        }

        try {
            // Verify current password and update to new password
            boolean passwordUpdated = userService.updatePassword(client.getId(), currentPassword, newPassword);

            if (passwordUpdated) {
                // Get the updated user to refresh the session
                Optional<User> updatedUser = userService.getUserById(client.getId());
                if (updatedUser.isPresent()) {
                    session.setAttribute("user", updatedUser.get());
                }

                redirectAttributes.addFlashAttribute("success", "Password updated successfully");
                return "redirect:/client/profile";
            } else {
                redirectAttributes.addFlashAttribute("error", "Current password is incorrect");
                return "redirect:/client/profile/password";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update password: " + e.getMessage());
            return "redirect:/client/profile/password";
        }
    }

}

