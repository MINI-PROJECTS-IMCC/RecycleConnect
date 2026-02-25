package com.example.Backend.Controller;
import org.springframework.stereotype.Controller; // to use @Controller
import org.springframework.web.bind.annotation.RequestMapping; // to use @RequestMapping
import com.example.Backend.Entities.*;
@Controller
public class HomeController {

    @RequestMapping("/")
    public String home()
     {
        return "index";
     }
}
