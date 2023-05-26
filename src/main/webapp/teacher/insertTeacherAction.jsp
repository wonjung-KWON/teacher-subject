<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");

	//요청값 디버깅
	System.out.println(request.getParameter("teacherId")+ "<-- param teacherId");
	System.out.println(request.getParameter("teacherName")+ "<-- param teacherName");
	System.out.println(request.getParameter("teacherHistory")+ "<-- param teacherHistory");
	
	//요청값 유효성 검사
	String msg = null;
	if(request.getParameter("teacherId")== null
			||request.getParameter("teacherId").equals("")
			||request.getParameter("teacherName")== null
			||request.getParameter("teacherName").equals("")
			||request.getParameter("teacherHistory")== null
			||request.getParameter("teacherHistory").equals("")){
		msg = URLEncoder.encode("새로생성 할 강사를  입력해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/insertTeacher.jsp?msg="+msg);
		return;
	}
	//요청값 변수 저장
	String teacherId = request.getParameter("teacherId");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	// 변수값 디버깅 확인
	System.out.println(teacherId+ "<-- teacherID");
	System.out.println(teacherName+ "<-- teacherName");
	System.out.println(teacherHistory+ "<-- teacherHistory");
	
	//클래스 타입에 값 저장
		Teacher teacher = new Teacher();
		teacher.setTeacherId(teacherId);
		teacher.setTeacherName(teacherName);
		teacher.setTeacherHistory(teacherHistory);
	//Dao 실행하고 row 값 받아오기
	TeacherDao in = new TeacherDao();
	int row = in.insertTeacher(teacher);
	//row값 디버깅
		System.out.println(row + "<--row");
		//성공 실패row값 if문으로 분기
			if(row ==  1){
				msg = URLEncoder.encode("추가완료되었습니다.","utf-8");
				response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?&msg="+msg);
				return;
			} else if(row == 0){
				msg = URLEncoder.encode("추가 실패하였습니다. 다시 입력해주시길 바랍니다","utf-8");
				response.sendRedirect(request.getContextPath()+"/teacher/insertTeacher.jsp?msg="+msg);
				return;
			}
%>