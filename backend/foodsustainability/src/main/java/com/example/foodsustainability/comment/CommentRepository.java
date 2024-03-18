package com.example.foodsustainability.comment;

import java.util.Optional;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.azure.spring.data.cosmos.repository.CosmosRepository;
import com.azure.spring.data.cosmos.repository.Query;

@Repository
public interface CommentRepository extends CosmosRepository<Comment, String> {
    
    @Query("SELECT * FROM f WHERE CONCAT(f.receiverRole, f.receiverEntity) = @receiverName")
    Optional<Comment> findByReceiverName(@Param("receiverName") String receiverName);

    @Query("SELECT VALUE COUNT(1) FROM c WHERE CONCAT(c.receiverRole, c.receiverEntity) = @receiverName")
    Integer countByReceiverName(@Param("receiverName") String receiverName);
}