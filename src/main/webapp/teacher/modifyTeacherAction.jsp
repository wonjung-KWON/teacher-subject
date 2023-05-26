<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%
	//요청값 디버깅 체크
	System.out.println(request.getParameter("teacherNo")+"<-- param teacherNo");
	System.out.println(request.getParameter("teacherName")+"<-- param teacherName");
	System.out.println(request.getParameter("teacherHistory")+"<-- param teacherHistory");
	//요청값 유효성 검사
	String msg = null;
	if(request.getParameter("teacherNo") == null
			||request.getParameter("teacherNo").equals("")
			||request.getParameter("teacherName")== null
			||request.getParameter("teacherName").equals("")
			||request.getParameter("teacherHistory")== null
			||request.getParameter("teacherHistory").equals("")){
		msg = URLEncoder.encode("변경할 Subject를  입력해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
		return;
	}
	//요청값 변수에 저장
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	//변수에 저장한 값 잘 들어갔는지 디버깅확인
	System.out.println(teacherNo+"<-- teacherNo");
	System.out.println(teacherName+"<-- teacherName");
	System.out.println(teacherHistory+"<-- teacherHistory");
	
	//클래스타입에 값 저장
	Teacher teacher = new Teacher();
	teacher.setTeacherNo(teacherNo);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherHistory(teacherHistory);
	//Dao 실행 하고 row값 받아오기
	TeacherDao up = new TeacherDao();
	int row = up.updateTeacher(teacher);
	System.out.println(row + "<--row");
	//성공 실패row값 if문으로 분기
	if(row ==  1){
		msg = URLEncoder.encode("수정완료되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherOne.jsp?teacherNo="+teacherNo+"&msg="+msg);
		return;
	} else if(row == 0){
		msg = URLEncoder.encode("수정 실패하였습니다. 다시 입력해주시길 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/modifyTeacher.jsp?teacherNo="+teacherNo+"&msg="+msg);
		return;
	}

%>