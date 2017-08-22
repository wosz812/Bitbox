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

<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.8/ace.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.8/ext-modelist.js"></script>
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
#group_a:hover{
    text-overflow:clip;
    width:auto;
    white-space: normal;
}
.modal-dialog {
    /* new custom width */
    width: 1000px;
    /* must be half of the width, minus scrollbar on the left (30px) */
    
}
.editor {
  width:900px;
  height:300px;
}
.plusMarker { 
  position:absolute;
  background:rgba(100,200,100,0.5);
}
.minusMarker { 
  position:absolute;
  background:rgba(200,100,100,0.5);
}
#myEditor{
	width:1050px;
  height:800px;
}
#new_file{
	width:800px;
	height:800px;
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
		    <div class="progress progress-xxs">
		    	<div class="percent progress-bar progress-bar-primary progress-bar-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100">
		        </div>
		    </div>
			<%-- ${token}
			${username}
			${status}
			${id} --%>
			<div id="toReplace">
				<cfile v-if="currentComponent==='cfile'">
					<label>Name your file</label>
					<input type="text" class="form-control" name="file_name" placeholder="file name">
					<label>Edit new file</label>
					<div id="new_file"></div>
					<button class="btn btn-primary" @click="swapComponent('create')">Create</button>
					<button class="btn btn-primary" @click="swapComponent(null)">Close</button>
				</cfile>
				<div v-if="currentComponent==='upload files'">
					<div id="dragandrophandler" @drop="onDrop">Drag & Drop Files Here</div>
					<table id="status1"></table>
					<button class="btn btn-primary" @click="swapComponent(null)">Close</button>
				</div>
				<div v-if="currentComponent==='patch'">
					<section class="content">
						<div class="row">
							<div class="col-xs-12">
								<div class="box">
									<div class="box-body">
										<table class="table table-bordered">
										<tr>
											<td>Commit Message</td>
											<td>Upload Date</td>
											<td>Committer</td>
										</tr>
											<tr v-for="row in patch_rows">
												<td style="text-align:left" data-toggle="modal" data-target="#myModal" class="modal_parent" data-sha="{{row.sha}}"><a v-on:click="detail_commit(row.sha)">{{row.message}}</a></td>
												<td>{{row.date}}</td>
												<td>{{row.committer}}</td>
											</tr>
										</table>
									</div>
									<!-- /.box-body -->
								</div>
							</div>
						</div>
					</section>
					<div id="myModal" class="modal fade" role="dialog" ng-app="editorApp">
					  <div class="modal-dialog">
					
					    <!-- Modal content-->
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					        <h4 class="modal-title">Detail Commit</h4>
					      </div>
					      <div class="modal-body">
					        <section class="content"  v-for="(index,row) in detailCommit_rows">
								<div class="row">
									<div class="col-xs-12">
										<div class="box">
											<div class="box-body">
												<table class="table table-bordered">
												<tr>
													<td>{{row.filename}}</td>
												</tr>
												<tr style="overflow: scroll; width: 510px; text-align:left;">
													<td><div class="editor"></div></td>
												</tr>
												</table>
											</div>
											<!-- /.box-body -->
										</div>
									</div>
								</div>
							</section>
					      </div>
					      <div class="modal-footer">
					      <button type="button" class="btn btn-danger rollback_btn" data-dismiss="modal" @click="rollback">Rollback</button>
					        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					      </div>
					    </div>
					
					  </div>
					</div>
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
							<button class="btn btn-primary" @click="swapComponent('cfile')"
								id="cfile">create new file</button>
							<button class="btn btn-primary" @click="swapComponent(component)"
								id="upfile">{{component}}</button>
							<button class="btn btn-primary" @click="swapComponent('patch')"
								id="patch">Patch</button>
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
	<!-- page script -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/1.0.16/vue.js"></script>
	<script src="/js/bootstrap-waitingfor.js"></script>
	<script type="text/javascript">
var treeSha;
var fileList=new Array();
var blobList=new Array();
var uploadList=new Array();//
var promises=new Array(); //promise all하기 위한 배열
var uploadDirs=new Array();//upload 할 dirs 담을 배열
var uploadFiles=new Array();//upload할 Files 담을 배열
var cnt=1; //file 몇개 올렸는지 확인하려고 생성함
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

$(document).on("click", ".modal_parent", function () {
    var sha = $(this).attr('data-sha');
    $(".rollback_btn").attr("data-sha",sha);
});

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
		    console.log("initStart: "+response);
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
				console.log("getCurrentTreeSHA: "+response);
				treeSha = response.tree.sha;
				fgetTree(treeSha);
			});
		};
		
		//github repository file Tree 얻어오기
		var fgetTree = function(sha) {
			$('.percent').width("10%").attr("aria-valuenow",10); //loading progress bar 10%정도 시작될때 보여주기
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
			$('.percent').width("100%").attr("aria-valuenow",100); //github repository table 져오기 완료 휴 loading progress bar 100%
			setTimeout(function(){ $('.percent').width("0%").attr("aria-valuenow",0); }, 800);
		} 
		 var getblobContent= function(path,url){
			 $('.percent').width("10%").attr("aria-valuenow",10);
			 
			 var modelist = ace.require("ace/ext/modelist");
			 var mode = modelist.getModeForPath(path).mode;
			 
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
						$('.percent').width("100%").attr("aria-valuenow",100);
						setTimeout(function(){ $('.percent').width("0%").attr("aria-valuenow",0); }, 800);
						var temp=atob(response['content']);
						var editor = ace.edit("myEditor");

						editor.setTheme("ace/theme/monokai");
						editor.getSession().setMode(mode);
						editor.getSession().setValue(temp,1);
					});
		}  
		 

var cfile = Vue.extend({
	template: '',
	data: function() {
	},
	created:function(){
		console.log("created cfile");		
	},
	ready:function(){
		var editor = ace.edit("new_file");
		//editor.setTheme("ace/theme/monokai");
		editor.getSession().setMode("ace/mode/text");
		editor.getSession().setValue("",1);
		editor.focus();
	}
});
 //single page를 만들기 위한 vue 변수 생성		 
  var toReplace =  new Vue({
	  el: '#toReplace', //vue를 사용할 div id
	  data: {
	    currentComponent: null, //currentComponent로 control할 div section 정함
	    component: 'upload files', //upload file이라는 component
	    rows: [], //github repository에서 받아온 tree값을 저장할 rows 변수
	    html_url: '', //초대장이 발송됐을 때 초대장 url을 저장할 변수
	    patch_rows:[],
	    totals:'',//patch list
	    patch_rows:[],//patch list
	    detailCommit_rows:[]
	  },
	  components: {
	    'upload files': { //upload file component
	     template: ''
	    },
	    'invitation': {  //invitation component
		     template: ''
		 },
		'cfile' : cfile,

		'patch':{
			 template:''
		}
	  },
	  methods: {
	    swapComponent: function(component)
	    {
	      this.currentComponent = component;
	      if(component==null){
	    	  window.location.href = "/git/gitBoardView";
	      }else if(component=='create'){
	    	  waitingDialog.show('Please wait for upload to complete');
	    		  var filename=$("input[name=file_name]").val();
		    	  var editor = ace.edit("new_file");
		    	  var content=editor.getSession().getValue();
		    	  
		    	  var filecontent=content;
		    	  var filemessage = "create file";
		    	  var basecontent = btoa(filecontent);
		    	  var filedata = '{"message":"'+filemessage+'","content":"'+basecontent+'"}';
		    	  $.ajax({ 
		    	      url: 'https://api.github.com/repos/${masId}/${title}/contents/'+filename,
		    	      type: 'PUT',
		    	      
		    	       beforeSend: function(xhr) { 
		    	          xhr.setRequestHeader('Authorization', 'Bearer ${token}');
		    	      }  , 
		    	      data: filedata
		    	  }).done(function(response) {
		    	      console.log(response);
		    	      waitingDialog.hide();
		    	      window.location.href = "/git/gitBoardView"
		    	  });
	      }else if(component=='patch'){
	    	  $('.percent').width("10%").attr("aria-valuenow",10); //loading progress bar 10%정도 시작될때 보여주기
	    	  var self=this;
	    	  var totals=0;
	    	  $.ajax({
	    			url : "https://api.github.com/repos/wosz812/Bitbox/commits",
	    			type : 'GET',
	    			beforeSend : function(xhr) {
	    			xhr.setRequestHeader('Authorization', "Basic " + btoa("yujiyeon:dbwldus26"));
	    			},
	    			data : {}
	    		}).done(function(response) {
	    			console.log(response);
	    			for(var i=0;i<response.length;i++){
	    				var sha=response[i].sha;
	    				var message=response[i].commit.message;
	    				var committer=response[i].commit.committer.name;
	    				var date=response[i].commit.committer.date;
						self.patch_rows.push({"sha":sha,"message":message,"committer":committer,"date":date});
	    			}
	    		});
	    	  $.ajax({
	    			url:'https://api.github.com/repos/wosz812/Bitbox/contributors',
	    			type:'GET',
	    			beforeSend: function(xhr){
	    				  xhr.setRequestHeader('Authorization', 'Bearer ${token}');
	    			},
	    			data:{}
	    		}).done(function(response){
	    			var total=0;
	    			for(var i=0;i<response.length;i++){
	    				var count=response[i].contributions;
	    				total+=count;			
	    			}
	    			totals=parseInt(total/30);
	    			console.log(totals);
	    			if(total%30!=0){
	    				totals+=1;
	    			}
	    			self.totals=totals;
	    		});
	    	  var promise1 = new Promise(function (resolve, reject) {
	    		  $.ajax({
		    			url : "https://api.github.com/repos/wosz812/Bitbox/commits", //Default 박아놈
		    			type : 'GET',
		    			beforeSend : function(xhr) {
		    			xhr.setRequestHeader('Authorization', "Basic " + btoa("yujiyeon:dbwldus26"));
		    			},
		    			data : {}
		    		}).done(function(response) {
		    			console.log(response);
		    			for(var i=0;i<response.length;i++){
		    				var sha=response[i].sha;
		    				var message=response[i].commit.message;
		    				var committer=response[i].commit.committer.name;
		    				var date=response[i].commit.committer.date;
							self.patch_rows.push({"sha":sha,"message":message,"committer":committer,"date":date});
		    			}
		    			$('.percent').width("100%").attr("aria-valuenow",100); //github repository table 져오기 완료 휴 loading progress bar 100%
		    			setTimeout(function(){ $('.percent').width("0%").attr("aria-valuenow",0); }, 800);
		    			resolve();
		    		});
	    		})
	      }
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
      	rollback:function(event){ // modal을 통해서 rollback할수있도록 만들어야함. rollback하는 함수
      		//var sha=event.dataset.sha;
      		alert("해당 시점으로 rollback 합니다.");
      		var sha=event.target.getAttribute('data-sha');
      		patch_repos(sha);
      	},
      	detail_commit:function(sha){
      		var self=this;
      		self.detailCommit_rows=[];
      		var promise1 = new Promise(function (resolve, reject) {
      			$.ajax({
    				url : 'https://api.github.com/repos/wosz812/Bitbox/commits/'+sha, //Default 박아놈
    				type : 'GET',
    				beforeSend : function(xhr) {
    					xhr.setRequestHeader('Authorization', 'Bearer ${token}');
    				},
    				data : {}
    			}).done(function(response) {
    				console.log(response);
    				for(var i=0;i<response.files.length;i++){
    					var filename=response.files[i].filename;
    					var patch=response.files[i].patch;
    					var strArray=filename.split(".");
    					 var mtemp=strArray[strArray.length-1];
    					self.detailCommit_rows.push({"filename":filename,"patch":patch});
    				}
    				resolve();
    			});
      		}).then(function(){  //여기 editor 수정부분
      			var editor;
      			$('.editor').each(function( index ) {
      				editor = ace.edit(this);
      				var Range = ace.require('ace/range').Range;
      				var modelist=ace.require("ace/ext/modelist");
      				var mode=modelist.getModeForPath(self.detailCommit_rows[index].filename).mode;
      			  editor.setTheme("ace/theme/monokai");
      			  editor.getSession().setMode(mode);
      			  editor.getSession().setValue(self.detailCommit_rows[index].patch+"\n");
      			  
      			var content=editor.getSession().getValue();
	      		  var fin=content.split("\n");
	      		  for(var i=0;i<fin.length;i++){
	      			  if(fin[i].indexOf("-")==0){
	      				  editor.getSession().addMarker(new Range(i, 0, i, 1), "minusMarker", "fullLine");
	      			  }else if(fin[i].indexOf("+")==0){
	      				  editor.getSession().addMarker(new Range(i, 0, i, 1), "plusMarker", "fullLine");
	      			  }
	      		  }
	      		  editor.gotoLine(fin.length+1); //마지막 line에 focus맞추기
		      		editor.commands.on("exec",function(e){
		      		     e.preventDefault();
		      		     e.stopPropagation();
		      		  }) //editor readonly로 만드는 부분
      			});
      		});
      		
      	},
      	onDrop: function(e){
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
	});
 
 /* Vue.component('cfile', {
	 	created:function(){
	 		cosnole.log("created cfile");
	 	},
   		  mounted: function() {
   		    console.log("Hello from child");
   		    var editor = ace.edit("new_file");

   			editor.setTheme("ace/theme/monokai");
   			editor.getSession().setMode("ace/mode/javascript");
   			editor.getSession().setValue("",1);
 		}
 }); */
  function dump(obj) {
	    var out = '';
	    for (var i in obj) {
	        out += i + ": " + obj[i] + "\n";
	    }

	    alert(out);

	    // or, if you wanted to avoid alerts...

	    var pre = document.createElement('pre');
	    pre.innerHTML = out;
	    document.body.appendChild(pre)
	} 
 
 //drop box에 load된 파일의 tree 읽어오기
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
	
	//content별로 sha코드를 받아오기 위한 함수
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
				    blobList.push(response.sha);
				    resolve();
				});
		});
	};

	//upload할 List를 github가 지원하는 형식에 맞게 세팅하는 함수
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
	
	//createFile 함수를 호출하여 업로드할 갯수만큼 promise를 약속하는 함수
	var createFileList = function() {
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
	};
	
	//uploadList를 Tree로 만들어 sha코드를 얻어오기
	var createTree=function(){
		return new Promise(function(resolve, reject) {
		 $.ajax({ 
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
				    resolve();
			});
		})
		} 
	
	//parent sha를 얻기위한 함수
	var prevCommitSha=function(){
		return new Promise(function(resolve, reject) {
			$.ajax(
					{
						url : "https://api.github.com/repos/${masId}/${title}/commits",
						type : 'GET',
						beforeSend : function(xhr) {
							xhr.setRequestHeader('Authorization', 'Bearer ${token}');
						},
						data : {  }
					}).done(function(response) {
						console.log(response);
						resolve(response[0].sha);
						console.log("prefCommitSha finish: "+response[0].sha);
					});
		})
	}
	
	//Commit to repository
	var createCommit= function (tree_sha){
		return new Promise(function(resolve, reject) {
			prevCommitSha()
			.then(function (text) {
				// 성공시
				var parents=[];
				parents.push(text);
				console.log("prevCommit return: "+text);
				var commit_data= JSON.stringify({"message":"file upload branch","tree":tree_sha,"parents":parents});
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
					    resolve();
				});
			});

		})
	}

	//Patch repository
	var patch_repos=function patch_repos(sha){
		return new Promise(function(resolve, reject) {
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
				    fileList=[];
				    blobList=[];
				    promises=[];
				    uploadDirs=[];
				    uploadFiles=[];
				    uploadList=[];
				    window.location.href = "/git/gitBoardView" 
				    resolve();
			});
		})
	}
	
	//Add Collaborators
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
			
			var html_url=response["html_url"]; //초대장 url 변수에 할당
			console.log(html_url);
			toReplace.changeUrl(html_url);
		});
	}
	
	//invitation이 발송 되었을 때 초대 승낙 페이지로 이동하는 버튼을 클릭해야만 close버튼이 활성화 됨
	function click_func(){
		$('#close_refresh').prop("disabled",false);
		$("#invitation_btn").prop("disabled",true);
	}
	
	//dropbox버튼에서 url을 copy하는 함수
	function copyToClipboard() {
	    var $temp = $("<input>");
	    $("body").append($temp);
	    $temp.val($("#clone_url").val()).select();
	    document.execCommand("copy");
	    $temp.remove();
	    $("btn_copy").tooltip();
	}
	
	// status==1 create group을 했을 때 master github id로 repository를 만든다.
	if(${status}==1){
		createRepos();
		
	} else if(${status}==2){ //status==2일때 멤버가 그룹에 가입버튼을 눌러 repository에 가입이 된다.
		addCollaborator();
		
	} else{ //그 이외에 sidebar에서 group title을 클릭해서 gitboard 페이지에 들어올 때
		toReplace.fetchEventsList();
	}
	
</script>

</body>
</html>