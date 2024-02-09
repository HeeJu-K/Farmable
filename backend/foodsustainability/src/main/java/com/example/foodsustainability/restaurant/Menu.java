package com.example.foodsustainability.restaurant;

import org.springframework.data.annotation.Id;
import com.azure.spring.data.cosmos.core.mapping.Container;
import com.azure.spring.data.cosmos.core.mapping.PartitionKey;

@Container(containerName = "restaurantmenu")
public class Menu {
    @Id
    private String id;
    @PartitionKey
    private String dishName;
    private String restaurantName;
    private String description; // this will be list of ingredients separated by '/', it MUST include all of the
                                // traceable produce, but CAN include other ingredients
    private Integer price;
    private boolean isActive;
    private boolean isFeatured;
    private String menuType; // this will either be appetizer, entree, beverage, etc

    public Menu() {

    }

    public Menu(String id, String dishName, String restaurantName, String description, Integer price, boolean isActive,
            boolean isFeatured, String menuType) {
        this.id = id;
        this.dishName = dishName;
        this.restaurantName = restaurantName;
        this.description = description;
        this.price = price;
        this.isActive = isActive;
        this.isFeatured = isFeatured;
        this.menuType = menuType;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDishName() {
        return dishName;
    }

    public void setDishName(String dishName) {
        this.dishName = dishName;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }
}