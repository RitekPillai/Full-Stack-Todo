package com.example.FullStackTodo.Controllers;


import com.example.FullStackTodo.DTO.LoginRequestDTO;
import com.example.FullStackTodo.DTO.LoginResponseDTO;
import com.example.FullStackTodo.DTO.SignUpUserDto;
import com.example.FullStackTodo.DTO.TokenRefreshResponseDTO;
import com.example.FullStackTodo.Models.RefreshToken;
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

        @PostMapping("/refresh")
    public ResponseEntity<TokenRefreshResponseDTO> refreshToken(@RequestBody String token) throws Exception {
        return refreshTokenService.refreshToken(token);
        }


}
