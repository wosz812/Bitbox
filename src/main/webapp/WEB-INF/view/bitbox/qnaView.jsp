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
               <h2 align="center">Q & A Content</h2>
            </div>
         </section>
			<!-- Main content -->
		<section class="content" >
				<div class="row">
					<!-- left column -->
					<div class="col-md-2">
					</div>
					<div class="col-md-8">
						<!-- general form elements -->
						<div class="box">
							<form role="form" action="" method="post"
								enctype="multipart/form-data" id="dataset">
								<input type="hidden" name="q_seq" value="${qna.q_seq}">
								<div class="box-body" style="padding: 20px">
									<div class="form-group">
										<div class="col-md-9" style="margin-bottom: 20px">
											<h5><label>제목</label></h5>
											<input type="text" class="form-control" name="q_title" value="${qna.q_title}">
										</div>
										<div class="col-md-3" style="margin-bottom: 20px">
											<h5><label>작성자</label></h5>
											<input type="text" class="form-control" name="s_id" value="${qna.s_id}" readonly="readonly">
										</div>
									</div>
									<div class="form-group">
										<label></label> 
										<div class="col-md-6">
											<h5><label>카테고리&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;${qna.q_category}</label></h5>
										</div>
										<div class="col-md-6" align="right">
											<h5><label><i class="fa fa-eye"></i>${qna.q_readCount}</label></h5>
										</div>
									</div>
									<div class="form-group" style="padding-left: 15px; padding-right: 15px;">
										<h5><label>내용</label></h5>
										<textarea class="form-control" rows="10" name="q_content" id="summernote" style="resize:none;">${qna.q_content}</textarea>
									</div>
									<div class="form-group" style="padding: 15px">
										<h5><label for="exampleInputFile">File Name:</label></h5>
										<a href="/bitbox/download?filename=${qna.q_upload}"><label>${qna.q_upload}</label></a>
									</div>
								</div>
								<!-- /.box-body -->
								<div class="box-footer" align="right" id="con" style="display: none;">
									<button type="button" class="btn btn-primary"
										onclick="gourl(1)">확인</button>
									<button type="button" class="btn btn-primary"
										onclick="gourl(2)">수정</button>
									<button type="button" class="btn btn-primary"
										onclick="gourl(3)">삭제</button>
								</div>
								<div align="center">
									<h4><label>Comment</label></h4>
								</div>
							</form>
							<c:forEach var="re" items="${replyList}">
								<div class="form-group" style="padding: 20px; border: 1px solid green;">
									<label>작성자</label>
									<input type="text" class="form-control" name="re_writer" value="${re.re_writer}" readonly="readonly">
									<label>댓글 내용</label>
									<textarea class="form-control" rows="2" name="re_content" readonly="readonly" style="resize:none;">${re.re_content}</textarea>
								</div>
							</c:forEach>
							<form action="/bitbox/registReply" method="post">
								<div style="padding: 20px;">
									<div class="form-group">
										<input type="hidden" name="q_seq" value="${qnaList.q_seq}">
										<input type="hidden" name="page" value="${page}">
										<label>작성자</label>
										<input type="text" class="form-control" name="re_writer" value="${replyUser}" readonly="readonly">
										<label>댓글 내용</label>
										<textarea class="form-control" rows="2" name="re_content" style="resize:none;"></textarea>
									</div>
									<div class="form-group" align="right">
										<button type="submit" class="btn btn-primary">댓글 작성</button>
									</div>
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
		$(document).ready(function(){
			var user = ${user};
			if( user == 1 ){
				document.getElementById("con").style.display = "";
			}		
		});
	</script>
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