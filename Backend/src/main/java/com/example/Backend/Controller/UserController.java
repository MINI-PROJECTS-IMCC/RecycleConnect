package com.example.Backend.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // to use @Controller
import org.springframework.web.bind.annotation.*; // tp use @RequestMapping,@PostMapping ,e.t.c
import org.springframework.web.servlet.ModelAndView;
import com.example.Backend.Services.UserServices;

import com.example.Backend.Repositories.UserRepo; // to use 'UserRepo' repository
import com.example.Backend.Entities.User; // to use class 'User'

@Controller
public class UserController {

    @Autowired
    UserRepo ref; // ref will be used to perform database related operations

    @Autowired
    UserServices us;

    @RequestMapping
    public String accountCreation()
     {
       
       return "getUser";
     }

    @RequestMapping("login")
    @ResponseBody
    public boolean login(String email,String password)
     {
       return(us.isValid(email, password));
     }
    
    @RequestMapping("createAccount")
    @ResponseBody // Used to return the string not the view 
    public boolean createAccount(/*String email,String password*/User user)
     {
        return (us.createAccount(user));
     }
    
}
