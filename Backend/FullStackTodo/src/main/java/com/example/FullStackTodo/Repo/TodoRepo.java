package com.example.FullStackTodo.Repo;

import com.example.FullStackTodo.Models.Todo;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface TodoRepo extends MongoRepository<Todo,Long> {

    public Todo getTodoById(long id);

    List<Todo> findAllByUserId(long id);
}
