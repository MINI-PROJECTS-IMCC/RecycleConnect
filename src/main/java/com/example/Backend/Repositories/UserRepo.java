package com.example.Backend.Repositories;

import com.example.Backend.Entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query; // to use @Query
import org.springframework.data.repository.query.Param; // to use @Param


import java.util.Optional;

public interface UserRepo extends JpaRepository<User, Long> {
    /* 
    @Query("SELECT u FROM User u WHERE u.email = :email") 
    Optional<User> getUserByEmail(@Param("email") String email);
    */
   // returns user object - if user found
   // returns null - if user doesn't exists
   User findByEmail(String email);

}
