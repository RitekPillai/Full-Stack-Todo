package com.example.FullStackTodo.Models;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
@Data

@Document(collection = "user_database_sequences")
public class userDatabaseSequence {



        @Id
        private String id;

        private long seq;



}
