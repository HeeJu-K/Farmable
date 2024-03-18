package com.example.foodsustainability.comment;

import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CommentService implements ICommentService {

    private final CommentRepository commentRepository;

    @Override
    public List<Comment> getComments() {
        return List.copyOf(StreamSupport.stream(commentRepository.findAll().spliterator(), false)
                .collect(Collectors.toList()));
    }

    @Override
    public Comment addComment(CommentRequest request) {
        Date currentDate = new Date(); // in milli seconds
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = formatter.format(currentDate);
        Comment newComment = new Comment();
        newComment.setId(UUID.randomUUID().toString());
        newComment.setDate(dateString);
        newComment.setMessage(request.message());
        newComment.setSenderEntity(request.senderEntity());
        newComment.setSenderRole(request.senderRole());
        newComment.setReceiverEntity(request.receiverEntity());
        newComment.setReceiverRole(request.receiverRole());
        return commentRepository.save(newComment);
    }

    @Override
    public Optional<Comment> getCommentList(String receiverName) {
        return commentRepository.findByReceiverName(receiverName);
    }

    @Override
    public Integer getCommentCount(String receiverName) {
        return commentRepository.countByReceiverName(receiverName);
    }

}
