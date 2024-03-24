package com.example.bysj.pojo;

import lombok.Data;

@Data
public class QueryInfo {
    private String query;
    private int pageNum=1;
    private int pageSize=1;
    private String username;
    private String time;

    public QueryInfo() {
    }

    public QueryInfo(String query, int pageNum, int pageSize, String username, String time) {
        this.query = query;
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.username = username;
        this.time = time;
    }

    @Override
    public String toString() {
        return "QueryInfo{" +
                "query='" + query + '\'' +
                ", pageNum=" + pageNum +
                ", pageSize=" + pageSize +
                ", username='" + username + '\'' +
                ", time='" + time + '\'' +
                '}';
    }
}
