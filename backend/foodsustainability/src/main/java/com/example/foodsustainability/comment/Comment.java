package com.example.foodsustainability.comment;

import java.util.Date;

import org.springframework.data.annotation.Id;
import com.azure.spring.data.cosmos.core.mapping.Container;
import com.azure.spring.data.cosmos.core.mapping.PartitionKey;
@Container(containerName = "comment")

public class Comment {
    // Like includes: Date, message, sender info , receiver info
    @Id
    private String id;
    private String date;
    private String message;
    @PartitionKey
    private String senderEntity; // the farm / restaurant name comment was sent from
    private String senderRole; // who the message is coming from, (farmer, restaurant, customer)
    private String receiverEntity; // the farm / restaurant name comment was sent to 
    private String receiverRole; // who the message is being sent to (farmer, restaurant)
    
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public String getSenderEntity() {
        return senderEntity;
    }
    public void setSenderEntity(String senderEntity) {
        this.senderEntity = senderEntity;
    }
    public String getSenderRole() {
        return senderRole;
    }
    public void setSenderRole(String senderRole) {
        this.senderRole = senderRole;
    }
    public String getReceiverEntity() {
        return receiverEntity;
    }
    public void setReceiverEntity(String receiverEntity) {
        this.receiverEntity = receiverEntity;
    }
    public String getReceiverRole() {
        return receiverRole;
    }
    public void setReceiverRole(String receiverRole) {
        this.receiverRole = receiverRole;
    }
    
}
