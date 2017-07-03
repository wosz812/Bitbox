<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/css/skins/_all-skins.min.css">
<!-- font -->
<link rel="stylesheet"
	href="http://fonts.googleapis.com/earlyaccess/nanumpenscript.css">
<div>
<aside class="main-sidebar"> <!-- sidebar: style can be found in sidebar.less -->
<section class="sidebar"> <!-- Sidebar user panel -->
<div class="user-panel">
	<div class="pull-left image">
		<img
			src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/img/user2-160x160.jpg"
			class="img-circle" alt="User Image">
	</div>
	<div class="pull-left info">
		<p>${id}</p>
		<a href="/bitbox/logout"><i class="fa fa-sign-out"></i>Sign out</a>
	</div>

</div>
<!-- sidebar menu: : style can be found in sidebar.less -->
<ul class="sidebar-menu" >
	<li class="header">BitBox Menu</li>
	<li><a href="#" ><i class="fa fa-dashboard"></i>PROJECT <span
			class="pull-right-container"> <i
				class="fa fa-angle-left pull-right"></i>
		</span> </a>
		<ul class="treeview-menu">
			<li><a href="/bitbox/listAll"><i class="fa fa-user"></i>
					Personal Project</a></li>
			<li><a href="#"><i class="fa fa-users"></i> Group Project <span
					class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="/bitbox/group"><i class="fa fa-list"></i>
							Group List</a></li>
					<li><a href="/bitbox/group"><i class="fa fa-dropbox"></i>
							BITBOX</a></li>
				</ul></li>
		</ul></li>
	<li><a href="#"><i class="fa fa-pencil"></i> MEMO <span
			class="pull-right-container"> <i
				class="fa fa-angle-left pull-right"></i>
		</span> </a>
		<ul class="treeview-menu">
			<li><a href="/memo/memoView"><i class="fa fa-user"></i>
					Personal MEMO</a></li>
			<li><a href="#"><i class="fa fa-users"></i> Group MEMO <span
					class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="/memo/memoView"><i class="fa fa-cube"></i>
							CRUD</a></li>
					<li><a href="/memo/memoView"><i class="fa fa-dropbox"></i>
							BITBOX</a></li>
				</ul></li>
		</ul></li>
	<li><a href="/bitbox/calendar"> <i class="fa fa-calendar"></i>
			<span>Calendar</span> <span class="pull-right-container"> </span>
	</a></li>
</ul>
</section> <!-- /.sidebar --> </aside></div>
</html>