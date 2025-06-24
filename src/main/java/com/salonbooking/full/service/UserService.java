package com.salonbooking.full.service;

import com.salonbooking.full.model.User;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

public interface UserService {
    User registerUser(User user) throws IOException;
    User updateUser(User user) throws IOException;
    List<User> getAllUsers() throws IOException;
    List<User> getAllClients() throws IOException;
    List<User> getAllAdmins() throws IOException;
    Optional<User> getUserById(String id) throws IOException;
    Optional<User> getUserByUsername(String username) throws IOException;
    void deleteUser(String id) throws IOException;
    boolean authenticateUser(String username, String password) throws IOException;
    Optional<User> loginUser(String username, String password) throws IOException;
    boolean updatePassword(String userId, String currentPassword, String newPassword) throws IOException;

}
