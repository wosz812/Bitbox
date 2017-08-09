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
<script type="text/javascript">
function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
            var imgObj = document.getElementById('imgView');
            imgObj.src = e.target.result;
    }
      reader.readAsDataURL(input.files[0]);
    }
}

</script>
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
					<h2 align="center">My Page</h2>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<!-- left column -->
					<div class="col-md-2"></div>
					<div class="col-md-8">
						<!-- general form elements -->
						<div class="box">

							<!-- /.box-header -->
							<!-- form start -->
							<form role="form" action="/bitbox/myUpdate"
								enctype="multipart/form-data" method="post">
								<div class="box-body">
									<div class="form-group">
										<label for="exampleInputFile">프로필 이미지</label> <input type="file"
											class="form-control" name="profile_img" onchange="readURL(this)">
											<img id="imgView" src="/pngFiles/${student.s_uuid_img}" style="width: 300px; height: 300px">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">이름</label> <input type="text"
											class="form-control" name="s_name" value="${student.s_name }"
											readonly="readonly">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">아이디</label> <input type="text"
											class="form-control" name="s_id" value="${student.s_id }"
											readonly="readonly">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">이메일</label> <input type="text"
											class="form-control" name="s_email"
											value="${student.s_email }">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">전화번호</label> <input
											type="text" class="form-control" name="s_phone"
											value="${student.s_phone }">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">반</label> <input type="text"
											class="form-control" name="s_class_name"
											value="${class_name}" readonly="readonly">
									</div>

								</div>
								<!-- /.box-body -->
								<div class="box-footer" align="right">
									<button type="submit" class="btn btn-primary">개인정보 수정</button>
								</div>
							</form>
						</div>
					</div>
					<div class="col-md-2"></div>
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
</body>
</html>