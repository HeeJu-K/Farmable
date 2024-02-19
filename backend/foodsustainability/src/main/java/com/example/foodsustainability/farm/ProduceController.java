package com.example.foodsustainability.farm;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/farm")

public class ProduceController {
    private final ProduceService produceService;

    @GetMapping
    public List<Produce> getProduces(){
        return produceService.getProduces();
    }

    @PostMapping("/add")
    public String addProduce(@RequestBody ProduceRequest AddProduceRequest, final HttpServletRequest request) {
        produceService.addProduce(AddProduceRequest);
        return "Success! Produce is added";
    }

    @PostMapping("/delete")
    public String deleteProduce(@RequestBody ProduceRequest DeleteProduceRequest, final HttpServletRequest request) {
        produceService.deleteProduce(DeleteProduceRequest);
        return "Success! Produce is deleted";
    }

    @PutMapping("/update")
    public String updateProduce(@RequestBody ProduceRequest UpdateProduceRequest, final HttpServletRequest request) {
        produceService.updateProduce(UpdateProduceRequest);
        return "Success! Produce is updated";
    }

    @GetMapping("/get")
    public Optional<Produce> getProduceDetails(@RequestBody ProduceRequest getProduceDetailsRequest, final HttpServletRequest request) {
        Optional<Produce> Produce = produceService.findByProduceName(getProduceDetailsRequest.produceName());
        return Produce;
    }
    
}
