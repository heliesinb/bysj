package com.example.bysj.service.impl;

import com.example.bysj.dao.ReferenceDao;
import com.example.bysj.pojo.Reference;
import com.example.bysj.service.ReferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReferenceServiceImpl implements ReferenceService {
    @Autowired
    ReferenceDao referenceDao;

    @Override
    public List<Reference> getAllReference(String aname, int pageStart, int pageSize) {
        return referenceDao.getAllReference(aname, pageStart, pageSize);
    }

    @Override
    public int getReferenceCounts(String aname) {
        return referenceDao.getReferenceCounts(aname);
    }

    @Override
    public int addReference(Reference reference) {
        return referenceDao.addReference(reference);
    }

    @Override
    public Reference getUpdateReference(int id) {
        return referenceDao.getUpdateReference(id);
    }

    @Override
    public int editReference(Reference reference) {
        return referenceDao.editReference(reference);
    }

    @Override
    public int deleteReference(int id) {
        return referenceDao.deleteReference(id );
    }
}
