package com.example.FullStackTodo.Repo;

import com.example.FullStackTodo.Models.RefreshToken;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.sql.Ref;
import java.util.Optional;

@Repository
public interface RefreshTokenRepo extends MongoRepository<RefreshToken,Long> {

    Optional<RefreshToken> findByToken(String token);

}
