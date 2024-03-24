package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.example.bysj.pojo.QueryInfo;
import com.example.bysj.pojo.Reference;
import com.example.bysj.service.impl.ReferenceServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class ReferenceController {
    @Autowired
    ReferenceServiceImpl referenceService;

    @RequestMapping("/allReference")
    public String getReferenceList(QueryInfo queryInfo){
        System.out.println(queryInfo);
        //获取最大列表数和当前编号
        int numbers = referenceService.
                getReferenceCounts("%"+queryInfo.getQuery()+"%");// 获取数据总数
        int pageStart = (queryInfo.getPageNum()-1)*queryInfo.getPageSize();

        List<Reference> reference = referenceService.
                getAllReference("%"+queryInfo.getQuery()+"%",pageStart,queryInfo.getPageSize());
        Map<String, Object> res = new HashMap<>();
        res.put("numbers",numbers);
        res.put("data",reference);
        System.out.println("总条数："+numbers);
        String reference_json = JSON.toJSONString(res);
        return reference_json;
    }

    @RequestMapping("/addReference")
    public String addReference(@RequestBody Reference reference){
        int i = referenceService.addReference(reference);
        return i>0?"success":"error";
    }

    @RequestMapping("/deleteReference")
    public String deleteReference(int id){
        int i = referenceService.deleteReference(id);
        return i > 0 ? "success" : "error";
    }

    @RequestMapping("/getUpdateReference")
    public String getUpdateReference(int id){
        Reference reference = referenceService.getUpdateReference(id);
        String reference_json = JSON.toJSONString(reference);
        return reference_json;
    }

    @RequestMapping("/editReference")
    public String editReference(@RequestBody Reference reference){
        int i = referenceService.editReference(reference);
        return i > 0 ? "success" : "error";
    }
}
