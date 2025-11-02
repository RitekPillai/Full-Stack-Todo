package com.example.FullStackTodo.Controllers;


import com.example.FullStackTodo.DTO.LoginRequestDTO;
import com.example.FullStackTodo.DTO.LoginResponseDTO;
import com.example.FullStackTodo.DTO.SignUpUserDto;
import com.example.FullStackTodo.Services.WebSecurityService;
import io.jsonwebtoken.Jwts;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Key;
import java.util.Base64;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final WebSecurityService webSecurityService;

    public AuthController(WebSecurityService webSecurityService){
        this.webSecurityService = webSecurityService;
    }


        @PostMapping("/signup")
    public ResponseEntity<SignUpUserDto> signUp(
           @RequestBody SignUpUserDto signUpUserDto
        ) throws Exception {
            return webSecurityService.signUp(signUpUserDto);
        }
        
        @PostMapping("/login")
    public LoginResponseDTO login(
                @RequestBody LoginRequestDTO loginRequestDTO
                ){

        return webSecurityService.login(loginRequestDTO);
        
        }


}
