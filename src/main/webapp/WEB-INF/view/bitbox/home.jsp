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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
<style type="text/css">
#graph {
	width: 50px;
	height: 100px;
}

#sales-chart3 {
	
}

#sales-chart {
	margin-left: 20px;
}

#sales-chart2 {
	
}

#slide {
	margin-top: -10px;
}

.btn {
	text-align: right;
}

.btn-item {
	width: 80%;
}

.inp {
	width: 65%;
}
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
				<div class="col-md-4">
					<div class="info-box bg-yellow">
						<span class="info-box-icon"><i
							class="ion ion-ios-cloud-upload-outline"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">Upload Files</span> <span
								class="info-box-number"><div class="counter" id="pboard_cnt">0</div></span>

							<div class="progress">
								<div class="percent progress-bar" ></div>
							</div>
							<span class="progress-description"> Number of files uploaded to personal board </span>
						</div>

						<!-- /.info-box-content -->
					</div>
				</div>
				<div class="col-md-4">
					<div class="info-box bg-red">
						<span class="info-box-icon"><i
							class="ion ion-ios-people-outline"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">Group Join</span> <span
								class="info-box-number"><div class="counter" id="gin_cnt">0</div></span>

							<div class="progress">
								<div class="percent progress-bar" ></div>
							</div>
							<span class="progress-description"> The number of groups I joined </span>
						</div>
						<!-- /.info-box-content -->
					</div>
				</div>
				<div class="col-md-4">
					<div class="info-box bg-green">
						<span class="info-box-icon"><i class="fa fa-comments-o"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">Comments</span> <span
								class="info-box-number"><div class="counter" id="qna_cnt">0</div></span>

							<div class="progress">
								<div class="percent progress-bar" ></div>
							</div>
							<span class="progress-description"> Q & A number I wrote </span>
						</div>
						<!-- /.info-box-content -->
					</div>
				</div>

			</section>
			<section class="content">
				<div class="col-md-8">
					<!-- DONUT CHART -->
					<div class="box" style="height: 300px">
						<div class="box-header with-border">
							<h3 class="box-title font">과정 커리큘럼</h3>

						</div>

						<div class="box-body chart-responsive col-md-4" align="left">
							<div class="chart" id="sales-chart"
								style="width: 180px; height: 180px; position: relative;"></div>
						</div>

						<div class="box-body chart-responsive col-md-4" align="center"
							style="width: 10px; margin-left: 10">
							<div class="chart" id="sales-chart3"
								style="width: 180px; height: 180px; position: relative;"></div>
						</div>

						<div class="box-body chart-responsive col-md-4" align="right"
							style="margin-left: 190px">
							<div class="chart" id="sales-chart2"
								style="width: 180px; height: 180px; position: relative;"
								align="center"></div>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
				<div class="col-md-4">
					<div class="box">
						<div class="box-header with-border">
							<h3 class="box-title font">TO DO</h3>
						</div>
						<div class="box-body chart-responsive"
							style="overflow: scroll; height: 250px;">
							<div id="todo-list">
								<table class="table table-hover" style="width: 422.33px;">
									<div id="todo"></div>
								</table>
							</div>
						</div>
						<!-- /.box-body -->
					</div>
				</div>
				<div class="col-md-8" id="slide">
					<div class="box box-solid">
						<!-- /.box-header -->
						<div class="box-body">
							<div id="carousel-example-generic" class="carousel slide"
								data-ride="carousel">
								<ol class="carousel-indicators">
									<li data-target="#carousel-example-generic" data-slide-to="0"
										class="active"></li>
									<li data-target="#carousel-example-generic" data-slide-to="1"
										class=""></li>
									<li data-target="#carousel-example-generic" data-slide-to="2"
										class=""></li>
								</ol>
								<div class="carousel-inner">

									<div class="item active">
										<a href="http://www.bitacademy.com"> <img
											src="/img/img_bit.JPG" alt="First slide"></a>

										<div class="carousel-caption">First Slide</div>
									</div>
									<div class="item">
										<a href="http://www.hrd.go.kr"> <img
											src="/img/img_hrd.JPG" alt="Second slide"></a>

										<div class="carousel-caption">Second Slide</div>
									</div>
									<div class="item">
										<a href="https://www.aladin.co.kr"> <img
											src="/img/img_aladin.jpg" alt="Third slide"></a>

										<div class="carousel-caption">Third Slide</div>
									</div>
								</div>
								<a class="left carousel-control"
									href="#carousel-example-generic" data-slide="prev"> <span
									class="fa fa-angle-left"></span>
								</a> <a class="right carousel-control"
									href="#carousel-example-generic" data-slide="next"> <span
									class="fa fa-angle-right"></span>
								</a>
							</div>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>

				<div class="col-md-4">
					<!-- DONUT CHART -->
					<div class="box" style="height: 400px">
						<div class="box-header with-border" style="overflow: scroll; height: 400px;">
							<h3 class="box-title font">최근 회의록</h3>
							<div>
								<table class="table table-hover" style="width: 460.33px;">
									<tr><td></td></tr>
									<tr align="center">
										<td><label>그룹명</label></td>
										<td><label>다운받기</label></td>
									</tr>
									<c:forEach items="${groupList}" var="group">
										<tr align="center">
											<td>
												<h4>${group.title}</h4>
											</td>
											<td>
												<div class="btn-group" align="right">
								                	<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
								                		다운받기&nbsp;&nbsp;
									                    <span class="caret"></span>
									                    <span class="sr-only">Toggle Dropdown</span>
								                    </button>
								               		<ul class="dropdown-menu" role="menu">
									                    <li><a href="/bitbox/recent_Down?group_seq=${group.group_seq }" style="background-color: darkcyan; width: 130px;">Hwp 로 다운</a></li>
									                    <li><a href="/bitbox/recent_Pdf?group_seq=${group.group_seq }" style="background-color: cadetblue; width: 130px;">PDF 로 다운</a></li>
								                  	</ul>
								                </div>
											</td>
										</tr>																																			
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</div>
			</section>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
	<!-- page script -->
	<script type="text/javascript" src="/js/chart.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$.ajax({
				url : '/bitbox/getTodoList',
				type : 'POST',
				success : function(data) {
					$('#todo').html(data);
				}
			});
		});

		$(document).on("click", "#todoButton", addTodo);
		function addTodo() {
			var todoText = document.getElementById("todoText").value;
			var controller = '/bitbox/addTodo'; //JH : controller 명 지정해주기 예:localhost/index.php/controller(이거)/function/param
			//var base_url = '<?php echo site_url(); //you have to load the "url_helper" to use this function ?>';            
			var url = controller + '?text=' + todoText;
			$.ajax({
				url : url,
				type : 'POST',
				//data: { "gno": JSON.stringify(gno)},
				//data: { "gno": gno},
				success : function(data) {
					$('#todo').html(data.toString());
				}
			});
		}

		$(document).on("click", "#todoDeleteAll", deleteAll);
		function deleteAll() {
			var controller = '/bitbox/deleteAll'; //JH : controller 명 지정해주기 예:localhost/index.php/controller(이거)/function/param
			//var base_url = '<?php echo site_url(); //you have to load the "url_helper" to use this function ?>';            
			var url = controller
			$.ajax({
				url : url,
				type : 'POST',
				//data: { "gno": JSON.stringify(gno)},
				//data: { "gno": gno},
				success : function(data) {
					$('#todo').html(data.toString());
				}
			});
		}

		$(document).on("click", "#deleteLine", deleteLine);
		function deleteLine() {
			var seq = $(this).attr("seq");
			var controller = '/bitbox/deleteLine'; //JH : controller 명 지정해주기 예:localhost/index.php/controller(이거)/function/param
			//var base_url = '<?php echo site_url(); //you have to load the "url_helper" to use this function ?>';            
			var url = controller + '?seq=' + seq;
			$.ajax({
				url : url,
				type : 'POST',
				//data: { "gno": JSON.stringify(gno)},
				//data: { "gno": gno},
				success : function(data) {
					$('#todo').html(data.toString());
				}
			});
		}
		
		var getPBoardCnt=new Promise(function(resolve,reject){
			var url = "/bitbox/getPBoardCnt"
				$.ajax({
					url : url,
					type : 'POST',
					success : function(data) {
						$("#pboard_cnt").attr("data-count",data);
						resolve();
					}
				});
		});
		
		var getGinCnt=new Promise(function(resolve,reject){
			var url = "/bitbox/getGinCnt"
				$.ajax({
					url : url,
					type : 'POST',
					success : function(data) {
						$("#gin_cnt").attr("data-count",data);
						resolve();
					}
				});
		});
		var getQnaCnt=new Promise(function(resolve,reject){
			var url = "/bitbox/getQnaCnt"
				$.ajax({
					url : url,
					type : 'POST',
					success : function(data) {
						$("#qna_cnt").attr("data-count",data);
						resolve();
					}
				});		
		});
		
		Promise.all([getPBoardCnt,getGinCnt, getQnaCnt]).then(function () {
			console.log("finish");
			$('.counter').each(function() {
				  var $this = $(this),
				      countTo = $this.attr('data-count'); //countTo: 언제까지 count를 increase할것인가
				  $({ countNum: $this.text()}).animate({  //증가에 대한 애니메이션 등록
				    countNum: countTo
				  },
				  {
				    duration: 1000, //속도
				    easing:'swing', //증가 방법 --> google에 javascript easing검색하면 증가방법에 대한 그래프가 나옴
				    step: function() { //value를 지정하기전에 값을 변경할 수 있는 animation에 대한 속성
				      $this.text(Math.floor(this.countNum)); //Math.floor는 counter에 대한 반올림에 대한 함수
				    },
				    complete: function() { //animate가 완료되면 counter에 text를 set한다.
				      $this.text(this.countNum);
				    }
				  });
			});
			$('.percent').each(function() {
				  var $this = $(this),
				      countTo = 100; //countTo: 언제까지 count를 increase할것인가
				  $({ countNum: $this.width()}).animate({  //증가에 대한 애니메이션 등록
				    countNum: countTo
				  },
				  {
				    duration: 1000, //속도
				    easing:'swing', //증가 방법 --> google에 javascript easing검색하면 증가방법에 대한 그래프가 나옴
				    step: function() { //value를 지정하기전에 값을 변경할 수 있는 animation에 대한 속성
				      $this.width(Math.floor(this.countNum)+"%"); //Math.floor는 counter에 대한 반올림에 대한 함수
				    },
				    complete: function() { //animate가 완료되면 counter에 text를 set한다.
				      $this.width(this.countNum+"%");
				    }
				  });
			});
		});
	</script>

</body>
</html>