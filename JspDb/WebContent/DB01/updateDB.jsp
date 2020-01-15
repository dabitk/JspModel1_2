<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*,student.model.*"%>
<HTML>
<HEAD>
	<meta charset="UTF-8">
</HEAD>
<BODY>
<h1 align=center>레코드 수정</h1>
<%!
	List<StudentDataBean> list = new ArrayList<StudentDataBean>();
%>
<%

		StudentDBBean bean = StudentDBBean.getInstance();	//객체를 얻는다.
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		int SID=Integer.parseInt(request.getParameter("SID"));
		int kor=Integer.parseInt(request.getParameter("kor"));
		int eng=Integer.parseInt(request.getParameter("eng"));
		int mat=Integer.parseInt(request.getParameter("mat"));		
		
		try{
			bean.updateStudentInfo(name, SID, kor, eng, mat);
			
			//이하 테이블을 프린트하는 부분
			list=bean.getStudentList();	//리스트를 가져온다
			int fromPT=(((SID)%209900)/10)*10;
			//int cntPT=((SID-1)%209900)*10;
			//System.out.println("fromPT값: "+fromPT);

			request.setAttribute("studentList", list);
			request.setAttribute("studentid",SID);
			request.setAttribute("from", fromPT);
			request.setAttribute("cnt",10);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/DB01/updateDB_paged.jsp");
			dispatcher.forward(request, response);

		}catch(Exception e){
			out.println("<h1 style='color:red; text-align:center;'>"+SID+" 학번을 가진 학생의 정보가 존재하지 않습니다.</h1>");
			//e.printStackTrace(new java.io.PrintWriter(out));
		}
%>		
			
				
				
				
				
			
			
			
<%			
			//out.println("<table align=center cellspacing=1 width=600 border=1>");
			//out.println("<div><TR><TD align=center>이름</TD><TD align=center>학번</TD><TD align=center>국어</TD><TD align=center>영어</TD><TD align=center>수학</TD>"+
			//					"<TD align=center>총점</TD><TD align=center>평균</TD><TD align=center>랭킹</TD></TR>");		
			
			//int cntPT=(((SID-1)%209900)/10)*10;
			
			
			
			//int i=1;
			//for(StudentDataBean data:list){
			
				//name = data.getsName();
				//int studentid = data.getStudentid();
				//kor = data.getKor();
				//eng = data.getEng();
				//mat = data.getMat();
				//int total = data.getTotal();

				//String average = String.format("%.2f",data.getAverage());
				//int rank = data.getRank();
			
				//if(SID==studentid){
				//	out.println("<tr style='background-color:yellow'>");
				//	out.println("<td width=150><a href='oneviewDB.jsp?studentid="+studentid+"'><p align=center>"+name+"</p></td>");
				//	out.println("<td width=150><p align=center>"+studentid+"</p></td>");
				//	out.println("<td width=50><p align=right>"+kor+"</p></td>");
				//	out.println("<td width=50><p align=right>"+eng+"</p></td>");
				//	out.println("<td width=50><p align=right>"+mat+"</p></td>");
				//	out.println("<td width=50><p align=right>"+total+"</p></td>");
				//	out.println("<td width=50><p align=right>"+average+"</p></td>");
				//	out.println("<td width=50><p align=center>"+rank+"</p></td>");			
				//	out.println("</tr>");				
				
				//}else{	
				//	out.println("<tr>");
				//	out.println("<td width=150><a href='oneviewDB.jsp?studentid="+studentid+"'><p align=center>"+name+"</p></td>");
				//	out.println("<td width=150><p align=center>"+studentid+"</p></td>");
				//	out.println("<td width=50><p align=right>"+kor+"</p></td>");
				//	out.println("<td width=50><p align=right>"+eng+"</p></td>");
				//	out.println("<td width=50><p align=right>"+mat+"</p></td>");
				//	out.println("<td width=50><p align=right>"+total+"</p></td>");
				//	out.println("<td width=50><p align=right>"+average+"</p></td>");
				//	out.println("<td width=50><p align=center>"+rank+"</p></td>");			
				//	out.println("</tr>");
				//}
				
				//i++;
			//}
			//out.println("</div></table>");				


		
%>

</BODY>
</HTML>
<%--19/12/14 김정후--%>