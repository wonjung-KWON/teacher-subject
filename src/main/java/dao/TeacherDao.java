package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Teacher;

public class TeacherDao {
	// 1) teacher List
	/*
	 -- mariadb에는 문자열을 집계하는 group_concat(매개변수 : 문자컬럼)이라는 집계함수가 있다. 
		select t.teacher_no, t.teacher_id, t.teacher_name, ts.subject_no, s.subject_name, group_concat(s.subject_name)
			from  teacher t left outer join teacher_subject ts
		 		on t.teacher_no = ts.teacher_no 
		 			inner join subject s 
		 			on ts.subject_no = s.subject_no
		GROUP BY t.teacher_no, t.teacher_id, t.teacher_name
		LIMIT ?,?;
	 */
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "select t.teacher_no 강사번호, t.teacher_id 강사아이디, t.teacher_name 강사이름, ts.subject_no 과목번호, IFNULL(group_concat(s.subject_name),'없음') 과목목록  from  teacher t left outer join teacher_subject ts on t.teacher_no = ts.teacher_no left outer join subject s on ts.subject_no = s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?,?;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt+"<-- stmt");
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("강사번호", rs.getInt("강사번호"));
			m.put("강사아이디", rs.getString("강사아이디"));
			m.put("강사이름", rs.getString("강사이름"));
			m.put("과목번호", rs.getInt("과목번호"));
			m.put("과목목록", rs.getString("과목목록"));
			list.add(m);
		}
		return list;
	}
	// 2) 강사전체 row
	public int selectTeacherCnt() throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// PreparedStatement
		PreparedStatement stmt  = conn.prepareStatement("SELECT count(*) from teacher");
		System.out.println(stmt+"<-- stmt");	
		// ResultSet
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
	// 3) 강사 추가
	public int  insertTeacher(Teacher teacher) throws Exception{
		int row = 0;
		Teacher t = new Teacher();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("INSERT INTO teacher(teacher_id, teacher_name, teacher_history, updatedate, createdate) VALUES(?,?,?,now(),now())");
		stmt.setString(1, teacher.getTeacherId());
		stmt.setString(2, teacher.getTeacherName());
		stmt.setString(3, teacher.getTeacherHistory());
		System.out.println(stmt+"<-- stmt");
		row = stmt.executeUpdate();
		return row;
	}
	// 4) 강사삭제
	public int deleteTeacher(int teacherNo) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("DELETE FROM teacher WHERE teacher_no = ?");
		stmt.setInt(1, teacherNo);
		System.out.println(stmt+"<-- stmt");
		row = stmt.executeUpdate();
		
		return row;
	}
	// 5) 강사 정보 수정
	public int updateTeacher(Teacher teacher) throws Exception{
		int row =0;
		
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("UPDATE teacher SET teacher_name = ?, teacher_history = ?, updatedate = now() WHERE teacher_no = ?");
		stmt.setString(1, teacher.getTeacherName());
		stmt.setString(2, teacher.getTeacherHistory());
		stmt.setInt(3, teacher.getTeacherNo());
		System.out.println(stmt+"<-- stmt");
		row = stmt.executeUpdate();
		return row;
	}
	// 6) 강사 상세보기
	public ArrayList<HashMap<String, Object>> selectTeacherOne(int teacherNo) throws Exception{
		ArrayList<HashMap<String, Object>> one = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select t.teacher_no 강사번호, t.teacher_id 강사아이디, t.teacher_name 강사이름, t.teacher_history 강사내용, ifnull(group_concat(s.subject_name),'없음') 강사과목, t.createdate 등록일, t.updatedate 수정일 from teacher t inner join teacher_subject ts on t.teacher_no = ts.teacher_no left outer join subject s on ts.subject_no = s.subject_no where t.teacher_no = ? group by t.teacher_no, t.teacher_id, t.teacher_name");
		stmt.setInt(1, teacherNo);
		System.out.println(stmt+"<-- stmt");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> o =  new HashMap<String, Object>();
			o.put("강사번호", rs.getInt("강사번호"));
			o.put("강사아이디", rs.getString("강사아이디"));
			o.put("강사이름", rs.getString("강사이름"));
			o.put("강사내용", rs.getString("강사내용"));
			o.put("강사과목", rs.getString("강사과목"));
			o.put("등록일", rs.getString("등록일"));
			o.put("수정일", rs.getString("수정일"));
			one.add(o);
		}
		return one;
	}
	
	
}
