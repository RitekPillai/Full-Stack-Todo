package com.example.FullStackTodo.Services;


import com.example.FullStackTodo.DTO.LoginRequestDTO;
import com.example.FullStackTodo.DTO.LoginResponseDTO;
import com.example.FullStackTodo.DTO.SignUpUserDto;
import com.example.FullStackTodo.Models.User;
import com.example.FullStackTodo.Repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class WebSecurityService {
        private final UserRepo userRepo;
    private final DatabaseSeqService databaseSeqService ;
    private final PasswordEncoder passwordEncoder;
    @Autowired
    private  AuthenticationManager authenticationManager;

    @Autowired
    private AuthUtil authUtil;

        public WebSecurityService(UserRepo userRepo,DatabaseSeqService databaseSeqService,PasswordEncoder passwordEncoder){
            this.userRepo = userRepo;
            this.databaseSeqService = databaseSeqService;
            this.passwordEncoder = passwordEncoder;
        }



    public ResponseEntity<SignUpUserDto> signUp(SignUpUserDto signUpUserDto) throws Exception {
        Optional<User> oUser =  userRepo.findByEmail(signUpUserDto.getEmail());
        if(oUser.isPresent()) throw new Exception("Email Already Exsist");
        long id= databaseSeqService.generateSequence(User.SEQUENCE_NAME);
        String encodePassword = passwordEncoder.encode(signUpUserDto.getPassword());
        User User = new User(id, signUpUserDto.getEmail(), signUpUserDto.getUsername(), encodePassword);
       User saveUser =  userRepo.save(User);
        SignUpUserDto signUpUserDto1 = new SignUpUserDto(saveUser.getUsername(), saveUser.getEmail(), saveUser.getPassword());
        return new ResponseEntity<>(signUpUserDto1, HttpStatus.CREATED);


    }

    public LoginResponseDTO login(LoginRequestDTO loginRequestDTO){
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(loginRequestDTO.getEmail(), loginRequestDTO.getPassword()));
        User user = (User) authentication.getPrincipal();
        String token = authUtil.generateJWTToken(user);

        return new LoginResponseDTO(token,user.getId() );
    }
}
