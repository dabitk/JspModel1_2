<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*,student.model.*"%>


<HTML>
<HEAD>
	<meta charset="UTF-8">
	<STYLE>
		body{
		    text-align: center;
		}
		div{
			display: inline-block;
		}	
		td{
			text-align:center;
		}
		input[type="text"]{
    		-webkit-box-sizing: border-box;
       		-moz-box-sizing: border-box;
            box-sizing: border-box;
            width:175px;
		}			
	</STYLE>	
</HEAD>
<BODY>
<h1 align=center>성적입력추가완료</h1>

<%
	StudentDBBean bean = StudentDBBean.getInstance();	//객체를 얻는다.

	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	int kor=Integer.parseInt(request.getParameter("kor"));
	int eng=Integer.parseInt(request.getParameter("eng"));
	int mat=Integer.parseInt(request.getParameter("mat"));
	
	

		int studentid = bean.singleInsert(name,kor,eng,mat);
		if(studentid > 209900){
			out.println("<div><form method='post' style='width:400px;' action='inputForm1.html'>");
			out.println("<input type='submit' style='float:right;margin-right:40px;margin-bottom:10px;' value='뒤로가기'>");
			out.println("<TABLE cellspaceing=1 width=400px border=1>");
			out.println("<TR><TD>이름</TD><TD><input type='text' name='name' value='"+name+"' autocomplete=off readonly></TD></TR>");
			out.println("<TR><TD>학번</TD><TD><input type='text' name='studentid' value='"+studentid+"' autocomplete=off readonly></TD></TR>");
			out.println("<TR><TD>국어</TD><TD><input type='text' name='kor' value='"+kor+"' autocomplete=off readonly></TD></TR>");
			out.println("<TR><TD>영어</TD><TD><input type='text' name='eng' value='"+eng+"' autocomplete=off readonly></TD></TR>");
			out.println("<TR><TD>수학</TD><TD><input type='text' name='mat' value='"+mat+"' autocomplete=off readonly></TD></TR>");
			out.println("</TABLE></form></div>");
		}else{
			out.println("<h1 style='color:red; text-align:center;'>에러코드 "+studentid+": 데이터를 입력할 테이블이 존재하지 않습니다.</h1>");
	}
%>
</BODY>
</HTML>
		


