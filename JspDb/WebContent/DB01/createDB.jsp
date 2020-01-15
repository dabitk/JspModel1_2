<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,student.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<HTML>
<HEAD>
	<meta charset="UTF-8">
</HEAD>
<BODY>
<h1 align=center>테이블 생성</h1>
<%
	//createDB.jsp는 테이블 생성 StudentDBBean에게 요청하는 뷰
	
	StudentDBBean bean = StudentDBBean.getInstance();	//객체를 얻는다.
	int errorcode =0;

	errorcode=bean.createTable();	//테이블을 만든다.
	pageContext.setAttribute("errorcode", errorcode);
%>
	<c:choose>
		<c:when test="${errorcode eq 0}">
		<%--errorcode가 0인 경우 (에러가 발생하지 않음)에는 이하 코드 실행--%>
			<h1 style='text-align:center;'>테이블을 성공적으로 생성했습니다.</h1>	
		</c:when>
		<c:otherwise>
		<%--errorcode가 0이 아닌경우 이하 코드 실행--%>
			<h1 style='color:red; text-align:center;'><c:out value="에러코드 ${errorcode}: 테이블이 이미 존재합니다."/></h1>
		</c:otherwise>
	</c:choose>		

</BODY>
</HTML>