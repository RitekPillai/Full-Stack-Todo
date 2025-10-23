package com.example.FullStackTodo.Controllers;

import com.example.FullStackTodo.Models.Todo;
import com.example.FullStackTodo.Services.TodoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class TodoControllers {
    private final TodoService todoService;


    public TodoControllers(TodoService todoService){
        this.todoService = todoService;
    }

        @PostMapping
    public Todo  addTodo(
            @RequestBody Todo todo

        ){
            return todoService.addTodo(todo);
        }

        @GetMapping
    public List<Todo> getAllTodos(){
        return todoService.getAllTodos();
        }

        @DeleteMapping
    public String deleteTodo(
            @RequestParam long id
        ){
        return todoService.deleteTodo(id);
        }

        @PutMapping
    public String todoUpdate(
            @RequestParam long id,
            @RequestBody Todo todo
        ){
        return todoService.updateTodo(id,todo);
        }
 }
