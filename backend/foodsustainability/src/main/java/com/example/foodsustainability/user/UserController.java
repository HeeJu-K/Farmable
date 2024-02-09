package com.example.foodsustainability.user;

import java.util.List;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.foodsustainability.event.RegistrationCompleteEvent;
import com.example.foodsustainability.registration.RegistrationRequest;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    @GetMapping
    public List<User> getUsers(){
        return userService.getUsers();
    }

    @PostMapping("/update")
    public String registerUser(@RequestBody RegistrationRequest updateUserRequst, final HttpServletRequest request) {
        userService.updateUser(updateUserRequst);
       
        return "Success! User is updated";
    }
    
}
