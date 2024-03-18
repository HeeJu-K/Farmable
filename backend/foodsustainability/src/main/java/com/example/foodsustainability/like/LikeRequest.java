package com.example.foodsustainability.like;

public record LikeRequest(
    String id,
    String Date,
    String message,
    String senderEntity,
    String senderRole,
    String receiverEntity, 
    String receiverRole
) {

}