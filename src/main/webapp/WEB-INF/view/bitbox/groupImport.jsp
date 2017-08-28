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
					<h2 align="center">Import Group</h2>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<!-- left column -->
					<div class="col-md-4">
					</div>
					<div class="col-md-4">
						<!-- general form elements -->
						<div class="box">

							<!-- /.box-header -->
							<!-- form start -->
							<form id="dataset" role="form" action="" enctype="multipart/form-data">
								<div class="box-body">
									<div class="form-group">
										<label for="exampleInputEmail1">Repository Information</label>
										<input type="text" class="form-control" name="s_id" placeholder="Enter Repository Owner">
										<input type="text" class="form-control" name="title" placeholder="Enter Repository Name">
										<h6 style="color: red;" id="info_error"></h6>
										<button class="btn btn-primary" type="button" onclick="info_check()">입력 정보 확인</button>
									</div>
									<div class="form-group">
										<label>Member</label> 
										
										<select class="form-control select2" name="member" multiple="multiple" data-placeholder="회의 참가자를 선택해주세요." style="width: 100%;">
											<c:forEach var="member" items="${memberList}">
												<option>${member.s_id}</option>
											</c:forEach>
										</select>
										
									</div>
								</div>
								<!-- /.box-body -->
								<div class="box-footer" align="right">
									<button type="button" class="btn btn-primary" id="import_btn" onclick="cgroup_check()" disabled>Import Group</button>
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
	<!-- include summernote css/js-->
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
	$(".select2").select2();
	function info_check(){
		var id=$("input[name=s_id]").val();
		var repos=$("input[name=title]").val();
		$.ajax({
			url : "https://api.github.com/repos/"+id+"/"+repos,
			type : 'GET',
			beforeSend : function(xhr) {
			},
			error: function(xhr, status, error) {
		        $("h6").css("color", "red");
		        $("h6").text("입력정보가 올바르지 않습니다.");
		    },
			data : {}
		}).done(function(response) {
			console.log(response);
			$("h6").css("color", "blue");
	        $("h6").text("정보 확인 완료");
	        $('#import_btn').prop("disabled",false);
		});
	}
	function cgroup_check(){
		var title=$("input[name=title]").val();
		var url="/bitbox/titleCheck?title="+title;
		$.ajax({
            url : url,
            type : 'POST',
	            success : function(data) {
	              if(!data){
	            	  alert("그룹 불러오기 완료");
	            	  var ds=document.getElementById("dataset");
	            	  ds.action="/bitbox/groupImport";
	            	  ds.submit();
	              }else{
	            	  alert("이미 그룹이 등록되어 있습니다.");
	              }
	            }
	    });
	}
	</script>
</body>
</html>