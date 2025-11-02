package com.example.FullStackTodo.Services;


import com.example.FullStackTodo.Models.DatabaseSequence;
import com.example.FullStackTodo.Models.Todo;

import com.example.FullStackTodo.Models.User;
import com.example.FullStackTodo.Repo.TodoRepo;
import io.jsonwebtoken.Jwt;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;



import static org.springframework.data.mongodb.core.FindAndModifyOptions.options;
import static org.springframework.data.mongodb.core.query.Criteria.where;
import static org.springframework.data.mongodb.core.query.Query.query;

@Service
public class TodoService {
    private final TodoRepo repo;
    private final MongoOperations mongoOperations ;
    private final DatabaseSeqService databaseSeqService ;


    public  TodoService(TodoRepo repo, MongoOperations mongoOperations, DatabaseSeqService databaseSeqService){
        this.repo = repo;
        this.mongoOperations = mongoOperations;

        this.databaseSeqService = databaseSeqService;
    }
/// getting the userId for personal Todos
    public long getUserId() throws Exception {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal!=null){
            User user = (User) principal;
            return user.getId();
        }
        throw  new Exception("user is not Authenticated");
    }



    public Todo addTodo(Todo todo) throws Exception {


        todo.setId(databaseSeqService.generateSequence(Todo.SEQUENCE_NAME));
        todo.setCreationDate(LocalDate.now());

        todo.setUserId(getUserId());
       return repo.save(todo);

    }

    public List<Todo> getAllTodos() throws Exception {
    long id = getUserId();
        return repo.findAllByUserId(id);
    }

    public String deleteTodo(long id) {


        repo.deleteById(id);
        return  "Deleted....";
    }


    public String updateTodo(long id, Todo todo) {
        Todo tempTodo = repo.getTodoById(id);

        if(tempTodo != null){
        tempTodo.setName(todo.getName());
        tempTodo.setDescription(todo.getDescription());
        tempTodo.setIsCompleted(todo.getIsCompleted());
        tempTodo.setDueDate(todo.getDueDate());
        tempTodo.setDueTime(todo.getDueTime());
            tempTodo.setTaskStatus(todo.getTaskStatus());
            tempTodo.setSubTasks(todo.getSubTasks());
        repo.save(tempTodo);
        return "Update Done...";
        }
        return  "Update Failed";

    }
}
