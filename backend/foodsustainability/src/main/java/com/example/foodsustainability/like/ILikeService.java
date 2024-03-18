package com.example.foodsustainability.like;

import java.util.List;
import java.util.Optional;


public interface ILikeService {
    List<Like> getLikes();
    Like addLike(LikeRequest request);
    void undoLike(LikeRequest request);
    Integer getLikeCount(String receiverName); // finds like for farmer or restaurant
}
