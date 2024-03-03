package com.example.foodsustainability.order;

import java.util.List;
import java.util.Optional;

public interface IOrderService {
    List<Order> getOrders();

    List<Order> getFarmOrders(String farmId);

    List<Order> getFarmActiveOrders(String farmId);

    List<Order> getFarmCompletedOrders(String farmId);

    List<Order> getRestaurantOrders(String restaurantId);

    List<Order> getRestaurantActiveOrders(String restaurantId);

    List<Order> getRestaurantCompletedOrders(String restaurantId);

    Order createOrder(OrderRequest CreateOrderRequest);

    Order updateOrderStatus(OrderRequest UpdateOrderRequest);

    Order addHarvestTime(OrderRequest UpdateOrderRequest);
}
