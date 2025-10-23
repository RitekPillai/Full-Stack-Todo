package com.example.FullStackTodo.Repo;

import com.example.FullStackTodo.Models.Todo;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface TodoRepo extends MongoRepository<Todo,Long> {

    public Todo getTodoById(long id);
}
