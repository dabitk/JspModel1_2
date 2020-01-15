<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*,student.model.*"%>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<style>
		input[type=submit]{margin:0; border:none; background:transparent; color:blue; 
			text-decoration: underline; cursor:pointer;}	
		p{margin:0;}
		
	</style>
</head>
<body>
<h1 align=center>레코드 삭제(페이지네이션)</h1>
<%!
	private static List<StudentDataBean> studentList;
	private int fromPT = 0;	//페이지당 시작되는 줄 번호
	private int cntPT = 0;	//페이지당 표시되는 데이터의 개수
	private int curPg = 0;	//현재 페이지를 나타내는 변수
	private int lastLine = 0;	//최대 데이터 갯수를 저장하는 변수
	private int startPg = 0;	//화면에 보이는 가장 작은 페이지
	private int endPg = 0;		//화면에 보이는 가장 큰 페이지
	private int totalPg = 0;	//이론상 마지막 페이지
	
	public int prevBtn(){	// << 버튼을 눌렀을때 이동하게 되는 페이지 번호를 반환하는 함수
		//curPg = (((fromPT)/100)*10);
		if(curPg-cntPT < 0){
			return 0;
		}else{
			return curPg-cntPT;
		}
	}
	
	public int nextBtn(){	// >> 버튼을 눌렀을때 이동하게 되는 페이지 번호를 반환하는 함수.
		//curPg = (((fromPT)/100)*10);
		if(curPg+cntPT >= totalPg){
			return totalPg-1;
		}else{
			return curPg+cntPT;
		}
	}
%>
<%
		request.setCharacterEncoding("utf-8");

		if(request.getParameter("from") != null && request.getParameter("cnt") != null){
			fromPT = Integer.parseInt(request.getParameter("from"));
			cntPT = Integer.parseInt(request.getParameter("cnt"));
		}else{
			if(request.getAttribute("from") != null && request.getAttribute("cnt") != null){
				fromPT=(int)request.getAttribute("from");
				cntPT=(int)request.getAttribute("cnt");
			}else{
				fromPT = 0;
				cntPT = 10;
			}
		}
		if(studentList==null){
		System.out.println("here");
		studentList = (List<StudentDataBean>)request.getAttribute("studentList");
		}
		int SID = Integer.parseInt(request.getParameter("SID"));
		
		//request.setAttribute("studentList", studentList);
		//request.setAttribute("SID",SID);		
		
		
		//System.out.println("리스트 크기: "+studentList.size());
		//System.out.println("SID 값: "+SID);
		//System.out.println("fromPT 크기: " +fromPT);
		//System.out.println("cntPT 크기: "+cntPT);
		if(!studentList.isEmpty()){
		out.println("<table align=center cellspacing=1 width=600 border=1>");
		out.println("<div><TR><Th align=center>이름</Th><Th align=center>학번</Th><Th align=center>국어</Th><Th align=center>영어</Th><Th align=center>수학</Th>"+
							"<Th align=center>총점</Th><Th align=center>평균</Th><Th align=center>랭킹</Th></TR>");		
		for(int i=0;i<studentList.size();i++){
			StudentDataBean data = studentList.get(i);	//학생정보 객체
			int lineCnt = i;	//줄 수
			String name = data.getsName();
			int studentid = data.getStudentid();
			int kor = data.getKor();
			int eng = data.getEng();
			int mat = data.getMat();
			int total = data.getTotal();
			String average = String.format("%.2f",data.getAverage());
			int rank = data.getRank();
			
			if(lineCnt<fromPT)continue;
			if(lineCnt>=fromPT+cntPT)break;

			out.println("<tr>");				
			out.println("<td width=150><a href='oneviewDB.jsp?studentid="+studentid+"'><p align=center>"+name+"</p></td>");
			out.println("<td width=150><p align=center>"+studentid+"</p></td>");
			out.println("<td width=50><p align=right>"+kor+"</p></td>");
			out.println("<td width=50><p align=right>"+eng+"</p></td>");
			out.println("<td width=50><p align=right>"+mat+"</p></td>");
			out.println("<td width=50><p align=right>"+total+"</p></td>");
			out.println("<td width=50><p align=right>"+average+"</p></td>");
			out.println("<td width=50><p align=center>"+rank+"</p></td>");			
			out.println("</tr>");
		}
		out.println("</div></table>");
		
		//이하 버튼 구현부
		out.println("<div style='text-align:center;'>");
		//curPg = (((fromPT)/100)*10);
		curPg = ((fromPT)/10);
		lastLine = studentList.size()-1;
		//if(lastLine<100) curPg=1;

		
		//마지막 페이지(총 페이지 수)
		totalPg = (int)(Math.ceil(1.0*lastLine/cntPT));
		startPg = ((curPg)/10)*10;
		endPg = startPg + cntPT;
		
		//끝부분 페이지 처리
		if(endPg > totalPg){
			endPg = totalPg;
		}
		//디버깅용 라인
		//out.println("curPg: "+curPg+", lastLine: "+lastLine+", totalPg: "+totalPg+", startPg: "+startPg+", endPg: "+endPg+"<br/>");
		//처음으로
		out.println("<a href='http://192.168.23.14:8080/JspDb/DB01/deleteDB_paged.jsp?from=0&cnt="+cntPT+"&SID="+SID+"'>처음으로</a>");
		//<<버튼
		out.println("<a href='http://192.168.23.14:8080/JspDb/DB01/deleteDB_paged.jsp?from="+(int)(Math.floor(prevBtn()*10/100))*100+"&cnt="+cntPT+"&SID="+SID+"'><<</a>");
		if(studentList.size()==1){
			out.println("<a href='http://192.168.23.14:8080/JspDb/DB01/deleteDB_paged.jsp?from=0&cnt="+cntPT+"&SID="+SID+"'><b>1</b></a>");
		}
		
		for(int i=startPg;i<endPg;i++){
			//if((i*10)>((lastLine-cntPT)))break;

			if(i==curPg){
				out.println("<a href='http://192.168.23.14:8080/JspDb/DB01/deleteDB_paged.jsp?from="+i*10+"&cnt="+cntPT+"&SID="+SID+"' ><b>"+(i+1)+"</b></a>");	
			}else{
				out.println("<a href='http://192.168.23.14:8080/JspDb/DB01/deleteDB_paged.jsp?from="+i*10+"&cnt="+cntPT+"&SID="+SID+"'>"+(i+1)+"</a>");					
			}

		}
		//>> 버튼
		out.println("<a href='http://192.168.23.14:8080/JspDb/DB01/deleteDB_paged.jsp?from="+(int)(Math.floor(nextBtn()*10/100))*100+"&cnt="+cntPT+"&SID="+SID+"'>>></a>");
		//마지막으로 버튼
		out.println("<a href='http://192.168.23.14:8080/JspDb/DB01/deleteDB_paged.jsp?from="+((totalPg*10)-cntPT)+"&cnt="+cntPT+"&SID="+SID+"'>마지막으로</a>");
		out.println("</div>");
	}

%>		


</body>
</html>