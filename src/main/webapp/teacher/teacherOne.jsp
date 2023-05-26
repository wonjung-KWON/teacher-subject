<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%
	String msg = null;
	if(request.getParameter("teacherNo") == null){
		msg = URLEncoder.encode("상세보기를 볼 강사를 선택해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
		return;
	}
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	TeacherDao one = new TeacherDao();
	ArrayList<HashMap<String,Object>> list = one.selectTeacherOne(teacherNo);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>TeacherOne.jsp</title>
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
                <img class="img-fluid rounded about-heading-img mb-3 mb-lg-0" src="assets/img/about.jpg" alt="..." />
                <div class="about-heading-content">
                    <div class="row">
                        <div class="col-xl-9 col-lg-10 mx-auto">
                            <div class="bg-faded rounded p-5">
                                <h2 class="section-heading mb-4">
                                    <span class="section-heading-upper">강사 상세보기</span>
                                </h2>
                              <%	
									for(HashMap<String, Object> s : list){
								%>
							<h1><%=(String)(s.get("강사이름"))%>님의 강사 정보</h1>
								<table>
									<tr>
										<td>강사번호</td>
										<td><%=(Integer)(s.get("강사번호"))%></td>
									</tr>
									<tr>
										<td>강사아이디</td>
										<td><%=(String)(s.get("강사아이디"))%></td>
									</tr>
									<tr>
										<td>강사이름</td>
										<td><%=(String)(s.get("강사이름"))%></td>
									</tr>
									<tr>
										<td>강사내용</td>
										<td><%=(String)(s.get("강사내용"))%></td>
									</tr>
									<tr>
										<td>강사과목</td>
										<td><%=(String)(s.get("강사과목"))%></td>
									</tr>
									<tr>
										<td>등록일</td>
										<td><%=(String)(s.get("등록일"))%></td>
									</tr>
									<tr>
										<td>수정일</td>
										<td><%=(String)(s.get("수정일"))%></td>
									</tr>
									<tr>
										<td>
											<a href="<%=request.getContextPath()%>/teacher/modifyTeacher.jsp?teacherNo=<%=(Integer)(s.get("강사번호"))%>">수정</a>
										</td>
										<td>
											<a href="<%=request.getContextPath()%>/teacher/removeTeacher.jsp?teacherNo=<%=(Integer)(s.get("강사번호"))%>">삭제</a>
										</td>
									</tr>
								</table>
								<%
									}
								%>
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
 