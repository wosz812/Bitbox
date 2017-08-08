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
			
			<section class="content-header">
		      <a href="/git/gitBoardView" class="aaf"><h2 id="title"></h2></a>
		    </section>
			<%-- ${token}
			${username}
			${status}
			${id} --%>
			<div id="toReplace">
				<div v-if="currentComponent==='upload files'">
					<div id="dragandrophandler" @drop="onDrop">Drag & Drop Files Here</div>
					<!-- <div class="progress">
		                <div class="progress-bar progress-bar-primary progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
		                  <span class="sr-only">40% Complete (success)</span>
		                </div>
		            </div> -->
					<table id="status1"></table>
					<button class="btn btn-primary" @click="swapComponent(null)">Close</button>
				</div>
				<div v-if="currentComponent==='invitation'">
					<div class="col-md-6">
				          <div class="box box-default">
				            <div class="box-header with-border">
				              <i class="fa fa-warning"></i>
				              <h3 class="box-title">Alerts</h3>
				            </div>
				            <div class="box-body">
				              <div class="alert alert-warning alert-dismissible">
						      	<h4><i class="icon fa fa-warning"></i> Github Rpository 초대를 수락해주세요</h4>
						        <div class="btn-group-horizontal">
					            	<a href="{{html_url}}" target="_blank" id="invitation_url"><button type="button" class="btn btn-primary" onclick="click_func()" id="invitation_btn">Accept</button></a>
					                <a href="/git/gitBoard?title=${title}"><button type="button" class="btn btn-default" id="close_refresh" disabled>Close</button></a>
					            </div>
						     </div>
				            </div>
				          </div>
					</div>
				</div>
				<div v-show="!currentComponent">
					<div class="dropdown">
						<div class="btn-group" style="float: right; margin-right: 20px;">
							<button class="btn btn-primary" @click="swapComponent(component)"
								id="upfile">{{component}}</button>
							<button class="btn btn-primary dropdown-toggle" type="button"
								data-toggle="dropdown">
								clone or download <span class="caret"></span>
							</button>
							<div class="dropdown-menu">
								Clone with HTTPS Use Git or checkout with SVN using the web URL.
								<!-- <input type="text" class="form-control" > -->
								<div class="input-group">
								<input type="text" class="form-control pull-right" id="clone_url">
				                  <div class="input-group-addon">
				                    <button class="fa fa-copy" onclick="copyToClipboard()" id="btn_copy" data-toggle="tooltip" title="url copy!" data-placement="bottom"></button>
				                  </div>
				                </div>
								<a href="https://api.github.com/repos/${masId}/${title}/zipball"><button style="margin-top: 10px;" type="button" class="btn btn-primary btn-block btn-flat">Download Zip</button></a>
							</div>
						</div>
					</div>

					<section class="content" id="sectiongB">
						<div class="row">
							<div class="col-xs-12">
								<div class="box">
									<div class="box-header with-border">
										<h3 class="box-title">${title}repository</h3>
									</div>
									<!-- /.box-header -->
									<div class="box-body">
										<table class="table table-bordered">
											<tr v-for="row in rows">
												<td width="15px"><img v-bind:src=row.src></td>
												<td style="text-align:left"><a v-on:click="gitClick(row.type,row.path,row.url)">{{row.path}}</a></td>
											</tr>
										</table>
									</div>
									<!-- /.box-body -->
								</div>
							</div>
						</div>
					</section>
					<div id="myEditor"></div>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<!-- page script -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/1.0.16/vue.js"></script>
	<script src="/js/bootstrap-waitingfor.js"></script>
	<script type="text/javascript">
var treeSha;
var fileList=new Array();
var blobList=new Array();
var uploadList=new Array();
var promises=new Array();
var uploadDirs=new Array();
var uploadFiles=new Array();
var cnt=1;
var flag=0;//상위 폴더 생성하기위한 변수
var prevUrl=new Array();

//create repository
var createRepos=function(){
	var reposdata='{"name": "${title}","description":"repo create from ajax test","homepage": "https://sample.com","auto_init":true}';
	console.log(reposdata);
	$.ajax({ 
	    url: 'https://api.github.com/user/repos',
	    type: 'POST',
	    beforeSend: function(xhr) { 
	        xhr.setRequestHeader("Authorization", 'Bearer ${token}'); 
	    },
	    data: reposdata
	}).done(function(response) {
	    console.log(response);
	    toReplace.fetchEventsList();
	});
}

 $(document).ready(function()
		{
		var obj = $("#dragandrophandler");
		
		obj.on('dragover', function (e) 
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
			$('#status1').text("");
			$.ajax({ //upload file 할 때 알람 띄우기 위해 필요한 ajax
	              url : "/bitbox/uploadFile?title=${title}",
	              type : 'POST',
		            success : function(data) {
		            	console.log(data);
		            	if(data){
		            		console.log(data);
		            	}
		            }
		    });//ajax end
		    waitingDialog.show('Please wait for upload to complete');
			var fl=0;
			 var testInterval=setInterval(function() {
				var path=fileList[fl].fpath;
				var content=fileList[fl].fcontent;
				promises.push(createBlob(content,path));
				if(fl==fileList.length-1){
					Promise.all(promises).then(function() {
						createFileList();
						clearInterval(testInterval);
					});
				}
				fl++;
			},1000); 
		}); 
}); 
 var getTitle = function() {
	 return new Promise(function(resolve, reject) {
		 $.ajax({ 	
			 url: 'https://api.github.com/repos/${masId}/${title}',
			 type: 'GET',
			    
			  beforeSend: function(xhr) { 
			    }  , 
			    data: {}
			}).done(function(response) {
			    console.log(response);
			    $("#title").html(response["full_name"]);
			    $("#clone_url").val(response["clone_url"]);
			    resolve();
		});	
	 });
 }
 var initStart = function() {
	 return new Promise(function(resolve, reject) {
		$.ajax({ 
	
		url: 'https://api.github.com/repos/${masId}/${title}/git/refs/heads/master',
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
		    resolve();
		});
	 });
	}
	
		var getCurrentTreeSHA = function(sha) {
			api_url = "https://api.github.com/repos/${masId}/${title}/git/commits/"+ sha;
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
		
		//github repository file Tree 얻어오기
		var fgetTree = function(sha) {
			$.ajax(
					{
						url : "https://api.github.com/repos/${masId}/${title}/git/trees/"+sha,
						type : 'GET',
						beforeSend : function(xhr) {
							xhr.setRequestHeader('Authorization', 'Bearer ${token}');
						},
						data : {}
					}).done(function(response) {
						console.log(response);
						prevUrl.push(response["url"]);
					    getTree(response.tree);
					});
				}
		
		
		//tree를 얻어온 것 테이블에 뿌려주기
		 var getTree = function(res) {
			$('#gBlist').text("");
			var el=new Object();
			var len=prevUrl.length;
			if(len!=1){
				el={
						src:"/img/directory.png",
						path:"..",
						type:"",
						url:prevUrl[prevUrl.length-2]
				}
				toReplace.rows.push(el);
			}
			$.each(res,function(key,object) {
				if(res[key].type=="tree"){
					el={
							src:"/img/directory.png",
							path:res[key].path,
							type:res[key].type,
							url:res[key].url
					}
				}else{
					el={
							src:"/img/file.png",
							path:res[key].path,
							type:res[key].type,
							url:res[key].url
					}
				}
				toReplace.rows.push(el);
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
		 
		 
  var toReplace =  new Vue({
	  el: '#toReplace',
	  data: {
	    currentComponent: null,
	    component: 'upload files',
	    rows: [],
	    html_url: ''
	  },
	  components: {
	    'upload files': {
	     template: ''
	    },
	    'invitation': {
		     template: ''
		 }
	  },
	  watch: {
	    // 질문이 변경될 때 마다 이 기능이 실행됩니다.
	    html_url: function (newValue) {
	    	//debugger;
	    }
	  },

	  
	  created: function() {
			
	  },
	  methods: {
	    swapComponent: function(component)
	    {
	    	console.log(component);
	      this.currentComponent = component;
	    },
	    changeUrl:function(url){
	    	this.html_url=url; //이렇게 하고
	    	this.swapComponent("invitation");
	    },
	    fetchEventsList: function() {
        	Promise.all([getTitle(), initStart()]).then(function () {
        		console.log("모두 완료됨");
        	});

        },
      	gitClick: function(type,path,url){
      		flag=1;
      		if(type==="blob"){
    			getblobContent(path,url);
    		}
    		else{
    			this.rows=[];
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
    						if(path===".."){
    		    				prevUrl.pop();
    		    			}else{
    							prevUrl.push(response["url"]);
    		    			}
    						getTree(response.tree);
    					});
    		}
      	},
      	onDrop: function(e){
      		alert("drop");
      		//alert(e.target);
      		 $("#dragandrophandler").css('border', '2px dotted #0B85A1');
		     e.preventDefault(); 
		     
		    var items=e.dataTransfer.items;
		    
		     var p = Promise.resolve().then(function() {
		    	for(var i=0;i<items.length;i++){
			    	 var item=items[i].webkitGetAsEntry();
			    	 if(item){
			    		 promises.push(item);
			    	 }
			     }
		    }).then(function() {
				for(var pro=0;pro<promises.length;pro++){
		    		traversefileTree(promises[pro]);
		    		if(pro==promises.length-1){
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
      	}
	  }
	})
  
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
	
	var createBlob = function(content,path) {
		var filecontent = content;
		var filedata = JSON.stringify({"content":""+filecontent+"","encoding":"UTF-8"});
		return new Promise(function(resolve, reject) {
			$.ajax({ 
				url: 'https://api.github.com/repos/${masId}/${title}/git/blobs',
				type: 'POST',
				beforeSend: function(xhr) { 
					xhr.setRequestHeader('Authorization', 'Bearer ${token}'); 
				},
				data: filedata
				})
				.done(function(response) {
					console.log("cnt: "+cnt+"+ "+path);
				    console.log(response);
				    cnt++;
				    //resolve(response.sha);
				    blobList.push(response.sha);
				    //setTimeout(resolve(),1000);
				    resolve();
				});
		});
	};

	var createFile = function(path,bsha) {
		return new Promise(function(resolve, reject) {
			var blob_sha;
				uploadList.push({
					sha:bsha,
					path:path,
					mode:"100644",
					type:"blob"
				});
				resolve();
		});
	};
	
	var createFileList = function() {
		//return new Promise(function(resolve, reject) {
			for(var fl=0;fl<fileList.length;fl++){
				var path=fileList[fl].fpath;
				var blob=blobList[fl];
				promises.push(createFile(path,blob));
				if(fl==fileList.length-1){
					Promise.all(promises).then(function() {
						createTree();
					});
				}
			}
		//});
	};
	function createTree(){
		return $.ajax({ 
			   url: 'https://api.github.com/repos/${masId}/${title}/git/trees',
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
		   url: 'https://api.github.com/repos/${masId}/${title}/git/commits',
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
		   url: 'https://api.github.com/repos/${masId}/${title}/git/refs/heads/master',
		   type: 'PATCH',
		   beforeSend: function(xhr) { 
			   xhr.setRequestHeader('Authorization', 'Bearer ${token}');
		   },
		   data: JSON.stringify({"sha":sha,"force":true})
		}).done(function(response) {
			    console.log(response);
			    waitingDialog.hide();
		});
	}
	
	//Add Collaborators ===>
	var addCollaborator=function(){
		apiUrl="https://api.github.com/repos/${masId}/${title}/collaborators/${username}";
		$.ajax({
			url:apiUrl,
			type:'PUT',
			beforeSend: function(xhr){
				xhr.setRequestHeader('Authorization',"Basic " + btoa("${masId}:${masPw}"));
				xhr.setRequestHeader("Accept","application/vnd.github.swamp-thing-preview+json");
			},
			data:{}
		}).done(function(response){
			console.log(response);
			
			var html_url=response["html_url"];
			console.log(html_url);
			toReplace.changeUrl(html_url);
			
			//$("#invitation_url").attr("href",html_url);
			//toReplace.fetchEventsList();
			
		});
	}
	
	function click_func(){
		//alert("hello");
		$('#close_refresh').prop("disabled",false);
		$("#invitation_btn").prop("disabled",true);
	}
	function copyToClipboard() {
	    var $temp = $("<input>");
	    $("body").append($temp);
	    $temp.val($("#clone_url").val()).select();
	    document.execCommand("copy");
	    $temp.remove();
	    $("btn_copy").tooltip();
	}
	if(${status}==1){
		createRepos();
		
	} else if(${status}==2){
		addCollaborator();
		
	} else{
		toReplace.fetchEventsList();
	}
</script>

</body>
</html>