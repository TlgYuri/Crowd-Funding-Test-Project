<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zh-CN">

<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">

<%@ include file="/WEB-INF/jsp/common/css.jsp"%>

<link rel="stylesheet" href="${PATH}/static/css/main.css">
<link rel="stylesheet" href="${PATH}/static/css/doc.min.css">

<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}
</style>

</head>

<body>

	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<div>
					<a class="navbar-brand" style="font-size: 32px;" href="user.html">后台管理 - 用户角色分配</a>
				</div>
			</div>

			<jsp:include page="/WEB-INF/jsp/common/navbar.jsp" />

		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">

			<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
					<li><a href="#">首页</a></li>
					<li><a href="#">数据列表</a></li>
					<li class="active">分配角色</li>
				</ol>
				<div class="panel panel-default">
					<div class="panel-body">
						<form role="form" class="form-inline">

							<div class="form-group">
								<label>未分配角色列表</label><br> 
								<select class="form-control unassigned" multiple size="10" style="width: 200px; overflow-y: auto; height: 255px">
									<c:forEach items="${unassignedRoles }" var="role">
										<option value="${role.id}">${role.name}</option>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<ul>
									<li class="btn btn-default glyphicon glyphicon-chevron-right"></li>
									<br />
									<li class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top: 20px;"></li>
								</ul>
							</div>

							<div class="form-group" style="margin-left: 40px;">
								<label>已分配角色列表</label><br> 
								<select class="form-control assigned" multiple size="10" style="width: 200px; overflow-y: auto; height: 255px">
									<c:forEach items="${assignedRoles }" var="role">
										<option value="${role.id}">${role.name}</option>
									</c:forEach>
								</select>

							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
	<script src="${PATH}/static/script/docs.min.js"></script>

	<script type="text/javascript">
		$(function() {
			$(".list-group-item").click(function() {
				if ($(this).find("ul")) {
					$(this).toggleClass("tree-closed");
					if ($(this).hasClass("tree-closed")) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});

			$("menu3").css("color", "red");

		});

		$(".glyphicon-chevron-right").click(function() {
			var selected = $(".unassigned option:selected");
			var data = '';
			$.each(selected,function(i,e){
				data += "roleIds=" + e.value + "&";
			});
			data += "adminId=" + ${param.adminId};
			
			$.ajax({
				url : '${PATH}/role/assignRoleToAdmin',
				type : 'post',
				data : data ,
				success : function(data) {
					if(data > 0) {
						layer.msg("分配成功",{time:1000,icon:6});
						$(".assigned").append($(selected).clone());
						$(selected).remove();
					} else {
						layer.msg("分配失败",{time:1000,icon:5});
					}
				}
			});
		});
		
		$(".glyphicon-chevron-left").click(function() {
			var selected = $(".assigned option:selected");
			var data = '';
			$.each(selected,function(i,e){
				data += "roleIds=" + e.value + "&";
			});
			data += "adminId=" + ${param.adminId};
			
			$.ajax({
				url : '${PATH}/role/unassignRoleFromAdmin',
				type : 'post',
				data : data ,
				success : function(data) {
					if(data > 0) {
						layer.msg("取消分配成功",{time:1000,icon:6});
						$(".unassigned").append($(selected).clone());
						$(selected).remove();
					} else {
						layer.msg("取消分配失败",{time:1000,icon:5});
					}
				}
			});
		});
	</script>

</body>

</html>
