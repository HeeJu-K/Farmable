package com.example.foodsustainability.restaurant;

import java.util.List;
import java.util.Optional;

public interface IRestaurantService {
    List<Menu> getMenus();
    Menu addMenu(MenuRequest request);
    void deleteMenu(MenuRequest request);
    Menu updateMenu(MenuRequest request);
    Optional<Menu> findByDishName(String dishName);
    Optional<Menu> getMenuDetails(MenuRequest request);
}

// addMenu, deleteMenu, updateMenu, getMenu(), getMenus, 
// addItem, reduceItem, getItem, getItems