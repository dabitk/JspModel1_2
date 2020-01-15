<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*,java.io.*"%>
<HTML>
<HEAD>
</HEAD>
<BODY>
<h1 style='align:center'>JSP Database 실습 1</h1>

<%
	String data;
	int cnt=0;
	
	FileReader f1 = new FileReader("C:\\JspStudy\\cnt.txt");
	StringBuffer sb = new StringBuffer();
	int ch =0;
	while((ch=f1.read()) != -1){
		sb.append((char)ch);
	}
	data=sb.toString().trim().replace("\n","");
	f1.close();
	
	cnt=Integer.parseInt(data);
	cnt++;
	data=Integer.toString(cnt);
	out.println("<br><br>현재 홈페이지 방문조회수는 ["+data+"] 입니다</br>");
	
	FileWriter f2 = new FileWriter("C:\\JspStudy\\cnt.txt",false);
	f2.write(data);
	f2.close();
%>

	<br/><br/>19/12/10<br/>
	kopo02 김정후<br/>
</BODY>
</HTML>