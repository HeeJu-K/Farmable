package com.example.foodsustainability.order;

public record OrderRequest(
        String id,
        String produceName,
        String originFarm,
        String destinationRestaurant,
        Integer orderStatus,
        Integer quantity,
        Integer price,
        String timestamp,
        String lastUpdateTime,
        String restaurantNotes,
        String farmerNotes
        ) {

}
