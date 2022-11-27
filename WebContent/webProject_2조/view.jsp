<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="member.*" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
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
        table.table_t{
            width: 70%;
            margin: auto;
            margin-bottom: -px;
        }
        table.table1{
            width: 70%;
            margin: auto;
        }
        .table1 > thead > tr > th{
            background-color: rgb(218, 143, 45);
        }
        .table1 > tbody > tr{
            border-bottom: 1px solid #e5e5e5;
        }
        .comment_input {
           width: 1000px;
        }
        .table_comment{
           text-align: center; 
           display: flex;
           align-items: center;
           justify-content:center;
           width: 100%;
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
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href='sign.jsp'");
			script.println("</script>");
		}
		
		int boardID=0;
		if (request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
		// bbsID를 초기화 시키고
		// 'bbsID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		// 만약 넘어온 데이터가 없다면
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='bbs1.jsp'");
			script.println("</script>");
		}
		
		// 유효한 글이라면 구체적인 정보를 'bbs'라는 인스턴스에 담는다
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		Comment comment = new CommentDAO().getComment(bbsID);
		
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
	<!-- 게시판 글 보기 양식 영역 시작 -->
	
	<div>
		<div>
			<table class="table1" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;")
								.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getId() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
							+ bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>조회수</td>
						<td><%= bbs.getBbsView() + 1 %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height:200px; text-align:left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;")
						.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %><br><br>
					</tr>
				</tbody>
			</table>
			<div>
				<div>
					<table style="text-align: center; border: 1px solid #dddddd; width: 100%;">
						<thead>
							<tr><td>댓글</td></tr>
						</thead>
						<tbody>
							<tr>
								<%
									CommentDAO commentDAO = new CommentDAO();
									ArrayList<Comment> list = commentDAO.getList(boardID, bbsID);
									MemberDAO memDao = new MemberDAO();
									MemberVO userData=memDao.checkDB(user.getId(), user.getPwd());
									for(int i=0; i<list.size(); i++) {
								%>
								<div>
			 						<div>
										<table style="text-align: center; border: 1px solid #dddddd; margin-left: auto; margin-right: auto;">
											<tbody style="align-items: center;">
												<tr>						
													<td align="left"><%= list.get(i).getUserID() %>&nbsp;&nbsp;&nbsp;<%= list.get(i).getCommentText() %>&nbsp;&nbsp;&nbsp;<%= list.get(i).getCommentDate().substring(0,11) + list.get(i).getCommentDate().substring(11,13) + "시" + list.get(i).getCommentDate().substring(14,16) + "분" %></td>		
													<td colspan="2"></td>
													<td align="right">
														<%
															if(list.get(i).getUserID() != null && list.get(i).getUserID().equals(userID)){
														%>
														<form name = "p_search">
															<a type="button" onclick="nwindow(<%=bbsID %>,<%=list.get(i).getCommentID()%>)" class="btn-primary">수정</a>
														</form>
														<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "commentDeleteAction.jsp?bbsID=<%=bbsID %>&commentID=<%= list.get(i).getCommentID() %>" class="btn-primary">삭제</a>						
														<%
															} else if (list.get(i).getUserID() != null && (userData.getManager()==1)) {
														%>
															<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "commentDeleteAction.jsp?bbsID=<%=bbsID %>&commentID=<%= list.get(i).getCommentID() %>" class="btn-primary">삭제</a>
														<%		
															}
														%>	
													</td>
												</tr>
											</tbody>
										</table>			
									</div>
								</div>
								<%
									}
								%>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div>
				<div>
					<form method="post" action="commentAction.jsp?bbsID=<%= bbsID %>">
                     <table class= "table_comment" >
                     <tbody style="border: 1px solid #dddddd;">
                        <tr >
                           <td><input class="comment_input" type="text" style="height:100px;" name = "commentText"></td>
                           <td><br><br><input type="submit" value="댓글 작성"></td>
                        </tr>
                        </tbody>
                     </table>
               </form>
				</div>
			</div>
		</div>
	</div>
	<div>
			<a href="bbs1.jsp">목록</a>
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<%
				if(userID != null && userID.equals(bbs.getId())) {
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href=
						"deleteAction.jsp?bbsID=<%= bbsID %>">삭제</a>
			<%
				} else if(userID != null && (userData.getManager()==1)) {
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href=
						"deleteAction.jsp?bbsID=<%= bbsID %>">삭제</a>
			<%		
				}
			%>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
	<footer class="footer" style="height: 320px; border-top: gray; background-color: gray; margin-top: 50px;">
		<%@ include file="footer.jsp" %> 
    </footer>
    <script type="text/javascript">
	function nwindow(bbsID,commentID){
		window.name = "commentParant";
		var url= "commentUpdate.jsp?bbsID="+bbsID+"&commentID="+commentID;
		window.open(url,"","width=600,height=230,left=300");
	}
	</script>
</body>
</html>