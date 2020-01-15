<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--위에 스타일이 제대로 적용되는지 재확인 필요 19/12/15 --%>
        
<!DOCTYPE html>
<html>
<head>
	<style>
		html{
			background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#55f));
			background-repeat: no-repeat;
			height:100%;			
		}
	
		body{/*배경색에 그라데이션 지정*/
			
			
		}

		header{
			position: relative;
			height:15%;
		}

		#content{/*id속성의 값이 content인 엘리먼트에 적용*/
			margin: 10px;
			height: 65%;
			width: 90%;
		}

		#areaMain{
			width:70%;
			float:right;
			padding:10px;
			background-color:#fff;
			-webkit-border-radius:8px;
			position:relative;
			border: 2px double lightblue;
		}

		#areaSub{
			margin:10px;
			float:left;
			background-color:white;
			border: 2px double lightpink; 
			-webkit-border-radius:15px;
			position:relative;
		}

		footer{
			clear:both;	/*배치 left,right를 모두 제거*/
			height:15;
		}
	</style>
</head>
<body>

	<% 
		String contentPage= request.getParameter("CONTENTPAGE");
	
		if(contentPage == null){
			contentPage = "Intro2.jsp";
		}
		
	 %>
	<header>
		<span style="display:inline-block;  text-align: center; width:100%"><img id="logo" style="width:100px;height:auto;"src="../logo.png"/><h1>성적조회 서비스 - Version Model 2</h1></span>
	</header>
	<div id="content">
		<section id="areaSub">
			<jsp:include page="menu.jsp" />
		</section>
		<section id="areaMain">
			<jsp:include page="<%=contentPage%>" />
		</section>
	</div>
	<footer>
		<span style="display:inline-block;  text-align: center; width:100%"><p>2019/12/15 kopo02 김정후</p></span>
	</header>
	</footer>
</body>
</html>