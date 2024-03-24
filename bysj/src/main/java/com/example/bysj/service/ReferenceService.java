package com.example.bysj.service;

import com.example.bysj.pojo.Reference;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReferenceService {
    public List<Reference> getAllReference(@Param("aname") String aname, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);

    public int getReferenceCounts(@Param("aname") String aname);

    public int addReference(Reference reference);

    public Reference getUpdateReference(int id);

    public int editReference(Reference reference);

    public int deleteReference(int id);
}
