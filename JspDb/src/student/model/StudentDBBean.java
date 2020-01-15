package student.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.exceptions.MySQLSyntaxErrorException;

public class StudentDBBean {

	private static StudentDBBean instance;	//한개의 객체만 만들어서 공유: 싱글턴 패턴
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rset = null;
	private List<StudentDataBean> list = null;
	
	private StudentDBBean(){	//생성자. 리스트 객체를 생성함. 클래스가 싱글턴으로 설계되었기 때문에 멤버변수인 리스트도 공유된다.
		list=new ArrayList<StudentDataBean>();

	}
	
	
	//StudentDBBean객체를 리턴하는 메소드
	public static StudentDBBean getInstance() {
		if(instance == null) {
			instance = new StudentDBBean();
		}
		return instance;
	}
	
	private void getConnection() {	//커넥션을 얻는 메소드
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		try{
			conn = DriverManager.getConnection("jdbc:mysql://192.168.56.1:3306/jsptest","root","1234");
			stmt = conn.createStatement();
			
		}catch(SQLException e){
			e.printStackTrace();
		}		
	}
	
	private void closeConnection(){	//커넥션을 닫는 메소드
		try{
			if(rset != null){
				rset.close();
			}
			if(stmt != null){
				stmt.close();					
			}
			if(conn != null){
				conn.close();					
			}
		}catch(SQLException e){
			e.printStackTrace();
		}	
	}
	
	public int createTable(){//createDB.jsp에서 호출함. 테이블을 생성함.
		int errorcode = 0;
		
		getConnection();
		try {
			stmt.execute("create table examtable(name varchar(20),"+
				"studentid int not null auto_increment primary key,"+
				"kor int,eng int,mat int) DEFAULT CHARSET=utf8;");
			stmt.execute("ALTER TABLE examtable auto_increment = 209901;");
		} catch (SQLException e) {

			errorcode=e.getErrorCode();
			return errorcode;
		}

		closeConnection();	
		return errorcode;
	}
	
	public int dropTable(){	//dropDB.jsp에서 호출함. 테이블을 삭제하고 리스트의 내용물을 초기화함
		int errorcode = 0;
		
		getConnection();
		try {
			stmt.execute("DROP TABLE examtable;");
		} catch (SQLException e) {

			errorcode = e.getErrorCode();
		}
		list.clear();	//리스트도 초기화 해준다.
		closeConnection();
		return errorcode;
	}
	
	public void deleteStudentInfo(int SID) throws Exception{	//deleteDB.jsp에서 호출함. 학번을 기준으로 학생 1명의 레코드를 삭제함. 리스트에서도 찾아서 삭제함. <=리스트에서 찾아서 삭제할 필요없는듯.
		getConnection();
		stmt.execute("delete from examtable where studentid="+SID+";");	//DB테이블에서 동일한 학번을 가진 학생정보를 제거한다.
		
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getStudentid() == SID) {	//리스트에서 동일한 학번인 학생을 찾아서
				list.remove(i);						//리스트로부터 제거한다.
			}
		}
		
		closeConnection();
	}
	
	public void updateStudentInfo(String name, int SID, int kor, int eng, int mat) throws Exception{		//updateDB.jsp에서 호출함. 학번을 기준으로 학생 1명의 레코드 정보를 수정함.
		getConnection();
		stmt.execute("update examtable SET NAME='"+name+"', kor="+kor+", eng="+eng+",mat="+mat+" where studentid="+SID+";");
		closeConnection();
	}
	
	public int batchInsert(){//AllsetDB.jsp에서 호출함. 한번에 모든 트와이스 멤버를 테이블에 추가함
		int errorcode = 0;
		
		getConnection();
		try {
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat) VALUES('나연',"+getValidSID()+",95,100,95);");
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat) VALUES('정연',"+getValidSID()+",95,95,95);");
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat) VALUES('모모',"+getValidSID()+",100,100,100);");
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat) VALUES('사나',"+getValidSID()+",100,95,90);");
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat) VALUES('지효',"+getValidSID()+",80,100,70);");
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat) VALUES('미나',"+getValidSID()+",100,100,70);");
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat) VALUES('다현',"+getValidSID()+",85,90,70);");
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat) VALUES('쯔위',"+getValidSID()+",70,70,75);");
		}catch(MySQLSyntaxErrorException e) {
			errorcode =e.getErrorCode();
			return errorcode;
		}catch (SQLException e) {
			errorcode = e.getErrorCode();
			return errorcode;
		}
		closeConnection();
		return errorcode;
	}
	
	public int singleInsert(String name, int kor,int eng,int mat){	//insertDB.jsp에서 호출함. 레코드 하나를 추가하고 학번을 반환함.
		
		getConnection();
		int studentid = getValidSID();

		try {
			stmt.execute("INSERT INTO examtable(name,studentid,kor,eng,mat)"+
				" VALUES('"+name+"',"+studentid+","+kor+","+eng+","+mat+");");
		} catch (SQLException e) {
			e.printStackTrace();
			int errorcode = e.getErrorCode();	//에러가 발생하면 에러코드를 반환함
			return errorcode;
		}

		closeConnection();
		
		return studentid;	//무사히 메소드가 종료하면 학번을 반환함
	}
	
	private int getValidSID() {	//DB로부터 사용가능한 학번을 반환받는 메소드. 이 클래스 내부에서만 호출된다.
		int studentid = 0;	
		try {
			rset=stmt.executeQuery("SELECT MIN(unused) AS unused\r\n" + 
					"FROM(\r\n" + 
					"	SELECT MIN(a.studentid)+1 AS unused\r\n" + 
					"	FROM examtable AS a\r\n" + 
					"	WHERE NOT EXISTS (SELECT * FROM examtable AS b\r\n" + 
					"	WHERE b.studentid = a.studentid+1)\r\n" + 
					"	UNION\r\n" + 
					"	SELECT 209901\r\n" + 
					"	FROM DUAL\r\n" + 
					"	WHERE NOT EXISTS(SELECT * FROM examtable WHERE studentid = 209901)\r\n" + 
					"	)AS subquery;");
			while(rset.next()) {
				studentid = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		
		return studentid;
	}
	
	public List<StudentDataBean> getStudentList(){		//AllviewDB.jsp에서 호출함. examtable의 모든 레코드를 성적순으로 가져온다음 리스트에 적재함.
		list.clear();	//리스트를 먼저 초기화 해주지 않으면 호출될때마다 데이터가 2배씩 늘어난다.  
		
		getConnection();
		try {
			rset = stmt.executeQuery("SELECT NAME,studentid,kor,eng,mat,total,average,rank FROM (SELECT name,studentid,kor,eng,mat,total,average, \r\n" + 
					"IF(average=@prev_value,@curRank:=@curRank,@curRank:=@_sequence) AS rank,\r\n" + 
					"@_sequence:=@_sequence+1,@prev_value:=average \r\n" + 
					"FROM (SELECT NAME,studentid,kor,eng,mat,kor+eng+mat AS total, (kor+eng+mat)/3 AS average FROM examtable) a,\r\n" + 
					"(SELECT @curRank := 1, @_sequence:=1, @prev_value:=0) b\r\n" + 
					"ORDER BY average DESC)AS result ORDER BY studentid");
		
			while(rset.next()) {
				String name=rset.getString(1);
				int studentid=rset.getInt(2);
				int kor=rset.getInt(3);
				int eng=rset.getInt(4);
				int mat=rset.getInt(5);
				int total=rset.getInt(6);
				double average=rset.getDouble(7);
				int rank=rset.getInt(8);
				
				list.add(new StudentDataBean(name,studentid,kor,eng,mat,total,average,rank));

		} 
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		closeConnection();
		return list;
	}
	
	public int dummysetDB() {
		int errorcode = 0;
		
		getConnection();
		try {
			stmt.execute("CALL prepare_data();");
		}catch(MySQLSyntaxErrorException e) {
			errorcode =e.getErrorCode();
			return errorcode;
		}catch (SQLException e) {
			errorcode = e.getErrorCode();
			return errorcode;
		}
		closeConnection();
		return errorcode;		
	}
	
	public StudentDataBean getStudentInfo(int studentid) throws Exception{//학번을 기준으로 학생정보를 검색하고 찾았을 경우 StudentDataBean 객체를 반환함. 못찾으며 null을 반환함.
		
		//서버를 킨 직후에는 리스트가 비어있기 때문에 한번 getStudentList메소드로 값을 초기화 해주어야 한다.
		if(list.isEmpty()) {
			getStudentList();
		}
		
		for(StudentDataBean student: list) {
			if(student.getStudentid()==studentid) {
				return student;
			}
		}
		return null;
	}
	
	

}
