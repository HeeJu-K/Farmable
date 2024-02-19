package com.example.foodsustainability.order;

public record OrderRequest(
        String id,
        String originFarm,
        String destinationRestaurant,
        Integer orderStatus,
        Integer quantity,
        Integer price,
        String timestamp,
        String lastUpdateTime) {

}
