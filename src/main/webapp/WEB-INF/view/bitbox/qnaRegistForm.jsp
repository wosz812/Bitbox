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
			<section class="content-header">
				<div class="box-body">
					<h2 align="center">Question</h2>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<!-- left column -->
					<div class="col-md-6">
						<!-- general form elements -->
						<div class="box box-primary">

							<!-- /.box-header -->
							<!-- form start -->
							<form role="form" action="/bitbox/question" enctype="multipart/form-data">
								<div class="box-body">
									<div class="form-group">
										<label for="exampleInputEmail1">제목</label>
										<input type="text" class="form-control" name="q_title" placeholder="Title ...">
										<input type="hidden" class="form-control" name="q_image">
										<label>카테고리</label> 
										<select class="form-control" name="q_category">
											<option value="JAVA" selected>JAVA</option>
											<option value="JSP">JSP</option>
											<option value="Spring">Spring</option>
											<option value="Android">Android</option>
											<option value="DataBase">DataBase</option>
											<option value="C">C</option>
											<option value="C++">C++</option>
											<option value="Linux">Linux</option>
											<option value="Embedded">Embedded</option>
											<option value="XML">XML</option>
											<option value="UML">UML</option>
											<option value="R">R</option>
											<option value="etc">etc</option>
										</select>
									</div>
									<div class="form-group">
										<label>내용</label>
									<!--  	<textarea class="form-control" rows="10"
											placeholder="Content ..." name="q_content"></textarea>-->
											 <textarea id="summernote" name="q_content" ></textarea>
									</div>
									<div class="form-group">
										<label for="exampleInputFile">File Load :</label> 
										<input type="file" name="q_upload">
										<p class="help-block"></p>
									</div>
								</div>
								<div class="box-footer" align="right">
									<button type="submit" class="btn btn-primary">생성하기</button>
								</div>
							</form>
						</div>
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
	<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.4/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.4/summernote.js"></script>
	<!-- Slimscroll -->
	<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src="/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="/dist/js/app.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/dist/js/demo.js"></script>
	<script>
	$('#summernote').summernote({
	    height: ($(window).height() - 300),
	    callbacks: {
	        onImageUpload: function(image) {
	            uploadImage(image[0]);
	        }
	    }
	});

	function uploadImage(image) {
	    var data = new FormData();
	    data.append("image", image);
	    $.ajax({
	        url: '/bitbox/uploadImage',
	        cache: false,
	        contentType: false,
	        processData: false,
	        data: data,
	        type: "post",
	        success: function(url) {
	            var image = $('<img>').attr('src',  url);
	            $('#summernote').summernote("insertNode", image[0]);
	        },
	        error: function(data) {
	            console.log(data);
	        }
	    });
	}
  </script>
</body>
</html>