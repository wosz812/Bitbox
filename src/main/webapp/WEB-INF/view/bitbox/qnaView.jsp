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
				<h1>Q & A Content</h1>
			</section>

			<!-- Main content -->
						<section class="content" >
				<div class="row">
					<!-- left column -->
					<div class="col-md-6">
						<!-- general form elements -->
						<div class="box box-primary">
							<form role="form" action="" method="post"
								enctype="multipart/form-data" id="dataset">
								<input type="hidden" name="q_seq" value="${qnaList.q_seq}">
								<div class="box-body" style="padding: 20px">
									<div class="form-group">
										<div class="col-md-10">
											<label for="exampleInputEmail1">제목</label> <input type="text"
											class="form-control" name="q_title" value="${qnaList.q_title}">
										</div>
										<div class="col-md-2">
											<label for="exampleInputEmail1">조회수</label> <input type="text"
											class="form-control" name="q_readCount" value="${qnaList.q_readCount}">
										</div>										
									</div>
									<div class="form-group">
										<div class="col-md-12">
											<label>카테고리&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;${qnaList.q_category}</label>
										</div>										
									</div>
									<div class="form-group">
										<label>내용</label>
										<textarea class="form-control" rows="10" name="q_content" id="summernote">${qnaList.q_content}</textarea>
									</div>
									<div class="form-group">
										<label for="exampleInputFile">File Name:</label> <a
											href="/bitbox/download?filename=${qnaList.q_upload}"><label>${qnaList.q_upload}</label></a>
										<p class="help-block"></p>
									</div>
								</div>
								<!-- /.box-body -->
								<div class="box-footer">
									<button type="button" class="btn btn-primary"
										onclick="gourl(1)">확인</button>
									<button type="button" class="btn btn-primary"
										onclick="gourl(2)">수정</button>
									<button type="button" class="btn btn-primary"
										onclick="gourl(3)">삭제</button>
								</div>
								<div align="center">
									<h4>Coment</h4>
								</div>
							</form>
							<c:forEach var="re" items="${replyList}">
								<div class="form-group" style="padding: 20px; border: 1px solid green;">
									<label>작성자</label>
									<input type="text" class="form-control" name="re_writer" value="${re.re_writer}" readonly="readonly">
									<label>댓글 내용</label>
									<textarea class="form-control" rows="2" name="re_content" readonly="readonly">${re.re_content}</textarea>
								</div>
							</c:forEach>
							<form action="/bitbox/registReply" method="post">
								<div style="padding: 20px;">
									<div class="form-group">
										<input type="hidden" name="q_seq" value="${qnaList.q_seq}">
										<input type="hidden" name="page" value="${page}">
										<label>작성자</label>
										<input type="text" class="form-control" name="re_writer">
										<label>댓글 내용</label>
										<textarea class="form-control" rows="2" name="re_content" ></textarea>
									</div>
									<div class="form-group" align="right">
										<button type="submit" class="btn btn-primary">댓글 작성</button>
									</div>
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
	<script type="text/javascript">
	 function gourl(type) {
		var ds = document.getElementById("dataset");
		var url = "/bitbox/";		
		if (type == 1) {
			url = "/bitbox/qna?page="+${page};
		} else if (type == 2) {
			url = "/bitbox/qnaUpdate?page="+${page};
		} else if (type==3){
			url = "/bitbox/qnaDelete?page="+${page};
		}
		ds.action = url;
		ds.submit();
	}			
	</script>
	<script>
	$('#summernote').summernote({
	    height: ($(window).height() - 300),
	    callbacks: {
	        onImageUpload: function(image,editor,welEditable) {
	            uploadImage(image[0]);
	        }
	    }
	});

	function uploadImage(image,editor,welEditable) {
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
	            editor.insertImage(welEditable,url);
	           // $('#summernote').summernote("insertNode", image[0]);
	        },
	        error: function(data) {
	            console.log(data);
	        }
	    });
	}
	</script>
</body>
</html>