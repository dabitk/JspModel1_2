<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,student.model2.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<HTML>
<HEAD>
	<meta charset="UTF-8">
</HEAD>
<BODY>
<h1>레코드 한 개 검색하기</h1>


<%
	request.setCharacterEncoding("utf-8");
%>

	
	<c:choose>
		<c:when test="${student ne null}">
			<TABLE align=center cellspacing=1 width=600 border=1><div>
			<TR><TD align=center>이름</TD><TD align=center>학번</TD>
			<TD align=center>국어</TD><TD align=center>영어</TD><TD align=center>수학</TD>
			<TD align=center>총점</TD><TD align=center>평균</TD><TD align=center>랭킹</TD></TR>
			<TR>
				<td width=50><p align=center><c:out value="${student.sName}"/></p></td>
				<td width=50><p align=center><c:out value="${student.studentid}"/></p></td>
				<td width=50><p align=center><c:out value="${student.kor}"/></p></td>
				<td width=50><p align=center><c:out value="${student.eng}"/></p></td>
				<td width=50><p align=center><c:out value="${student.mat}"/></p></td>
				<td width=50><p align=center><c:out value="${student.total}"/></p></td>															
				<td width=50><p align=center><c:out value="${student.average}"/></p></td>
				<td width=50><p align=center><c:out value="${student.rank}"/></p></td>
			</TR>					
			</div></TABLE>			
		</c:when>
		<c:otherwise>
		<%--student가 null인 경우에는 이하 코드 실행--%>
			<p align=center>학생 데이터가 존재하지 않습니다.</p>
		</c:otherwise>	
	</c:choose>

</BODY>
</HTML>