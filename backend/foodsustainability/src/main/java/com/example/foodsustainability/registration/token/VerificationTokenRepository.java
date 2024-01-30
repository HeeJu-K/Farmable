package com.example.foodsustainability.registration.token;

import java.util.Optional;

import org.springframework.stereotype.Repository;

// import org.springframework.data.jpa.repository.JpaRepository;

import com.azure.spring.data.cosmos.repository.CosmosRepository;


// public interface VerificationTokenRepository extends JpaRepository<VerificationToken, Long> {
//     VerificationToken findByToken(String token);
// }

@Repository

public interface VerificationTokenRepository extends CosmosRepository<VerificationToken, String> {
    VerificationToken findByToken(String token);
}