<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%
	String msg = null;
	if(request.getParameter("subjectNo") == null){
		msg = URLEncoder.encode("상세보기를 볼 Subject를 선택해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
		return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));

	SubjectDao one = new SubjectDao();
		Subject list = one.selectSubjectOne(subjectNo);
		
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>subjectList</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <header>
            <h1 class="site-heading text-center text-faded d-none d-lg-block">
                <span class="site-heading-upper text-primary mb-3">NEW COFFEE EDUCATION</span>
                <span class="site-heading-lower">GOODEE 바리스타 학원</span>
            </h1>
        </header>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
            <div class="container">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mx-auto">
                         <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="<%=request.getContextPath()%>/subject/subjectList.jsp">과목 목록</a></li>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="<%=request.getContextPath()%>/teacher/teacherList.jsp">강사목록</a></li>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="<%=request.getContextPath()%>/subject/insertSubject.jsp">과목 추가</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <section class="page-section about-heading">
            <div class="container">
                
                <div class="about-heading-content">
                    <div class="row">
                        <div class="col-xl-9 col-lg-10 mx-auto">
                            <div class="bg-faded rounded p-5">
                            <br>
                                <h2 class="section-heading mb-4">
                                    <span class="section-heading-upper">과목 상세보기</span>
                                </h2>
                                <<br>
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
										<td>createdate</td>
										<td><%=list.getCreatedate()%></td>	
									</tr>
									<tr>
										<td>updatedate</td>
										<td><%=list.getUpdatedate()%></td>	
									</tr>
									<tr>
										<td>
											<a href="<%=request.getContextPath()%>/subject/modifySubject.jsp?subjectNo=<%=list.getSubjectNo()%>">수정</a>
										</td>
										<td>
											<a href="<%=request.getContextPath()%>/subject/removeSubjectAction.jsp?subjectNo=<%=list.getSubjectNo()%>">삭제</a>
										</td>
									</tr>
								</table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <footer class="footer text-faded text-center py-5">
            <div class="container"><p class="m-0 small">GOODEE &copy; GDJ66 KWON</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
 