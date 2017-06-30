<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="text/html; charset=UTF-8">
<title>BITBOX SearchInfo</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- daterange picker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-daterangepicker/2.1.25/daterangepicker.css">
<!-- bootstrap datepicker -->
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.0/css/bootstrap-datepicker3.css">
<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/iCheck/1.0.2/skins/all.css">
<!-- Bootstrap Color Picker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-colorpicker/2.5.1/css/bootstrap-colorpicker.min.css">
<!-- Bootstrap time Picker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.min.css">
<!-- Select2 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="/resources/css/dist/css/skins/_all-skins.min.css">
</head>
<body class="hold-transition register-page">
<script type="text/javascript">
	function div_OnOff(v){
		if(v=="0"){
	 		document.getElementById("con").style.display = "none"; // 보여줌
	 		document.getElementById("type").value = "0";
		} else {
			document.getElementById("con").style.display = ""; // 숨김
			document.getElementById("type").value = "1";
		}
	}
</script>
<script type="text/javascript">
	function popup(frm){
	 	 var url    ="/mail/sendMail";
	 	 var title  = "Search ID/PW";
	 	 var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=630,height=250,top=30,left=20"; 
	 	 window.open("", title,status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
	   	                                         //인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
	   	                                         //가능합니다.
		 frm.target = title;                     //form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
		 frm.action = url;                       //form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
		 frm.method = "post";
 	 	 frm.submit();     
 	 }
</script>
	<div class="register-box">
		<div class="register-logo">
			<a href="/login/"><b>BIT</b>BOX</a>
		</div>

		<div class="register-box-body">
			<p class="login-box-msg">Search your Id & Password</p>
			<div class="btn-group form-group">
            	<button class="btn btn-primary" onclick="div_OnOff(0);">ID Search</button>
            	<button class="btn btn-primary" onclick="div_OnOff(1);">PW Search</button>
            </div>
			<form>
				<input type="hidden" id="type" name="type" value="0">
				<div id="con" style="display:none" class="form-group has-feedback">
        			<input type="text" class="form-control" placeholder="Id" name="s_id">
        			<span class="glyphicon glyphicon-check form-control-feedback"></span>
     			</div>
				<div class="form-group has-feedback">
					<input type="text" class="form-control" placeholder="Full name" name="s_name"> 
					<span class="glyphicon glyphicon-user form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="email" class="form-control" placeholder="Email" name="s_email"> 
					<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
				</div>
				<div class="row">
        			<div class="col-xs-8">
        				<br>
						<a href="/login/">I already know</a>
      				</div>
       			 	<div class="col-xs-4">
          				<button type="submit" onclick="popup(this.form)" class="btn btn-primary btn-block btn-flat">찾기</button>
        			</div>
     			 </div>
			</form>
		</div>
	</div>
	<!-- /.register-box -->
	<!-- jQuery 2.2.3 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/iCheck/1.0.2/icheck.min.js"></script>
	<script>
		$(function() {
			$('input').iCheck({
				checkboxClass : 'icheckbox_square-blue',
				radioClass : 'iradio_square-blue',
				increaseArea : '20%' // optional
			});
		});
	</script>
</body>
</html>