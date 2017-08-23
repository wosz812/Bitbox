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
			<section class="content-header">
				<div class="box-body">
					<h2 align="center">MeetingView</h2>
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
							<form role="form" action="" id="dataset" method="post">
								<div class="box-body">
									<div class="form-group">
										<div class="col-md-6">
											<label>그룹명</label>
											<input type="text" class="form-control" name="group_title" value="${group_title}" readonly="readonly">
										</div>
										<div class="col-md-6">
											<label>작성일자</label>
											<input type="text" class="form-control" name="min_date" value="${minutes.min_date}" readonly="readonly">
										</div> <br>
										<div style="padding-left: 15px; padding-right: 15px;">
											<label style="padding-top: 10px">회의 참가자</label> <br> 
											<input type="text" class="form-control" name="min_attendee" value="${minutes.min_attendee}" readonly="readonly">
											<label style="padding-top: 10px">회의 주제</label> 
											<input type="text" class="form-control" name="min_subject" value="${minutes.min_subject}">
											<label style="padding-top: 10px">회의 내용</label><br>
											<textarea class="form-control" rows="9" name="min_content" style="resize:none;">${minutes.min_content}</textarea>
										</div>
										<div class="col-md-6">
											<label style="padding-top: 10px">의견 사항</label><br>
											<textarea class="form-control" rows="5" name="min_opinion" style="resize:none;">${minutes.min_opinion}</textarea>
											<label style="padding-top: 10px">추후일정</label><br>
											<textarea class="form-control" rows="5" name="min_schedule" style="resize:none;">${minutes.min_schedule}</textarea>
										</div>
										<div class="col-md-6">
											<label style="padding-top: 10px">확정 내용</label><br>
											<textarea class="form-control" rows="5" name="min_decide" style="resize:none;">${minutes.min_decide}</textarea>
											<label style="padding-top: 10px">준비 사항</label><br>
											<textarea class="form-control" rows="5" name="min_prepare" style="resize:none;">${minutes.min_prepare}</textarea>
											<input type="hidden" name="min_seq" value="${minutes.min_seq}">
											<input type="hidden" name="group_seq" value="${minutes.group_seq}">
											<input type="hidden" name="page" value="${page}">
										</div>
									</div>
								</div>
								<div class="box-footer" align="right" style="padding: 15px">
								<button type="button" class="btn btn-primary" onclick="gourl(1)">수정하기</button>
								<button type="button" class="btn btn-primary" onclick="gourl(2)">삭제하기</button>
								<button type="button" class="btn btn-primary" onclick="gourl(3)">돌아가기</button>
								<button type="button" class="btn btn-primary dropdown toggle" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">다운받기
								<span class="caret"></span>
								</button>
								<ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
									<li role="presentation" class="btn btn-info"><a role="menuitem" tabindex="-1" onclick="gourl(0)">Hwp</a></li>
									
									<li role="presentation" class="btn btn-success"><a role="menuitem" tabindex="-1" onclick="gourl(4)">PDF</a></li>
								</ul>
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
	
	<script type="text/javascript">
		function gourl(type) {
			var ds = document.getElementById("dataset");
			var url = "";
			if (type == 0) {
				url = "/bitbox/minutesDownload";
			} else if (type == 1) {
				url = "/bitbox/minutesUpdate";
			} else if (type == 2) {
				url = "/bitbox/minutesDelete";
			} else if (type == 3){
				url = "/bitbox/minutesList";
			} else if (type == 4){
				url = "/bitbox/pdfCreate";
			}
			ds.action = url;
			ds.submit();
		}		
	</script>
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
</body>
</html>