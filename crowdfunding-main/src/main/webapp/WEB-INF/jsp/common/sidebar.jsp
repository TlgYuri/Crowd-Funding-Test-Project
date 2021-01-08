<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="col-sm-3 col-md-2 sidebar">
	<div class="tree">
		<ul style="padding-left: 0px; " class="list-group">
			<c:forEach items="${menus}" var="parent">
				<c:if test="${parent.url ne null}">
					<li id="menu${parent.id}" class="list-group-item tree-closed"><span><a href="${PATH}/${parent.url}"><i class="${parent.icon}"></i>${parent.name}</a><span class="badge" style="float: right">${fn:length(parent.menus) eq 0 ? '' : fn:length(parent.menus)}</span></span>
				</c:if>
				<c:if test="${parent.url eq null}">
					<li id="menu${parent.id}" class="list-group-item tree-closed"><span><i class="${parent.icon}"></i>${parent.name}<span class="badge" style="float: right">${fn:length(parent.menus) eq 0 ? '' : fn:length(parent.menus)}</span></span>
				</c:if>
				<c:if test="${fn:length(parent.menus) ne 0}">		
					<ul style="margin-top: 10px; display: none;">
						<c:forEach items="${parent.menus}" var="menu" >
							<li style="height: 30px;"><a id="menu${menu.id}" href="${PATH}/${menu.url}"><i class="${menu.icon}"></i>${menu.name}</a></li>
						</c:forEach>
					</ul>
				</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>