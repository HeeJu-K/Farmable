package com.example.foodsustainability.farmer;

import com.example.foodsustainability.user.User;

import org.springframework.stereotype.Repository;
import com.azure.spring.data.cosmos.repository.CosmosRepository;

@Repository
public interface FarmerProduceRepository extends CosmosRepository<User, String>{
    
}
