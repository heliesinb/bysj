package com.example.bysj.service;

import com.example.bysj.pojo.CosFile;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface CosFileService {
    public String upload(MultipartFile file);

    public String getFileKey(String originalfileName);

    public List<CosFile> getAllFile(@Param("filename") String filename, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);

    public int getFileCounts(@Param("filename") String filename);

    public int addFile(CosFile cos_file);
}
