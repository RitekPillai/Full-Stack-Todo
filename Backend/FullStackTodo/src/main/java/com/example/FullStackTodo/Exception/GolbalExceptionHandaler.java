package com.example.FullStackTodo.Exception;

import io.jsonwebtoken.JwtException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.nio.file.AccessDeniedException;

@RestControllerAdvice
public class GolbalExceptionHandaler {


    @ExceptionHandler(UsernameNotFoundException.class)
    public ResponseEntity<ApiError> handleUsernameNotFoundException(UsernameNotFoundException e){
        ApiError apiError = new ApiError("Username not found with Given Username:"+e.getMessage(), HttpStatus.NOT_FOUND);
        return new ResponseEntity<>(apiError,HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(AuthenticationException.class)
    public ResponseEntity<ApiError> handleAuthenticationException(AuthenticationException authenticationException){
         ApiError apiError = new ApiError("Authentication Failed:"+authenticationException.getMessage(), HttpStatus.UNAUTHORIZED);
         return new ResponseEntity<>(apiError,apiError.getStatusCode());
    }

@ExceptionHandler(JwtException.class)
    public ResponseEntity<ApiError> handleJwtException(JwtException jwtException){
        ApiError apierror = new ApiError("Invaild JWT Token:"+jwtException.getMessage(),HttpStatus.UNAUTHORIZED);
        return new ResponseEntity<>(apierror,apierror.getStatusCode());
}

@ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ApiError> handleAcessDeniedException(AccessDeniedException e){
        ApiError apierror = new ApiError("Acess denied: Insuffient permission:"+e.getMessage(),HttpStatus.FORBIDDEN);
        return new ResponseEntity<>(apierror,apierror.getStatusCode());
}
@ExceptionHandler(Exception.class)
    public ResponseEntity<ApiError> handleException(Exception e){
        ApiError apierror  = new ApiError("An Unexcepted Error Occured: "+e.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        return new ResponseEntity<>(apierror,apierror.getStatusCode());
    }

}
