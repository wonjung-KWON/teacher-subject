<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%
	// 요청값 유효성검사
	System.out.println(request.getParameter("subjectNo")+"subjectNo");
	System.out.println(request.getParameter("subjectName")+"subjectName");
	System.out.println(request.getParameter("subjectTime")+"subjectTime");
	
	String msg = null;
	if(request.getParameter("subjectNo") == null
			||request.getParameter("subjectNo").equals("")
			||request.getParameter("subjectName")== null
			||request.getParameter("subjectName").equals("")
			||request.getParameter("subjectTime")== null
			||request.getParameter("subjectTime").equals("")){
		msg = URLEncoder.encode("변경할 Subject를  입력해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
		return;
	}
	
	// 요청값 변수에 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	//변수값 디버깅
	System.out.println(subjectNo+"subjectNo");
	System.out.println(subjectName+"subjectName");
	System.out.println(subjectTime+"subjectTime");
	
	//클래스타입에 값 넣기
	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo);
	subject.setSubjectName(subjectName);
	subject.setSubjentTime(subjectTime);
	// Dao 실행 하고 row  값 받아오기
	SubjectDao up = new SubjectDao();
	int row = up.updateSubject(subject);
	System.out.println(row + "<--row");
	//성공 실패row값 if문으로 분기
	if(row ==  1){
		msg = URLEncoder.encode("수정완료되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectOne.jsp?subjectNo="+subjectNo+"&msg="+msg);
		return;
	} else if(row == 0){
		msg = URLEncoder.encode("수정 실패하였습니다. 다시 입력해주시길 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/modifySubject.jsp?subjectNo="+subjectNo+"&msg="+msg);
		return;
	}
%>
