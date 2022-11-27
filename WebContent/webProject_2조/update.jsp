<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
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
        .wrap{
           display: table;
           width: 100%;
           
        }
        .int{
           width: 60%;
        }
         textarea{
            width: 60%;
         }
        .btn{
           display:flex;
            
            justify-content: center;
        }
        header {
            display:flex;
            align-items: center;
            justify-content: center;
            height:50px;
            border-bottom-style: solid;
            border-bottom-width:1px;
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
<title>DOGETHER</title>
</head>
<body>
	<%
		// 세션에 값이 담겨있는지 체크
		String userID = null;
		MemberVO user=(MemberVO)session.getAttribute("user");
		MemberDAO memDao = new MemberDAO();
		MemberVO userData = memDao.checkDB(user.getId(), user.getPwd());
		if(user != null) {
			userID = user.getId();
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='sign.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='bbs1.jsp'");
			script.println("</script>");
		}
		// 해당 'bbsID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		System.out.println(userData.getId().equals(bbs.getId()));
		if((userData.getManager()==1) || userData.getId().equals(bbs.getId())){
			

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
            <li><a href="weather.jsp">산책지수</a></li>
        </ul>
    </nav>
	<!-- 게시판 글 수정 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
				<table class="wrap" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="int" placeholder="글 제목" name="bbsTitle" maxlength="50"
								value="<%=bbs.getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048"
								style="height: 350px;"><%= bbs.getBbsContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>
	<%}else if(!userID.equals(bbs.getId())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='bbs1.jsp'");
			script.println("</script>");
		} %>
	<!-- 게시판 글 수정 양식 영역 끝 -->
	<footer class="footer" style="height: 320px; border-top: gray; background-color: gray; margin-top: 50px;">
		<jsp:include page="footer.jsp"/>
    </footer>
</body>
</html>