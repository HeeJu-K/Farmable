package com.example.foodsustainability.like;

import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.stereotype.Service;

import com.azure.cosmos.models.PartitionKey;
import com.example.foodsustainability.restaurant.MenuRequest;

import lombok.RequiredArgsConstructor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LikeService implements ILikeService {

    private final LikeRepository likeRepository;

    @Override
    public List<Like> getLikes() {
        return List.copyOf(StreamSupport.stream(likeRepository.findAll().spliterator(), false)
                .collect(Collectors.toList()));
    }

    @Override
    public Like addLike(LikeRequest request) {
        Date currentDate = new Date(); // in milli seconds
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = formatter.format(currentDate);
        Like newLike = new Like();
        newLike.setId(UUID.randomUUID().toString());
        newLike.setDate(dateString);
        newLike.setSenderEntity(request.senderEntity());
        newLike.setSenderRole(request.senderRole());
        newLike.setReceiverEntity(request.receiverEntity());
        newLike.setReceiverRole(request.receiverRole());
        return likeRepository.save(newLike);
    }

    @Override
    public void undoLike(LikeRequest request) {
        PartitionKey partitionKey = new PartitionKey(request.senderEntity());
        Optional<Like> optionalLike = likeRepository.findById(request.id(), partitionKey);
        if (optionalLike.isPresent()) {
            Like like = optionalLike.get();
            likeRepository.delete(like);
        }    
        else {
            // Handle the case where the item doesn't exist
            throw new RuntimeException("Item not found");
        }   
    }

    @Override
    public Integer getLikeCount(String receiverName) {
        // String receiverName = request.receiverRole() + request.receiverEntity();
        return likeRepository.findByReceiverName(receiverName);
    }
}
