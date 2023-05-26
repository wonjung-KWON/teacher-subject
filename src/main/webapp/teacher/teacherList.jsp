<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.*" %>
<%
	int currentPage = 1; 
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage -1) * rowPerPage;
	
	
	//리스트 출
	TeacherDao sd = new TeacherDao();
	ArrayList<HashMap<String,Object>> list = sd.selectTeacherListByPage(beginRow, rowPerPage);
	System.out.println(list+"<-- list");		
	
	
	//페이지****************************************************
	TeacherDao tr = new TeacherDao();
	int totalRow = tr.selectTeacherCnt();
	
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
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>teacherList</title>
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
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="<%=request.getContextPath()%>/teacher/insertTeacher.jsp">강사 추가</a></li>
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
                                    <span class="section-heading-upper">강사 목록</span>
                                </h2>
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
										<th>teacherId</th>
										<th>teacherName</th>
										<th>subjectList</th>
									</tr>
									<%
										for(HashMap<String, Object> s : list){
									%>
										<tr>
											<td><a href="<%=request.getContextPath()%>/teacher/teacherOne.jsp?teacherNo=<%=(Integer)(s.get("강사번호"))%>">
												<%=(String)(s.get("강사아이디"))%></a>
											</td>
											<td><%=(String)(s.get("강사이름"))%></td>
											<td><%=(String)(s.get("과목목록"))%></td>
										</tr>
									<% 
										}
									%>
								</table>
								<div>
									<%
										if(startPage > 5){
									%>
										<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=startPage-1%>">이전</a>
									<% 
										}
										for(int i = startPage; i<=endPage; i++){
									%>
										<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=i%>"><%=i%></a>
									<%
										}
										if(endPage<lastPage){
									%>
										<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=endPage+1%>">다음</a>
									<%
										}
									%>
								</div>
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
 