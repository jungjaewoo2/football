package football.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/test")
public class TestController {
    
    @GetMapping("/hello")
    @ResponseBody
    public String hello() {
        return "Hello, Test Controller is working!";
    }
    
    @GetMapping("/register_schedule")
    @ResponseBody
    public String testRegisterSchedule() {
        return "Register Schedule Test - Controller is working!";
    }
}
