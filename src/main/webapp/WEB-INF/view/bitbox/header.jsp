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
              <li class="header">You have {{qnaAlarm}} messages</li>
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
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
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
                  <li v-for="row in qnaRows">
                    <a href="#">
                    <h6>
                      <i class="fa fa-users text-aqua"></i>
                        {{row.re_writer}}
                    </h6><span>{{row.re_content}}</span>
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
                <span class="label label-danger">9</span>
              </a>
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
  	    qnaAlarm: "",
  	    qnaRows: [],
  	  },
  	  created: function() {
  		this.getQnaAlarm();
  		this.getGroupAlarm();
  		var self=this;
  		var testInterval=setInterval(function() {
  			self.getQnaAlarm();
  	  		self.getGroupAlarm();
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
	              self.groupAlarm=data;
	              console.log(data);
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
          }
  	  }
  	})
    </script>

