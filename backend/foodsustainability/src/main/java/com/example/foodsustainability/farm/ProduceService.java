package com.example.foodsustainability.farm;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import java.util.UUID;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import com.azure.cosmos.models.PartitionKey;
import com.example.foodsustainability.restaurant.Menu;

@Service
@RequiredArgsConstructor
public class ProduceService implements IProduceService {

    private final FarmProduceRepository farmProduceRepository;

    @Override
    public List<Produce> getProduces() {
        return List.copyOf(StreamSupport.stream(farmProduceRepository.findAll().spliterator(), false)
                .collect(Collectors.toList()));
    }

    @Override
    public Produce addProduce(ProduceRequest request) {

        Produce newProduce = new Produce();
        newProduce.setId(UUID.randomUUID().toString());
        newProduce.setProduceName(request.produceName());
        newProduce.setQuantity(request.quantity());
        newProduce.setPrice(request.price());
        newProduce.setHarvestTime(request.harvestTime());
        return farmProduceRepository.save(newProduce);
    }

    @Override
    public void deleteProduce(ProduceRequest request) {
        PartitionKey partitionKey = new PartitionKey(request.produceName());
        findByProduceName(request.produceName()).ifPresent(produce -> {
            System.out.println("MENU TO BE DELETED" + produce + " :ID: " + produce.getId());
            farmProduceRepository.deleteById(produce.getId(), partitionKey);
        });
    }

    @Override
    public Produce updateProduce(ProduceRequest request) {
        Optional<Produce> produce = findByProduceName(request.produceName());

        if (produce.isPresent()) {
            Produce updatedProduce = produce.get();

            if (request.produceName() != null)
                updatedProduce.setProduceName(request.produceName());
            if (request.quantity() != null)
                updatedProduce.setQuantity(request.quantity());
            if (request.harvestTime() != null )
                updatedProduce.setHarvestTime(request.harvestTime());
            if (request.price() != null)
                updatedProduce.setPrice(request.price());

            return farmProduceRepository.save(updatedProduce);
        }

        return null;
    }

    @Override
    public Optional<Produce> findByProduceName(String produceName) {   
        return farmProduceRepository.findByProduceName(produceName);    
    }

}
