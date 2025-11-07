package com.example.FullStackTodo.Services;


import com.example.FullStackTodo.DTO.UserResponseDto;
import com.example.FullStackTodo.Models.RefreshToken;
import com.example.FullStackTodo.Models.User;
import com.example.FullStackTodo.Repo.RefreshTokenRepo;
import com.example.FullStackTodo.DTO.TokenRefreshResponseDTO;
import com.example.FullStackTodo.Repo.UserRepo;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.springframework.security.core.context.SecurityContextHolder.getContext;

@Service
public class RefreshTokenService {

    private final RefreshTokenRepo refreshTokenRepo;
    private final UserRepo userRepo;
    private final AuthUtil authUtil;


    public RefreshTokenService(RefreshTokenRepo refreshTokenRepo, UserRepo userRepo, AuthUtil authUtil) {
        this.refreshTokenRepo = refreshTokenRepo;
        this.userRepo = userRepo;
        this.authUtil = authUtil;
    }

    public RefreshToken generateToken(String email){
        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setToken(UUID.randomUUID().toString());
        long refreshTokenDurationMs = 30 * 24 * 60 * 60 * 1000L;
        refreshToken.setExpiryDate(Instant.now().plusMillis(refreshTokenDurationMs));
        refreshToken.setEmail(email);

        return  refreshTokenRepo.save(refreshToken);

    }
    public Optional<RefreshToken> findToken(String token){
        return refreshTokenRepo.findByToken(token);
    }

    public RefreshToken verifyExpiration(RefreshToken token){
        if(token.getExpiryDate().isBefore(Instant.now())){
            refreshTokenRepo.delete(token);
            throw new RuntimeException("Refresh token was expired. Please make a new sign-in request");
        }
        return token;
    }

    public ResponseEntity<TokenRefreshResponseDTO> refreshToken(String token) throws Exception {
      return findToken(token)
              .map(this::verifyExpiration)
              .map(RefreshToken::getEmail)
              .map(email ->{
                  User user = userRepo.findByEmail(email);
                  String newJwt = authUtil.generateJWTToken(user);

                  Long id = user.getId();

                  return ResponseEntity.ok(new TokenRefreshResponseDTO(newJwt,token,id));

              } ).orElseThrow(() -> new RuntimeException("Refresh token is not in database!"));

    }

    public UserResponseDto getAuthenticatedUser() throws Exception {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String errormesg = "";
        try{
            if(authentication.isAuthenticated()){
                String name = authentication.getName();
                System.out.println(name);
                User user  =   userRepo.findByUsername(name);
                return new UserResponseDto(user.getUsername(), user.getEmail());
            };
        } catch (Exception e) {
         errormesg =    e.getMessage();
            throw new RuntimeException(e.toString());
        }
      throw    new Exception("Error "+errormesg.toString());
    }
}
