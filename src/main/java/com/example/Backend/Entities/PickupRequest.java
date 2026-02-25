package com.example.Backend.Entities;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Entity
@Table(name = "pickup_request")
public class PickupRequest {

    @Id // Primaray key
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-increment , starts from 1
    @Column(name = "request_id")
    private Long requestId; 

    @ManyToOne
    @JoinColumn (name = "user_id")
    private User user; // Foreign key column

    @ManyToOne
    @JoinColumn(name = "recycler_id")
    private Recycler recycler; // Foreign key column

    @Column(name = "request_date")
    private LocalDateTime requestDate;

    private String status;

    // No-args constructor (required by JPA)
    public PickupRequest() {}

    // Parameterized constructor
    public PickupRequest(User user, Recycler recycler, LocalDateTime requestDate, String status) {
        // not setting the requestId because value of request_id will be set by DB - Autoincrement
        this.user = user;
        this.recycler = recycler;
        this.requestDate = requestDate;
        this.status = status;
    }

    // Getters and Setters
    public Long getRequestId() { return requestId; }
    public void setRequestId(Long requestId) { this.requestId = requestId; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Recycler getRecycler() { return recycler; }
    public void setRecycler(Recycler recycler) { this.recycler = recycler; }

    public LocalDateTime getRequestDate() { return requestDate; }
    public void setRequestDate(LocalDateTime requestDate) { this.requestDate = requestDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

}
