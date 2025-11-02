package com.example.FullStackTodo.Services;

import com.example.FullStackTodo.Models.User;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.security.Key;
import java.util.Date;

@Component
public class AuthUtil {

    @Value("${jwt.key}")
    private String jwtSecretKeyBase64;



    public SecretKey getSecretKey(){
        byte[] keyBytes = Decoders.BASE64.decode(jwtSecretKeyBase64);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String generateJWTToken(User user){
        return Jwts.builder()
                .subject(user.getEmail())
                .claim("userId", user.getId())

                .issuedAt(new Date())
                // Token expires in 10 minutes (1000ms * 60s * 10m)
                .expiration(new Date(System.currentTimeMillis() + 1000 * 60 * 10))
                .signWith(getSecretKey())
                .compact();
    }

    public String getUsernamefromToken(String token) {
        Claims claims= Jwts.parser()
                .verifyWith(getSecretKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
        return claims.getSubject();
    }
}