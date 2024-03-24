package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.example.bysj.pojo.CosFile;
import com.example.bysj.pojo.QueryInfo;
import com.example.bysj.pojo.Result;
import com.example.bysj.service.impl.CosFileServiceImpl;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("file")
public class CosFileController {
    @Autowired
    public CosFileServiceImpl cosFileService;

    /**
     * 上传文件
     * @param file
     */
    @RequestMapping(value="/upload",method = RequestMethod.POST)
    public String upload(@RequestPart("file") MultipartFile file) {
        return cosFileService.upload(file);
    }
    @RequestMapping("/allFile")
    public String getFileList(QueryInfo queryInfo){
        System.out.println(queryInfo);
        //获取最大列表数和当前编号
        int numbers = cosFileService.getFileCounts("%"+queryInfo.getQuery()+"%");// 获取数据总数
        int pageStart = (queryInfo.getPageNum()-1)*queryInfo.getPageSize();

        List<CosFile> files = cosFileService.getAllFile("%"+queryInfo.getQuery()+"%",pageStart,queryInfo.getPageSize());
        Map<String, Object> map = new HashMap<>();
        map.put("numbers",numbers);
        map.put("data",files);
        System.out.println("总条数："+numbers);
        String file_json = JSON.toJSONString(map);
        return file_json;
    }
}
