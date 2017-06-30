<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<td>순번</td>
			<td>개설자</td>
			<td>그룹이름</td>
			<td>설명</td>
		</tr>
		<c:forEach var="gList" items="${list}">
			<tr>
				<td>${gList.s_id}</td>
				<td>${gList.s_code}</td>
				<td>${gList.s_pw}</td>
				<td>${gList.s_email}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>