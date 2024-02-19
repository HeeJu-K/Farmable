package com.example.foodsustainability.order;


import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.azure.spring.data.cosmos.repository.CosmosRepository;
import com.azure.spring.data.cosmos.repository.Query;

@Repository
public interface OrderRepository extends CosmosRepository<Order, String>{

    @Query("SELECT * FROM c WHERE c.originFarm = @farmId")
    List<Order> getFarmOrders(@Param("farmId") String farmId);

    @Query("SELECT * FROM c WHERE c.originFarm = @farmId AND c.orderStatus < 5")
    List<Order> getFarmActiveOrders(@Param("farmId") String farmId);

    @Query("SELECT * FROM c WHERE c.originFarm = @farmId AND c.orderStatus >= 5")
    List<Order> getFarmCompletedOrders(@Param("farmId") String farmId);

    @Query("SELECT * FROM c WHERE c.destinationRestaurant = @restaurantId")
    List<Order> getRestaurantOrders(@Param("restaurantId") String restaurantId);

    @Query("SELECT * FROM c WHERE c.destinationRestaurant = @restaurantId AND c.orderStatus < 6")
    List<Order> getRestaurantActiveOrders(@Param("restaurantId") String restaurantId);

    @Query("SELECT * FROM c WHERE c.destinationRestaurant = @restaurantId AND c.orderStatus >= 5")
    List<Order> getRestaurantCompletedOrders(@Param("restaurantId") String restaurantId);
    
}
