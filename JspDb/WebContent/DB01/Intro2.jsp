<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*,java.io.*,visitors.model.*"%>
<HTML>
<HEAD>
	<STYLE>
		body{
		    text-align: center;
		}
		div{
			display: inline-block;
		}		
	</STYLE>
</HEAD>
<BODY>
<h1 style='text-align:center;'>JSP Database 실습 2</h1>
	<div>
<%
	VisitCountDBBean bean = VisitCountDBBean.getInstance();
	
	try{
		int visitCnt = bean.getVisitCount();	//방문자 카운트를 얻어온다.
		out.println("<br><br>현재 홈페이지 방문조회수는 ["+visitCnt+"] 입니다</br>");
	}catch(Exception e){
		out.println(e);	//디버깅용
	}	
%>

	<br/><br/>19/12/10<br/>
	kopo02 김정후<br/>
	</div>
</BODY>
</HTML>