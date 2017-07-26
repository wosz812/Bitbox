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
<script src="http://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="http://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css" rel="stylesheet"></link>
</head>
<body class="hold-transition skin-blue sidebar-mini">
${token }
${username }
	<div class="wrapper">
		<%@include file="header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="sidebar.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<a href="#" class="aaf"><span id="title"></span></a>
			<a href="https://api.github.com/repos/wosz812/Bitbox/zipball"><button>download</button></a>
			<table class="table table-hover" id="gBlist">
	
			</table>
			<div id="myEditor"></div>
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
	var treeSha;
	
	$.ajax({ 
	
		 url: 'https://api.github.com/repos/wosz812/Bitbox',
		 type: 'GET',
		    
		  beforeSend: function(xhr) { 
		    }  , 
		    data: {}
		}).done(function(response) {
		    console.log(response);
		    $("#title").html(response["full_name"]);
	});	
	
	var initStart = function() {
		$.ajax({ 
	
		url: 'https://api.github.com/repos/wosz812/Bitbox/git/refs/heads/master',
		type: 'GET',
		beforeSend: function(xhr) { 
		    xhr.setRequestHeader("Authorization", "Basic " + btoa("yujiyeon:dbwldus26")); 
		},
		data: {}
		})
		.done(function(response) {
		    console.log(response);
		    var sha=response.object.sha;
		    getCurrentTreeSHA(sha);
		});
	}
	
		var getCurrentTreeSHA = function(sha) {
			api_url = "https://api.github.com/repos/wosz812/Bitbox/git/commits/"+ sha;
			$.ajax(
					{
						url : api_url,
						type : 'GET',
						beforeSend : function(xhr) {
							xhr.setRequestHeader("Authorization", "Basic "+ btoa("yujiyeon:dbwldus26"));
						},
						data : {}
					}).done(function(response) {
				console.log(response);
				treeSha = response.tree.sha;
				fgetTree(treeSha);
			});
		};
		var fgetTree = function(sha) {
			$.ajax(
					{
						url : "https://api.github.com/repos/wosz812/Bitbox/git/trees/"+sha,
						type : 'GET',
						beforeSend : function(xhr) {
							xhr.setRequestHeader("Authorization", "Basic "+ btoa("yujiyeon:dbwldus26"));
						},
						data : {}
					}).done(function(response) {
						console.log(response);
					    getTree(response.tree);
					});
				}
		initStart();
		 var getTree = function(res) {
			$('#gBlist').text("");
			$.each(res,function(key,object) {
		    	var el=$('<tr><td class="fPath"><a>' + res[key].path+ '</a></td></tr>');
		    	el.click(function(){
		    		var temp=res[key].type;
		    		var url=res[key].url;
		    		var path=res[key].path;
		    		if(temp=="blob"){
		    			getblobContent(path,url);
		    		}
		    		else{
		    			$('#gBlist').text("");
		    			$.ajax(
		    					{
		    						url : url,
		    						type : 'GET',
		    						beforeSend : function(xhr) {
		    							xhr.setRequestHeader("Authorization", "Basic "+ btoa("yujiyeon:dbwldus26"));
		    						},
		    						data : {}
		    					}).done(function(response) {
		    						console.log(response);
		    						getTree(response.tree);
		    					});
		    		}
		    	})
		    	$('#gBlist').append(el);
		    });
		} 
		 var getblobContent= function(path,url){
			 var strArray=path.split(".");
			 var mtemp=strArray[strArray.length-1];
			$.ajax(
					{
						url : url,
						type : 'GET',
						beforeSend : function(xhr) {
							xhr.setRequestHeader("Authorization", "Basic "+ btoa("yujiyeon:dbwldus26"));
						},
						data : {}
					}).done(function(response) {
						console.log(response);
						var temp=atob(response['content']);
						$('#gBlist').text("");
						YUI().use(
		    		    		  'aui-ace-editor',
		    		    		  function(Y) {
		    		    		    new Y.AceEditor(
		    		    		      {
		    		    		    	  boundingBox: '#myEditor',
		    		    		          mode: mtemp,
		    		    		          value:temp
		    		    		      }
		    		    		    ).render();
		    		    		  }
		    		    );
					});
		} 
		$('.aaf').on("click",function(){
			
		})
	
	</script>

</body>
</html>