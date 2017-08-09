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
  <style type="text/css">
  #group_a{
    text-overflow:ellipsis;
    width: 250px;
    white-space: nowrap;
    overflow: hidden;
}

#group_a:hover{
    text-overflow:clip;
    width:auto;
    white-space: normal;
}
  </style>
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
					<h2 align="center">Detail Project</h2>
				</div>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-md-2">
					</div>
					<div class="col-md-8">
						<div class="box">
							<form role="form" action="" method="post"
								enctype="multipart/form-data" id="dataset">
								<input type="hidden" name="p_boardseq"
									value="${board.p_boardseq}">
								<div class="box-body">
									<div class="form-group" style="padding-left: 15px; padding-right: 15px;">
										<label for="exampleInputEmail1">제목</label> <input type="text"
											class="form-control" name="p_title" value="${board.p_title}">
									</div>
									<div class="form-group" style="padding-left: 15px; padding-right: 15px;">
										<label>카테고리</label><br><label>${board.p_category}</label>
									</div>
									<div class="form-group" style="padding-left: 15px; padding-right: 15px;">
										<label>내용</label>
										<textarea class="form-control" rows="10" style="resize:none;"
											name="p_content">${board.p_content}</textarea>
									</div>
									<div class="form-group" style="padding-left: 15px; padding-right: 15px;">
										<label for="exampleInputFile">File Name:</label>
										<a href="/bitbox/download?p_boardseq=${board.p_boardseq}">
										<label>${board.p_filename}</label></a>
										<p class="help-block"></p>
									</div>
								</div>
								<div class="box-footer" align="right" style="padding-left: 15px; padding-right: 15px;">
									<button type="button" class="btn btn-primary" onclick="gourl(1)">확인</button>
									<button type="button" class="btn btn-primary" onclick="gourl(2)">수정</button>
									<button type="button" class="btn btn-primary" onclick="gourl(3)">삭제</button>
								</div>
							</form>
						</div>
					</div>
					<div class="col-md-2">
					</div>
				</div>
			</section>
		</div>
		<%@include file="controlSideBar.jsp"%>
	</div>
	<!-- jQuery 2.2.3 -->
	<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="/bootstrap/js/bootstrap.min.js"></script>
	<!-- Slimscroll -->
	<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src="/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="/dist/js/app.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/dist/js/demo.js"></script>
	<script type="text/javascript">
	 function gourl(type) {
		var ds = document.getElementById("dataset");
		var url = "/bitbox/";		
		var tempurl=location.search.substring(1);
		var urlArray=tempurl.split('&');
		
		if(urlArray[5]=="cal=cal"){
			if (type == 1) {
				url = "/bitbox/calendar";
			} else if (type == 2) {
				url = "/bitbox/projectUpdate?"+urlArray[5];
			} else if (type==3){
				url = "/bitbox/projectDelete?"+urlArray[5];
			}
		}else{
			if (type == 1) {
				url = "/bitbox/listAll";
			} else if (type == 2) {
				url = "/bitbox/projectUpdate";
			} else if (type==3){
				url = "/bitbox/projectDelete";
			}
		}
		ds.action = url;
		ds.submit();
	}			
	</script>
</body>
</html>