package com.example.foodsustainability.user;

import java.util.Calendar;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.foodsustainability.exception.UserAlreadyExistException;
import com.example.foodsustainability.registration.RegistrationRequest;
import com.example.foodsustainability.registration.token.VerificationToken;
import com.example.foodsustainability.registration.token.VerificationTokenRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final VerificationTokenRepository tokenRepository;

    // @Autowired
    // public UserService(
    // UserRepository userRepository,
    // PasswordEncoder passwordEncoder,
    // VerificationTokenRepository tokenRepository
    // ) {
    // this.userRepository = userRepository;
    // this.passwordEncoder = passwordEncoder;
    // this.tokenRepository = tokenRepository;
    // }

    @Override
    public List<User> getUsers() {
        return List.copyOf(StreamSupport.stream(userRepository.findAll().spliterator(), false)
                .collect(Collectors.toList()));
        // return userRepository.findAll();
    }

    @Override
    public User registerUser(RegistrationRequest request) {
        Optional<User> appUser = this.findByEmail(request.email());
        if (appUser.isPresent()) {
            throw new UserAlreadyExistException(
                    "User with email " + request.email() + "alrady exists");
        }
        User newUser = new User();
        newUser.setId(UUID.randomUUID().toString());
        newUser.setFirstName(request.firstName());
        newUser.setLastName(request.lastName());
        newUser.setEmail(request.email());
        newUser.setPassword(passwordEncoder.encode(request.password()));
        newUser.setRole(request.role());
        return userRepository.save(newUser);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public User updateUser(RegistrationRequest request) {
        User user = findByEmail(request.email())
                .orElseThrow(() -> new NoSuchElementException("No user found with the email: " + request.email()));
        user.setProfileUrl(request.profileUrl());
        user.setSize(request.size());
        user.setAddress(request.address());
        user.setName(request.name());
        
        user.setFarmerFeedback(request.farmerFeedback());
        user.setRestaurantFeedback(request.restaurantFeedback());
        return userRepository.save(user); 
    }

    @Override
    public void saveUserVerificationToken(User theUser, String token) {
        VerificationToken verificationToken = new VerificationToken(token, theUser);
        tokenRepository.save(verificationToken);
    }

    @Override
    public String validateToken(String theToken) {
        VerificationToken token = tokenRepository.findByToken(theToken);

        if (token == null) {
            return "Invalid verification token";
        }

        User user = token.getUser();
        Calendar calendar = Calendar.getInstance();
        if ((token.getExpirationTime().getTime() - calendar.getTime().getTime()) <= 0) {
            tokenRepository.delete(token);
            return "Token already expired";
        }
        user.setIsEnabled(true);
        userRepository.save(user);
        return "valid";
    }

}
