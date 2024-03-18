package com.example.foodsustainability.comment;

public record CommentRequest(
    String id,
    String date,
    String message,
    String senderEntity,
    String senderRole,
    String receiverEntity, 
    String receiverRole
) {

}