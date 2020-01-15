<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,student.model.*"%>
<HTML>
<HEAD>
	<meta charset="UTF-8">
</HEAD>
<BODY>


<%
	StudentDBBean bean = StudentDBBean.getInstance();	//객체를 얻는다.
	int studentid=Integer.parseInt(request.getParameter("studentid"));	//GET방식으로 받은 학번 정보를 얻는다.
	
	
	StudentDataBean student = bean.getStudentInfo(studentid);
	String name=student.getsName();
	out.println("<h1 style='text-align:center;'>["+name+"] 조회</h1>");
	//String average = String.format("%.2f",data.getAverage());
	if(student != null){
		out.println("<table align=center cellspacing=1 width=600 border=1>");
		out.println("<div><TR><Th align=center>이름</Th><Th align=center>학번</Th><Th align=center>국어</Th><Th align=center>영어</Th><Th align=center>수학</Th>"+
				"<Th align=center>총점</Th><Th align=center>평균</Th><Th align=center>랭킹</Th></TR>");		
		out.println("<tr>");
		out.println("<td width=150><p align=center>"+student.getsName()+"</p></td>");	
		out.println("<td width=150><p align=center>"+student.getStudentid()+"</p></td>");
		out.println("<td width=50><p align=right>"+student.getKor()+"</p></td>");
		out.println("<td width=50><p align=right>"+student.getEng()+"</p></td>");
		out.println("<td width=50><p align=right>"+student.getMat()+"</p></td>");
		out.println("<td width=50><p align=right>"+student.getTotal()+"</p></td>");
		out.println("<td width=50><p align=right>"+String.format("%.2f",student.getAverage())+"</p></td>");
		out.println("<td width=50><p align=center>"+student.getRank()+"</p></td>");
		out.println("</tr></div></table>");
	}else{
		out.println("<h1 style='color:red'>학생정보를 가져오는 과정에서 오류가 발생했습니다.</h1>");
	}

%>
</BODY>
</HTML>