package visitors.model2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import student.model2.StudentDBBean;

public class VisitCountDBBean {
	private static VisitCountDBBean instance;	//�Ѱ��� ��ü�� ���� ����: �̱��� ����
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rset = null;
	
	
	//StudentDBBean��ü�� �����ϴ� �޼ҵ�
	public static VisitCountDBBean getInstance() {
		if(instance == null) {
			instance = new VisitCountDBBean();
		}
		return instance;
	}
	
	private void getConnection() {	//Ŀ�ؼ��� ��� �޼ҵ�
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
	
	private void closeConnection(){	//Ŀ�ؼ��� �ݴ� �޼ҵ�
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
	
	public int getVisitCount() throws Exception{
		int count = 0;
		
		getConnection();
		stmt.execute("update visitcount SET counter=counter+1;");
		rset=stmt.executeQuery("SELECT counter from visitcount;");
		while(rset.next()) {
			count = rset.getInt(1);
		}
		closeConnection();
		
		return count;
	}
}
