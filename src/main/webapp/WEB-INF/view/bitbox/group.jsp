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
					<h2 align="center">GroupList</h2>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<!-- <div style="float: right;">
									
								</div>
								<div style="float: right;">
									<a href="/bitbox/groupRegistForm"><button type="button"
											class="btn btn-primary" onclick="" >Create Group</button></a>
								</div>
								<br> -->
								
								<div class="btn-group" style="float: right;">
									<button class="btn btn-primary btn-flat" id="importG" onclick="convertLocation('importG')">Import Group</button>
									<button class="btn btn-primary btn-flat" id="createG" onclick="convertLocation('createG')">Create Group</button>
								</div>
							</div>
							<!-- /.box-header -->
							<div class="box-body table-responsive no-padding">
								<table class="table table-hover">
									<tr align="center">
										<td>순번</td>
										<td>개설자</td>
										<td>그룹이름</td>
										<td>설명</td>
									</tr>
									<c:forEach var="gList" items="${list}">
										<tr align="center">
											<td class='gno'>${gList.ordernum}</td>
											<td>${gList.s_id}</td>
											<td class="left"><a class="gTitle" data-id="${gList.group_seq}">${gList.title}</a></td>
											<td height=20 style="padding-left: 5">
												<div style="overflow: hidden; text-overflow: ellipsis; width: 180">
													<nobr>${gList.info}</nobr>
												</div>
											</td>
										</tr>
									</c:forEach>
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
		<!-- Fullsize Modal -->
		<div class="modal fade" id="myFullsizeModal" tabindex="-1" role="dialog" aria-labelledby="myFullsizeModalLabel">
			<div class="modal-dialog modal-fullsize" role="document">
				<div class="modal-content modal-fullsize">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">그룹 상세정보</h4>
					</div>
					<form action="/bitbox/groupJoin" method="post">
						<div class="modal-body">
							<input type="hidden" class="form-control" id="mgno" name="group_seq">
							<label>그룹명</label>
							<input type="text" class="form-control" id="mtitle" name="title" readonly="readonly">
							<label>그룹 설명</label>
							<textarea class="form-control" rows="5" id="mexplain" name="info" readonly="readonly" style="resize:none;"></textarea>
							<label>가입시 필요한 비밀번호를 입력해주세요.</label>
							<input type="password" class="form-control" id="pw" name="pw" placeholder="password">
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">가입</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						</div>
					</form>
				</div>
			</div>
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
		var state =<%=request.getParameter("state")%>;
		//alert(s);
		if (state == 2) {
			alert("비밀번호 오류입니다.");
		} else if (state == 1) {
			alert("중복된 가입입니다.");
		} else if (state == 0) {
			alert("가입 성공!!");
		}
		$('.gTitle').click(function(e) {
			var value = $(this).attr("data-id");
			ajax_data(value);
			$("#myFullsizeModal").modal('show');
		});
		function ajax_data(gno) {
			var controller = '/bitbox/modal'; //JH : controller 명 지정해주기 예:localhost/index.php/controller(이거)/function/param
			//var base_url = '<?php echo site_url(); //you have to load the "url_helper" to use this function ?>';            
			var url = controller + "?gno=" + gno;
			//var url = controller;
			$.ajax({
				url : url,
				type : 'POST',
				//data: { "gno": JSON.stringify(gno)},
				//data: { "gno": gno},
				success : function(data) {
					//console.log(data);
					//alert(data);
					$('#mgno').val(data.group_seq);
					$('#mtitle').val(data.title);
					$('#mexplain').val(data.info);
					$('#pw').val("");
					//alert(data.title);
				}
			});
		}
		function convertLocation(cmd){
			if(cmd=='importG'){
				window.location.href = "/bitbox/groupImportForm"
			}else if(cmd=='createG'){
				window.location.href = "/bitbox/groupRegistForm"
			}
		} 
	</script>
</body>
</html>