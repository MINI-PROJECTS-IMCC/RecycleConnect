package com.example.Backend.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // to use @Controller
import org.springframework.web.bind.annotation.*; // tp use @RequestMapping,@PostMapping ,e.t.c
import org.springframework.web.servlet.ModelAndView;

import com.example.Backend.Repositories.UserRepo; // to use 'UserRepo' repository
import com.example.Backend.Entities.User; // to use class 'User'

@Controller
public class UserController {

    @Autowired
    UserRepo ref; // ref will be used to perform database related operations

    @RequestMapping
    public String accountCreation()
     {
       
       return "getUser";
     }
    @RequestMapping("login")
    @ResponseBody
    public String login(String email,String password)
     {
       String msg = ""; // Empty string

        // Email regex
       String emailPattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.com$";
   
       // Password regex:
       // 8–12 chars, 1 digit, 1 uppercase, 1 special
       String passPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,12}$";

       // Validation and verification(else block -> verification) 
        if (email == null || !email.matches(emailPattern)) // empty email or email is not empty but invalid 
        {
          msg = "Invalid email format";
        }
       else if (password == null || !password.matches(passPattern)) // empty password or password is not empty but invalid
        {
            msg = "Password must be 8-12 chars, 1 uppercase, 1 digit, 1 special";
        }
       else // If everything is correct - valid email and password
        {
           User temp = ref.findByEmail(email);

           if(temp!=null && temp.getPassword().equals(password)) // Registered email and password match
            {
              msg = "Login successful";
            }
           else if(temp!=null && !temp.getPassword().equals(password)) // Registered email but wrong password
            msg = "wrong password";
           else 
            msg = "Email Address is not registered";
        } 
        return msg;
     }
    @RequestMapping("createAccount")
    @ResponseBody // Used to return the string not the view 
    public String createAccount(/*String email,String password*/User user)
     {
       String msg = "";

       // Email regex
       String emailPattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.com$";
   
       // Password regex:
       // 8–12 chars, 1 digit, 1 uppercase, 1 special
       String passPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,12}$";
   
       if (user.getEmail() == null || !user.getEmail().matches(emailPattern)) // empty email or email is not empty but invalid 
        {
          msg = "Invalid email format";
        }
       else if (user.getPassword() == null || !user.getPassword().matches(passPattern)) // empty password or password is not empty but invalid
        {
            msg = "Password must be 8-12 chars, 1 uppercase, 1 digit, 1 special";
        }
       else // If everything is correct - valid email and password
        {
           ref.save(user);
           msg = "Account created successfully";
        }
        return (msg);
     }
    
}
