package dao;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.spi.DirStateFactory.Result;

import util.DBUtil;
import vo.Subject;

public class SubjectDao {
	// 1) 과목목록
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Subject> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// PreparedStatement
		PreparedStatement stmt = conn.prepareStatement("SELECT subject_no subjectNo,subject_name subjectName, subject_time subjectTime, createdate FROM subject ORDER BY createdate desc LIMIT ?,?");
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		// ResultSet
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Subject s = new Subject();
			s.setSubjectNo(rs.getInt("subjectNo"));
			s.setSubjectName(rs.getString("subjectName"));
			s.setSubjentTime(rs.getInt("subjectTime"));
			s.setCreatedate(rs.getString("createdate"));
			list.add(s);
		}
		return list;
		
	}
	// 2) 과목추가
	public int insertSubject(Subject subject) throws Exception {
		int row = 0;
		Subject s = new Subject();
		String subjectName = s.getSubjectName();
		int subjectTime = s.getSubjentTime();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// PreparedStatement
		PreparedStatement stmt = conn.prepareStatement("INSERT INTO subject(subject_name, subject_time, createdate, updatedate) VALUES(?,?,NOW(),NOW())");
		stmt.setString(1, subjectName);
		stmt.setInt(2, subjectTime);
		row = stmt.executeUpdate();
		return row;
	}
	// 3) 과목삭제
	public int deleteSubject(int subjectNo) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// PreparedStatement
		PreparedStatement stmt = conn.prepareStatement("DELETE FROM subject WHERE subject_no = ?");
		stmt.setInt(1, subjectNo);
		row = stmt.executeUpdate();
		return row;
	}
	// 4) 과목수정
	public int updateSubject(Subject subject) throws Exception{
		int row = 0;
		Subject s = new Subject();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// PreparedStatement
		PreparedStatement stmt = conn.prepareStatement("UPDATE subject SET subject_name = ?, subject_time = ?, updatedate = now() WHERE subject_no = ?");
		stmt.setString(1, s.getSubjectName());
		stmt.setInt(2, s.getSubjentTime());
		row = stmt.executeUpdate();
		return row;
	}
	// 5) 과목 하나 상세
	public Subject selectSubjectOne(int subjectNo) throws Exception {
		Subject subject = new Subject();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// PreparedStatement
		PreparedStatement stmt = conn.prepareStatement("SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, createdate , updatedate FROM subject WHERE subject_no = ?");
		// ResultSet
		stmt.setInt(1, subjectNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			
			subject.setSubjectNo(subjectNo);
			subject.setSubjectName(rs.getString("subjectName"));
			subject.setSubjentTime(rs.getInt("subjectTime"));
			subject.setCreatedate(rs.getString("createdate"));
			subject.setUpdatedate(rs.getString("updatedate"));
		}
		return subject;
	}
	
	// 6) 과목전체row
	public int selectSubjectCnt() throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// PreparedStatement
		PreparedStatement stmt  = conn.prepareStatement("SELECT count(*) from subject");
		// ResultSet
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
}
