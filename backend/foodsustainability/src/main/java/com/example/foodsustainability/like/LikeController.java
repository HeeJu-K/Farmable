package com.example.foodsustainability.like;

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
@RequestMapping("/like")
public class LikeController {
    private final LikeService likeService;

    @GetMapping
    public List<Like> getLikes(){
        return likeService.getLikes();
    }

    @PostMapping("/add")
    public String addLike(@RequestBody LikeRequest addLikeRequest, final HttpServletRequest request) {
        likeService.addLike(addLikeRequest);
        return "Success! Like is added";
    }

    @PostMapping("/undo")
    public String undoLike(@RequestBody LikeRequest undoLikeRequest, final HttpServletRequest request) {
        likeService.undoLike(undoLikeRequest);
        return "Success! Like is deleted";
    }

    @GetMapping("/get/{receiverName}")
    public Integer getLikeCount(@PathVariable("receiverName") String receiverName, final HttpServletRequest request) {

    // public Integer getLikeCount(@PathVariable("receiverName") String receiverName, @RequestBody LikeRequest getLikeCountRequest, final HttpServletRequest request) {
        Integer likeCount = likeService.getLikeCount(receiverName);
        return likeCount;
    }
    
}
