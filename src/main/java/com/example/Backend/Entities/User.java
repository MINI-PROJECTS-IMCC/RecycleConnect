package com.example.Backend.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "user")
public class User {

    // Member variables 
        
    @Id // Primaray key
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-increment , starts from 1
    @Column(name = "user_id")
    private Long userId; 

    @Column(nullable = false) // Username can't be null - Full name of a user
    private String name;

    @Column(nullable = false,unique = true) // email can't be null and should be unique
    private String email;

    @Column(nullable = false) // password can't be null 
    private String password;

    private String phone;

    private String address;

    private String locality;

    // Constructors
    
    // No-args constructor (required by JPA)
    public User(){} 

    // Parameterized constructor
    public User(String name, String email, String password, String phone, String address, String locality) {
        // not setting the userId because value of user_id will be set by DB - Autoincrement
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.locality = locality;
    }

    
    // Getters and Setters

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLocality() {
        return locality;
    }

    public void setLocality(String locality) {
        this.locality = locality;
    }


}
