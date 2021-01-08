<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh_CN">
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
					<a class="navbar-brand" style="font-size: 32px;" href="${PATH}/user">后台管理 - 修改用户</a>
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
					<li><a href="${PATH}/admin/main">首页</a></li>
					<li><a href="${PATH}/admin/index">数据列表</a></li>
					<li class="active">修改</li>
				</ol>
				<div class="panel panel-default">
					<div class="panel-heading">
						表单数据
						<div style="float: right; cursor: pointer;" data-toggle="modal" data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">

						<form id="updateForm" action="${PATH}/admin/doUpdate" method="post">
							<input type="hidden" name="id" value="${admin.id}" /> <input type="hidden" name="pageNum" value="${pageNum}" />
							<div class="form-group">
								<label for="exampleInputPassword1">登陆账号</label> <input type="text" name="loginacct" value="${admin.loginacct}" class="form-control" id="exampleInputPassword1" placeholder="请输入登陆账号">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">用户名称</label> <input type="text" name="username" value="${admin.username}" class="form-control" id="exampleInputPassword1" placeholder="请输入用户名称">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">邮箱地址</label> <input type="email" name="email" value="${admin.email }" class="form-control" id="exampleInputEmail1" placeholder="请输入邮箱地址">
								<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
							</div>
							<button type="button" class="btn btn-success">
								<i class="glyphicon glyphicon-plus"></i> 更新
							</button>
							<button type="button" class="btn btn-danger">
								<i class="glyphicon glyphicon-refresh"></i> 重置
							</button>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<%-- <p>${pInfo}</p> --%>


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
			$("#menu3").css("color", "red");
		});

		$("#updateForm .btn-success").click(function() {
			layer.confirm("确认修改？", {
				btn : [ "确定", "取消" ]
			}, function() {
				$("#updateForm").submit();
			}, function() {
			});
		});
	</script>

</body>

</html>
