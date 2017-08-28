<header class="main-header">
         <!-- Logo -->
         <a href="/bitbox/home" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>B</b>IT</span> <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>BIT</b>BOX</span>
         </a>
         <!-- Header Navbar: style can be found in header.less -->
         <nav class="navbar navbar-static-top">
         <div id="app">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas"
               role="button"> <span class="sr-only">Toggle navigation</span> <span
               class="icon-bar"></span> <span class="icon-bar"></span> <span
               class="icon-bar"></span>
            </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
          <li class="dropdown messages-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-comments-o"></i>
              <span class="label label-success">{{qnaAlarm}}</span>
            </a>
              <ul class="dropdown-menu">
              <li class="header">You have {{qnaAlarm}} Q&A reply</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu" >
                  <li v-for="row in qnaRows"><!-- start message -->
                    <a v-bind:href="'/bitbox/readQna?q_seq='+row.q_seq+'&page=0'" @click="atagclick(row.q_seq)">
                      <div class="pull-left">
                        <img src="/img/default.png" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        {{row.re_writer}}
                      </h4><p>{{row.re_content}}</p>
                    </a>
                  </li>
                  <!-- end message -->
                </ul>
              </li>
              <li class="footer"><a href="#">See All Messages</a></li>
            </ul>
          </li>
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">{{ groupAlarm }}</span>
            </a>
			<ul class="dropdown-menu">
              <li class="header">You have {{groupAlarm}} notifications</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li v-for="row in groupRows">
                  <div class="pull-right"><button type="button" class="btn btn-box-tool" @click="gLogclick(row.log_seq)"><i class="fa fa-times"></i></button></div>
                    <a v-bind:href="goUrl(row.action,row.title)" @click="gLogclick(row.log_seq)" id="group_a">
                      <i v-if="row.action==='group join'" class="fa fa-user-plus text-aqua"></i>
                      <i v-if="row.action==='file upload'" class="fa fa-cloud-upload text-green"></i>
                      <i v-if="row.action==='write meeting'" class="fa fa-users text-yellow"></i>
                      {{row.detail}}
                    </a>
                  </li>
                </ul>
              </li>
              <li class="footer"><a href="#">View all</a></li>
            </ul>
            </li>
            <!-- Tasks: style can be found in dropdown.less -->
            <li class="dropdown tasks-menu">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-flag-o"></i>
                <span class="label label-danger">{{ todoList.length }}</span>
              </a>
  			  <ul class="dropdown-menu">
              <li class="header">You have {{ todoList.length }} todo List</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li v-for="row in todoList">
                  <div class="pull-right"><button type="button" class="btn btn-box-tool" @click="deleteTodo(row.todo_seq)"><i class="fa fa-times"></i></button></div>
                    <a href="/bitbox/home">
                      <i class="fa fa-user-plus text-aqua"></i>
                      {{row.todo}}
                    </a>
                  </li>
                </ul>
              </li>
              <li class="footer"><a href="#">View all</a></li>
            </ul>
            </li>
            <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="/pngFiles/${img}" class="user-image" alt="User Image">
              <span class="hidden-xs">${id}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="/pngFiles/${img}" class="img-circle" alt="User Image">

                <p>
                  ${id}
                  <small>${className}</small>
                </p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="/bitbox/myPage" class="btn btn-default btn-flat">Profile</a>
                </div>
                <div class="pull-right">
                  <a href="/bitbox/logout" class="btn btn-default btn-flat">Sign out</a>
                </div>
              </li>
            </ul>
          </li>
          </ul><!-- 여기 -->
        </div>
        </div>
      </nav>
    </header>
    <!-- jQuery 2.2.3 -->
    <script src="../js/vue.js"></script>
    <script src="../plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script>
    var toReplace =  new Vue({
  	  el: '#app',
  	  data: {
  	    groupAlarm: "",
  	    groupRows:[],
  	    qnaAlarm: "",
  	    qnaRows: [],
  	    todoList:[],
  	    click_url:"/bitbox/gitBoard"
  	  },
  	  created: function() {
  		this.getQnaAlarm();
  		this.getGroupAlarm();
  		this.gettodoList();
  		var self=this;
  		var testInterval=setInterval(function() {
  			self.getQnaAlarm();
  	  		self.getGroupAlarm();
  	  		self.gettodoList();
  		},60000);
  	  },
  	  methods: {
  		getGroupAlarm: function() {
            var url="/bitbox/groupAlarm";
            var self=this;
            $.ajax({
              url : url,
              type : 'POST',
	            success : function(data) {
	            	console.log(data);
	              self.groupAlarm=data.length;
	              self.groupRows=data;
	            }
	          });
          },
          getQnaAlarm: function(){
          	var url="/bitbox/qnaAlarm";
              var self=this;
              $.ajax({
                url : url,
                type : 'POST',
	            success : function(data) {
	            	console.log(data);
	              self.qnaAlarm=data.length;
	              self.qnaRows=data;
	            }
	          });
          },
          gettodoList: function(){
            	var url="/bitbox/getTodoListAlarm";
                var self=this;
                $.ajax({
                  url : url,
                  type : 'POST',
  	            success : function(data) {
  	            	console.log(data);
  	            	self.todoList=data;
  	            }
  	          });
            },
          cancelAutoUpdate: function() { clearInterval(this.timer) },
          atagclick:function(seq){
        	  var url="/bitbox/qnaState?q_seq="+seq;
        	  $.ajax({
                  url : url,
                  type : 'POST',
    	            success : function(data) {
    	              if(data){
    	            	  console.log(data);
    	              }
    	            }
    	       });
          },
          gLogclick:function(seq){
        	  var self=this;
        	  var url="/bitbox/readGLog?log_seq="+seq;
        	  $.ajax({
                  url : url,
                  type : 'POST',
    	            success : function(data) {
    	              if(data){
    	            	  console.log(data);
    	            	  self.getGroupAlarm();
    	              }
    	            }
    	       });
          },
          goUrl:function(action,title){
        	  if(action=="group join"){
        		  return "/git/gitBoard?title="+title;
        	  }else if(action=="file upload"){
        		  return "/git/gitBoard?title="+title;
        	  }else if(action=="write meeting"){
        		  return "/bitbox/minutesList?group_title="+title;
        	  }
        	  
          },
          deleteTodo:function(seq){
        	  //console.log("delete todo seq",seq);deleteTodo
        	  var url="/bitbox/deleteTodo?seq="+seq;
        	  var self=this;
        	  $.ajax({
                  url : url,
                  type : 'POST',
    	            success : function(data) {
    	              if(data){
    	            	  self.gettodoList();
    	              }
    	            }
    	       });
          }
  	  }
  	})
    
    var lengthText = 30;
    var text = $('a').text();
    var shortText = $.trim(text).substring(0, lengthText).split(" ").slice(0, -1).join(" ") + "...";

    $("#group_a").text(shortText);

    $("#group_a").hover(function(){
        $(this).text(text);
    }, function(){
        $(this).text(shortText);
    });
    </script>

