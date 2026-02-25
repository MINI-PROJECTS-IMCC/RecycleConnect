package com.example.Backend.Entities;
import jakarta.persistence.*;

@Entity
@Table(name = "recycler")
public class Recycler {

    // Member variables 

    @Id // Primaray key
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-increment , starts from 1
    @Column(name = "recycler_id")
    private Long recyclerId; 

    @Column(nullable = false) // recycler name can't be null
    private String name;

    @Column(nullable = false, unique = true) // email can't be null and should be unique
    private String email;

    @Column(nullable = false) // password can't be null
    private String password;

    private String phone;

    @Column(name = "service_area")
    private String serviceArea;

    // Constructors

    // No-args constructor (required by JPA)
    public Recycler() {}

    // Parameterized constructor
    public Recycler(String name, String email, String password, String phone, String serviceArea) {
        // not setting the recyclerId because value of recycler_id will be set by DB - Autoincrement
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.serviceArea = serviceArea;
    }

    // Getters and Setters
    public Long getRecyclerId() { return recyclerId; }
    public void setRecyclerId(Long recyclerId) { this.recyclerId = recyclerId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getServiceArea() { return serviceArea; }
    public void setServiceArea(String serviceArea) { this.serviceArea = serviceArea; }
}
