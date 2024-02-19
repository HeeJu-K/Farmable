package com.example.foodsustainability.farm;

import java.util.List;
import java.util.Optional;

public interface IProduceService {
    List<Produce> getProduces();
    Produce addProduce(ProduceRequest request);
    void deleteProduce(ProduceRequest request);
    Produce updateProduce(ProduceRequest request);
    Optional<Produce> findByProduceName(String produceName);
}
