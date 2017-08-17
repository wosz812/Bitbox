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

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
<style>
.example-modal .modal {
   position: relative;
   top: auto;
   bottom: auto;
   right: auto;
   left: auto;
   display: block;
   z-index: 1;
}

.example-modal .modal {
   background: transparent !important;
}

#btn_button {
   float: right;
}

#whitebox {
   padding: 30px;
}
#group_a{
    text-overflow:ellipsis;
    width: 250px;
    white-space: nowrap;
    overflow: hidden;
}

#group_a:hover{
    text-overflow:clip;
    width:auto;
    white-space: normal;
}
</style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
   <div class="wrapper">
      <%@include file="header.jsp"%>
      <!-- Left side column. contains the logo and sidebar -->
      <%@include file="sidebar.jsp"%>
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
         <section class="content-header">
            <div class="box-body">
               <h2 align="center">Memo</h2>
            </div>
         </section>
         <section class="content">
            <div class="col-xs-12">
               <div class="box" id="whitebox">
                  <button id="btn_button" type="button"
                     class="btn btn-primary btn-lg" data-toggle="modal"
                     data-target="#myModal">Add Memo</button>

                  <!-- Modal -->
                  <br>
                  <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                     <div class="modal-dialog">
                        <div class="modal-content">
                           <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal"
                                 aria-label="Close">
                                 <span aria-hidden="true">&times;</span>
                              </button>
                              <h4 class="modal-title" id="myModalLabel">메모 작성</h4>
                           </div>
                           <form action="/memo/registMemo?group_seq=${group_seq}" method="post">
                              <div class="modal-body">
                                 <input type="text" class="form-control" placeholder="title.."
                                    name="m_title">
                                 <textarea class="form-control" rows="3" cols="20"
                                    placeholder="text.." name="m_content" style="resize:none;"></textarea> 
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-default"
                                    data-dismiss="modal">닫기</button>

                                 <input type="submit" class="btn btn-primary" value="작성"></input>
                              </div>
                           </form>
                        </div>
                     </div>
                  </div>
                  <div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                     <div class="modal-dialog">
                        <div class="modal-content">
                           <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal"
                                 aria-label="Close">
                                 <span aria-hidden="true">&times;</span>
                              </button>
                              <h4 class="modal-title" id="myModalLabel">메모 수정</h4>
                           </div>
                           <form action="/memo/updateMemo?page=${page}&group_seq=${group_seq}" method="post">
                              <div class="modal-body">
                                 <input type="text" class="form-control"
                                    name="m_title" id="m_title">
                                 <input type="hidden" name="m_seq" id="m_seq">
                                 <textarea class="form-control" rows="3" cols="20"
                                    name="m_content" id="m_content"></textarea>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-default"
                                    data-dismiss="modal">닫기</button>

                                 <input type="submit" class="btn btn-primary" value="수정"></input>
                              </div>
                           </form>
                        </div>
                     </div>
                  </div>
                  <br> <br> <br>
                  <c:forEach items="${memoList}" var="memo">
                     <div class="example-modal">
                        <div class="modal">
                           <div class="modal-dialog">
                              <div class="modal-content">
                                 <div class="modal-header">
                                    <h4 class="modal-title">
                                       <i class="fa fa-book">&nbsp;&nbsp;&nbsp;</i>${memo.m_title}
                                    </h4>
                                 </div>
                                 <div class="modal-body"><p>${memo.m_content}</p></div>
                                 <h4 align="right">
                                 <a class="mUpdate" seq="${memo.m_seq}" group_seq="${group_seq}"><i class="fa fa-refresh"></i></a>
                                 <a href="/memo/removeMemo?seq=${memo.m_seq}&page=${page}&group_seq=${group_seq}"><i
                                 class="fa fa-trash"></i></a>
                                 </h4>
                              </div>
                              <!-- /.modal-content -->
                           </div>
                           <!-- /.modal-dialog -->
                        </div>
                        <!-- /.modal -->
                     </div>
                  </c:forEach>
                  <div align="center">
                  	 <c:forEach var="page" items="${pageList}">
                  	 	${page.toString()}
                  	 </c:forEach>
                  </div>
               </div>
            </div>
         </section>

         <!-- Main content -->
         <section class="content"></section>
         <!-- /.content -->
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
   
   <script type="text/javascript">
      $('.mUpdate').click(function(e) {
         var seq = $(this).attr("seq");
         var group_seq = $(this).attr("group_seq");
         if(group_seq==0){
            var str = 'p';
            ajax_data(seq, group_seq, str);
         }else{
            var str = 'g';
            ajax_data(seq, group_seq, str);
         }         
         $("#updateModal").modal('show');
      });
      function ajax_data(seq, group_seq, str) {
         var controller = '/memo/modal'+str; //JH : controller 명 지정해주기 예:localhost/index.php/controller(이거)/function/param
         //var base_url = '<?php echo site_url(); //you have to load the "url_helper" to use this function ?>';            
         var url = controller + "?seq=" + seq + "&group_seq=" + group_seq;
         //var url = controller;
         $.ajax({
            url : url,
            type : 'POST',
            //data: { "gno": JSON.stringify(gno)},
            //data: { "gno": gno},
            success : function(data) {
               //console.log(data);
               //alert(data);
               $('#m_seq').val(data.m_seq);
               $('#m_title').val(data.m_title);
               $('#m_content').val(data.m_content)
               //alert(data.title);
            }
         });
      }
   </script>
</body>
</html>