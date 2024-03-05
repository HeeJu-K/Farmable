package com.example.foodsustainability.restaurant;

import java.util.Date;

public record GroceryRequest(
    String groceryName,
    Integer quantity,
    String harvestTime,
    Integer price,
    String originFarm,
    String farmerNotes
) {
    
}
