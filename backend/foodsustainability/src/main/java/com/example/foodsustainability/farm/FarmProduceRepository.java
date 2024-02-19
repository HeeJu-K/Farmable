package com.example.foodsustainability.farm;

import java.util.Optional;

import org.springframework.stereotype.Repository;
import com.azure.spring.data.cosmos.repository.CosmosRepository;

@Repository
public interface FarmProduceRepository extends CosmosRepository<Produce, String>{
    Optional<Produce> findByProduceName(String produceName);
}
