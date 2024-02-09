package com.example.foodsustainability.restaurant;

public record MenuRequest(
        String dishName,
        String restaurantName,
        String description,
        Integer price,
        boolean isActive,
        boolean isFeatured,
        String menuType) {
}
