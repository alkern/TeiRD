package main.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RenderController {

    @RequestMapping("/render")
    public String render() {
        return "test";
    }
}
