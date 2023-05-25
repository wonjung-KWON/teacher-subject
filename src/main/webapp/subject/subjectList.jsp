<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int currentPage = 1; 
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
	int rowPerPage = 10;
	int beginRow = (currentPage -1) * rowPerPage;
	
	SubjectDao sd = new SubjectDao();
		ArrayList<Subject> list = sd.selectSubjectListByPage(beginRow, rowPerPage);
				
				
	SubjectDao tr = new SubjectDao();
	int totalRow = tr.selectSubjectCnt();
	 
	System.out.println(tr+"<-- tr");
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage++;
	}
	int pageCount = 5;// 페이지당 출력될 페이지수
	// startPage가 currentPage가 1~10이면 1로 고정 11~20이면 2로 고정되게 소수점을 이용하여 고정값 만드는 알고리즘
	int startPage = ((currentPage -1)/pageCount)*pageCount+1;
	// startPage에서 9를 더한값이 마지막 출력될 Page이지만 lastPage보다 커지면 endPage는 lastpage로변환
	int endPage = startPage+9;
	if(endPage > lastPage){
		endPage = lastPage;
	}
	System.out.println(startPage+"<-- startPage");
	System.out.println(endPage+"<-- endPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Subject List</h1>
	<table>
	<tr>
        <td>
        <%
        	if(request.getParameter("msg") != null){
        %>
        		<div><%=request.getParameter("msg") %></div>
        <% 
        	}
        %>
        </td>
	</tr>
		<tr>
			<th>subjectName</th>
			<th>subjectTime</th>
			<th>createdate</th>
		</tr>
		<%
			for(Subject s : list){
		%>
			<tr>
				<td><a href="<%=request.getContextPath()%>/subject/subjectOne.jsp?subjectNo=<%=s.getSubjectNo()%>">
					<%=s.getSubjectName()%></a>
				</td>
				<td><%=s.getSubjentTime()%></td>
				<td><%=s.getCreatedate()%></td>
			</tr>
		<% 
			}
		%>
	</table>
	<div>
		<%
			if(startPage > 5){
		%>
			<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=startPage-1%>">이전</a>
		<% 
			}
			for(int i = startPage; i<=endPage; i++){
		%>
			<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
			<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=endPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</body>
</html>