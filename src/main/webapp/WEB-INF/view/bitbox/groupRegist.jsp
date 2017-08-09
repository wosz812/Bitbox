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
					<h2 align="center">Create Group</h2>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<!-- left column -->
					<div class="col-md-2">
					</div>
					<div class="col-md-8">
						<!-- general form elements -->
						<div class="box">

							<!-- /.box-header -->
							<!-- form start -->
							<form role="form" action="/bitbox/groupRegist"
								enctype="multipart/form-data">
								<div class="box-body">
									<label for="exampleInputEmail1">그룹이름</label>
									<div class="form-group row">
									<div class="col-xs-10">
										<input type="text" class="form-control" name="title" placeholder="Enter title">
									</div>
									<button class="btn btn-primary" type="button" id="title_check" onclick="click_func()">중복확인</button>
									</div>
									
									<div class="form-group">
										<label>그룹 비밀번호(그룹가입시에 사용됩니다.)</label> <input type="text"
											class="form-control" name="pw" placeholder="Enter password">
									</div>
									<div class="form-group">
										<label>그룹 설명</label>
										<textarea class="form-control" rows="10"
											placeholder="Enter ..." name="info" style="resize:none;"></textarea>
									</div>

								</div>
								<!-- /.box-body -->
								<div class="box-footer" align="right">
									<button type="submit" class="btn btn-primary" id="cgroup" disabled>그룹생성</button>
								</div>
							</form>
						</div>
					</div>
					<div class="col-md-2">
					</div>
				</div>
				<!-- /.row -->
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
	<script src="/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="/dist/js/app.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/dist/js/demo.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		 $("input[name=title]").keyup(function(event){
		  regexp = /[\ㄱ-ㅎㅏ-ㅣ가-힣\s]/g;
		  v = $(this).val();
		  if( regexp.test(v) ) {
		   alert("그룹 이름에 공백과 한글은 제한됩니다.");
		   $(this).val(v.replace(regexp,''));
		  }
		 });

	});
	function click_func(){
		var title=$("input[name=title]").val();
		var url="/bitbox/titleCheck?title="+title;
		$.ajax({
            url : url,
            type : 'POST',
	            success : function(data) {
	              if(!data){
	            	  $('#cgroup').prop("disabled",false);
	              }else{
	            	  alert("그룹 이름 중복");
	            	  $("input[name=title]").val("");
	            	  $('#cgroup').prop("disabled",true);
	              }
	            }
	    });
	}
	</script>
</body>
</html>