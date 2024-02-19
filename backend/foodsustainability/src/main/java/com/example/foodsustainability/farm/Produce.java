package com.example.foodsustainability.farm;

import org.springframework.data.annotation.Id;

import com.azure.spring.data.cosmos.core.mapping.PartitionKey;

public class Produce {
    @Id
    private String id;
    @PartitionKey
    private String produceName;
    private String quantity;
    private String harvestTime;
    private String price;

    public Produce() {
        
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProduceName() {
        return produceName;
    }

    public void setProduceName(String produceName) {
        this.produceName = produceName;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getHarvestTime() {
        return harvestTime;
    }

    public void setHarvestTime(String harvestTime) {
        this.harvestTime = harvestTime;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
}
