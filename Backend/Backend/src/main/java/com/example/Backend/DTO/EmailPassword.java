package com.example.Backend.DTO;

public class EmailPassword {

    // Member variables
    private String email;
    private String password;
    // Member functions
  
  // 0 args constructor 
  public EmailPassword() {
  }

  // Parameterized cosnstructor
  public EmailPassword(String email, String password) {
    this.email = email;
    this.password = password;
  }

  // Getters and setters
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
}
