<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.*"%>
<%@ page import="bbs.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
    <title>Dogether</title>
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
		    text-align: center;
        }
        .table1 > tbody > tr{
            border-bottom: 1px solid #e5e5e5;
		    text-align: center;
        }
        
        .table1 > tbody > tr:hover{
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

        @media screen and (max-width: 600px) {
        .header_right > ul > li {
            font-size:11px;
        }

        form {
            width:100%;
            display:flex;
        }
        form > input[type="submit"]{
            width:20%;
        }
        form > input[type="search"]{
            width:80%;
        }
    }
        
    </style>
</head>
<body>
<%
MemberVO user=(MemberVO)session.getAttribute("user");
BbsDAO bbsDao = new BbsDAO();
ArrayList<Bbs> bbs = bbsDao.allList();
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
            <form method="get" action="http://www.google.co.kr/search" target="_blank">
                <input type="text" style="border-color: rgb(245,186,59);">
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
    <br><br>
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
                <col style="width: 20%;">
                <col style="width: 30%;">
                <col style="width: 30%;">
                <col style="width: 20%;">
            </colgroup>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
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
                </tr>
                <%} %>
            </tbody>
        </table>
        <br>
    </section>
    <section>
        <table class="table_t">
            <thead>
                <tr>
                    <td style="text-align: center; margin-bottom: -40px;"><h2>오늘의 날씨</h2></td>
                </tr>
            </thead>
        </table>
    	<jsp:include page="weatherOnly.jsp" flush="false"/>
    </section>
    <footer class="footer" style="height: 320px; border-top: gray; background-color: gray; margin-top: 50px;">
        <%@ include file="footer.jsp" %>
    </footer>

</body>
</html>