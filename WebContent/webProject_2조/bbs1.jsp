<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<title>DOGETHER</title>
<style>
        * {
            font-family: 'Jua', sans-serif;
        }
        html{
            overflow-y: scroll;
        }
        body {
            margin:0px;
        }
        header {
            display:flex;
            align-items: center;
            justify-content: center;
            height:50px;
            margin-left: 50px;
        }

        .header_left {
            display: flex;
            width:30%;
            padding-left:10px;
            justify-content: center;
        }
        .header_middle {
            display:flex;
            justify-content: center;
            width:50%;
        }
        .header_right {
            width:20%;
            margin-right: 5%;
            align-items:center;
            justify-content: center;
        }

        .header_right > ul {
            margin:0px;
            padding:0px;
            display:flex;
            justify-content: center;
        }

        .header_right > ul > li {
            list-style: none;
            margin-left:10px;
            margin-right:10px;
        }
        .header_right > ul > li:hover {
            text-decoration: underline;
            text-decoration-style: wavy;
            border-bottom: 15px;
            text-decoration-color: rgb(245,186,59);
        }
        nav {
            height:60px;
            border-bottom-style:solid;
            border-bottom-width:1px;
            border-top-style: solid;
            border-top-width:1px;
        }

        nav > ul {
            margin:0px;
            padding:0px;
            height: 100%;
            display:flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-left:200px;
            margin-right:200px;
        }
        nav > ul > li {
            list-style: none;
        }
        nav > ul > li:hover {
            text-decoration: underline;
            text-decoration-style: wavy;
            border-bottom: 15px;
            text-decoration-color: rgb(245,186,59);
        }
        table.table1{
            width: 100%;
            margin: auto;
        }
        .table1 > thead > tr > th{
            background-color: rgb(218, 143, 45);
		    text-align: center;
        }
        .table1 > tbody > tr{
            border-bottom: 1px solid #e5e5e5;
		    text-align: center;
        }
        
        .table1 > tbody > tr:hover{
            background-color: rgb(245,186,59);
        }
        .table1 > tfoot > tr{
            display:flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        footer{
            text-align: center;
            align-items: center;
        }
        footer > div > ul {
            margin:0px;
            padding:0px;
            height: 100%;
            display:flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-left:200px;
            margin-right:200px;
        }
        footer > div > ul > li {
            list-style: none;
        }
        footer > div > ul > li:hover {
            text-decoration: underline;
            text-decoration-style: wavy;
            border-bottom: 15px;
            text-decoration-color: rgb(245,186,59);
        }
</style>
</head>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		MemberVO user=(MemberVO)session.getAttribute("user");
		if(user != null) {
			userID = user.getId();
		}
		int pageNumber = 1;
		// 만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면
		// 'int'타입으로 캐스팅을 해주고 그 값을 'pageNubmer'변수에 저장한다
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
		<header>
	        <div class="header_left">
        <%if(user == null || user.getManager()==0){ %>
            <a href="index.jsp"><img src="img/dogether.PNG"></a>
            <%}else{ %>
            <a href="adminIndex.jsp"><img src="img/dogether.PNG"></a>
            <%} %>
	        </div>
	        <div class="header_middle">
	            <form>
	                <input type="search" style="border-color: rgb(245,186,59);">
	                <input type="submit" value="검색" style="background-color: rgb(245,186,59); border-radius: 10px;">
	            </form>
	        </div>
	        <%
	           if(user != null){ %>
	        	<%@ include file="header_login.jsp" %>
	        <% } else{%>
	        <%@ include file="header.jsp" %>
	        <% } %>
	    </header>
	    <nav>
        <ul>
            <li><a href="bbs1.jsp">도지스토리</a></li>
            <li><a href="map1.jsp">병원찾기</a></li>
            <li><a href="weather.jsp">기상정보</a></li>
        </ul>
    </nav>
	<!-- 게시판 메인 페이지 영역 시작 -->
	
	<div>
		<div>
			<table class="table1" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="text-align: center;">번호</th>
						<th style="text-align: center;">제목</th>
						<th style="text-align: center;">작성자</th>
						<th style="text-align: center;">작성일</th>
						<th style="text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<!-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 -->
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>">
							<%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getId() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
							+ list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
						<td><%= list.get(i).getBbsView() %></td>
						
					</tr>
					<%
						}
					%>
				</tbody>
				<tfoot>
					<tr>
					<td><%
						if(pageNumber != 1) {
					%>
						<a href="bbs1.jsp?pageNumber=<%=pageNumber - 1 %>">이전</a>
					<%
						} %></td>
					<td><a href="write.jsp">글쓰기</a></td>
					<td>
					<%if(bbsDAO.nextPage(pageNumber + 1)) {
					%>
						<a href="bbs1.jsp?pageNumber=<%=pageNumber + 1 %>">다음</a>
					<%
						}
					%>
					</td></tr>
				</tfoot>
			</table>
			
			<!-- 글쓰기 버튼 생성 -->
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
	<footer class="footer" style="height: 320px; border-top: gray; background-color: gray; margin-top: 50px;">
		<jsp:include page="footer.jsp"/>
    </footer>
</body>
</html>