package com.example.FullStackTodo.Services;

import com.example.FullStackTodo.Models.DatabaseSequence;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.Objects;

import static org.springframework.data.mongodb.core.FindAndModifyOptions.options;
import static org.springframework.data.mongodb.core.query.Criteria.where;
import static org.springframework.data.mongodb.core.query.Query.query;

@Service
public class DatabaseSeqService {


  private final  MongoOperations mongoOperations;

  public  DatabaseSeqService(MongoOperations mongoOperations) {
      this.mongoOperations = mongoOperations;
  }
    public long generateSequence(String seqName) {
        DatabaseSequence counter = mongoOperations.findAndModify(
                query(where("_id").is(seqName)),
                new Update().inc("seq", 1),
                options().returnNew(true).upsert(true),
                DatabaseSequence.class);

        return !Objects.isNull(counter) ? counter.getSeq() : 1;
    }
}
