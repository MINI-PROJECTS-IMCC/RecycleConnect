package com.example.Backend.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // to use @Controller
import org.springframework.web.bind.annotation.*; // tp use @RequestMapping,@PostMapping ,e.t.c
import org.springframework.web.servlet.ModelAndView;
import com.example.Backend.Services.UserServices;
import com.example.Backend.Repositories.UserRepo; // to use 'UserRepo' repository
import com.example.Backend.DTO.EmailPassword;
import com.example.Backend.Entities.User; // to use class 'User'

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api")
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

    @PostMapping("/login")
    @ResponseBody
    public boolean login(@RequestBody EmailPassword ep){
       System.out.println("In the login()");
       System.out.println(ep.getEmail()+" "+ep.getPassword());
       return(us.login(ep.getEmail(),ep.getPassword()));
     }
    @PostMapping("/createAccount")
    @ResponseBody // Used to return the string not the view 
    public boolean createAccount(@RequestBody User user) // @RequestBody is used when json data is coming from frontend and we want to store it into object directly
     {
        return (us.createAccount(user));
     }
}
