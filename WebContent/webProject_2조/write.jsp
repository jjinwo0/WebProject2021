<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      // 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
      String userID = null;
      MemberVO user=(MemberVO)session.getAttribute("user");
      if(user != null) {
         userID = user.getId();
      }
   %>
   <!-- 헤더 영역 -->
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
              %@ include file="header_login.jsp" %>
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
      <div class= "wrap">
         <form method="post" action="writeAction.jsp">
            <table class="wrap" style="text-align: center; border: 1px solid #dddddd">
               <thead>
                  <tr>
                     <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                     <td><input class="int" type="text"  placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
                  </tr>
                  <tr>
                     <td><textarea placeholder="글 내용" name="bbsContent" maxlength="2048" style=" height: 350px;"></textarea></td>
                  </tr>
               

                  
               </tbody>
               
            </table>
            <!-- 글쓰기 버튼 생성 -->
            <div class="btn" >
               <input type="submit" value="글쓰기" >
            </div>
         
         </form>
      </div>
   </div>
   <!-- 게시판 메인 페이지 영역 끝 -->
   <footer class="footer" style="height: 320px; border-top: gray; background-color: gray; margin-top: 50px;">
        <jsp:include page="footer.jsp"/>
    </footer>
</body>
</html>