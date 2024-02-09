package com.example.foodsustainability.restaurant;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequiredArgsConstructor
@RequestMapping("/restaurant")

public class RestaurantController {
    private final RestaurantService restaurantService;

    @GetMapping
    public List<Menu> getMenus(){
        return restaurantService.getMenus();
    }

    @PostMapping("/add")
    public String addMenu(@RequestBody MenuRequest AddMenuRequest, final HttpServletRequest request) {
        restaurantService.addMenu(AddMenuRequest);
        return "Success! Menu is added";
    }

    @PostMapping("/delete")
    public String deleteMenu(@RequestBody MenuRequest DeleteMenuRequest, final HttpServletRequest request) {
        restaurantService.deleteMenu(DeleteMenuRequest);
        return "Success! Menu is deleted";
    }

    @PostMapping("/update")
    public String updateMenu(@RequestBody MenuRequest UpdateMenuRequest, final HttpServletRequest request) {
        restaurantService.updateMenu(UpdateMenuRequest);
        return "Success! Menu is updated";
    }

    @GetMapping("/get")
    public Optional<Menu> getMenuDetails(@RequestBody MenuRequest getMenuDetailsRequest, final HttpServletRequest request) {
        Optional<Menu> menu = restaurantService.getMenuDetails(getMenuDetailsRequest);
        return menu;
    }
    
}
