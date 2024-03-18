package com.example.foodsustainability.like;

import java.util.Optional;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.azure.spring.data.cosmos.repository.CosmosRepository;
import com.azure.spring.data.cosmos.repository.Query;

@Repository
public interface LikeRepository extends CosmosRepository<Like, String> {
    
    @Query("SELECT VALUE COUNT(1) FROM c WHERE CONCAT(c.receiverRole, c.receiverEntity) = @receiverName")
    Integer findByReceiverName(@Param("receiverName") String receiverName);
}