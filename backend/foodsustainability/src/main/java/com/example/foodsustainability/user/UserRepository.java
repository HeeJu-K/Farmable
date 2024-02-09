package com.example.foodsustainability.user;

import java.util.Optional;

import org.springframework.stereotype.Repository;

import com.azure.spring.data.cosmos.repository.CosmosRepository;

@Repository
public interface UserRepository extends CosmosRepository<User, String> {
// public interface UserRepository extends ReactiveCosmosRepository<User, String> {
    Optional<User> findByEmail(String email);
}
