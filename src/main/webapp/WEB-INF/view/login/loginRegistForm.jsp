<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>BITBOX RegistMember</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/dist/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/iCheck/1.0.2/skins/flat/blue.css">
<style type="text/css">
.bg_img {
	background-image: url("/img/image.jpg");
	background-repeat: no-repeat;
	z-index: 1;
	background-size: 100%;
}

.blur:before {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: inherit;
	z-index: -1;
	filter: blur(6px);
	-webkit-filter: blur(6px);
	-moz-filter: blur(6px);
	-o-filter: blur(6px);
	filter: url(#blur);
}
</style>
</head>
<body class="hold-transition register-page blur bg_img">
<div class="register-box">
  <div class="register-logo">
    <a href="/login/"><b>BIT</b>BOX</a>
  </div>

  <div class="register-box-body">
    <p class="login-box-msg">Register a new membership</p>

    <form action="/login/regist" method="post">
      <div class="form-group has-feedback">
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
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Phone" name="s_phone">
        <span class="glyphicon glyphicon-phone form-control-feedback"></span>        
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" name="s_pw">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password Check">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <select name="s_class_code" class="form-control">
        	<option value="0">반을 선택해주세요.
	 		<option value="1">1반 - IOT 디바이스 개발을 위한 임베디드 시스템 개발자 양성과정
	 		<option value="2">2반 - JAVA Enterprise 시스템 개발자 양성과정
	 		<option value="3">3반 - JAVA 기반 Database 개발자 양성과정
	 		<option value="4">4반 - JAVA 기반 웹표준/웹프로그래밍 고급인력 양성과정
	 		<option value="5">5반 - C 기반 Embedded Linux 시스템 고급인력 양성과정
	 	</select>
        <span class="glyphicon glyphicon-book form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="GIT-ID" id="git_id" name="git_id">
        <span class="fa fa-github form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="GIT-PW" id="git_pw" name="git_pw">
        <span class="fa fa-lock form-control-feedback"></span>
        <h6 style="color: red;" id="git_error"></h6>
      </div>
      <button type="button" class="btn btn-primary btn-flat" onclick="git_check()" id="git_info">Github 입력정보 확인</button>
      <div class="row">
        <div class="col-xs-8">
        	<br>
        	<a href="/login/">I already have a membership</a>
        </div>
        <div class="col-xs-4">
          <button type="submit" class="btn btn-primary btn-block btn-flat disabled" id="regist" >Regist</button>
        </div>
      </div>
    </form>
  </div>
</div>

<!-- jQuery 2.2.3 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/iCheck/1.0.2/icheck.min.js"></script>
<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
  });
  
  function git_check(){
	  var git_id=$("#git_id").val();
	  var git_pw=$("#git_pw").val();
	  $.ajax({ 
		    url: 'https://api.github.com/user',
		    type: 'GET',
		    beforeSend: function(xhr) { 
		        xhr.setRequestHeader("Authorization", "Basic " + btoa(git_id+":"+git_pw)); 
		    },
		    error: function(xhr, status, error) {
		        //alert(xhr.responseText);
		        $("h6").css("color", "red");
		        $("h6").text("입력정보가 올바르지 않습니다.");
		    }
		}).done(function(response) {
		    console.log(response);
		    var username=response.login;
		    //console.log(username);
		    $("#git_id").val(username);
		    $("h6").css("color", "blue");
	        $("h6").text("입력정보 확인.");
	        $('#regist').removeClass(' btn btn-primary btn-block btn-flat disabled');
	        $('#regist').addClass('btn btn-primary btn-block btn-flat');
	        $("#git_info").prop("disabled",true);
		});
  }
</script>
</body>
</html>