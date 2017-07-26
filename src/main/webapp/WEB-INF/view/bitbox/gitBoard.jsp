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
<style>
#dragandrophandler
{
border:2px dotted #0B85A1;
width:400px;
color:#92AAB0;
text-align:left;vertical-align:middle;
padding:10px 10px 10 10px;
margin-bottom:10px;
font-size:200%;
}
.progressBar {
    width: 200px;
    height: 22px;
    border: 1px solid #ddd;
    border-radius: 5px; 
    overflow: hidden;
    display:inline-block;
    margin:0px 10px 5px 5px;
    vertical-align:top;
}
 
.progressBar div {
    height: 100%;
    color: #fff;
    text-align: right;
    line-height: 22px; /* same as #progressBar height if we want text middle aligned */
    width: 0;
    background-color: #0ba1b5; border-radius: 3px; 
}
.statusbar
{
    border-top:1px solid #A9CCD1;
    min-height:25px;
    width:700px;
    padding:10px 10px 0px 10px;
    vertical-align:top;
}
.statusbar:nth-child(odd){
    background:#EBEFF0;
}
.filename
{
display:inline-block;
vertical-align:top;
width:250px;
}
.filesize
{
display:inline-block;
vertical-align:top;
color:#30693D;
width:100px;
margin-left:10px;
margin-right:5px;
}
.abort{
    background-color:#A8352F;
    -moz-border-radius:4px;
    -webkit-border-radius:4px;
    border-radius:4px;display:inline-block;
    color:#fff;
    font-family:arial;font-size:13px;font-weight:normal;
    padding:4px 15px;
    cursor:pointer;
    vertical-align:top
    }
</style>

<link href="/dist/css/bootstrap.min.css" rel="stylesheet"></link>

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="sidebar.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<a href="/git/gitBoardView" class="aaf"><span id="title"></span></a>

			${token}
			${username}
			<a href="#" class="aaf"><span id="title"></span></a>

			<a href="https://api.github.com/repos/wosz812/Bitbox/zipball"><button>download</button></a>
			<table class="table table-hover" id="gBlist">
	
			</table>
			<div id="myEditor"></div>
			<div id="dragandrophandler">Drag & Drop Files Here</div>
			<table id="status1"></table>
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
	var fileList=new Array();
	var uploadList=new Array();
	var promises=new Array();
	var uploadDirs=new Array();
	var uploadFiles=new Array();
	
	$(document).ready(function()
			{
			var obj = $("#dragandrophandler");
			obj.on('dragenter', function (e) 
			{
			    e.stopPropagation();
			    e.preventDefault();
			    $(this).css('border', '2px solid #0B85A1');
			});
			obj.on('dragover', function (e) 
			{
			     e.stopPropagation();
			     e.preventDefault();
			});
			obj.on('drop', function (e) 
			{
			 
			     $(this).css('border', '2px dotted #0B85A1');
			     e.preventDefault();
			    
			    var items=e.originalEvent.dataTransfer.items;
			    
			    var p = Promise.resolve().then(function() {
			    	//alert("pro1");
			    	for(var i=0;i<items.length;i++){
				    	 var item=items[i].webkitGetAsEntry();
				    	 if(item){
				    		 promises.push(item);
				    	 }
				     }
			    }).then(function() {
					//alert("pro2");
					for(var pro=0;pro<promises.length;pro++){
			    		traversefileTree(promises[pro]);
			    		if(pro==promises.length-1){
			    			//console.log(uploadDirs);
							if(uploadFiles.length==0){
								$('#status1').text("");
								for(var d=0;d<uploadDirs.length;d++){
									$('#status1').append('<tr><td>' + uploadDirs[d]+ '</a></td><td class="rDid" data-val="'+uploadDirs[d]+'"><span class="glyphicon glyphicon-remove"></td></tr>');
								}
							}
							else{
								$('#status1').text("");
								for(var d=0;d<uploadFiles.length;d++){
									$('#status1').append('<tr><td>' + uploadFiles[d]+ '</a></td><td class="rid" data-val="'+uploadFiles[d]+'"><span class="glyphicon glyphicon-remove"></td></tr>');
								}
							}
							$('#status1').append('<input type="button" id="appendbtn" class="btn btn-primary" value="Commit" />');
			    		}
					}
			    });
			});
			$(document).on('dragenter', function (e) 
			{
			    e.stopPropagation();
			    e.preventDefault();
			});
			$(document).on('dragover', function (e) 
			{
			  e.stopPropagation();
			  e.preventDefault();
			  obj.css('border', '2px dotted #0B85A1');
			});
			$(document).on('drop', function (e) 
			{
			    e.stopPropagation();
			    e.preventDefault();
			});
			$(document).on('click','.rid',function() {
				var value=$(this).attr("data-val");
				 $(this).parent().remove();
				var index = uploadFiles.indexOf(value);
				if (index > -1) {
					uploadFiles.splice(index, 1);
				}
				console.log("remove: "+uploadFiles);
			});
			$(document).on('click','.rDid',function() {
				var value=$(this).attr("data-val");
				 $(this).parent().remove();
				var index = uploadDirs.indexOf(value);
				if (index > -1) {
					uploadDirs.splice(index, 1);
				}
				console.log("remove: "+uploadDirs);
			});
			$(document).on('click','#appendbtn',function() {
				//console.log(treeSha);
				//console.log(fileList);
				for(var fl=0;fl<fileList.length;fl++){
					var path=fileList[fl].fpath;
					var content=fileList[fl].fcontent;
					promises.push(createFileList(path,content));
					if(fl==fileList.length-1){
						Promise.all(promises).then(function() {
							createTree();
						});
					}
				}
			}); 
	});
	
	//title 얻어오기
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
	
		url: 'https://api.github.com/repos/yujiyeon/repo-test2/git/refs/heads/master',
		type: 'GET',
		beforeSend: function(xhr) { 
			xhr.setRequestHeader('Authorization', 'Bearer ${token}'); 
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
			api_url = "https://api.github.com/repos/yujiyeon/repo-test2/git/commits/"+ sha;
			$.ajax(
					{
						url : api_url,
						type : 'GET',
						beforeSend : function(xhr) {
							xhr.setRequestHeader('Authorization', 'Bearer ${token}');
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
						url : "https://api.github.com/repos/yujiyeon/repo-test2/git/trees/"+sha,
						type : 'GET',
						beforeSend : function(xhr) {
							xhr.setRequestHeader('Authorization', 'Bearer ${token}');
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
		    							xhr.setRequestHeader('Authorization', 'Bearer ${token}');
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
							xhr.setRequestHeader('Authorization', 'Bearer ${token}');
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
		
		 //commit tree
		 /* $.ajax({ 
				url: 'https://api.github.com/repos/yujiyeon/repo-test2/git/refs/heads/master',
				type: 'GET',
				beforeSend: function(xhr) { 
					xhr.setRequestHeader('Authorization', 'Bearer ${token}');
				},
				data: {}
				})
				.done(function(response) {
				    console.log(response);
				    var sha=response.object.sha;
				    getCurrentTreeSHA(sha);
				});
				

				var getCurrentTreeSHA = function(sha) {
					api_url = "https://api.github.com/repos/yujiyeon/repo-test2/git/commits/"+ sha;
					$.ajax(
							{
								url : api_url,
								type : 'GET',
								beforeSend : function(xhr) {
									xhr.setRequestHeader('Authorization', 'Bearer ${token}');
								},
								data : {}
							}).done(function(response) {
						console.log(response);
						treeSha = response.tree.sha;
					});
				}; */
				var traversefileTree = function(item, path) {
					path = path || "";
					if (item.isFile) {
						uploadFiles.push(path + item.name);
						item.file(function(file) {
							var r = new FileReader();
							r.onload = function(e) {
								var contents = e.target.result;
								var tpath = path + item.name;
								fileList.push({
									fpath : tpath,
									fcontent : contents
								});
							}
							r.readAsText(file);
						});

					} else if (item.isDirectory) {
						var dirReader = item.createReader();
						uploadDirs.push(item.fullPath);
						dirReader.readEntries(function(entries) {
							for (var i = 0; i < entries.length; i++) {
								promises.push(traversefileTree(entries[i], path + item.name
										+ "/"));
								if (i == entries.length - 1) {
									return Promise.all(promises).then(function() {

									});
								}
							}
						})
					}
				};

				var createBlob = function(content) {
					var filecontent = content;
					var filedata = JSON.stringify({"content":""+filecontent+"","encoding":"UTF-8"});
					return new Promise(function(resolve, reject) {
						$.ajax({ 
							url: 'https://api.github.com/repos/yujiyeon/repo-test2/git/blobs',
							type: 'POST',
							beforeSend: function(xhr) { 
								xhr.setRequestHeader('Authorization', 'Bearer ${token}'); 
							},
							data: filedata
							})
							.done(function(response) {
							    console.log(response);
							    resolve(response.sha);
							});
					});
				};

				var createFileList = function(path,content) {
					return new Promise(function(resolve, reject) {
						var blob_sha;
						createBlob(content)
						.then(function (text) {
							//console.log(text);
							uploadList.push({
								sha:text,
								path:path,
								mode:"100644",
								type:"blob"
							});
							resolve(uploadList);
						});
					});
				};
				function createTree(){
					return $.ajax({ 
						   url: 'https://api.github.com/repos/yujiyeon/repo-test2/git/trees',
						   type: 'POST',
						   beforeSend: function(xhr) { 
							   xhr.setRequestHeader('Authorization', 'Bearer ${token}');
						   },
						   data: JSON.stringify({"tree":uploadList,"base_tree":treeSha})
						}).done(function(response) {
								console.log("finish");
							    console.log(response);
							    var cmsha=response.sha;
							    console.log(cmsha);
							    createCommit(cmsha);
						});
					} 
					
				function createCommit(tree_sha){
					var commit_data= JSON.stringify({"message":"file upload branch","tree":""+tree_sha+""});
					$.ajax({ 
					   url: 'https://api.github.com/repos/yujiyeon/repo-test2/git/commits',
					   type: 'POST',
					   beforeSend: function(xhr) { 
						   xhr.setRequestHeader('Authorization', 'Bearer ${token}');
					   },
					   data: commit_data
					}).done(function(response) {
						    console.log(response);
						    patch_repos(response.sha);
					});
				}

				function patch_repos(sha){
					$.ajax({ 
					   url: 'https://api.github.com/repos/yujiyeon/repo-test2/git/refs/heads/master',
					   type: 'PATCH',
					   beforeSend: function(xhr) { 
						   xhr.setRequestHeader('Authorization', 'Bearer ${token}');
					   },
					   data: JSON.stringify({"sha":sha,"force":true})
					}).done(function(response) {
						    console.log(response);
					});
				}
	
	</script>

</body>
</html>