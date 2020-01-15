<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,student.model.*"%>
<html>
	<HEAD>
		<meta charset="UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script>
		function onlyNumber(){	//숫자만 입력 받게하는 함수
			if(((event.keyCode<48)||(event.keyCode>57))&&event.keyCode!=13){
				alert('숫자만 입력할 수 있습니다.');				
				event.returnValue=false;
			}
			//if((/[0-9]/i).test(String.fromCharCode(event.keyCode | event.which))){
				//event.returnValue=true;
			//}else{
				//alert('숫자만 입력할 수 있습니다.');
				//event.returnValue=false;
			//}
			
		}

		function onlyEngKor(){
			if((/^[a-zA-Z가-힣 ]*$/).test(String.fromCharCode(event.keyCode | event.which))){
				event.returnValue=true;
			}else{
				alert('한글과 영어만 입력할 수 있습니다.');
				event.returnValue=false;
			}
		}
		

		
		$(document).ready(function(){
			var form = $("#myForm")[0];
			var formData = new FormData(form);
			
			$("#btn1").click(function(){
				form.action='updateDB.jsp';
				if($("#kor").val() < 0 || $("#kor").val() >100||
				   $("#eng").val() < 0 || $("#eng").val() > 100||
				   $("#mat").val() < 0 || $("#mat").val() > 100){
					alert('점수는 0부터 100까지 입니다.');
				}else if(

				   $("#kor").val() ==""||
				   $("#eng").val() ==""||
				   $("#mat").val() ==""||
				   $("#name").val() ==""){
				   alert('공란이 존재합니다.');
				}else{
					form.submit();
				}
			});
			$("#btn2").click(function(){
				form.action='deleteDB.jsp';
				form.submit();
			});
		});
	</script>		
		<STYLE>
			td{
				text-align:center;
			}
			body{
			    text-align: center;
			}
			div{
				display: inline-block;

			}
			input[type="number"],input[type="text"]{
    			-webkit-box-sizing: border-box;
       			-moz-box-sizing: border-box;
            	box-sizing: border-box;
            	width:175px;
			}			
		</STYLE>
	</HEAD>
	<BODY>

	<h1 align=center>성적 조회 후 정정 / 삭제</h1>
	<div>
	<form method="post" id="myForm" style="width:400px;" action="showREC.jsp">
	<label for="studentid">조회할 학번 </label>
	<input type="search" id="studentid"  onkeypress="onlyNumber();" maxlength="6" style="margin-left:20px;margin-bottom:10px;" name="studentid" autocomplete=off required/>
	<input type="submit" style="float:right;margin-right:60px;" value="조회">
	<TABLE cellspacing=1 width=400px border=1>
<%
	StudentDBBean bean = StudentDBBean.getInstance();	//객체를 얻는다.
	int studentid=Integer.parseInt(request.getParameter("studentid"));	//GET방식으로 받은 학번 정보를 얻는다.
	
	//out.println("<TR><TD>학번</TD><TD>"+studentid+"</TD></TR>");
	StudentDataBean student = bean.getStudentInfo(studentid);

	if(student != null){
		String name=student.getsName();
		int kor=student.getKor();
		int eng=student.getEng();
		int mat=student.getMat();
		//int total=student.getTotal();
		//double average=student.getAverage();
		//int rank=student.getRank();

		out.println("<TR><TD>이름</TD><TD><input type='text' onkeypress='onlyEngKor();' maxlength='5' name='name' value='"+name+"' required/></TD></TR>");
		out.println("<TR><TD>학번</TD><TD><input type='text' name='SID' value='"+studentid+"' readonly/></TD></TR>");
		out.println("<TR><TD>국어</TD><TD><input type='number' min='0' max='100' maxlength='3' onkeypress='onlyNumber();' name='kor' id='kor' value='"+kor+"' required/></TD></TR>");
		out.println("<TR><TD>영어</TD><TD><input type='number' min='0' max='100' maxlength='3' onkeypress='onlyNumber();' name='eng' id='eng' value='"+eng+"' required/></TD></TR>");
		out.println("<TR><TD>수학</TD><TD><input type='number' min='0' max='100' maxlength='3' onkeypress='onlyNumber();' name='mat' id='mat' value='"+mat+"' required/></TD></TR></TABLE>");
		out.println("<div align='right'><input type='button' id='btn1'value='수정'>");
		out.println("<input type='button' id='btn2' align=right value='삭제'></div></form>");		
	}else{
		out.println("<TR><TD>이름</TD><TD><input type='text' name='name' value='해당학번없음' readonly/></TD></TR>");
		out.println("<TR><TD>학번</TD><TD><input type='text' readonly/></TD></TR>");
		out.println("<TR><TD>국어</TD><TD><input type='number' min='0' max='100' name='kor' readonly/></TD></TR>");
		out.println("<TR><TD>영어</TD><TD><input type='number' min='0' max='100' name='eng' readonly/></TD></TR>");
		out.println("<TR><TD>수학</TD><TD><input type='number' min='0' max='100' name='mat' readonly/></TD></TR></TABLE></form>"); 
	}
	
%>	
	</div>
	</BODY>
</html>
