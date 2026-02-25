package com.example.Backend.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "item")
public class Item {


    // Member variables

       @Id // primary key 
       @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-increment , starts from 1
       @Column(name = "item_id")
       private Long itemId;

       @ManyToOne
       @JoinColumn(name = "request_id")
       private PickupRequest request;

       @ManyToOne
       @JoinColumn(name = "user_id")
       private User user;

       @Column(name = "item_type")
       private String itemType; // Values :- Plastic/Paper/Metal/E-waste

       private int quantity;

       public Item() {
       }

       public Item(PickupRequest request, User user, String itemType, int quantity) {
           // not setting the itemId because value of item_id will be set by DB - Autoincrement
           this.request = request;
           this.user = user;
           this.itemType = itemType;
           this.quantity = quantity;
       }

       public Long getItemId() {
           return itemId;
       }

       public void setItemId(Long itemId) {
           this.itemId = itemId;
       }

       public PickupRequest getRequest() {
           return request;
       }

       public void setRequest(PickupRequest request) {
           this.request = request;
       }

       public User getUser() {
           return user;
       }

       public void setUser(User user) {
           this.user = user;
       }

       public String getItemType() {
           return itemType;
       }

       public void setItemType(String itemType) {
           this.itemType = itemType;
       }

       public int getQuantity() {
           return quantity;
       }

       public void setQuantity(int quantity) {
           this.quantity = quantity;
       }

    
}
