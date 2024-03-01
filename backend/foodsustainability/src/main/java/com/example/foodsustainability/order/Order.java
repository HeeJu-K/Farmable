package com.example.foodsustainability.order;

import java.util.Date;

import org.springframework.data.annotation.Id;
import com.azure.spring.data.cosmos.core.mapping.Container;
import com.azure.spring.data.cosmos.core.mapping.PartitionKey;

@Container(containerName = "order")
public class Order {
    @Id
    private String id;
    private String orderItem;
    private String originFarm;
    @PartitionKey
    private String destinationRestaurant;
    private Integer orderStatus;
    // 0: "Requested", 1: "Accepted", 2: "Declined", 3: "Harvested",
    // 4: "On Delivery", 5: "Delivered", 6: "Confirmed", 7: "Rated"
    private Integer quantity;
    private Integer price;
    private String timestamp; // Date of harvest time
    private Date lastUpdateTime; // Time of last update
    private String restaurantNotes;
    private String farmerNotes;

    public Order(String id, String orderItem, String originFarm, String destinationRestaurant, Integer orderStatus,
            Integer quantity,
            Integer price, String timestamp, Date lastUpdateTime, String restaurantNotes, String farmerNotes) {
        this.id = id;
        this.orderItem = orderItem;
        this.originFarm = originFarm;
        this.destinationRestaurant = destinationRestaurant;
        this.orderStatus = orderStatus;
        this.quantity = quantity;
        this.price = price;
        this.timestamp = timestamp;
        this.lastUpdateTime = lastUpdateTime;
        this.restaurantNotes = restaurantNotes;
        this.farmerNotes = farmerNotes;
    }

    public Order() {

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(String orderItem) {
        this.orderItem = orderItem;
    }

    public String getOriginFarm() {
        return originFarm;
    }

    public void setOriginFarm(String originFarm) {
        this.originFarm = originFarm;
    }

    public String getDestinationRestaurant() {
        return destinationRestaurant;
    }

    public void setDestinationRestaurant(String destinationRestaurant) {
        this.destinationRestaurant = destinationRestaurant;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public Date getLastUpdate() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public String getRestaurantNotes() {
        return restaurantNotes;
    }

    public void setRestaurantNotes(String restaurantNotes) {
        this.restaurantNotes = restaurantNotes;
    }

    public String getFarmerNotes() {
        return farmerNotes;
    }

    public void setFarmerNotes(String farmerNotes) {
        this.farmerNotes = farmerNotes;
    }

}
