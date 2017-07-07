<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<aside class="main-sidebar"> <!-- sidebar: style can be found in sidebar.less -->
<section class="sidebar"> <!-- Sidebar user panel -->
<div class="user-panel">
	<div class="pull-left image">
		<img src="/img/background.png" class="img-circle"
			alt="User Image">
	</div>
	<div class="pull-left info">
		<p>${id}</p>
		<a href="/bitbox/logout"><i class="fa fa-sign-out"></i>Sign out</a>
	</div>
</div>
<!-- sidebar menu: : style can be found in sidebar.less -->
<ul class="sidebar-menu">
	<li class="header">BitBox Menu</li>
	<li class="treeview"><a href="#"> <i class="fa fa-dashboard"></i>
			<span>PROJECT</span> <span class="pull-right-container"> <i
				class="fa fa-angle-left pull-right"></i>
		</span>
	</a>
		<ul class="treeview-menu">
			<li><a href="/bitbox/listAll"><i class="fa fa-user"></i>
					Personal Project</a></li>
			<li><a href="/bitbox/getGroupList"><i class="fa fa-users"></i>
					Group Project <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					
					<c:forEach items="${groupList}" var="group">
						<li><a href="/memo/memoView?title=${group.title}"><i class="fa fa-group"></i>
							${group.title}</a></li>
					</c:forEach>
				</ul></li>
		</ul></li>
	<li class="treeview"><a href="#"><i class="fa fa-pencil"></i><span>MEMO</span> <span
			class="pull-right-container"> <i
				class="fa fa-angle-left pull-right"></i>
		</span> </a>
		<ul class="treeview-menu">
			<li><a href="/memo/pMemo?group_seq=0"><i class="fa fa-user"></i>
					Personal MEMO</a></li>
			<li><a href="#"><i class="fa fa-users"></i>
					Group MEMO <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<c:forEach items="${groupList}" var="group">
						<li><a href="/memo/gMemo?group_seq=${group.group_seq}"><i class="fa fa-group"></i>
							${group.title}</a></li>
					</c:forEach>
				</ul></li>
		</ul></li>

	<li><a href="/bitbox/calendar"> <i class="fa fa-calendar"></i>
			<span>Calendar</span> <span class="pull-right-container"> </span>
	</a></li>
	<li><a href="/bitbox/qna"> <i class="fa fa-question"></i>
			<span>Q & A</span> <span class="pull-right-container"> </span>
	</a></li>
	
	<li><a href="/bitbox/group"> <i class="fa fa-users"></i>
			<span>Group</span> <span class="pull-right-container"> </span>
	</a></li>
</ul>
</section> <!-- /.sidebar --> </aside>

</html>