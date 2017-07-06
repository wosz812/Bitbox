<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>BITBOX</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="/dist/css/skins/_all-skins.min.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="sidebar.jsp"%>
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
								<button type="submit" class="btn btn-default" onclick="gourl(1)">삭제</button>
								<button type="submit" class="btn btn-primary" onclick="gourl(2)"
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
								<div style="width: 150px;float:right;">
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
		<!-- /.content-wrapper -->
		<%@include file="controlSideBar.jsp"%>
	</div>
	<!-- ./wrapper -->

	<!-- jQuery 2.2.3 -->
	<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="/bootstrap/js/bootstrap.min.js"></script>
	<!-- Slimscroll -->
	<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
<script
			src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
		<script
			src="//cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>

	<script src="/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="/dist/js/app.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/dist/js/demo.js"></script>
	<!-- modal -->
	<script
		src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"></script>
	<script
		src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"></script>

	<script type="text/javascript" src="/js/datatable.js"></script>


</body>
</html>