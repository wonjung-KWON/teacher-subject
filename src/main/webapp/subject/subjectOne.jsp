<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%
	String msg = null;
	if(request.getParameter("subjectNo") == null){
		msg = URLEncoder.encode("변경할 지역이름을 적어주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
		return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));

	SubjectDao one = new SubjectDao();
		Subject list = one.selectSubjectOne(subjectNo);
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Subject 상세보기</h1>
	<table>
		<tr>
			<td>subjectNo</td>
			<td><%=list.getSubjectNo()%></td>	
		</tr>
		<tr>
			<td>subjectName</td>
			<td><%=list.getSubjectName()%></td>	
		</tr>
		<tr>
			<td>subjectTime</td>
			<td><%=list.getSubjentTime()%></td>	
		</tr>
		<tr>
			<td>subjectNo</td>
			<td><%=list.getCreatedate()%></td>	
		</tr>
		<tr>
			<td>subjectNo</td>
			<td><%=list.getUpdatedate()%></td>	
		</tr>
	</table>
</body>
</html>