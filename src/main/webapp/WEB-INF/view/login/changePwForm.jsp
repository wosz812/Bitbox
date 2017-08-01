<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>BITBOX SearchInfo</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.3.11/css/AdminLTE.min.css">
</head>
<body class="hold-transition login-page">
	<script type="text/javascript">
		function winClose(){
			window.close();
		}
	</script>
	<div class="login-box">
		<div class="login-logo">
			<a href="#"><b>BIT</b>BOX</a>
		</div>
		<form action="/mail/changePW" method="post">
			<div class="login-box-body">
				<input type="hidden" name="s_id" value="${id}">
				<div class="form-group has-feedback">
	        		<input type="password" class="form-control" placeholder="Password" name="s_pw">
	        		<span class="glyphicon glyphicon-lock form-control-feedback"></span>
	     		</div>
	      		<div class="form-group has-feedback">
	        		<input type="password" class="form-control" placeholder="Password Check">
	        		<span class="glyphicon glyphicon-lock form-control-feedback"></span>
	      		</div>
				<div class="row">
					<div class="col-xs-12" align="right">
						<button class="btn btn-primary">��й�ȣ ����</button>
						<button type="submit" onclick="winClose();" class="btn btn-primary">Close</button>
					</div>
				</div>
			</div>
		</form>
	</div>
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