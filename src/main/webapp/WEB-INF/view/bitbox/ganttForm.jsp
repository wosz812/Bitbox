<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8"/>
<meta http-equiv="Content-Script-Type" content="text/javascript"/>
<meta http-equiv="Content-Style-Type" content="text/css"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=1024"/>

<meta property="og:title" content="HTML5 자바스크립트 간트차트 AUIGantt"/>
<meta property="og:url"  content="http://www.auisoft.net/demo/auigantt/index.html">
<meta property="og:image" content="http://www.auisoft.net/images/logo3d.png">
<meta property="og:description"  content="HTML5 자바스크립트 간트차트(javascript ganttchart - AUIGantt"/>
<meta name="Keywords" content="webGantt, web Gantt, dataGantt, javascript Gantt, html5 Gantt, Gantt component, javascript Gantt component, 웹 간트차트, 데이타 간트차트, 데이터간트차트, 자바스크립트 간트차트, HTML5 간트차트"/>

<title>BITBOX</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="/dist/css/skins/_all-skins.min.css">

<!-- 간트 차트 CSS 스타일  -->
<link href="/gantt/AUIGantt_style.css" rel="stylesheet">
<!-- AUIGantt 라이센스. -->
<script type="text/javascript" src="/gantt/AUIGanttLicense.js"></script>
<!-- AUIGantt 라이브러리 -->
<script type="text/javascript" src="/gantt/AUIGantt.js"></script>
<!-- AUIGantt 리소스 파일 -->
<script type="text/javascript" src="/gantt/AUIGantt.resources.kr.js"></script>
<script type="text/javascript">

// AUIGantt 생성 후 반환 ID
var myGanttID;

// 윈도우 onload
// DOM 완료 후 간트 차트 생성함.
window.onload = function() {  
	
	// 간트차트를 생성합니다.
	createAUIGanttChart();

	// 최초 50행을 갖는 새문서 모드 만들기
	AUIGantt.createNewDocument(myGanttID, 50);
	
	// 간트 데이터 삽입
	AUIGantt.setGanttData(myGanttID, myGanttData);
};

// AUIGantt 를 생성합니다.
function createAUIGanttChart() {
	
	// 간트 그리드(시트) 에 출력할 칼럼 필드 들 작성함.
	// 아래는 기본값으로 위치 또는 임의 작성으로 개발자는 작성 가능합니다.
	var myColumnLayout = [
         //AUIGantt.defaultColumnInfo.index, // 기본 정보 필드
         AUIGantt.defaultColumnInfo.name, // 작업 이름 필드
         AUIGantt.defaultColumnInfo.period, // 기간 필드
         AUIGantt.defaultColumnInfo.start, // 작업 시작 날짜 필드
         AUIGantt.defaultColumnInfo.end, // 작업 종료 날짜 필드
         //AUIGantt.defaultColumnInfo.predecessor, // 선행 관계 필드
         //AUIGantt.defaultColumnInfo.resource, // 자원 필드
         AUIGantt.defaultColumnInfo.progress // 진행률 필드
	];
	                      
	// 간트차트 속성 설정
	var ganttProps = {
			
			// 편집 가능 여부
			editable : true, 
			
			// 엑셀 저장 URL
			exportURL : "/",
			
			
			gridWidth : "43%",
			
			// 인덱스 1에 트리 칼럼을 만듬. 즉, 설정한 columnLayout 기준임.
			treeColumnIndex: 1, 
			
			// 간트 그리드(시트) 레이아웃 (필수 정의해야 함)
			columnLayout : myColumnLayout
			
	};
	

	// 실제로 #gantt_wrap 에 간트차트 생성
	myGanttID = AUIGantt.create("#gantt_wrap", ganttProps);
	
	// ready 이벤트 바인딩
	AUIGantt.bind(myGanttID, "ready", function(event) {
		// 처음에 rowIndex 0, columnIndex 1 에 엑셀처럼 선택자 만들기.
		AUIGantt.setSelectionByIndex(myGanttID, 0, 1);
	});
	
	// 헤더 메뉴 아이콘 클릭 이벤트 바인딩
	AUIGantt.bind(myGanttID, "headerIconClick", function(event) {
		alert(event.headerText + " 헤더 메뉴 아이콘 클릭!!");
	});
};

// 새 문서
function newDocument() {
	// 새 간트 다큐멘트 작성하기
	// 파라메터 50 은 최초 문서에 50개의 행을 만듭니다.
	if(confirm("새로 문서를 작성하시겠습니까?")) {
		AUIGantt.createNewDocument(myGanttID, 50);
	}
};

// 간트 데이터 삽입
function setGanttData() {
	// 간트 차트에 출력 시킬 데이터
	var myGanttData = document.getElementById("gan_data").value
	AUIGantt.setGanttData(myGanttID, myGanttData);
};

// 간트 데이터 얻기
function getGanttData() {
	var ganttData = AUIGantt.getGanttData(myGanttID);
	document.getElementById("gan_data").value = ganttData;
	var ds = document.getElementById("dataset");
	ds.submit();
};

//엑셀로 저장하기
function saveAsExcel( timeUnit ) {
	var exportProps = {
		fileName : "BITBIX_Gantt", // 파일 명 지정
		sheetName : "일정 관리표", // 엑셀 시트명 지정
		//fontFamily : "Calibri", // 폰트명 지정
		timeLabelWidth : 30, // 타임 1유닛의 크기
		includeGantt : true,  // 간트 차트 엑셀 포함 여부
		displayTimeUnit : timeUnit, // 시간 단위
		headers : [ {
			text : "", height:5, style : { background:"#555555"} // 빈줄 색깔 경계 만듬
		}, {
			text : "BITBOX 간트차트 엑셀 저장", height:24, style : { fontSize:14, textAlign:"left", fontWeight:"bold", underline:true, background:"#DAD9FF"}
		}, {
			text : "작성자 : BITBOX"
		}, {
			text : "작성일 : 작성일을 입력해 주세요."
		}, {
			text : "추가 정보 : 원하는 문구를 헤더에 넣을 수 있습니다."
		}, {
			text : "", height:5, style : { background:"#555555"} // 빈줄 색깔 경계 만듬
		}],
	footers : [ {
			text : "", height:5, style : { background:"#555555"} // 빈줄 색깔 경계 만듬
		}, {
			text : "원하는 행 만큼", height:24, style : { color: "#0000aa" }
		}, {
			text : "푸터에도 뭔가를 넣을 수 있습니다.", height:24, style : { textAlign:"left", fontSize:14, fontWeight:"bold", color:"#ffffff", background:"#222222"}
		}]
	};

	AUIGantt.exportToXlsx(myGanttID, exportProps);
};

</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="sidebar.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="box-body">
					<h2 align="center">Gantt Chart</h2>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<div class="col-xs-12">
									<h4 align="left"><label>[ ${group_title} ] 의 간트차트</label></h4>
									<div id="desc_top">
										<div>
											<button class="btn btn-primary" onclick="newDocument()">새 문서 작성하기</button>
											<button class="btn btn-primary" onclick="setGanttData()">간트 데이터 불러오기</button>
											<button class="btn btn-primary" onclick="getGanttData()">간트 데이터 저장하기</button> 
										</div>
									</div>
								</div>
							</div>
							<div class="box-body">
								<div id="main">
									<!-- 에이유아이간트가 이곳에 생성됩니다. -->
									<div id="gantt_wrap" style="width:100%; height:700px;"></div>
									<form id="dataset" action="/bitbox/saveGantt" method="post">
										<input type="hidden" name="gan_seq" value="${gantt.gan_seq}">
										<input type="hidden" id="gan_data" name="gan_data" value="${gantt.gan_data}">
										<input type="hidden" name="group_seq" value="${gantt.group_seq}">
										<input type="hidden" name="group_title" value="${group_title}">
									</form>
								</div>
							</div>
							<div align="right">
								<button class="btn btn-primary" onclick="saveAsExcel('day')">일(day) 단위 엑셀로 저장하기</button>
								<button class="btn btn-primary" onclick="saveAsExcel('week')">주(week) 단위 엑셀로 저장하기</button>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<%@include file="controlSideBar.jsp"%>
	</div>
	<!-- jQuery 2.2.3 -->
	<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="/bootstrap/js/bootstrap.min.js"></script>
	<!-- Slimscroll -->
	<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
	<script src="//cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>
	<script src="/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="/dist/js/app.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/dist/js/demo.js"></script>
</body>
</html>