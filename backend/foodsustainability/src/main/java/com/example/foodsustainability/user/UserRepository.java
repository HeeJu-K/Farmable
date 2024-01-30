package com.example.foodsustainability.user;

import java.util.Optional;

// import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.azure.spring.data.cosmos.repository.CosmosRepository;
// import com.azure.spring.data.cosmos.repository.ReactiveCosmosRepository;


// public interface UserRepository extends JpaRepository<User, Long>{

//     Optional<User> findByEmail(String email);
// }

@Repository
public interface UserRepository extends CosmosRepository<User, String> {
// public interface UserRepository extends ReactiveCosmosRepository<User, String> {
    Optional<User> findByEmail(String email);
}
