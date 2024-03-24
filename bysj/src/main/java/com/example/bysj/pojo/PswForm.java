package com.example.bysj.pojo;

import lombok.Data;

@Data
public class PswForm {
    private String username;
    private String oldPsw;
    private String newPsw;
    private String surePsw;

}
