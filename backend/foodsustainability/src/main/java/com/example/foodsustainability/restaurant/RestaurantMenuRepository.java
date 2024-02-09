package com.example.foodsustainability.restaurant;

import java.util.Optional;

import org.springframework.stereotype.Repository;
import com.azure.spring.data.cosmos.repository.CosmosRepository;

@Repository
public interface RestaurantMenuRepository extends CosmosRepository<Menu, String>{
    Optional<Menu> findByDishName(String dishName);
}