package com.salonbooking.full.service;

import com.salonbooking.full.model.User;
import com.salonbooking.full.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User registerUser(User user) throws IOException {
        Optional<User> existingUser = userRepository.findByUsername(user.getUsername());
        if (existingUser.isPresent()) {
            throw new RuntimeException("Username already exists");
        }
        return userRepository.save(user);
    }

    @Override
    public User updateUser(User user) throws IOException {
        // First, get the existing user to preserve critical fields
        Optional<User> existingUserOpt = userRepository.findById(user.getId());
        if (!existingUserOpt.isPresent()) {
            throw new RuntimeException("User not found");
        }

        User existingUser = existingUserOpt.get();

        // Print existing user info for debugging
        System.out.println("Existing user: ID=" + existingUser.getId() +
                ", Username=" + existingUser.getUsername() +
                ", Role=" + existingUser.getRole());

        // Print incoming user info for debugging
        System.out.println("Incoming user: ID=" + user.getId() +
                ", Username=" + user.getUsername() +
                ", Role=" + user.getRole());

        // Create a new user object preserving critical fields
        User updatedUser = new User();

        // Always keep these fields from the existing user
        updatedUser.setId(existingUser.getId());
        updatedUser.setUsername(existingUser.getUsername());
        updatedUser.setRole(existingUser.getRole());

        // Only update these fields from the incoming user
        updatedUser.setEmail(user.getEmail());
        updatedUser.setPhone(user.getPhone());

        // For password - keep existing unless specifically being changed
        updatedUser.setPassword(user.getPassword() != null && !user.getPassword().isEmpty() ?
                user.getPassword() : existingUser.getPassword());

        // Print final user to save for debugging
        System.out.println("Saving user: ID=" + updatedUser.getId() +
                ", Username=" + updatedUser.getUsername() +
                ", Role=" + updatedUser.getRole());

        // Now save the user with preserved fields
        return userRepository.save(updatedUser);
    }

    @Override
    public List<User> getAllUsers() throws IOException {
        return userRepository.findAll();
    }

    @Override
    public List<User> getAllClients() throws IOException {
        return userRepository.findAllByRole("CLIENT");
    }

    @Override
    public List<User> getAllAdmins() throws IOException {
        return userRepository.findAllByRole("ADMIN");
    }

    @Override
    public Optional<User> getUserById(String id) throws IOException {
        return userRepository.findById(id);
    }

    @Override
    public Optional<User> getUserByUsername(String username) throws IOException {
        return userRepository.findByUsername(username);
    }

    @Override
    public void deleteUser(String id) throws IOException {
        userRepository.deleteById(id);
    }

    @Override
    public boolean authenticateUser(String username, String password) throws IOException {
        Optional<User> user = userRepository.findByUsername(username);
        return user.isPresent() && user.get().getPassword().equals(password);
    }

    @Override
    public Optional<User> loginUser(String username, String password) throws IOException {
        Optional<User> user = userRepository.findByUsername(username);
        if (user.isPresent() && user.get().getPassword().equals(password)) {
            return user;
        }
        return Optional.empty();
    }
    @Override
    public boolean updatePassword(String userId, String currentPassword, String newPassword) throws IOException {
        Optional<User> userOpt = getUserById(userId);
        if (!userOpt.isPresent()) {
            throw new IllegalArgumentException("User not found");
        }

        User user = userOpt.get();

        // Verify current password
        if (!user.getPassword().equals(currentPassword)) {
            return false;  // Password verification failed
        }

        // Update to new password
        user.setPassword(newPassword);

        // Save the user
        updateUser(user);

        return true;
    }
}
