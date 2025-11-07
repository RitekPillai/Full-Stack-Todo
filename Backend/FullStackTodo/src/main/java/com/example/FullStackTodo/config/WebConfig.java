//package com.example.FullStackTodo.config;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.CorsRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
//// Spring Boot Example: CORS Configuration
//@Configuration
//public class WebConfig implements WebMvcConfigurer {
//
//    @Override
//    public void addCorsMappings(CorsRegistry registry) {
//        registry.addMapping("/**") // Apply to all endpoints
//                .allowedOrigins("*") // ⚠️ Use for testing only!
//                .allowedMethods("GET", "POST", "PUT", "DELETE")
//
//          .allowedHeaders("*")
//                .allowCredentials(true);
//    }
//}