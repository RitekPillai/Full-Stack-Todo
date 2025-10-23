package com.example.FullStackTodo.Services;


import com.example.FullStackTodo.Models.DatabaseSequence;
import com.example.FullStackTodo.Models.Todo;

import com.example.FullStackTodo.Repo.TodoRepo;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;



import static org.springframework.data.mongodb.core.FindAndModifyOptions.options;
import static org.springframework.data.mongodb.core.query.Criteria.where;
import static org.springframework.data.mongodb.core.query.Query.query;

@Service
public class TodoService {
    private TodoRepo repo;
    private MongoOperations mongoOperations ;

    public  TodoService(TodoRepo repo, MongoOperations mongoOperations){
        this.repo = repo;
        this.mongoOperations = mongoOperations;

    }

    public long generateSequence(String seqName) {
        DatabaseSequence counter = mongoOperations.findAndModify(query(where("_id").is(seqName)),
                new Update().inc("seq",1), options().returnNew(true).upsert(true),
                DatabaseSequence.class);
        return !Objects.isNull(counter) ? counter.getSeq() : 1;
    }

    public Todo addTodo(Todo todo){


        todo.setId(generateSequence(Todo.SEQUENCE_NAME));
        todo.setCreationDate(LocalDate.now());


       return repo.save(todo);

    }

    public List<Todo> getAllTodos() {
        return repo.findAll();
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
        repo.save(tempTodo);
        return "Update Done...";
        }
        return  "Update Failed";

    }
}
