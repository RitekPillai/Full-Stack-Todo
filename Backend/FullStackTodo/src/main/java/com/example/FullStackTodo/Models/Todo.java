package com.example.FullStackTodo.Models;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "Todo")
public class Todo {
    @Transient
    public static final String SEQUENCE_NAME = "todo_sequence";
    @Id
    private long id;
    private String name;
    private String Description;
    private Boolean isCompleted;
    private LocalDate creationDate;
    private LocalDate dueDate;
    private List<SubTask> subTasks;
    private LocalDateTime dueTime;
    private Status taskStatus;
    private Long userId;


}
