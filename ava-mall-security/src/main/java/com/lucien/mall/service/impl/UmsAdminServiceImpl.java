package com.lucien.mall.service.impl;

import com.lucien.mall.dto.UmsAdminDto;
import com.lucien.mall.dto.UpdateAdminPasswordDto;
import com.lucien.mall.mapper.UmsAdminLoginLogMapper;
import com.lucien.mall.mapper.UmsAdminMapper;
import com.lucien.mall.mapper.UmsAdminRoleRelationMapper;
import com.lucien.mall.pojo.UmsAdmin;
import com.lucien.mall.pojo.UmsAdminExample;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;
import com.lucien.mall.service.UmsAdminService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/21
 * 后台用户service实现类
 */
@Service
public class UmsAdminServiceImpl implements UmsAdminService {

    @Autowired
    private UmsAdminMapper adminMapper;

    @Autowired
    private UmsAdminRoleRelationMapper roleRelationMapper;

    @Autowired
    private UmsAdminLoginLogMapper adminLoginLogMapper;


    @Override
    public String login(String username, String password) {
        return null;
    }

    @Override
    public UmsAdmin register(UmsAdminDto umsAdminDto) {
        UmsAdmin umsAdmin = new UmsAdmin();
        BeanUtils.copyProperties(umsAdminDto, umsAdmin);
        umsAdmin.setCreateTime(new Date());
        umsAdmin.setStatus(1);

        //检查重复名
        UmsAdminExample umsAdminExample = new UmsAdminExample();
        umsAdminExample.createCriteria().andUsernameEqualTo(umsAdminDto.getUsername());
        List<UmsAdmin> adminList = adminMapper.selectByExample(umsAdminExample);

        if(adminList.size() > 0){
            return null;
        }
        //使用springboot自带md5加密方式加密用户密码
        String md5Password = DigestUtils.md5DigestAsHex(umsAdminDto.getPassword().getBytes());
        umsAdmin.setPassword(md5Password);
        adminMapper.insert(umsAdmin);

        return umsAdmin;
    }

    @Override
    public UmsAdmin getAdminByUsername(String username) {
        return null;
    }

    @Override
    public UmsAdmin getItem(Long id) {
        return null;
    }

    @Override
    public int update(Long id, UmsAdmin admin) {
        return 0;
    }

    @Override
    public int delete(Long id) {
        return 0;
    }

    @Override
    public List<UmsRole> getRoleList(Long adminId) {
        return null;
    }

    @Override
    public List<UmsResource> getResourceList(Long adminId) {
        return null;
    }

    @Override
    public int updatePassword(UpdateAdminPasswordDto updateAdminPasswordDto) {
        return 0;
    }
}
