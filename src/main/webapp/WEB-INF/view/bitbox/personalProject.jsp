<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>BITBOX</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/css/skins/_all-skins.min.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<header class="main-header">
			<!-- Logo -->
			<a href="/bitbox/home" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"><b>B</b>IT</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg"><b>BIT</b>BOX</span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
				</a>
				<li><a href="#" data-toggle="control-sidebar"><i
						class="fa fa-gears"></i></a></li>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/img/user2-160x160.jpg"
							class="img-circle" alt="User Image">
					</div>
					<div class="pull-left info">
						<p>${id}</p>
						<a href="/bitbox/logout"><i class="fa fa-sign-out"></i>Sign
							out</a>
					</div>
				</div>
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu">
					<li class="header">BitBox Menu</li>
					<li><a href="#"><i class="fa fa-dashboard"></i> PROJECT <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="/bitbox/listAll"><i class="fa fa-user"></i>
									Personal Project</a></li>
							<li><a href="#"><i class="fa fa-users"></i> Group
									Project <span class="pull-right-container"> <i
										class="fa fa-angle-left pull-right"></i>
								</span> </a>
								<ul class="treeview-menu">
									<li><a href="/bitbox/group"><i class="fa fa-list"></i>
											Group List</a></li>
									<li><a href="/bitbox/group"><i class="fa fa-dropbox"></i>
											BITBOX</a></li>
								</ul></li>
						</ul></li>

					<li><a href="/memo/memoView"><i class="fa fa-link"></i> <span>MEMO</span></a></li>
					<li><a href="/bitbox/calendar"> <i class="fa fa-calendar"></i>
							<span>Calendar</span> <span class="pull-right-container">
						</span>
					</a></li>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="box-body">
					<h1 align="center">Personal Project</h1>
				</div>
			</section>
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myFullsizeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-fullsize" role="document">
					<div class="modal-content modal-fullsize">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">프로젝트 상세보기</h4>
						</div>
						<form action="" id="dataset" method="post">
							<div class="modal-body">
								<input class="form-contorl" type="hidden" id="p_boardseq"
									name="p_boardseq" value="" /><br> <label>ID:</label> <input
									class="form-contorl" type="text" id="s_id" name="s_id"
									value="${id}" readonly="readonly" /><br> <label>제목:</label>
								<input class="form-contorl" type="text" id="p_title"
									name="p_title" value="" /><br> <label>내용:</label>
								<textarea class="form-contorl" rows="5" id="p_content"
									name="p_content" value=""></textarea>
								<br> <label>등록일:</label> <input type="text" id="p_date"
									value="" readonly="readonly" /><br> <label>파일명:</label> <input
									type="text" id="p_upload" value="" readonly="readonly" /><br>

							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-default"
									data-dismiss="modal">닫기</button>
								<button type="submit" class="btn btn-primary" onclick="test(2)"
									id="saving">수정</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<div style="width: 150px;">
									<a href="/bitbox/registForm"><button
											class="btn btn-primary btn-block">Create Project</button></a>
								</div>
								<div class="box-body">
									<table class="table table-striped table-bordered nowrap"
										id="test">
										<thead>
											<tr align="center">
												<td>순번</td>
												<td>카테고리</td>
												<td>제목</td>
												<td>등록일자</td>
												<td>파일첨부</td>
												<td>내용</td>
											</tr>
										</thead>
									</table>
								</div>
								<!-- /.box-body -->
							</div>
							<!-- /.box -->
						</div>
					</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- jQuery 2.2.3 -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<!-- Bootstrap 3.3.6 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<!-- Slimscroll -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-slimScroll/1.3.8/jquery.slimscroll.min.js"></script>
		<!-- FastClick -->

		<script
			src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
		<script
			src="//cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>

		<script src="https://cdnjs.cloudflare.com/ajax/libs/fastclick/1.0.6/fastclick.js"></script>
		<!-- AdminLTE App -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/js/app.min.js"></script>
		<!-- AdminLTE for demo purposes -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/js/demo.js"></script>
		<!-- modal -->
		<script
			src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"></script>
		<script
			src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"></script>


		<!--	<script >
		$(document).ready(function(){
			$.getJSON("/bitbox/getData",function(data){
				var boards='';
				$.each(data,function(key,value){
					boards +='<tr>';
					boards +='<td>'+value.p_boardno+'</td>';
					boards +='<td>'+value.p_category+'</td>';
					boards +='<td>'+value.p_title+'</td>';
					boards +='<td>'+value.p_date+'</td>';
					boards +='<td>'+value.p_upload+'</td>';
					boards +='</tr>';					
				});
				$('#test').append(boards);
			});
		});
	
	</script>
	 <script>	
		  $(document).ready(function() {
	            $('#test').DataTable({
	            	"paging" : true,
					"lengthChange" : true,
					"searching" : true,
					"ordering" : true,
					"info" : true,
					"autoWidth" : true,	 
					columns : [ {
					data : "p_boardno"
				}, {
					data : "p_category"
				}, {
					data : "p_title"
				}, {
					data : "p_date"
				},{
					data : "p_upload"
				} ]               
	            });
	        });
	</script>
	-->

		<!--  <script>
		$(function() {
			var table = $('#test').DataTable({
				"paging" : true,
				"lengthChange" : true,
				"searching" : true,
				"ordering" : true,
				"info" : true,
				"autoWidth" : true
			});
			var info = table.page.info();
			console.log(info);
		});
	</script>
	-->
		<script>
			$(document)
					.ready(
							function() {
								var table = $('#test')
										.DataTable(
												{
													"paging" : true,
													"lengthChange" : true,
													"searching" : true,
													"ordering" : true,
													"info" : true,
													"autoWidth" : true,
													"ajax" : {
														url : "/bitbox/getData",
														contentType : "application/x-www-form-urlencoded; charset=UTF-8"
													},
													"columns" : [
															{
																data : "p_boardseq"
															},
															{
																data : "p_category"
															},
															{
																data : "p_title"
															},
															{
																data : "p_date"
															},
															{
																data : "p_upload",
																"render" : function(
																		data,
																		type,
																		row,
																		meta) {
																	if (type === 'display') {
																		data = '<a href=/bitbox/download?filename='
																				+ data
																				+ '>'
																				+ data
																				+ '</a>';
																	}

																	return data;
																}
															},
															{

																data : "null",
																"targets" : 0,
																"defaultContent" : '<button class="btn_view" data-toggle="modal" data-target="#myModal" >상세보기</button>'
															} ]

												});
								$('#test tbody')
										.on(
												'click',
												'.btn_view',
												function() {

													var a = table.row(
															$(this).parents(
																	'tr'))
															.data();
													var boardseq = a.p_boardseq;
													var title = a.p_title;
													var date = a.p_date;
													var upload = a.p_upload;
													var content = a.p_content;
													$('#myModal')
															.on(
																	'shown.bs.modal',
																	function() {
																		$(
																				"#myModal")
																				.modal(
																						'show');
																		$(
																				'.modal-body #p_title')
																				.val(
																						title);
																		$(
																				'.modal-body #p_date')
																				.val(
																						date);
																		$(
																				'.modal-body #p_upload')
																				.val(
																						upload);
																		$(
																				'.modal-body #p_content')
																				.val(
																						content);
																		$(
																				'.modal-body #p_boardseq')
																				.val(
																						boardseq);
																		$(
																				'#myInput')
																				.focus()
																	});

												});

							});
			function test(type) {
				var ds = document.getElementById("dataset");
				var url = "/bitbox/";
				if (type == 1) {
					url = "/modify";
				} else if (type == 2) {
					url = "/bitbox/projectUpdate";
				}
				ds.action = url;
				ds.submit();
			}
		</script>
</body>
</html>
