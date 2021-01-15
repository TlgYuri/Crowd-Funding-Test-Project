<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="zh_CN">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">

<%@ include file="/WEB-INF/jsp/common/css.jsp"%>

<link rel="stylesheet" href="${PATH}/static/css/main.css">

<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>

</head>

<body>

	<div class="container-fluid">
		<div class="row">
			<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
				<div class="container-fluid">
					<div class="navbar-header">
						<div>
							<a class="navbar-brand" style="font-size: 32px;" href="#">后台管理 - 用户维护</a>
						</div>
					</div>

					<jsp:include page="/WEB-INF/jsp/common/navbar.jsp" />

				</div>
			</nav>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">

			<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">

						<form id="queryForm" action="${PATH}/admin/index" method="post" class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text" name="condition" value="${param.condition}" placeholder="请输入关键字" />
								</div>
							</div>
							<button type="button" class="btn btn-warning" onclick="$('#queryForm').submit()">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>

						<security:authorize access="hasAnyRole('SA-超级管理员','PM - 项目经理')">
						<button id="deleteBatch" type="button" class="btn btn-danger" style="float: right; margin-left: 10px;">
							<i class="glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary" style="float: right;" onclick="window.location.href='${PATH}/admin/toAdd'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						</security:authorize>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input id="checkAll" type="checkbox"></th>
										<th>账号</th>
										<th>名称</th>
										<th>邮箱地址</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${pInfo.list}" var="admin" varStatus="status">
										<tr adminId="${admin.id}">
											<td>${pInfo.startRow + status.count - 1}</td>
											<td><input type="checkbox"></td>
											<td>${admin.loginacct}</td>
											<td>${admin.username}</td>
											<td>${admin.email}</td>
											<td>
												<button type="button" class="btn btn-success btn-xs">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<button type="button" class="btn btn-primary btn-xs">
													<i class=" glyphicon glyphicon-pencil"></i>
												</button>
												<button type="button" class="btn btn-danger btn-xs">
													<i class=" glyphicon glyphicon-remove"></i>
												</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>

								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
												<c:if test="${pInfo.hasPreviousPage}">
													<li><a href="${PATH}/admin/index?pageNum=1&condition=${param.condition}">首页</a></li>
													<li><a href="${PATH}/admin/index?pageNum=${pInfo.prePage}&condition=${param.condition}">上一页</a></li>
												</c:if>
												<c:if test="${!pInfo.hasPreviousPage}">
													<li class="disabled"><a href="#">首页</a></li>
													<li class="disabled"><a href="#">上一页</a></li>
												</c:if>

												<c:forEach items="${pInfo.navigatepageNums }" var="pageNum">
													<c:if test="${pInfo.pageNum eq pageNum}">
														<li class="active"><a href="#">${pageNum}<span class="sr-only">(current)</span></a></li>
													</c:if>
													<c:if test="${pInfo.pageNum ne pageNum}">
														<li><a href="${PATH}/admin/index?pageNum=${pageNum}&condition=${param.condition}">${pageNum}</a></li>
													</c:if>
												</c:forEach>

												<c:if test="${pInfo.hasNextPage}">
													<li><a href="${PATH}/admin/index?pageNum=${pInfo.nextPage}&condition=${param.condition}">下一页</a></li>
													<li><a href="${PATH}/admin/index?pageNum=${pInfo.lastPage}&condition=${param.condition}">尾页</a></li>
												</c:if>
												<c:if test="${!pInfo.hasNextPage}">
													<li class="disabled"><a href="#">下一页</a></li>
													<li class="disabled"><a href="#">尾页</a></li>
												</c:if>
											</ul>
										</td>
									</tr>

								</tfoot>

							</table>
						</div>
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
			// 控制树形结构的打开关闭
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
			$("#menu2").click();
		});

		//给用户分配角色
		$("tbody .btn-success").click(function() {
			window.location.href = "${PATH}/admin/assignRole?adminId=" + $(this).parent().parent().attr("adminId");
		});
		// 修改用户信息
		$("tbody .btn-primary").click(function() {
			window.location.href = "${PATH}/admin/toUpdate?pageNum=${pInfo.pageNum}&id=" + $(this).parent().parent().attr("adminId");
		});
		// 删除用户
		$("tbody .btn-danger").click(function() {
			var id = $(this).parent().parent().attr("adminId");
			layer.confirm("确认删除？", {
				btn : [ "确定", "取消" ]
			}, function() {
				window.location.href = "${PATH}/admin/doDelete?pageNum=${pInfo.pageNum}&id=" + id;
			}, function() {
			});
		});

		$("#checkAll").click(function() {
			$("tbody input[type='checkbox']").prop("checked", this.checked);
		});

		$("tbody input[type='checkbox']").click(function() {
			$("#checkAll").prop("checked", false);
		});

		$("#deleteBatch").click(function() {
			var checkedBoxList = $("tbody input[type='checkbox']:checked");
			if (checkedBoxList.length == 0) {
				layer.msg("请先选择要删除的数据");
				return false;
			}
			var array = new Array();
			$.each(checkedBoxList, function(i, e) {
				var id = $(e).parent().parent().attr("adminId");
				array.push(id);
			});
			var ids = array.join(',');
			layer.confirm("确认删除？", {
				btn : [ "确定", "取消" ]
			}, function() {
				window.location.href = "${PATH}/admin/doDeleteBatch?pageNum=${pInfo.pageNum}&ids=" + ids;
			}, function() {
			});
		});
	</script>
</body>

</html>
