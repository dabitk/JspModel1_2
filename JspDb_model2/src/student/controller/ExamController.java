package student.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import student.model2.*;

/**
 * Servlet implementation class ExamController
 */
@WebServlet("/ExamController")
public class ExamController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExamController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String RequestURI=request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=RequestURI.substring(contextPath.length());
		request.setCharacterEncoding("UTF-8"); 
		System.out.println(command);
		RequestDispatcher rd = null;
		rd = request.getRequestDispatcher("/DB01/main2.jsp");
		
		StudentDBBean bean = StudentDBBean.getInstance();

		
		if(command.contains("createDB")) {	//들어오는 명령어에 따른 분기. 요청에 따른 jsp페이지를 웹 애플리케이션 서버에 요청함.
			
			int isError = 0;	//생성/삭제/추가 등의 작업을 수행할때 테이블이 존재하지 않아서 SQLException이 발생했을때 1의 값을 가지게 됨.		
			
			isError = bean.createTable();//테이블 생성 쿼리
			
			request.setAttribute("ERROR", isError);			
			request.setAttribute("CONTENTPAGE", "createDB.jsp");
			
		}else if(command.contains("AllsetDB")) {
			
			int isError = 0;	//생성/삭제/추가 등의 작업을 수행할때 테이블이 존재하지 않아서 SQLException이 발생했을때 1의 값을 가지게 됨.	
			
			isError=bean.batchInsert(); //레코드 삽입 쿼리
			
			request.setAttribute("ERROR", isError);				
			request.setAttribute("CONTENTPAGE", "AllsetDB.jsp");
			
		}else if(command.contains("dropDB")) {
			
			int isError = 0;	//생성/삭제/추가 등의 작업을 수행할때 테이블이 존재하지 않아서 SQLException이 발생했을때 1의 값을 가지게 됨.	
			
			isError=bean.dropTable();	//테이블을 삭제 쿼리
			
			request.setAttribute("ERROR", isError);				
			request.setAttribute("CONTENTPAGE", "dropDB.jsp");
			
		}else if(command.contains("AllviewDB")) {
			
			List<StudentDataBean> list = new ArrayList<StudentDataBean>();
			
			list = bean.getStudentList(); //학생리스트를 얻는 메소드
			
			request.setAttribute("studentList", list);
			request.setAttribute("CONTENTPAGE", "AllviewDB.jsp");
			
		}else if(command.contains("oneviewDB")) {
			
			int studentid = Integer.parseInt(request.getParameter("studentid"));
			System.out.println("한명조회 학변 :" + studentid);
			StudentDataBean student = bean.getStudentInfo(studentid);	//학번을 기준으로 레코드 하나를 리스트에서 탐색하는 메소드
			
			request.setAttribute("student", student);
			request.setAttribute("CONTENTPAGE", "oneviewDB.jsp");
		}else {
			System.out.println("사용자가 매핑되지 않은 명령을 입력했습니다.");
			//매핑되지 않은 명령을 입력바드면 기본 페이지인 Intro2.jsp로 보낸다
			request.setAttribute("CONTENTPAGE", "Intro2.jsp");
		}
		System.out.println("isError : " + request.getAttribute("ERROR"));
		System.out.println("request : " + request.getAttribute("CONTENTPAGE"));
		rd.forward(request, response);
		//2019/12/15 김정후
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
