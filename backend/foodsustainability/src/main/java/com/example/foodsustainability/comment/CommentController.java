package com.example.foodsustainability.comment;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {

    private final CommentService commentService;

    @GetMapping
    public List<Comment> getComments() {
        return commentService.getComments();
    }

    @PostMapping("/add")
    public String addComment(@RequestBody CommentRequest addCommentRequest, final HttpServletRequest request) {
        commentService.addComment(addCommentRequest);
        return "Success! Comment is added";
    }

    @GetMapping("/getlist/{receiverName}")
    public Optional<Comment> getCommentList(@PathVariable("receiverName") String receiverName, final HttpServletRequest request) {
        Optional<Comment> commentList = commentService.getCommentList(receiverName);
        return commentList;
    }

    @GetMapping("/getcount/{receiverName}")
    public Integer getCommentCount(@PathVariable("receiverName") String receiverName, final HttpServletRequest request) {
        Integer commentCount = commentService.getCommentCount(receiverName);
        return commentCount;
    }
}
