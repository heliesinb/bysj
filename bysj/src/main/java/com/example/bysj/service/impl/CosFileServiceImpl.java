package com.example.bysj.service.impl;

import com.alibaba.fastjson.JSON;
import com.example.bysj.dao.CosFileDao;
import com.example.bysj.pojo.CosFile;
import com.example.bysj.service.CosFileService;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.model.CannedAccessControlList;
import com.qcloud.cos.model.PutObjectRequest;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CosFileServiceImpl implements CosFileService {
    @Value("${spring.tengxun.SecretId}")
    private String secretId;
    @Value("${spring.tengxun.SecretKey}")
    private String secretKey;

    @Value("${spring.tengxun.region}")
    private String region;

    @Value("${spring.tengxun.bucketName}")
    private String bucketName;

    @Value("${spring.tengxun.url}")
    private String path;

    @Autowired
    private COSClient cosClient;
    @Autowired
    private CosFileDao cosFileDao;

    @Override
    public String upload(MultipartFile file) {
//        ResponseDto responseDto = null;
        CosFile cos_file = new CosFile();
        try {
            String originalfileName = file.getOriginalFilename();
            cos_file.setFilename(originalfileName);
            // 获得文件流
            InputStream inputStream = file.getInputStream();
            //设置文件key
            String filePath = getFileKey(originalfileName);
            Date date = new Date();
            SimpleDateFormat dateFormat_min=new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
            String localTime = dateFormat_min.format(date);
            cos_file.setDate(localTime);
            // 上传文件
            cosClient.putObject(new PutObjectRequest(bucketName, filePath, inputStream, null));
            cosClient.setBucketAcl(bucketName, CannedAccessControlList.PublicRead);
            String url = path + "/" + filePath;
            cos_file.setUrl(url);
            cosFileDao.addFile(cos_file);
            Map<String, Object> map = new HashMap<>();
            map.put("fileName", originalfileName);
            map.put("url", url);
            map.put("status",200);
            map.put("msg","上传成功!");
//            cosClient.shutdown();
            return JSON.toJSONString(map);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> map = new HashMap<>();
            map.put("status",400);
            map.put("msg","上传失败!");
            return JSON.toJSONString(map);

        }



    }
    /**
     * 生成文件路径
     *
     * @return
     */
    public String getFileKey(String originalfileName) {
        String filePath = "file/";
        filePath +=  new DateTime().toString("yyyyMMddHHmmss") + "_" + originalfileName;
        return filePath;
    }

    @Override
    public List<CosFile> getAllFile(String filename, int pageStart, int pageSize) {
        return cosFileDao.getAllFile(filename, pageStart, pageSize);
    }

    @Override
    public int getFileCounts(String filename) {
        return cosFileDao.getFileCounts(filename);
    }

    @Override
    public int addFile(CosFile cos_file) {
        return cosFileDao.addFile(cos_file);
    }
}
