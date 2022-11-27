<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="memberdao" class="member.MemberDAO" scope="session" />
<jsp:useBean id="membervo" class="member.MemberVO" scope="session" />
<jsp:setProperty name="memberdao" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
@import url(http://fonts.googleapis.com/css?family=Roboto:400,100);

.login-card {
  padding: 40px;
  width: 274px;
  background-color: #F7F7F7;
  margin: 0 auto 10px;
  border-radius: 2px;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  overflow: hidden;
}

.login-card h1 {
  font-weight: 100;
  text-align: center;
  font-size: 2.3em;
}

.login-card input[type=submit] {
  width: 100%;
  display: block;
  margin-bottom: 10px;
  position: relative;
}

.login-card input[type=text], input[type=password] {
  height: 44px;
  font-size: 16px;
  width: 100%;
  margin-bottom: 10px;
  -webkit-appearance: none;
  background: #fff;
  border: 1px solid #d9d9d9;
  border-top: 1px solid #c0c0c0;
  /* border-radius: 2px; */
  padding: 0 8px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
}

.login-card input[type=text]:hover, input[type=password]:hover {
  border: 1px solid #b9b9b9;
  border-top: 1px solid #a0a0a0;
  -moz-box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
  -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
  box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
}

.login {
  text-align: center;
  font-size: 14px;
  font-family: 'Arial', sans-serif;
  font-weight: 700;
  height: 36px;
  padding: 0 8px;
/* border-radius: 3px; */
/* -webkit-user-select: none;
  user-select: none; */
}

.login-submit {
  /* border: 1px solid #3079ed; */
  border: 0px;
  color: #fff;
  text-shadow: 0 1px rgba(0,0,0,0.1); 
  background-color: #4d90fe;
  /* background-image: -webkit-gradient(linear, 0 0, 0 100%,   from(#4d90fe), to(#4787ed)); */
}

.login-submit:hover {
  /* border: 1px solid #2f5bb7; */
  border: 0px;
  text-shadow: 0 1px rgba(0,0,0,0.3);
  background-color: #357ae8;
  /* background-image: -webkit-gradient(linear, 0 0, 0 100%,   from(#4d90fe), to(#357ae8)); */
}

.login-card a {
  text-decoration: none;
  color: #666;
  font-weight: 400;
  text-align: center;
  display: inline-block;
  opacity: 0.6;
  transition: opacity ease 0.5s;
}

.login-card a:hover {
  opacity: 1;
}

.login-help {
  width: 100%;
  text-align: center;
  font-size: 12px;
}
.find {
	margin-left:30px;
}
</style>
</head>
<%
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	
	MemberVO foundPW = new MemberVO();
	foundPW = memberdao.findPW(name, id, email);
	
	try {
%>
	
<body>
	<div class="login-card">
		<%
			if (foundPW.getPwd() != null) {
		%>	
				<%= name %>님의 비밀번호는 <b><%= foundPW.getPwd() %></b>입니다.<p>
			<form method="post" action="sign.jsp">
				<input type="submit" class="login login-submit" value="로그인 페이지로 이동">
			</form>
			<form method="post" action="index.jsp">
				<input type="submit" class="login login-submit" value="메인 페이지로 이동">
			</form>
		<%	
			} else {
		%>
				이름 또는 아이디 또는 이메일 주소가 틀렸습니다.<p>
				<a href="findPW.jsp"><input type="button" class="login login-submit" value="다시 입력하기"></a>
		<%
			}
		%>	
		<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	    <script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
	</div>
</body>
	<%
		} catch(Exception e) {
			e.printStackTrace();
		}
	%>
</html>