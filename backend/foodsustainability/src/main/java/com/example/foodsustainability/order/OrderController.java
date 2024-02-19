package com.example.foodsustainability.order;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.foodsustainability.restaurant.MenuRequest;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PutMapping;

@RestController
@RequiredArgsConstructor
@RequestMapping("/order")

public class OrderController {
    private final OrderService orderService;

    @GetMapping
    public List<Order> getOrders() {
        return orderService.getOrders();
    }

    @GetMapping("/farm/{farmId}")
    public List<Order> getFarmOrders(@PathVariable String farmId) {
        return orderService.getFarmOrders(farmId);
    }

    @GetMapping("/farm/active/{farmId}")
    public List<Order> getFarmActiveOrders(@PathVariable String farmId) {
        return orderService.getFarmActiveOrders(farmId);
    }

    @GetMapping("/farm/completed/{farmId}")
    public List<Order> getFarmCompletedOrders(@PathVariable String farmId) {
        return orderService.getFarmCompletedOrders(farmId);
    }

    @GetMapping("/restaurant/{restaurantId}")
    public List<Order> getRestaurantOrders(@PathVariable String restaurantId) {
        return orderService.getRestaurantOrders(restaurantId);
    }

    @GetMapping("/restaurant/active/{restaurantId}")
    public List<Order> getRestaurantActiveOrders(@PathVariable String restaurantId) {
        return orderService.getRestaurantActiveOrders(restaurantId);
    }

    @GetMapping("/restaurant/completed/{restaurantId}")
    public List<Order> getRestaurantCompletedOrders(@PathVariable String restaurantId) {
        return orderService.getRestaurantCompletedOrders(restaurantId);
    }

    @PostMapping("/create")
    public String createOrder(@RequestBody OrderRequest CreateOrderRequest, final HttpServletRequest request) {
        orderService.createOrder(CreateOrderRequest);
        return "Success! Order is created!";
    }

    @PutMapping("/update")
    public String updateOrderStatus(@RequestBody OrderRequest UpdateOrderRequest, final HttpServletRequest request) {
        orderService.updateOrderStatus(UpdateOrderRequest);
        return "Success! Order status is updated!";
    }
}
