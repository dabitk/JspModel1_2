<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<meta charset="UTF-8">
	<STYLE>
			input[type=submit]{margin:0; border:none; background:transparent; color:blue; 
				text-decoration: underline; cursor:pointer;}
	</STYLE>
</HEAD>
<BODY>
	<ul>
		<li>
			<FORM method="get" action="createDB.do">
					<input type="hidden" name="CONTENTPAGE" value="createDB.jsp" />
					<input type="submit" value="TBL생성"/>
			</FORM>
		</li>
		<li>
			<FORM method="get" action="dropDB.do">
					<input type="hidden" name="CONTENTPAGE" value="dropDB.jsp" />
					<input type="submit" value="TBL삭제"/>
			</FORM>			
		</li>
		<li>
			<FORM method="get" action="AllsetDB.do">
					<input type="hidden" name="CONTENTPAGE" value="AllsetDB.jsp" />
					<input type="submit" value="TBL값넣기"/>
			</FORM>						
		</li>
		<li>
			<FORM method="get" action="AllviewDB.do">
					<input type="hidden" name="CONTENTPAGE" value="AllviewDB.jsp" />
					<input type="submit" value="TBL전체조회"/>
			</FORM>						
		</li>		
	</ul>
</BODY>
</HTML>