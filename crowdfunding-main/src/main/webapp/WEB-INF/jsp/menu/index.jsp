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
<link rel="stylesheet" href="${PATH}/static/jquery/ztree/zTreeStyle.css">

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
					<a class="navbar-brand" style="font-size: 32px;" href="${PATH}/user">后台管理 - 菜单维护</a>
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
							<i class="glyphicon glyphicon-th"></i> 菜单维护
						</h3>
					</div>

					<div class="panel-body">
						<ul id="zTree" class="ztree"></ul>
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
					<h4 class="modal-title" id="exampleModalLabel">添加菜单</h4>
				</div>

				<div class="modal-body">
					<div>
						<input type="hidden" />
					</div>

					<div>
						<label for="recipient-name" class="control-label">菜单名称:</label> <input type="text" class="form-control" placeholder="请输入要添加的菜单的名称">
					</div>

					<div>
						<label for="recipient-name" class="control-label">菜单图标:</label> <input type="text" class="form-control" placeholder="请输入要添加的菜单的图标类名">
					</div>
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
					<h4 class="modal-title" id="exampleModalLabel">修改菜单</h4>
				</div>

				<div class="modal-body">
					<div>
						<input type="hidden" />
					</div>

					<div>
						<label for="recipient-name" class="control-label">菜单名称:</label> <input type="text" class="form-control" placeholder="请输入修改后的菜单的名称">
					</div>

					<div>
						<label for="recipient-name" class="control-label">菜单图标:</label> <input type="text" class="form-control" placeholder="请输入修改后的菜单的图标名">
					</div>

					<div>
						<label for="recipient-name" class="control-label">父菜单:</label>&nbsp; <select name="selectPid">
							<option value="0" selected="selected" hidden="hidden">系统权限菜单</option>
						</select>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary">修改</button>
				</div>

			</div>
		</div>
	</div>


	<!--------------- 模态框 → 权限分配  --------------->
	<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="assignModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">修改菜单</h4>
				</div>

				<div class="modal-body">
					<div>
						<input type="hidden" />
						<label for="recipient-name" class="control-label">权限列表：</label>
						<ul id="permissionTree" class="ztree"></ul>
					</div>
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
			$("#menu6").css("color", "red");
			$("#menu2").click();

			initZTree();
		});

		var nodesJson;

		//========================= 初始化权限树  =============================
		function initZTree() {
			//设置初始化参数
			var zTreeSetting = {
				data : {
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
					},
					addHoverDom : function(treeId, treeNode) {
						var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
						aObj.attr("href", "javascript:;");
						aObj.attr("target", "_self");
						if (treeNode.editNameFlag || $("#btnGroup" + treeNode.tId).length > 0)
							return;
						var s = '<span id="btnGroup'+treeNode.tId+'">';
						if (treeNode.level == 0) {
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addMenu(' + treeNode.id + ')" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
						} else if (treeNode.level == 1) {
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="updateMenu(' + treeNode.id + ')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
							if (treeNode.children == null || treeNode.children.length == 0) {
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteMenu(' + treeNode.id + ')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
							}
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addMenu(' + treeNode.id + ')" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="assignPermission(' + treeNode.id + ')" >&nbsp;&nbsp;<i class="fa fa-fw fa-anchor rbg "></i></a>';
						} else if (treeNode.level == 2) {
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="updateLeafMenu(' + treeNode.id + ',' + treeNode.pid + ')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteMenu(' + treeNode.id + ')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="assignPermission(' + treeNode.id + ')" >&nbsp;&nbsp;<i class="fa fa-fw fa-anchor rbg "></i></a>';
						}
						s += '</span>';
						aObj.after(s);
					},
					removeHoverDom : function(treeId, treeNode) {
						$("#btnGroup" + treeNode.tId).remove();
					}
				}
			};

			//加载中 动画
			var index = layer.load(0, {
				time : 3 * 1000
			});

			//ajax请求  获取数据
			$.get("${PATH}/menu/loadZTree", {}, function(data) {
				data.push({
					"id" : 0,
					"name" : "系统权限菜单",
					"icon" : "fa fa-fw fa-sitemap",
					"url" : "menu/index",
				});
				nodesJson = data;
				$.fn.zTree.init($("#zTree"), zTreeSetting, data);

				var zTree = $.fn.zTree.getZTreeObj("zTree");
				zTree.expandAll(true);
				initSelect();
				layer.close(index);
			});
		}
		//========================= 初始化选择框  =============================
		function initSelect() {
			$("#updateModal select").html('<option value="0">系统权限菜单</option>');
			$.each(nodesJson, function(i, e) {
				if (e.pid == 0) {
					$("#updateModal select").append('<option value="'+ e.id +'">' + e.name + '</option>');
				}
			});
		}

		//========================= 添加菜单  =============================
		function addMenu(pid) {
			$("#addModal input[type='hidden']").val(pid);
			$("#addModal").modal({
				show : true
			});
		}

		$("#addModal .modal-footer .btn-primary").click(function() {
			var pid = $("#addModal input[type='hidden']").val();
			var name = $("#addModal input[type='text']").first().val();
			var icon = $("#addModal input[type='text']").last().val();
			$.post("${PATH}/menu/addMenu", {
				pid : pid,
				name : name,
				icon : icon
			}, function(data) {
				if (data > 0) {
					layer.msg("添加成功");
					initZTree();
					$("#addModal").modal("hide");
					$("#addModal input").val("");
				} else {
					layer.msg("添加失败");
				}
			});
		});

		//========================= 修改菜单  =============================
		function updateMenu(id) {
			updateLeafMenu(id, null);
		}

		function updateLeafMenu(id, pid) {
			if (pid == null || pid == 0) {
				$("#updateModal select").prop("disabled", true);
				$("#updateModal select").prepend('<option value="0">系统权限菜单</option>');
				$("#updateModal option[value='0']").prop("selected", true);
			} else {
				$("#updateModal select").prop("disabled", false);
				$("#updateModal option[value='0']").remove();
			}

			$.each(nodesJson, function(i, e) {
				if (e.id == id) {
					$("#updateModal input[type='text']").first().val(e.name);
					$("#updateModal input[type='text']").last().val(e.icon);
					return;
				}
			});

			var id = $("#updateModal input[type='hidden']").val(id);
			$("#updateModal option[value='" + pid + "']").prop("selected", true);

			$("#updateModal").modal({
				show : true
			});
		}

		$("#updateModal .modal-footer .btn-primary").click(function() {
			var id = $("#updateModal input[type='hidden']").val();
			var pid = $("#updateModal option:selected").val();
			var name = $("#updateModal input[type='text']").first().val();
			var icon = $("#updateModal input[type='text']").last().val();
			$.post("${PATH}/menu/updateMenu", {
				id : id,
				pid : pid,
				name : name,
				icon : icon
			}, function(data) {
				if (data > 0) {
					layer.msg("修改成功");
					initZTree();
					$("#updateModal").modal("hide");
					$("#updateModal input").val("");
					$("#updateModal  option[value='0']").prop("selected", true);
				} else {
					layer.msg("修改失败");
				}
			});
		});

		//========================= 删除菜单  =============================
		function deleteMenu(id) {
			layer.confirm("是否确认删除？", {
				btn : [ "确定", "取消" ]
			}, function() {
				$.post("${PATH}/menu/deleteMenu", {
					id : id
				}, function(data) {
					if (data > 0) {
						layer.msg("删除成功");
						initZTree();
					} else {
						layer.msg("删除失败");
					}
				});
			}, function() {

			});
		}

		//========================= 给菜单分配权限  =============================
		function assignPermission(menuId) {
			//设置初始化参数
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
						pIdKey : "pid",
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

			//ajax请求  获取数据
			$.get("${PATH}/permission/loadZTree", {}, function(data) {

				$.fn.zTree.init($("#permissionTree"), zTreeSetting, data);

				var zTree = $.fn.zTree.getZTreeObj("permissionTree");
				
				//回显已有权限
				$.get("${PATH}/menu/listPermissionByMenuId", {
					menuId : menuId
				}, function(data) {
					var treeNode = $.fn.zTree.getZTreeObj("permissionTree");
					$.each(data, function(i, e) {
						var node = treeNode.getNodeByParam("id", e, null);
						treeNode.checkNode(node, true, false, false);
					});
				});
				
				zTree.expandAll(true);
			});

			$("#assignModal input[type='hidden']").val(menuId);
			$("#assignModal").modal({
				show : true
			});
		}

		$("#assignModal .btn-primary").click(function() {
			var menuId = $("#assignModal input[type='hidden']").val();
			
			var treeNode = $.fn.zTree.getZTreeObj("permissionTree");
			var nodes = treeNode.getCheckedNodes(true);
			
			var ids = new Array();
			$.each(nodes,function(i,e){
				ids.push(e.id);
			});
			var idStr = ids.join();
			$.post("${PATH}/menu/doAssignPermissionToMenu",{menuId:menuId,idStr:idStr},function(data){
				if(data > 0 ) {
					layer.msg("分配成功",{icon:6});
					$("#assignModal").modal("hide");
				} else {
					layer.msg("分配失败",{icon:5});
					$("#assignModal").modal("hide");
				}
			});
		});
	</script>

</body>

</html>