package com.example.bysj.dao;

import com.example.bysj.pojo.CosFile;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CosFileDao {
    public List<CosFile> getAllFile(@Param("filename") String filename, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);

    public int getFileCounts(@Param("filename") String filename);

    public int addFile(CosFile cos_file);
}
