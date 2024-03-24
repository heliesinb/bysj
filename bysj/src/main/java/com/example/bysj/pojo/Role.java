package com.example.bysj.pojo;
import lombok.Data;

@Data
public class Role {
    private Integer roleId;
    private String roleName,ps;
    private Boolean status;
    private int sort;
    public Role() {
    }

    public Role(Integer roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }
}
