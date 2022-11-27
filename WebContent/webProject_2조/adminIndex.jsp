<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="member.*" %>
<%@ page import="bbs.*" %>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<style type="text/css">
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
        table.table_t{
            width: 70%;
            margin: auto;
            margin-bottom: -px;
        }
		table{
			width: 100%;
		    border-collapse: collapse;
		    line-height: 15px;
		}
		table > thead > td,th {
		    border-top:1px solid black;
		    border-bottom:1px solid black;
		    border-collapse: collapse;
		    text-align: center;
		    padding: 10px;
	        background-color: rgb(218, 143, 45);
		}
		table > tbody > tr{
		    border-collapse: collapse;
		    text-align: center;
		    padding: 10px;
	        border-bottom: 1px solid #e5e5e5;
		}
	    table > tbody > tr:hover{
	        background-color: rgb(245,186,59);    	
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
<head>
<%
	ArrayList<MemberVO> MemberList=new ArrayList<MemberVO>();
	MemberDAO memberDao=new MemberDAO();
	MemberList=memberDao.selectUserDB();
	String search = request.getParameter("search");
    BbsDAO bbsDao = new BbsDAO();
    ArrayList<Bbs> bbs = bbsDao.allList();
%>
<meta charset="UTF-8">
<title>admin</title>
</head>
<body>
<%MemberVO user=(MemberVO)session.getAttribute("user"); %>
    <header>
        <div class="header_left">
	    <%if(user.getManager()==1) {%>
            <a href="adminIndex.jsp"><img src="img/dogether.PNG"></a>
        <%}else { %>
            <a href="index.jsp"><img src="img/dogether.PNG"></a>
        <%} %>
        </div>
        <div class="header_middle">
            <form>
                <input type="search" style="border-color: rgb(245,186,59);">
                <input type="submit" value="검색" style="background-color: rgb(245,186,59); border-radius: 10px;">
            </form>
        </div>
        <% if(user != null){ %>
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
    <br><br>
<div id="wrap">
	<div id="src">
		<form action="adminIndex.jsp" method="post">
			<input type="text" name="search" style="width:300px">
			<input type="submit" value="검색"  style="background-color: rgb(245,186,59); border-radius: 10px;">
		</form>
	</div><br>
	<div>
		<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>Password</th>
				<th>Username</th>
				<th>Age</th>
				<th>Place</th>
				<th>Email</th>
				<th>Nickname</th>
				<th>Manager</th>
	            <th>Modify and delete</th>
			</tr>
		</thead>
		<tbody>
		<%  for(MemberVO member : MemberList){
				if(request.getParameter("search")==null){%>
					<tr>
						<td><%=member.getId() %></td>
						<td><%=member.getPwd() %></td>
						<td><%=member.getUsername() %></td>
						<td><%=member.getAge() %></td>
						<td><%=member.getPlace() %></td>
						<td><%=member.getEmail() %></td>
						<td><%=member.getNickname() %></td>
						<%if(member.getManager() == 1){ %>
							<td>Manager</td>
						<%}else{ %>
							<td>Normal User</td>
						<%} %>
						<td>
							<button onclick="modifyMember('+<%=member.getId()%>+');">수정</button>
							<button onclick="deleteMember('+<%=member.getId()%>+');">삭제</button>
							<button onclick="managerApp('+<%=member.getId()%>+');">관리자임명</button>
                     		<button onclick="managerDis('+<%=member.getId()%>+');">관리자해임</button>
						</td>
					</tr>
					<%} else if(request.getParameter("search").equals(member.getId())){%>
						<tr>
							<td><%=member.getId() %></td>
							<td><%=member.getPwd() %></td>
							<td><%=member.getUsername() %></td>
							<td><%=member.getAge() %></td>
							<td><%=member.getPlace() %></td>
							<td><%=member.getEmail() %></td>
							<td><%=member.getNickname() %></td>
							<%if(member.getManager() == 1){ %>
								<td>Manager</td>
							<%}else{ %>
								<td>Normal User</td>
							<%} %>
							<td>
								<button onclick="modifyMember('+<%=member.getId()%>+');">수정</button>
								<button onclick="deleteMember('+<%=member.getId()%>+');">삭제</button>
								<button onclick="managerApp('+<%=member.getId()%>+');">관리자임명</button>
	                     		<button onclick="managerDis('+<%=member.getId()%>+');">관리자해임</button>
							</td>
						</tr>
				<%}else if(request.getParameter("search").equals(member.getUsername())){ %>
					<tr>
						<td><%=member.getId() %></td>
						<td><%=member.getPwd() %></td>
						<td><%=member.getUsername() %></td>
						<td><%=member.getAge() %></td>
						<td><%=member.getPlace() %></td>
						<td><%=member.getEmail() %></td>
						<td><%=member.getNickname() %></td>
						<%if(member.getManager() == 1){ %>
							<td>Manager</td>
						<%}else{ %>
							<td>Normal User</td>
						<%} %>
						<td>
							<button onclick="modifyMember('+<%=member.getId()%>+');">수정</button>
							<button onclick="deleteMember('+<%=member.getId()%>+');">삭제</button>
							<button onclick="managerApp('+<%=member.getId()%>+');">관리자임명</button>
                     		<button onclick="managerDis('+<%=member.getId()%>+');">관리자해임</button>
						</td>
					</tr>
				<%} else if(request.getParameter("search").equals("")){ %>
					<tr>
						<td><%=member.getId() %></td>
						<td><%=member.getPwd() %></td>
						<td><%=member.getUsername() %></td>
						<td><%=member.getAge() %></td>
						<td><%=member.getPlace() %></td>
						<td><%=member.getEmail() %></td>
						<td><%=member.getNickname() %></td>
						<%if(member.getManager() == 1){ %>
							<td>Manager</td>
						<%}else{ %>
							<td>Normal User</td>
						<%} %>
						<td>
							<button onclick="modifyMember('+<%=member.getId()%>+');">수정</button>
							<button onclick="deleteMember('+<%=member.getId()%>+');">삭제</button>
							<button onclick="managerApp('+<%=member.getId()%>+');">관리자임명</button>
                     		<button onclick="managerDis('+<%=member.getId()%>+');">관리자해임</button>
						</td>
					</tr>
				<%} 
			} %></tbody>
		</table>
	</div>
</div>
    <section>
        <table class="table_t">
            <thead>
                <tr>
                    <td style="text-align: center;"><h3>도지스토리 인기글</h3></td>
                </tr>
            </thead>
        </table>
        <table class="table1">
            <colgroup>
                <col style="width: 10%;">
                <col style="width: 30%;">
                <col style="width: 30%;">
                <col style="width: 10%;">
                <col style="width: 20%;">
            </colgroup>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>수정/삭제</th>
                </tr>
            </thead>
            <tbody>
            <%
            	for(int i=0; i<bbs.size(); i++){%>
                <tr>
                    <td class="number" style="text-align: center;"><%= (i+1) %></td>
                    <td class="title"><a href="view.jsp?bbsID=<%= bbs.get(i).getBbsID() %>">
							<%= bbs.get(i).getBbsTitle()%></a></td>
                    <td class="name" style="text-align: center;"><%= bbs.get(i).getId()%></td>
                    <td class="view" style="text-align: center;"><%= bbs.get(i).getBbsView()%></td>
                    <td>
							<button onclick="modifyBbs('+<%=bbs.get(i).getBbsID()%>+');">수정</button>
							<button onclick="deleteBbs('+<%=bbs.get(i).getBbsID()%>+');">삭제</button>
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
        <br>
    </section>    
<footer class="footer" style="height: 320px; border-top: gray; background-color: gray; margin-top: 50px;">
        <%@ include file="footer.jsp" %>
</footer>
<script>
	function modifyMember(id){
		location.href="memberModify.jsp?member="+id;
	}
	function deleteMember(id){
		location.href="Ctrl_Member.jsp?action=delete&member="+id;
	}function managerApp(id){
	    location.href="Ctrl_Member.jsp?action=managerApp&member="+id;
	}
	function managerDis(id){
	    location.href="Ctrl_Member.jsp?action=managerDis&member="+id;
	    console.log(id);
	}
	function modifyBbs(id){
		location.href="update.jsp?bbsID="+parseInt(id);
	}
	function deleteBbs(id){
		location.href="deleteAction.jsp?bbsID="+parseInt(id);
	}
</script>
</body>
</html>