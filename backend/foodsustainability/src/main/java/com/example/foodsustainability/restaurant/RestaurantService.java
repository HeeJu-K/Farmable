package com.example.foodsustainability.restaurant;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import com.azure.cosmos.implementation.changefeed.PartitionCheckpointer;
import com.azure.cosmos.models.PartitionKey;

@Service
@RequiredArgsConstructor
public class RestaurantService implements IRestaurantService {

    private final RestaurantMenuRepository restaurantMenuRepository;
    private final RestaurantInventoryRepository restaurantInventoryRepository;

    @Override
    public List<Menu> getMenus() {
        // return RestaurantMenuRepository.findAll();
        return List.copyOf(StreamSupport.stream(restaurantMenuRepository.findAll().spliterator(), false)
                .collect(Collectors.toList()));
    }

    @Override
    public Menu addMenu(MenuRequest request) {
        Menu newMenu = new Menu();
        newMenu.setId(UUID.randomUUID().toString());
        newMenu.setDishName(request.dishName());
        newMenu.setRestaurantName(request.restaurantName());
        newMenu.setDescription(request.description());
        newMenu.setPrice(request.price());
        newMenu.setActive(request.isActive());
        newMenu.setFeatured(request.isFeatured());
        newMenu.setMenuType(request.menuType());
        return restaurantMenuRepository.save(newMenu);
    }

    @Override
    public void deleteMenu(MenuRequest request) {
        PartitionKey partitionKey = new PartitionKey(request.dishName());
        findByDishName(request.dishName()).ifPresent(menu -> {
            System.out.println("MENU TO BE DELETED" + menu + " :ID: " + menu.getId());
            restaurantMenuRepository.deleteById(menu.getId(), partitionKey);
        });
    }

    @Override
    public Menu updateMenu(MenuRequest request) {
        Optional<Menu> menu = findByDishName(request.dishName());

        if (menu.isPresent()) {
            Menu updatedMenu = menu.get();

            if (request.restaurantName() != null)
                updatedMenu.setRestaurantName(request.restaurantName());
            if (request.description() != null)
                updatedMenu.setDescription(request.description());
            if (request.price() != null)
                updatedMenu.setPrice(request.price());
            updatedMenu.setActive(request.isActive());
            updatedMenu.setFeatured(request.isFeatured());
            if (request.menuType() != null)
                updatedMenu.setMenuType(request.menuType());

            return restaurantMenuRepository.save(updatedMenu);
        }

        return null;

    }

    @Override
    public Optional<Menu> findByDishName(String dishName) {
        return restaurantMenuRepository.findByDishName(dishName);
    }

    @Override
    public List<Grocery> getGroceries() {
        return List.copyOf(StreamSupport.stream(restaurantInventoryRepository.findAll().spliterator(), false)
                .collect(Collectors.toList()));
    }

    @Override
    public Grocery addGrocery(GroceryRequest request) {
        Grocery newGrocery = new Grocery();
        newGrocery.setId(UUID.randomUUID().toString());
        newGrocery.setGroceryName(request.groceryName());
        newGrocery.setQuantity(request.quantity());
        newGrocery.setHarvestTime(request.harvestTime());
        newGrocery.setPrice(request.price());
        newGrocery.setOriginFarm(request.originFarm());
        return restaurantInventoryRepository.save(newGrocery);
    }

    @Override
    public void deleteGrocery(GroceryRequest request) {
        PartitionKey partitionKey = new PartitionKey(request.groceryName());
        findByGroceryName(request.groceryName()).ifPresent(grocery -> {
            System.out.println("SEE GROCERY DELET" + grocery.getId());
            restaurantInventoryRepository.deleteById(grocery.getId(), partitionKey);
        });
    }

    @Override
    public Grocery updateGrocery(GroceryRequest request) {

        Optional<Grocery> grocery = findByGroceryName(request.groceryName());

        if (grocery.isPresent()) {
            Grocery updatedGrocery = grocery.get();

            if (request.groceryName() != null)
                updatedGrocery.setGroceryName(request.groceryName());
            if (request.quantity() != null)
                updatedGrocery.setQuantity(request.quantity());
            if (request.harvestTime() != null)
                updatedGrocery.setHarvestTime(request.harvestTime());

            if (request.price() != null)
                updatedGrocery.setPrice(request.price());
            if (request.originFarm() != null)
                updatedGrocery.setOriginFarm(request.originFarm());
            return restaurantInventoryRepository.save(updatedGrocery);
        }

        return null;
    }

    @Override
    public Optional<Grocery> findByGroceryName(String groceryName) {
        return restaurantInventoryRepository.findByGroceryName(groceryName);
    }

}
