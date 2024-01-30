package com.example.foodsustainability.user;

// import org.hibernate.annotations.NaturalId;

// import jakarta.persistence.Entity;
// import jakarta.persistence.GeneratedValue;
// import jakarta.persistence.GenerationType;
// import jakarta.persistence.Id;
// import lombok.AllArgsConstructor;
// import lombok.Getter;
// import lombok.NoArgsConstructor;
// import lombok.Setter;

// @Getter
// @Setter
// @Entity
// @NoArgsConstructor
// @AllArgsConstructor
// public class User {

//     @Id
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
//     private Long id;
//     private String firstName;
//     private String lastName;
//     @NaturalId(mutable = true)
//     private String email;
//     private String password;
//     private String role;
//     private boolean isEnabled = false;

// }

import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.TypeAlias;
import com.azure.spring.data.cosmos.core.mapping.Container;
import com.azure.spring.data.cosmos.core.mapping.PartitionKey;
// import org.springframework.data.cosmos.core.mapping.Document;
// import org.springframework.data.cosmos.core.mapping.PartitionKey;

// import com.microsoft.azure.spring.data.cosmosdb.core.mapping.Document;

@Container(containerName = "user")
public class User {

    @Id
    private String id;
    private String firstName;
    private String email;
    private String password;
    private String role;
    private boolean isEnabled = false;
    @PartitionKey
    private String lastName;
    

    public User() {

    }

    public User(String id, String firstName, String lastName, String email, String password, String role,
            boolean isEnabled) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.isEnabled = isEnabled;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    public boolean getIsEnabled() {
        return isEnabled;
    }

    public void setIsEnabled(boolean isEnabled) {
        this.isEnabled = isEnabled;
    }
}
