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

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="sidebar.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<a href="#"><span id="title"></span></a>
			<a href="https://api.github.com/repos/wosz812/Bitbox/zipball"><button>download</button></a>
			<table class="table table-hover" id="gBlist">
	
			</table>
			<div id="readme">
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<!-- page script -->
	<script type="text/javascript">
	$.ajax({ 
	    url: 'https://api.github.com/repos/wosz812/Bitbox',
	    type: 'GET',
	    
	     beforeSend: function(xhr) { 
	        xhr.setRequestHeader("Authorization",  "Basic " + btoa("yujiyeon:dbwldus26"));
	        //xhr.setRequestHeader("Accept", "application/vnd.github.swamp-thing-preview+json"); 
	    }  , 
	    //dataType: 'jsonp',
	    data: { /* "base":"master","head":"featureB","commit_message":"featureB upload"  */}///*,"affiliation":"all"*/
	}).done(function(response) {
	    console.log(response);
	    $("#title").html(response["full_name"]);
	});
	$.ajax({ 
	    url: 'https://api.github.com/repos/wosz812/Bitbox/contents',
	    type: 'GET',
	    
	     beforeSend: function(xhr) { 
	        xhr.setRequestHeader("Authorization",  "Basic " + btoa("yujiyeon:dbwldus26"));
	        //xhr.setRequestHeader("Accept", "application/vnd.github.swamp-thing-preview+json"); 
	    }  , 
	    //dataType: 'jsonp',
	    data: { /* "base":"master","head":"featureB","commit_message":"featureB upload"  */}///*,"affiliation":"all"*/
	}).done(function(response) {
	    console.log(response);
	    console.log(response.length);
	    var len=response.length;
	    var trHTML = '';
	    $.each(response,function(key,object) {
	    	//console.log()
	    	//alert(response[key].name);
	    	var el=$('<tr><td class="fPath"><a >' + response[key].name + '</a></td></tr>');
	    	//trHTML += '<tr><td class="fPath"><a >' + response[key].name + '</a></td></tr>';
	    	//trHTML.click(function(){ alert("hi") });
	    	el.click(function(){
	    		var temp=$(this).text();
	    		//alert(temp);
	    		$.ajax({ 
	    		    url: 'https://api.github.com/repos/wosz812/Bitbox/contents/'+temp,
	    		    type: 'GET',
	    		    
	    		     beforeSend: function(xhr) { 
	    		        xhr.setRequestHeader("Authorization",  "Basic " + btoa("yujiyeon:dbwldus26"));
	    		        //xhr.setRequestHeader("Accept", "application/vnd.github.swamp-thing-preview+json"); 
	    		    }  , 
	    		    //dataType: 'jsonp',
	    		    data: { /* "base":"master","head":"featureB","commit_message":"featureB upload"  */}///*,"affiliation":"all"*/
	    		}).done(function(response) {
	    		    console.log(response);
	    		    console.log(atob(response['content']));
	    		    $("#readme").html(atob(response['content']));
	    		});
	    	})
	    	$('#gBlist').append(el);
	    });
	    
	});	
	
	
	</script>

</body>
</html>