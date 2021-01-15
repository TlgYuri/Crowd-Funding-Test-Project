<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="keys" content="">

<%@ include file="/WEB-INF/jsp/common/css.jsp"%>

<link rel="stylesheet" href="${PATH}/static/css/login.css">

<style>
</style>
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<div>
					<a class="navbar-brand" href="${PATH}/index" style="font-size: 32px;">尚筹网-创意产品众筹平台</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">

		<form id="loginForm" class="form-signin" role="form" action="${PATH}/login" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<h2 class="form-signin-heading">
				<i class="glyphicon glyphicon-log-in"></i> 用户登录
			</h2>
			<div class="form-group has-success has-feedback">
				<!-- value="${param.loginAccount }" -->
				<input type="text" class="form-control" id="loginAccount" name="loginAccount" value="yuri" placeholder="请输入登录账号" autofocus /> <span class="glyphicon glyphicon-userform-control-feedback"> </span>
			</div>
			<div class="form-group has-success has-feedback">
				<input type="password" class="form-control" id="loginPassword" name="loginPassword" value="114514" placeholder="请输入登录密码" style="margin-top: 10px;" /> <span class="glyphicon glyphicon-lock form-control-feedback"></span>
			</div>
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me" /> 记住我
				</label>
				<div class="form-group has-success has-feedback">${SPRING_SECURITY_LAST_EXCEPTION.message}</div>
				<br /> <label> 忘记密码 </label> <label style="float: right"> <a href="${PATH}/regist">我要注册</a>
				</label>
			</div>
			<a class="btn btn-lg btn-success btn-block" onclick="dologin()"> 登录</a>
		</form>
	</div>

	<%@ include file="/WEB-INF/jsp/common/js.jsp"%>

	<script type="text/javascript">
		function dologin() {
			// 			var type = $(":selected").val();
			// 			if (type == "user") {
			// 				window.location.href = "main";
			// 			} else {
			// 				window.location.href = "index";
			// 			}
			$("#loginForm").submit();
		}
	</script>

</body>

</html>