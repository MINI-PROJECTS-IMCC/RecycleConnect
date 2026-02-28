package com.example.Backend.Services;

import com.example.Backend.Entities.User; // to use class 'User'
import com.example.Backend.Repositories.UserRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service 
public class UserServices {

    @Autowired
    UserRepo ref; // ref will be used to perform database related operations

    private boolean epValidation(String email,String password) // Email and password validation
     {
       boolean result = true; // let's assume email and password is valid 

       // Email regex
       String emailPattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
   
       // Password regex:
       // 8–12 chars, 1 digit, 1 uppercase, 1 special
       String passPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,12}$";

       // Validation
        if (email == null || !email.matches(emailPattern)) // empty email or email is not empty but invalid 
        {
           // msg = "Invalid email format";
           result = false;
        }
       else if (password == null || !password.matches(passPattern)) // empty password or password is not empty but invalid
        {
            // msg = "Password must be 8-12 chars, 1 uppercase, 1 digit, 1 special";
            result = false;
        }
       System.out.println("epValidation() returns "+result);
       return (result);
     }
    public boolean login(String email,String password)
     {
       //String msg = "";
       boolean result = false; // let's assume email address don't match or password is wrong 
       if(epValidation(email, password)!=false) // Valid email and password
       {
         System.out.println("Valid email and password");
         User temp = ref.findByEmail(email);
  
         if(temp!=null && temp.getPassword().equals(password)) // Registered email and password match
          {
            // msg = "Login successful";
            result = true;
          }
         else if(temp!=null && !temp.getPassword().equals(password)) // Registered email but wrong password
          {
            //msg = "wrong password";
            result = false;
          }
         else 
         {
           //msg = "Email Address is not registered";
           result = false;
         }
       }
      System.out.println(result);
      return result;
     }
    public boolean createAccount(User user)
     {
       System.out.println(user.toString());
       boolean result = false;
       // String msg = "";
       if(epValidation(user.getEmail(), user.getPassword())!=false) // Valid email and password
       {
          if (ref.findByEmail(user.getEmail())!=null) // If username already used
           {
              //msg = "Username already exists";
              result = false;
           } 
          else // If username doesn't exists already - then add it
           { 
             ref.save(user);
             //msg = "Account created successfully"
             result = true;
           }
        }
       return (result);
     } // method ends here
}
