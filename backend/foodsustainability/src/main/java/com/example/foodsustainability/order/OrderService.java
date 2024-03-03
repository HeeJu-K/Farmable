package com.example.foodsustainability.order;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.azure.cosmos.models.CosmosQueryRequestOptions;
import com.azure.cosmos.models.PartitionKey;
import com.azure.cosmos.models.SqlParameter;
import com.azure.cosmos.models.SqlQuerySpec;
import com.example.foodsustainability.user.*;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderService implements IOrderService {

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    @Override
    public List<Order> getOrders() {
        return List.copyOf(StreamSupport.stream(orderRepository.findAll().spliterator(), false)
                .collect(Collectors.toList()));
    }

    @Override
    public List<Order> getFarmOrders(String farmId) {
        return orderRepository.getFarmOrders(farmId);
    }

    @Override
    public List<Order> getFarmActiveOrders(String farmId) {
        return orderRepository.getFarmActiveOrders(farmId);
    }

    @Override
    public List<Order> getFarmCompletedOrders(String farmId) {
        return orderRepository.getFarmCompletedOrders(farmId);

    }

    @Override
    public List<Order> getRestaurantOrders(String restaurantId) {
        return orderRepository.getRestaurantOrders(restaurantId);
    }

    @Override
    public List<Order> getRestaurantActiveOrders(String restaurantId) {
        return orderRepository.getRestaurantActiveOrders(restaurantId);
    }

    @Override
    public List<Order> getRestaurantCompletedOrders(String restaurantId) {
        return orderRepository.getRestaurantCompletedOrders(restaurantId);
    }

    @Override
    public Order createOrder(OrderRequest request) {
        Date currentDate = new Date(); // in milli seconds
        Order newOrder = new Order();
        newOrder.setId(UUID.randomUUID().toString());
        newOrder.setProduceName(request.produceName());
        newOrder.setOriginFarm(request.originFarm());
        newOrder.setDestinationRestaurant(request.destinationRestaurant());
        newOrder.setPrice(request.price());
        newOrder.setQuantity(request.quantity());
        newOrder.setOrderStatus(0);
        newOrder.setRestaurantNotes(request.restaurantNotes());
        newOrder.setLastUpdateTime(currentDate);
        return orderRepository.save(newOrder);
    }

    @Override
    public Order updateOrderStatus(OrderRequest request) {
        Date currentDate = new Date(); // in milli seconds
        PartitionKey partitionKey = new PartitionKey(request.destinationRestaurant());
        Optional<Order> optionalOrder = orderRepository.findById(request.id(), partitionKey);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setOrderStatus(request.orderStatus());
            order.setLastUpdateTime(currentDate);
            return orderRepository.save(order);
        }    
        else {
            // Handle the case where the item doesn't exist
            throw new RuntimeException("Item not found");
        }    
    }

    @Override 
    public Order addHarvestTime(OrderRequest request) {
        Date currentDate = new Date(); // in milli seconds
        PartitionKey partitionKey = new PartitionKey(request.destinationRestaurant());
        Optional<Order> optionalOrder = orderRepository.findById(request.id(), partitionKey);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setHarvestTime(currentDate);
            order.setLastUpdateTime(currentDate);
            order.setOrderStatus(2);
            order.setFarmerNotes(request.farmerNotes());
            return orderRepository.save(order);
        }    
        else {
            // Handle the case where the item doesn't exist
            throw new RuntimeException("Item not found");
        }    
    }

}
