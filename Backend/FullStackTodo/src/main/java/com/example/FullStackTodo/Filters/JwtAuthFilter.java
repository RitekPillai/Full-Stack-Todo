package com.example.FullStackTodo.Filters;

import com.example.FullStackTodo.Models.User;
import com.example.FullStackTodo.Repo.UserRepo;
import com.example.FullStackTodo.Services.AuthUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.servlet.HandlerExceptionResolver;

import java.io.IOException;
@RequiredArgsConstructor
@Component
@Slf4j
public class JwtAuthFilter extends OncePerRequestFilter {
    @Autowired
    private final UserRepo userRepo;
    @Autowired
    private final AuthUtil authUtil;

    @Autowired
    private final HandlerExceptionResolver handlerExceptionResolver;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        try {
            log.info("incoming request: {}", request.getRequestURI());

            final String requestHeaderToken = request.getHeader("Authorization");
            if (requestHeaderToken == null || !requestHeaderToken.startsWith("Bearer")) {
                filterChain.doFilter(request, response);
                return;
            }
            String token = requestHeaderToken.split("Bearer ")[1];
            String email = authUtil.getUsernamefromToken(token);
            log.info("EMAIL OF THE USER ______________: {}", token);
            if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                User user = userRepo.findByEmail(email);
                UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
                SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);

            }
            filterChain.doFilter(request, response);
        } catch (Exception e) {
           handlerExceptionResolver.resolveException(request,response,null,e);
        }
    }
}