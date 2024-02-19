package com.example.foodsustainability.restaurant;

import java.util.List;
import java.util.Optional;

public interface IRestaurantService {
    List<Menu> getMenus();
    Menu addMenu(MenuRequest request);
    void deleteMenu(MenuRequest request);
    Menu updateMenu(MenuRequest request);
    Optional<Menu> findByDishName(String dishName);

    List <Grocery> getGroceries();
    Grocery addGrocery(GroceryRequest request);
    void deleteGrocery(GroceryRequest request);
    Grocery updateGrocery(GroceryRequest request);
    Optional<Grocery> findByGroceryName(String groceryName);
}
