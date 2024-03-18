package com.example.foodsustainability.comment;

import java.util.List;
import java.util.Optional;


public interface ICommentService {
    List<Comment> getComments();
    Comment addComment(CommentRequest request);
    Optional<Comment> getCommentList(String receiverName); // finds comment for farmer or restaurant
    Integer getCommentCount(String receiverName);
}
