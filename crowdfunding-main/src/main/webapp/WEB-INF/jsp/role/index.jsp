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
<link rel="stylesheet" href="${PATH}/static/jquery/ztree/zTreeStyle.css">

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

	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<div>
					<a class="navbar-brand" style="font-size: 32px;" href="#">后台管理 - 角色维护</a>
				</div>
			</div>

			<jsp:include page="/WEB-INF/jsp/common/navbar.jsp" />

		</div>
	</nav>

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

						<form class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input id="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
								</div>
							</div>
							<button id="queryBtn" type="button" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>

						<button id="deleteBatch" type="button" class="btn btn-danger" style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button id="addBtn" type="button" class="btn btn-primary" style="float: right;">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">

							<table class="table  table-bordered">

								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox"></th>
										<th>名称</th>
										<th width="100">操作</th>
									</tr>
								</thead>

								<tbody>
								</tbody>

								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
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


	<!--------------- 模态框 → 新增  --------------->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">新增角色</h4>
				</div>
				<div class="modal-body">
					<label for="recipient-name" class="control-label">角色名称:</label> <input type="text" class="form-control" placeholder="请输入要新增的角色名称">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary">新增</button>
				</div>
			</div>
		</div>
	</div>

	<!--------------- 模态框 → 修改  --------------->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">修改角色名称</h4>
				</div>
				<div class="modal-body">
					<label for="recipient-name" class="control-label">角色名称</label> <input type="text" class="form-control">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary">修改</button>
				</div>
			</div>
		</div>
	</div>

	<!--------------- 模态框 → 分配权限  --------------->
	<div class="modal fade" id="permissionModal" tabindex="-1" role="dialog" aria-labelledby="permissionModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">分配权限</h4>
				</div>

				<div class="modal-body">
					<label for="recipient-name" class="control-label">权限列表</label><br /> <input type="hidden" />
					<ul id="zTree" class="ztree"></ul>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary">分配</button>
				</div>

			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
	<script src="${PATH}/static/script/docs.min.js"></script>
	<script src="${PATH}/static/jquery/ztree/jquery.ztree.all-3.5.min.js"></script>

	<script type="text/javascript">
		$(function() {//页面加载完执行
			//高亮显示菜单中当前选项
			$("#menu4").css("color", "red");

			//控制树形菜单开关
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

			$("#menu2").click();
			
			//ajax初始化页面数据
			loadData();
		});

		//========================= 加载数据 =============================
		// 定义查询页面数据时的参数对象
		var queryJson = {
			pageNum : 1,
			pageSize : 3,
		};

		// ajax初始化页面数据
		function loadData(pageNum, pageSize) {
			$("thead input").prop("checked", false);
			var index = -1;
			queryJson.pageNum = pageNum;
			queryJson.pageSize = pageSize;
			$.ajax({
				url : "${PATH}/role/loadData",
				data : queryJson,
				beforeSend : function() {
					index = layer.load(0, {
						time : 5 * 1000
					});
					return true;
				},
				success : function(data) {
					layer.close(index);
					fillData(data);
					initNavi(data);
				}
			});
		}

		// 将初始化数据加载到页面中
		function fillData(data) {
			//清空掉原有数据
			$("tbody").empty();

			$.each(data.list, function(i, e) {
				var tr = $('<tr roleId="'+ e.id +'"></tr>');

				tr.append('<td>' + (data.startRow + i) + '</td>');
				tr.append('<td><input type="checkbox"></td>');
				tr.append('<td>' + e.name + '</td>');

				var td = $("<td></td>")

				td.append('<button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button> ');
				td.append('<button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button> ');
				td.append('<button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button> ');

				tr.append(td);

				$("tbody").append(tr);
			});

		}

		// 加载导航条
		function initNavi(data) {
			//删除上次操作时 插入的导航条
			$("ul.pagination").empty();

			//首页、上一页
			if (data.hasPreviousPage == false) {
				$("ul.pagination").append('<li class="disabled"><a href="#">首页</a></li> <li class="disabled"><a href="#">上一页</a></li>');
			} else {
				$("ul.pagination").append('<li><a onclick="loadData(1,3)">首页</a></li> <li><a onclick="loadData(' + data.prePage + ',3)">上一页</a></li>');
			}

			//页码
			$.each(data.navigatepageNums, function(i, e) {
				if (data.pageNum == (i + 1)) {
					$("ul.pagination").append('<li  class="active"><a onclick="loadData(' + e + ',3)">' + e + '</a></li>');
				} else {
					$("ul.pagination").append('<li><a onclick="loadData(' + e + ',3)">' + e + '</a></li>');
				}
			});

			//下一页、尾页
			if (data.hasNextPage == false) {
				$("ul.pagination").append('<li class="disabled"><a href="#">下一页</a></li> <li class="disabled"><a href="#${PATH}/role/index?pageNum=1">尾页</a></li>');
			} else {
				$("ul.pagination").append('<li><a onclick="loadData(' + data.nextPage + ',3)">下一页</a></li> <li><a onclick="loadData(' + data.lastPage + ',3)">尾页</a></li>');
			}

		}

		//========================= 条件查询 =============================
		//获取输入的条件，根据条件重新获取分页数据
		$("form #queryBtn").click(function() {
			var condition = $("form #condition").val();
			queryJson.condition = condition;
			loadData();
		});

		//========================= 添加角色  =============================
		//弹出模态框
		$("#addBtn").click(function() {
			$("#addModal div.modal-body input").val("");
			$("#addModal").modal({
				show : true
			});
		});

		//提交添加
		$("#addModal div.modal-footer .btn-primary").click(function() {
			var name = $("#addModal div.modal-body input").val();
			$.ajax({
				url : "${PATH}/role/doAdd",
				type : "post",
				data : {
					name : name
				},
				beforeSend : function() {
					return true;
				},
				success : function(data) {
					if (data >= 1) {
						layer.msg("添加成功", {
							icon : 1
						});
						$("#addModal").modal("hide");
						loadData(2147483647);
					} else {
						layer.msg("添加失败", {
							icon : 2
						});
					}
				}
			});
		});

		//========================= 修改角色 =============================
		//弹出模态框
		$("tbody").on('click', 'button.btn-primary', function() {
			//获取值
			var id = $(this).parent().parent().attr("roleId");
			var name = $(this).parent().prev().text();
			var pageNum = $("ul.pagination .active").text();
			//将值赋给模态框
			$("#updateModal div.modal-body input").val(name);
			$("#updateModal div.modal-body input").attr("roleId", id);
			$("#updateModal div.modal-body input").attr("pageNum", pageNum);
			//显示模态框
			$("#updateModal").modal({
				show : true
			});
		});

		//提交修改
		$("#updateModal div.modal-footer .btn-primary").click(function() {
			var name = $("#updateModal div.modal-body input").val();
			var id = $("#updateModal div.modal-body input").attr("roleId");
			var pageNum = $("#updateModal div.modal-body input").attr("pageNum");
			$.ajax({
				url : "${PATH}/role/doUpdate",
				type : "post",
				data : {
					id : id,
					name : name
				},
				beforeSend : function() {
					return true;
				},
				success : function(data) {
					if (data >= 1) {
						$("#updateModal div.modal-body input").attr("roleId", "-1");
						$("#updateModal div.modal-body input").val("");
						$("#updateModal").modal("hide");
						layer.msg("修改成功", {
							icon : 1
						});
						loadData(pageNum);
					} else {
						layer.msg("修改失败", {
							icon : 2
						});
					}
				}
			});
		});

		//========================= 一键全选  =============================
		$("thead input").click(function() {
			$("tbody input[type='checkbox']").prop("checked", this.checked);
		});

		$("tbody").on('click', 'input[type="checkbox"]', function() {
			$("thead input").prop("checked", false);
		});

		//========================= 删除角色  =============================
		$("tbody").on('click', 'button.btn-danger', function() {
			var id = $(this).parent().parent().attr("roleId");
			var pageNum = $("ul.pagination .active").text();
			layer.confirm("确认删除？", {
				btn : [ "确认", "取消" ]
			}, function() {
				$.ajax({
					url : "${PATH}/role/doDelete",
					type : "post",
					data : {
						id : id
					},
					beforeSend : function() {
						return true;
					},
					success : function(data) {
						if (data >= 1) {
							layer.msg("删除成功", {
								icon : 1
							});
							loadData(pageNum);
						} else {
							layer.msg("删除失败", {
								icon : 2
							});
						}
					}
				});
			}, function() {
			});
		});

		//========================= 修改角色权限  =============================
		$("tbody").on('click', 'button.btn-success', function() {
			var roleId = $(this).parent().parent().attr("roleId");
			$("#permissionModal input[type='hidden']").val(roleId);
			//初始化权限树
			$.get("${PATH}/permission/loadZTree", {}, function(data) {
				var zTreeSetting = {
					check : {
						enable : true
					},
					data : {
						key : {
							name : "title"
						},
						simpleData : {
							enable : true,
							pIdKey : "pid"
						}
					},
					view : {
						addDiyDom : function(treeId, treeNode) {
							$("#" + treeNode.tId + "_ico").removeClass();
							$("#" + treeNode.tId + "_ico").css("background", "");
							//$("#" + treeNode.tId + "_ico").addClass(treeNode.icon);  //  会因background属性  导致有子节点的节点  的图标失效
							$("#" + treeNode.tId + "_span").before("<span class='"+ treeNode.icon +"' ></span>");
						}
					}
				};

				$.fn.zTree.init($("#zTree"), zTreeSetting, data);

				var zTree = $.fn.zTree.getZTreeObj("zTree");
				zTree.expandAll(true);
			});

			//回显已有权限
			$.get("${PATH}/permission/listPermissionByRoleId", {
				roleId : roleId
			}, function(data) {
				var treeNode = $.fn.zTree.getZTreeObj("zTree");
				$.each(data, function(i, e) {
					var node = treeNode.getNodeByParam("id", e, null);
					treeNode.checkNode(node, true, false, false);
				});
			});

			$("#permissionModal").modal({
				show : true
			});
		});

		$("#permissionModal div.modal-footer .btn-primary").click(function() {
			var roleId = $("#permissionModal input[type='hidden']").val();
			var json = {
				roleId : roleId
			};
			var treeNode = $.fn.zTree.getZTreeObj("zTree");
			var nodes = treeNode.getCheckedNodes(true);
			$.each(nodes, function(i, e) {
				var permissionId = e.id;
				json['permissionIds[' + i + ']'] = permissionId;
			});

			$.ajax({
				url : "${PATH}/permission/doAssignPermissionToRole",
				type : "post",
				data : json,
				success : function(data) {
					if (data > 0) {
						layer.msg("分配成功");
					} else {
						layer.msg("分配失败");
					}
					$("#permissionModal").modal("hide");
				}
			});

		});
	</script>

</body>

</html>