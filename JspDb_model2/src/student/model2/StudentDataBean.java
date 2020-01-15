package student.model2;


public class StudentDataBean{	
	//SELECT로 DB에 접근해서 얻은 데이터를 저장하는 자바빈
	private String sName;	//학생의 이름
	private int studentid;	//학번
	private int kor;		//국어점수
	private int eng;		//영어점수
	private int mat;		//수학점수
	private int total;		//점수합계
	private double average;	//점수평균
	private int rank;	//등수
	
	
	public StudentDataBean(String sName,int studentid,int kor,int eng,int mat,int total,double average,int rank) {
		setsName(sName);
		setStudentid(studentid);
		setKor(kor);
		setEng(eng);
		setMat(mat);
		setTotal(total);
		setAverage(average);
		setRank(rank);
	}
	
	public String getsName() {
		return sName;
	}
	public void setsName(String sName) {
		this.sName = sName;
	}
	public int getStudentid() {
		return studentid;
	}
	public void setStudentid(int studentid) {
		this.studentid = studentid;
	}
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
	}
	public int getMat() {
		return mat;
	}
	public void setMat(int mat) {
		this.mat = mat;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public double getAverage() {
		return average;
	}
	public void setAverage(double average) {
		this.average = average;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank=rank;
	}
	
	
}
