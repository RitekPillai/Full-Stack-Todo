package com.example.FullStackTodo.Controllers;


import com.example.FullStackTodo.DTO.*;
import com.example.FullStackTodo.Models.RefreshToken;
import com.example.FullStackTodo.Models.User;
import com.example.FullStackTodo.Services.RefreshTokenService;
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

    private final RefreshTokenService refreshTokenService;

    public AuthController(WebSecurityService webSecurityService, RefreshTokenService refreshTokenService){
        this.webSecurityService = webSecurityService;
        this.refreshTokenService = refreshTokenService;
    }


        @PostMapping("/signup")
    public ResponseEntity<UserResponseDto> signUp(
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

        @PostMapping("/refresh")
    public ResponseEntity<TokenRefreshResponseDTO> refreshToken(@RequestBody String token) throws Exception {
        return refreshTokenService.refreshToken(token);
        }

        @GetMapping("/user")

    public UserResponseDto getAuthenticatedUser(

        ) throws Exception {
        return  refreshTokenService.getAuthenticatedUser();
        }

}
