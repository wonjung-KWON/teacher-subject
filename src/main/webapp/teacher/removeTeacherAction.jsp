<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%
	//요청값 유효성검사
	System.out.println(request.getParameter("teacherNo")+"teacherNo");

	String msg = null;
	if(request.getParameter("teacherNo") == null
			||request.getParameter("teacherNo").equals("")){
		msg = URLEncoder.encode("삭제할 teacher를 선택해주세여","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp>msg="+msg);		
		return;
	}
	// 요청값 변수에 저장
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	//변수값 디버깅
	System.out.println(teacherNo + "<-- teacherNo");
	
	//Dao 실행 하고 row 받아오기
	TeacherDao de = new TeacherDao();
	int row = de.deleteTeacher(teacherNo);
	// 성공 실패 row값으로 if문으로 분기시키기
	if(row ==  1){
		msg = URLEncoder.encode("삭제완료되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
		return;
	} else if(row == 0){
		msg = URLEncoder.encode("삭제 실패하였습니다. 다시 입력해주시길 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherOne.jsp?teacherNo="+teacherNo+"&msg="+msg);
		return;
	}
%>