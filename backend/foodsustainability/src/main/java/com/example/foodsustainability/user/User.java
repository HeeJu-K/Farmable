package com.example.foodsustainability.user;

import org.springframework.data.annotation.Id;
import com.azure.spring.data.cosmos.core.mapping.Container;
import com.azure.spring.data.cosmos.core.mapping.PartitionKey;

@Container(containerName = "user")
public class User {

    @Id
    private String id;
    private String firstName;
    @PartitionKey
    private String lastName;
    private String password;
    private String role;
    private boolean isEnabled = false;
    private String profileUrl; // image url address for profile picture
    private String size;
    private String address;
    private String name; // farm or restaurant name
    private String email;
    private String teamDescription;
    private String locationDescription;
    private String farmerFeedback;
    private String restaurantFeedback;

    public User() {

    }

    public User(
            String id,
            String firstName,
            String lastName,
            String email,
            String password,
            String role,
            boolean isEnabled,
            String profileUrl,
            String size,
            String address,
            String name,
            String teamDescription,
            String locationDescription, 
            String farmerFeedback,
            String restaurantFeedback) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.isEnabled = isEnabled;
        this.profileUrl = profileUrl;
        this.size = size;
        this.address = address;
        this.name = name;
        this.teamDescription = teamDescription;
        this.locationDescription = locationDescription;
        this.farmerFeedback = farmerFeedback;
        this.restaurantFeedback = restaurantFeedback;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean getIsEnabled() {
        return isEnabled;
    }

    public void setIsEnabled(boolean isEnabled) {
        this.isEnabled = isEnabled;
    }

    public String getProfileUrl() {
        return profileUrl;
    }

    public void setProfileUrl(String profileUrl) {
        this.profileUrl = profileUrl;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTeamDescription() {
        return teamDescription;
    }

    public void setTeamDescription(String teamDescription) {
        this.teamDescription = teamDescription;
    }

    public String getLocationDescription() {
        return locationDescription;
    }

    public void setLocationDescription(String locationDescription) {
        this.locationDescription = locationDescription;
    }

    public void setEnabled(boolean isEnabled) {
        this.isEnabled = isEnabled;
    }

    public String getFarmerFeedback() {
        return farmerFeedback;
    }

    public void setFarmerFeedback(String farmerFeedback) {
        this.farmerFeedback = farmerFeedback;
    }

    public String getRestaurantFeedback() {
        return restaurantFeedback;
    }

    public void setRestaurantFeedback(String restaurantFeedback) {
        this.restaurantFeedback = restaurantFeedback;
    }
}
