package com.example.FullStackTodo.Models;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "refreshToken")
public class RefreshToken {
    @Transient
    public static final String SEQUENCE_NAME = "RefreshToken_sequence";
    @Id
 private   String id;
    private String token;
    private String email;
    private Instant expiryDate;



}
