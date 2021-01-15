<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<div id="navbar" class="navbar-collapse collapse">
	<form class="navbar-form navbar-right">
		<input type="text" class="form-control" placeholder="查询">
	</form>
	<ul class="nav navbar-nav navbar-right">
		<li style="padding-top: 8px;">
			<div class="btn-group">
				<form id="logoutForm" action="${PATH}/logout" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
						<i class="glyphicon glyphicon-user"></i>
						<security:authentication property="principal.admin.username" />
						<span class="caret"></span>
					</button>

					<ul class="dropdown-menu" role="menu">
						<li><a href="javascript:;"><i class="glyphicon glyphicon-cog"></i>个人设置</a></li>
						<li><a href="javascript:;"><i class="glyphicon glyphicon-comment"></i>消息 </a></li>
						<li class="divider"></li>
						<li><a href="javascript:;" onclick="$('#logoutForm').submit()" ><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
					</ul>
				</form>
			</div>
		</li>
		<li style="margin-left: 10px; padding-top: 8px;">
			<button type="button" class="btn btn-default btn-danger">
				<span class="glyphicon glyphicon-question-sign"></span> 帮助
			</button>
		</li>
	</ul>
</div>