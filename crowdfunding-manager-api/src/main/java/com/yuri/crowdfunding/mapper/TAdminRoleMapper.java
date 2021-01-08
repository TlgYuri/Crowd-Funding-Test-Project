package com.yuri.crowdfunding.mapper;

import com.yuri.crowdfunding.bean.TAdminRole;
import com.yuri.crowdfunding.bean.TAdminRoleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TAdminRoleMapper {
    long countByExample(TAdminRoleExample example);

    int deleteByExample(TAdminRoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TAdminRole record);

    int insertSelective(TAdminRole record);

    List<TAdminRole> selectByExample(TAdminRoleExample example);

    TAdminRole selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TAdminRole record, @Param("example") TAdminRoleExample example);

    int updateByExample(@Param("record") TAdminRole record, @Param("example") TAdminRoleExample example);

    int updateByPrimaryKeySelective(TAdminRole record);

    int updateByPrimaryKey(TAdminRole record);

	List<Integer> selectRoleIdByAdminId(@Param("adminId") Integer adminId);

	int assignRoleToAdmin(@Param("adminId") Integer adminId, @Param("roleIds") Integer[] roleIds);

	int revokeRoleFromAdmin(@Param("adminId") Integer adminId, @Param("roleIds") Integer[] roleIds);
}