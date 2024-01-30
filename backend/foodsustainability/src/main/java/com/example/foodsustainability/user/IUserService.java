package com.example.foodsustainability.user;

import java.util.List;
import java.util.Optional;

import com.example.foodsustainability.registration.RegistrationRequest;

public interface IUserService {
    
    List<User> getUsers();

    User registerUser(RegistrationRequest request);
    Optional<User> findByEmail(String email);
    void saveUserVerificationToken(User theUser, String token);
    String validateToken(String theToken);
}
