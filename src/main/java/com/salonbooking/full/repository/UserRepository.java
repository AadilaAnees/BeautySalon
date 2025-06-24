package com.salonbooking.full.repository;

import com.salonbooking.full.model.User;
import com.salonbooking.full.util.FileUtil;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Repository
public class UserRepository {
    private static final String CLIENTS_FILE = "users.txt";
    private static final String ADMINS_FILE = "admin.txt";

    public User save(User user) throws IOException {
        // Debug output to see what we're trying to save
        System.out.println("Saving user - ID: " + user.getId() +
                ", Username: " + user.getUsername() +
                ", Role: " + user.getRole());

        // CRITICAL: Make sure role is not null or empty
        if (user.getRole() == null || user.getRole().isEmpty()) {
            // If we don't have a role, try to get it from the existing user
            Optional<User> existingUser = findById(user.getId());
            if (existingUser.isPresent()) {
                user.setRole(existingUser.get().getRole());
                System.out.println("Retrieved role from existing user: " + user.getRole());
            } else {
                // Default to CLIENT if we can't determine the role
                user.setRole("CLIENT");
                System.out.println("No role found, defaulting to CLIENT");
            }
        }

        // Now continue with role-based file selection
        String fileName = "ADMIN".equals(user.getRole()) ? ADMINS_FILE : CLIENTS_FILE;
        System.out.println("Selected file for saving: " + fileName);

        // For new users, generate an ID
        if (user.getId() == null || user.getId().isEmpty()) {
            String role = user.getRole();
            List<User> existingUsers = findAllByRole(role);
            int maxId = 0;
            for (User existingUser : existingUsers) {
                try {
                    int id = Integer.parseInt(existingUser.getId());
                    if (id > maxId) {
                        maxId = id;
                    }
                } catch (NumberFormatException e) {
                    // Skip non-numeric IDs
                }
            }

            // Set the new ID (maxId + 1)
            user.setId(String.valueOf(maxId + 1));
        }

        // Get users from the correct file based on role
        List<User> users = findAllByRole(user.getRole());

        // Remove existing user if updating
        users = users.stream()
                .filter(u -> !u.getId().equals(user.getId()))
                .collect(Collectors.toList());

        // Add the new/updated user
        users.add(user);

        // Save all users back to file
        FileUtil.writeToFile(fileName, users.stream()
                .map(User::toString)
                .collect(Collectors.toList()));

        return user;
    }

    public List<User> findAll() throws IOException {
        List<User> allUsers = new ArrayList<>();
        allUsers.addAll(findAllByRole("ADMIN"));
        allUsers.addAll(findAllByRole("CLIENT"));
        return allUsers;
    }

    public List<User> findAllByRole(String role) throws IOException {
        String fileName = "ADMIN".equals(role) ? ADMINS_FILE : CLIENTS_FILE;
        List<String> lines = FileUtil.readFromFile(fileName);

        return lines.stream()
                .map(this::parseUser)
                .collect(Collectors.toList());
    }

    public Optional<User> findById(String id) throws IOException {
        return findAll().stream()
                .filter(user -> user.getId().equals(id))
                .findFirst();
    }

    public Optional<User> findByUsername(String username) throws IOException {
        return findAll().stream()
                .filter(user -> user.getUsername().equals(username))
                .findFirst();
    }

    public void deleteById(String id) throws IOException {
        List<User> users = findAll();
        Optional<User> userToDelete = users.stream()
                .filter(user -> user.getId().equals(id))
                .findFirst();

        if (userToDelete.isPresent()) {
            User user = userToDelete.get();
            String fileName = "ADMIN".equals(user.getRole()) ? ADMINS_FILE : CLIENTS_FILE;
            List<User> roleUsers = findAllByRole(user.getRole());

            roleUsers = roleUsers.stream()
                    .filter(u -> !u.getId().equals(id))
                    .collect(Collectors.toList());

            FileUtil.writeToFile(fileName, roleUsers.stream()
                    .map(User::toString)
                    .collect(Collectors.toList()));
        }
    }

    private User parseUser(String line) {
        // Debug what we're parsing from the file
        System.out.println("Parsing user line: " + line);

        String[] parts = line.split(",");

        // Make sure we have at least 6 parts
        if (parts.length < 6) {
            System.out.println("Warning: User data has fewer than 6 parts: " + line);
            return null;
        }

        // Create user with the parsed data
        User user = new User(
                parts[0],  // id
                parts[1],  // username
                parts[2],  // password
                parts[3],  // email
                parts[4],  // phone
                parts[5]   // role
        );

        // Debug what we parsed
        System.out.println("Parsed user - ID: " + user.getId() +
                ", Username: " + user.getUsername() +
                ", Role: " + user.getRole());

        return user;
    }
}
