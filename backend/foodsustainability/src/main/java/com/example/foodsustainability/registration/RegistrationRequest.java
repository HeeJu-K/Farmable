package com.example.foodsustainability.registration;

public record RegistrationRequest(
    String firstName,
    String lastName,
    String email,
    String password,
    String role, 
    String profileUrl, // image url address for profile picture
    String size,
    String address,
    String name, 
    String farmerFeedback,
    String restaurantFeedback) {

}
