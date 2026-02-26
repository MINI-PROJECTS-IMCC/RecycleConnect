package com.example.Backend.Services;

import com.example.Backend.Entities.User; // to use class 'User'
import com.example.Backend.Repositories.UserRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service 
public class UserServices {

    @Autowired
    UserRepo ref; // ref will be used to perform database related operations

    public boolean isValid(String email,String password)
     {
       //String msg = "";
       boolean result = true; // Empty string

        // Email regex
       String emailPattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.com$";
   
       // Password regex:
       // 8–12 chars, 1 digit, 1 uppercase, 1 special
       String passPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,12}$";

       // Validation and verification(else block -> verification) 
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
       else // If everything is correct - valid email and password
        {
           User temp = ref.findByEmail(email);

           if(temp!=null && temp.getPassword().equals(password)) // Registered email and password match
            {
              // msg = "Login successful";
              result = true;
            }
           else if(temp!=null && !temp.getPassword().equals(password)) // Registered email but wrong password
            //msg = "wrong password";
            result = false;
           else 
            //msg = "Email Address is not registered";
            result = false;
        } 
        return result;
     }
    public boolean createAccount(User user)
     {
       boolean result;
       // String msg = "";
       if (ref.findByEmail(user.getEmail())==null) // If username already used
        {
           //msg = "Username already exists";
           result = false;

        }   
       else // Check for email and password validation 
        {
          result = isValid(user.getEmail(),user.getPassword());
          if(result) // email and password is valid
           {
             ref.save(user);
             //msg = "Account created successfully";
           }
        }
      return (result);
     }
}
