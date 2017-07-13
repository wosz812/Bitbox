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
 	#graph{
 		width:50px;
 		height:100px;
 	
 	}
 	#sales-chart3{
 		
 		
 	}
 	#sales-chart{
 		
 		margin-left: 20px;
 	}
 	#sales-chart2{
 		
 		
 	}
 	#slide{
 		margin-top:-10px;
 	}
 	.btn{
 		text-align:right;
 	}
 	.btn-item{
 		width:80%;
 	}
 	.inp{
 		width:65%;
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
								class="info-box-number">5,200</span>

							<div class="progress">
								<div class="progress-bar" style="width: 50%"></div>
							</div>
							<span class="progress-description"> 50% Increase in 30
								Days </span>
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
								class="info-box-number">114,381</span>

							<div class="progress">
								<div class="progress-bar" style="width: 70%"></div>
							</div>
							<span class="progress-description"> 70% Increase in 30
								Days </span>
						</div>
						<!-- /.info-box-content -->
					</div>
				</div>
				<div class="col-md-4">
					<div class="info-box bg-green">
						<span class="info-box-icon"><i
							class="fa fa-comments-o"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">Comments</span> <span
								class="info-box-number">92,050</span>

							<div class="progress">
								<div class="progress-bar" style="width: 20%"></div>
							</div>
							<span class="progress-description"> 20% Increase in 30
								Days </span>
						</div>
						<!-- /.info-box-content -->
					</div>
				</div>

			</section>
			<section class="content">
				<div class="col-md-8">
					<!-- DONUT CHART -->
					<div class="box box-primary" style="height: 300px">
						<div class="box-header with-border">
							<h3 class="box-title font">과정 커리큘럼</h3>

						</div>

						<div class="box-body chart-responsive col-md-4" align="left">
							<div class="chart" id="sales-chart"
								style="width: 180px; height: 180px; position: relative;"></div>
						</div>
						
						<div class="box-body chart-responsive col-md-4" align="center" style="width:10px; margin-left: 10">
							<div class="chart" id="sales-chart3"
								style="width: 180px; height: 180px; position: relative;"></div>
						</div>

						<div class="box-body chart-responsive col-md-4" align="right" style="margin-left: 190px">
							<div class="chart" id="sales-chart2"
								style=" width:180px; height: 180px; position: relative;" align="center"></div>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
			

				<div class="col-md-4">
					
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title font">TO DO</h3>
						</div>
						<div class="box-body chart-responsive"  style="overflow: scroll; height:220px;">
							<div id="todo-list">
							<table class="table table-hover" style="width:422.33px;">
								<tr><td class="inp">
									<input class="form-control" id="todoText" placeholder="Input TODO"  type="text">
									</td>
									<td><button @click="add" class="btn btn-primary">Add</button></td>
									<td><button @click="deleteAll(items)" class="btn btn-danger">Delete all</button></td>
								</tr>
								<div id="items">
									
										<tr v-for="(item,key) in items">
											<td colspan="2">{{ item }}</td>
											<td class="btn"><button @click="deletedd(key)" class="btn btn-warning">Delete</button></td>
										</tr>		
								</div>
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
											<a href="http://www.bitacademy.com"> <img src="/img/img_bit.JPG"
												alt="First slide"></a>

											<div class="carousel-caption">First Slide</div>
										</div>
										<div class="item">
											<a href="http://www.hrd.go.kr"> <img src="/img/img_hrd.JPG"
												alt="Second slide"></a>

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
					<div class="box box-primary" style="height: 400px">
						<div class="box-header with-border">
							<h3 class="box-title font">간편 메뉴</h3>
						</div>
						
						<!-- /.box-body -->
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
		var STORAGE_KEY = 'vue-js-todo-P7oZi9sL';
		var app = new Vue({
			el : '#todo-list',
			data : {
				items : JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]'),
				todoText : ''
			},
			watch: {
				  items: function (items) {
					  //todoStorage.save(todos);
					  localStorage.setItem(STORAGE_KEY, JSON.stringify(items));
				  }
			},
			methods : {
				add : function() {
					var txt = document.getElementById("todoText").value;
					//alert(txt);
					//this.$set('todo-list.items', txt);
					this.items.push(txt);
					//localStorage.setItem('items');
					//console.log(this.items[0]);
					document.getElementById("todoText").value = "";
				},
				deletedd : function(ev) {
					//console.log(this.items); 
					//alert(ev);
					this.items.splice(ev, 1);
				},
				deleteAll : function(ev){
					this.items.splice(ev);
				}

			}
		});
	</script>

</body>
</html>