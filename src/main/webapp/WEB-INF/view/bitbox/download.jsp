<%@ page language="java" contentType="application/hwp; charset=UTF-8" pageEncoding="UTF-8"%> 
 
<%
	//******************************한글(hwp)********************************
	// 한글(hwp)로 다운로드/실행, filename에 저장될 파일명을 적어준다.
	//response.setContentType("appliction/octet-stream");
  	response.setHeader("Accept-Ranges","bytes");
 	response.setHeader("Content-Transfer-Encoding", "binary;");
 	response.setHeader("Pragma", "no-cache;");
 	response.setHeader("Expires", "-1;");
	response.setHeader("Content-Disposition", "attachment; filename=minutes.hwp;");
	response.setHeader("Content-Description", "JSP Generated Data");
  	response.setHeader("Cache-control","private");
    // ↓ 이걸 풀어주면 열기/저장 선택창이 뜨는 게 아니라 그냥 바로 저장된다.
	//  response.setContentType("application/hwp");
	//*********************************************************************
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="UTF-8">
<style type="text/css">
.title {
	font-size: 25.0pt;
	font-weight: bold;
}
table{
	border-collapse: collapse;
	font-size: 10pt
}
td{
	border: 1px solid black
}
.col {
	text-align: center;
	background-color: silver;
	font-weight: bold;
	width : 100px;
	height: 50px;
}
.con1 {
	text-align: center;
	width : 120px;
}
.con2 {
	text-align: center;
	width : 240px;
}
.hei{
	height: 130px;
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
<title>Download</title>
</head>
<body>
	<p class="title" align="center">회  의  록</p>
	<table border="1px solid black">
			<tr>
				<td class="col">그룹명</td>
				<td class="con1">${title}</td>
				<td class="col">작성일자</td>
				<td class="con2">${data.min_date}</td>
			</tr>
			<tr>
				<td class="col">회의참가자</td>
				<td colspan="3">${data.min_attendee}</td>
			</tr>
			<tr>
				<td class="col">회의주제</td>
				<td colspan="3">${data.min_subject}</td>
			</tr>
			<tr class="hei">
				<td class="col">회의내용</td>
				<td colspan="3">${data.min_content}</td>
			</tr>
			<tr class="hei">
				<td class="col">의견사항</td>
				<td colspan="3">${data.min_opinion}</td>
			</tr>
			<tr class="hei">
				<td class="col">추후일정</td>
				<td colspan="3">${data.min_schedule}</td>
			</tr>
			<tr class="hei">
				<td class="col">확정내용</td>
				<td colspan="3">${data.min_decide}</td>
			</tr>
			<tr class="hei">
				<td class="col">준비사항</td>
				<td colspan="3">${data.min_prepare}</td>
			</tr>
	</table>
</body>
</html>