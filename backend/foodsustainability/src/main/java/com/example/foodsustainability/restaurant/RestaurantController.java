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

    @GetMapping("/menu")
    public List<Menu> getMenus(){
        return restaurantService.getMenus();
    }

    @PostMapping("/menu/add")
    public String addMenu(@RequestBody MenuRequest AddMenuRequest, final HttpServletRequest request) {
        restaurantService.addMenu(AddMenuRequest);
        return "Success! Menu is added";
    }

    @PostMapping("/menu/delete")
    public String deleteMenu(@RequestBody MenuRequest DeleteMenuRequest, final HttpServletRequest request) {
        restaurantService.deleteMenu(DeleteMenuRequest);
        return "Success! Menu is deleted";
    }

    @PostMapping("/menu/update")
    public String updateMenu(@RequestBody MenuRequest UpdateMenuRequest, final HttpServletRequest request) {
        restaurantService.updateMenu(UpdateMenuRequest);
        return "Success! Menu is updated";
    }

    @GetMapping("/menu/get")
    public Optional<Menu> getMenuDetails(@RequestBody MenuRequest getMenuDetailsRequest, final HttpServletRequest request) {
        Optional<Menu> menu = restaurantService.findByDishName(getMenuDetailsRequest.dishName());
        return menu;
    }

    @GetMapping("/grocery")
    public List<Grocery> getGroceries(){
        return restaurantService.getGroceries();
    }

    @PostMapping("/grocery/add")
    public String addGrocery(@RequestBody GroceryRequest AddGroceryRequest, final HttpServletRequest request) {
        restaurantService.addGrocery(AddGroceryRequest);
        return "Success! Grocery is added";
    }

    @PostMapping("/grocery/delete")
    public String deleteGrocery(@RequestBody GroceryRequest DeleteGroceryRequest, final HttpServletRequest request) {
        restaurantService.deleteGrocery(DeleteGroceryRequest);
        return "Success! Grocery is deleted";
    }

    @PostMapping("/grocery/update")
    public String updateGrocery(@RequestBody GroceryRequest UpdateGroceryRequest, final HttpServletRequest request) {
        restaurantService.updateGrocery(UpdateGroceryRequest);
        return "Success! grocery is updated";
    }

    @GetMapping("/grocery/get")
    public Optional<Grocery> getGroceryDetails(@RequestBody GroceryRequest getGroceryDetailsRequest, final HttpServletRequest request) {
        Optional<Grocery> grocery = restaurantService.findByGroceryName(getGroceryDetailsRequest.groceryName());
        return grocery;
    }
    
}
