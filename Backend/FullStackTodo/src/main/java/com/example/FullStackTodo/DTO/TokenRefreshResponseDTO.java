package com.example.FullStackTodo.DTO;

import lombok.Data;

@Data
public class TokenRefreshResponseDTO {
    private String accessToken;
    private String refreshToken;
    private Long id;


    public TokenRefreshResponseDTO(String accessToken, String refreshToken,Long id) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
        this.id = id;
    }
}
