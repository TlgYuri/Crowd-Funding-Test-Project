package com.yuri.crowdfunding.mapper;

import com.yuri.crowdfunding.bean.TRolePermission;
import com.yuri.crowdfunding.bean.TRolePermissionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TRolePermissionMapper {
    long countByExample(TRolePermissionExample example);

    int deleteByExample(TRolePermissionExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TRolePermission record);

    int insertSelective(TRolePermission record);

    List<TRolePermission> selectByExample(TRolePermissionExample example);

    TRolePermission selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TRolePermission record, @Param("example") TRolePermissionExample example);

    int updateByExample(@Param("record") TRolePermission record, @Param("example") TRolePermissionExample example);

    int updateByPrimaryKeySelective(TRolePermission record);

    int updateByPrimaryKey(TRolePermission record);

	int assignPermissionToRole(@Param("roleId") Integer roleId, @Param("permissionIds") List<Integer> permissionIds);

	List<Integer> selectPermissionByRoleId(Integer roleId);

	int deleteByRoleId(Integer roleId);
	
}