package com.example.foodsustainability.farm;

public record ProduceRequest(
    String id,
    String produceName,
    String quantity,
    String harvestTime,
    String price)
{
}
