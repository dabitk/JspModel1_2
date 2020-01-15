<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*,student.model2.*"%>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>

<HTML>
<HEAD>
	<meta charset="UTF-8">
	<style>
		input[type=submit]{margin:0; border:none; background:transparent; color:blue; 
			text-decoration: underline; cursor:pointer;}	
	</style>
</HEAD>
<BODY>
<h1>테이블 조회</h1>
<%
	request.setCharacterEncoding("utf-8");
%>
	<c:choose>
		<c:when test="${!studentList.isEmpty()}">
			<TABLE align=center cellspacing=1 width=600 border=1><div>
			<TR><TD align=center>이름</TD><TD align=center>학번</TD>
			<TD align=center>국어</TD><TD align=center>영어</TD><TD align=center>수학</TD>
			<TD align=center>총점</TD><TD align=center>평균</TD><TD align=center>랭킹</TD></TR>
				<c:forEach var="studentList" items="${studentList}">
					<tr>
					<td width=50>
						<FORM method="get" action="oneviewDB.do">
							<input type="hidden" name="studentid" value=<c:out value="${studentList.studentid}"/> />
							<input type="hidden" name="CONTENTPAGE" value="oneviewDB.jsp"/>
							<input type="submit" value=<c:out value="${studentList.sName}" escapeXml="false"/> />
						</FORM>
					</td>					
					<td width=50><p align=center><c:out value="${studentList.studentid}"/></p></td>
					<td width=50><p align=center><c:out value="${studentList.kor}"/></p></td>
					<td width=50><p align=center><c:out value="${studentList.eng}"/></p></td>
					<td width=50><p align=center><c:out value="${studentList.mat}"/></p></td>
					<td width=50><p align=center><c:out value="${studentList.total}"/></p></td>															
					<td width=50><p align=center><c:out value="${studentList.average}"/></p></td>
					<td width=50><p align=center><c:out value="${studentList.rank}"/></p></td>
					</tr>					
				</c:forEach>
			</div></TABLE>			
		</c:when>
		<c:otherwise>
		<%--studentList가 null인 경우에는 이하 코드 실행--%>
			<p align=center><b>학생 데이터가 존재하지 않습니다.</b></p>
		</c:otherwise>	
	</c:choose>

</BODY>
</HTML>