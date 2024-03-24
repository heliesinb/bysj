package com.example.bysj.dao;

import com.example.bysj.pojo.Reference;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReferenceDao {
    public List<Reference> getAllReference(@Param("aname") String aname, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);

    public int getReferenceCounts(@Param("aname") String aname);

    public int addReference(Reference reference);

    public Reference getUpdateReference(int id);

    public int editReference(Reference reference);

    public int deleteReference(int id);
}
