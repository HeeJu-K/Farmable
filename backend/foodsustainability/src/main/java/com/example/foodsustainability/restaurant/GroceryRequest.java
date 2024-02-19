package com.example.foodsustainability.restaurant;

public record GroceryRequest(
    String groceryName,
    String quantity,
    String harvestTime,
    String price,
    String originFarm
) {
    
}
