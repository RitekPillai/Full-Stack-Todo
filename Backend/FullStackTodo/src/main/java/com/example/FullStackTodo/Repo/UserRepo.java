package com.example.FullStackTodo.Repo;

import com.example.FullStackTodo.Models.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface UserRepo extends MongoRepository<User,Long> {
    User findByEmail(String email);

    User findByUsername(String name);
}
