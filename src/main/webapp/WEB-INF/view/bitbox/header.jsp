<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 
</head>
<body class="hold-transition skin-blue sidebar-mini">
  <div class="wrapper">
   <header class="main-header">
         <!-- Logo -->
         <a href="/bitbox/home" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>B</b>IT</span> <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>BIT</b>BOX</span>
         </a>
         <!-- Header Navbar: style can be found in header.less -->
         <nav class="navbar navbar-static-top">
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
              <span class="label label-success">4</span>
            </a>

          </li>
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">
                <div id="app">
                  {{ message }}
                </div></span>
              </a>

            </li>
            <!-- Tasks: style can be found in dropdown.less -->
            <li class="dropdown tasks-menu">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-flag-o"></i>
                <span class="label label-danger">9</span>
              </a>
            </li>
          </ul>
        </div>
      </nav>
    </header>
  </div>
    <!-- jQuery 2.2.3 -->
    <script src="../js/vue.js"></script>
    <script src="../plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script>
      var app = new Vue({
        el: '#app',
        data: {
          message:''
        },
        created: function() {

            this.fetchEventsList();
            this.timer = setInterval(this.fetchEventsList, 60000);
          },
          methods: {

            fetchEventsList: function() {
              var url="/bitbox/alarm";
              var self=this;
              $.ajax({
                url : url,
                type : 'POST',
            success : function(data) {
              self.message=data;
              //app.message=data;
              console.log(data);
             
            }
          });

            },
            cancelAutoUpdate: function() { clearInterval(this.timer) }

          },
          beforeDestroy() {
            clearIntervall(this.timer)
          }
      })
    </script>
  </body>
  </html>
