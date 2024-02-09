package com.example.foodsustainability.restaurant;

import org.springframework.data.annotation.Id;
import com.azure.spring.data.cosmos.core.mapping.Container;
import com.azure.spring.data.cosmos.core.mapping.PartitionKey;

@Container(containerName = "grocery")
public class Grocery {
    @Id
    private String id;
    @PartitionKey
    private String itemName;
    private String quantity;
    private String harvestTime;
    private String price;
    private String originFarm;

    public Grocery() {
        
    }
}
