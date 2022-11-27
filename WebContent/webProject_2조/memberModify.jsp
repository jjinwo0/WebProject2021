<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.*"%>
<%
	String userId = request.getParameter("member");
	MemberVO loginUser = (MemberVO)session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<style>
	table{
		border-style: solid;
	}
</style>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
<form action="Ctrl_Member.jsp" method="post">
<table>
	<tr>
		<td>Password</td>
		<td><input type="password" name="pwd" size="10" value=<%=loginUser.getPwd() %>></td>
	</tr>
	<tr>
		<td>Password 확인</td>
		<td><input type="password" name="correctPW" size="10"></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="text" name="username" size="10" value=<%=loginUser.getUsername() %>></td>
	</tr>
	<tr>
		<td>나이</td>
		<td><input type="text" name="age" size="10" value=<%=loginUser.getAge() %>></td>
	</tr>
	<tr>
		<td>거주지역</td>
		<td><input type="text" id="address" name="place"  value=<%=loginUser.getPlace() %> readonly /></td>
	</tr>
	<tr>
		<td>e-mail</td>
		<td><input type="text" name="email" size="10" value=<%=loginUser.getEmail() %>></td>
	</tr>
	<tr>
		<td>닉네임</td>
		<td><input type="text" name="nickname" size="10" value=<%=loginUser.getNickname() %>></td>
	</tr>
	<tr>
		<td><input type="submit" value=" MODIFY "></td>
		<td><input type="hidden" name="action" value="modify"></td>
		<td><input type="hidden" name="id" value=<%=userId %>></td>
	</tr>
</table>
</form>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생.
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address").value = data.address; // 주소 넣기
                document.querySelector("input[name=place]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
</html>