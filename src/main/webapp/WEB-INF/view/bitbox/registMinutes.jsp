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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/dist/css/AdminLTE.min.css">
<!-- Select2 -->
 <link rel="stylesheet" href="/plugins/select2/select2.min.css">
<!-- Bootstrap time Picker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.min.css">
<!-- daterange picker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-daterangepicker/2.1.25/daterangepicker.css">
<!-- bootstrap datepicker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css">
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
					<h2 align="center">Create Meeting</h2>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<!-- left column -->
					<div class="col-md-2"></div>
					<div class="col-md-8">
						<!-- general form elements -->
						<div class="box box-default">
							<!-- /.box-header -->
							<!-- form start -->
							<form role="form" action="/bitbox/registMinutes">
								<div class="box-body">
									<div class="form-group">
										<div class="col-md-6">
											<label>그룹명</label>
											<input type="text" class="form-control"	name="group_title" value="${group_title}"
											readonly="readonly">
										</div>
										<div class="col-md-6">
											<label>작성일자</label>
											<input type="text" name="min_date" class="form-control"/>
										</div><br>
										<div style="padding-left: 15px; padding-right: 15px;">
											<label style="padding-top: 10px">회의 참가자</label> <br>
											<select class="form-control select2" name="member" multiple="multiple" 
											data-placeholder="회의 참가자를 선택해주세요." style="width: 100%;">
												<c:forEach var="member" items="${member}">
													${member.toString()}
												</c:forEach>
											</select>
											<br> <label style="padding-top: 10px">회의 주제</label> <input
												type="text" class="form-control" name="min_subject">
											<label style="padding-top: 10px">회의 내용</label><br>
											<textarea class="form-control" rows="9" name="min_content" style="resize:none;"></textarea>
										</div>
										<div class="col-md-6">
											<label style="padding-top: 10px">의견 사항</label><br>
											<textarea class="form-control" rows="5" name="min_opinion" style="resize:none;"></textarea>
											<label style="padding-top: 10px">추후일정</label><br>
											<textarea class="form-control" rows="5" name="min_schedule" style="resize:none;"></textarea>
										</div>
										<div class="col-md-6">
											<label style="padding-top: 10px">확정 내용</label><br>
											<textarea class="form-control" rows="5" name="min_decide" style="resize:none;"></textarea>
											<label style="padding-top: 10px">준비 사항</label><br>
											<textarea class="form-control" rows="5" name="min_prepare" style="resize:none;"></textarea>
											<input type="hidden" name="group_seq" value="${group_seq}">
										</div>
									</div>
							</div>
						<div class="box-footer" align="right" style="padding: 15px">
							<button type="submit" class="btn btn-primary">작성하기</button>
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
	<!-- include summernote css/js-->
	<link
		href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.4/summernote.css"
		rel="stylesheet">
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.4/summernote.js"></script>
	<!-- Slimscroll -->
	<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- Select2 -->
	<script src="/plugins/select2/select2.full.min.js"></script>
	<!-- date-range-picker -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-daterangepicker/2.1.25/moment.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-daterangepicker/2.1.25/daterangepicker.js"></script>
	<!-- bootstrap datepicker -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
	<!-- bootstrap time picker -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.min.js"></script>
	<!-- FastClick -->
	<script src="/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="/dist/js/app.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/dist/js/demo.js"></script>
	<!-- Page script -->
	<script type="text/javascript">
		$(function(){
			$('.select2').select2();
		});
		$(function() {
			$('input[name="min_date"]').daterangepicker({
				timePicker : true,
				timePickerIncrement : 10,
				locale : {
					format : 'YYYY/MM/DD(dd) h:mm A'
				}
			});
		});
		
	</script>
</body>
</html>