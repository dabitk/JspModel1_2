<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,student.model2.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<HTML>
<HEAD>
	<meta charset="UTF-8">
</HEAD>
<BODY>
<h1>테이블에 테이터 입력</h1>


<%
	request.setCharacterEncoding("utf-8");
%>
	<c:choose>
		<c:when test="${ERROR eq 0}">
			<h1>테이블에 데이터를 성공적으로 입력했습니다.</h1>
		</c:when>
		<c:otherwise>
		<%--SQLException이 발생한 경우에는 이하 코드 실행--%>
			<h1 style="color:red"><b>테이블이 존재하지 않습니다.</b></h1>
		</c:otherwise>	
	</c:choose>

</BODY>
</HTML>