<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<html>
<head>
<style>

 /* 레이아웃 틀 */
html {
    height: 100%;
}

body {
    margin: 0;
    height: 100%;
    background: #f5f6f7;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}
#logo {
    width: 240px;
    height: 44px;
    cursor: pointer;
}

#header {
    padding-top: 62px;
    padding-bottom: 20px;
    text-align: center;
}
#wrapper {
    position: relative;
    height: 100%;
}

#content {
    position: absolute;
    left: 60%;
    transform: translate(-50%);
    width: 700px;
}
h3 {
    margin: 19px 0 8px;
    font-size: 14px;
    font-weight: 700;
}


.box {
    display: block;
    width: 100%;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px 14px 10px 14px;
    box-sizing: border-box;
    background: #fff;
    position: relative;
}

.input {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
}
#wrap {
    display: table;
    width: 100%;
}
#username {
    display: table-cell;
    width: 147px;
}
#age{
    display: table-cell;
    width: 147px;
}

input {
    font-family: Dotum,'돋움',Helvetica,sans-serif;    
}


/* 에러메세지 */

.error_next_box {
    margin-top: 9px;
    font-size: 12px;
    color: red;    
    display: none;
}

#alertTxt {
    position: absolute;
    top: 19px;
    right: 38px;
    font-size: 12px;
    color: red;
    display: none;
}

/* 버튼 */

.btn_area {
    margin: 30px 0 91px;
}

#btnJoin {
    width: 100%;
    height: 80%;
    padding: 21px 0 17px;
    border: 0;
    cursor: pointer;
    color: #fff;
    background-color: #8B6331;
    font-size: 20px;
    font-weight: 400;
    font-family: fantasy,'돋움',Helvetica,sans-serif;
}

</style>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>

<div id="header">
	<a href="index.jsp"><img src="img/logo.png" width="170"></a>
</div>
<div id="wrapper">
	<div id="content">
	<table><tr><td>
	<form action="Ctrl_Member.jsp" method="post">
	
		<div>	
			<h3 class="join_title">
				<label for="id">아이디</label>
			</h3>
			<span class="box int">
			<input class="input" id="id" type="text" name="id" size="10">
			<span class="error_next_box"></span>
			</span>
		</div>
		<div>	
			<h3 class="join_title">
				<label for="password">비밀번호</label>
			</h3>
			<span class="box int">
			<input class="input" type="password" id="pw" name="pwd" value="" minlength="4" maxlength="12" size="15" pattern="[a-zA-Z0-9]{4,12}" title="4~12자의 영문 대소문자와 숫자로만 입력."required/> <!--patter으로 비밀번호 유효성 검사 minlength와 maxlength로 글자 수 제한--> 
			<span class="error_next_box"></span>
			</span>
		</div>
		<div>	
			<h3 class="join_title">
				<label for="correctPW">비밀번호 확인</label>
			</h3>
			<span class="box int">
			<input class="input" type="password" id="pw_cf" name="password_confirm" onkeyup="check_pw()" value="" maxlength="12" size="15" required><br>
			</span><span id="pw_check_msg" style='color: red; font-size: 12px'></span> 
			<span class="error_next_box"></span>
		</div>
	<div id="wrap">
			<div id="username">
				<h3 class="join_title">
					<label for="username">사용자이름</label>
				</h3>
				<span class="box int">
				<input class="input" id="username" type="text" name="username" size="10">
				<span class="error_next_box"></span>
				</span>
			</div>
			<div id="age">	
				<h3 class="join_title">
					<label for="age">나이</label>
				</h3>
				<span class="box int">
				<input class="input" id="age" type="text" name="age" size="10">
				<span class="error_next_box"></span>
				</span>
			</div>
		</div>
		<div>	
			<h3 class="join_title">
				<label for="place">거주지역</label>
			</h3>
			<span class="box int">
			<input class="input" type="text" id="address" name="place" readonly />
			<span class="error_next_box"></span>
			</span>
		</div>
		<div>	
			<h3 class="join_title">
				<label for="email">e-mail</label>
			</h3>
			<span class="box int">
			<input class="input" id="email" type="text" name="email" size="10">
			<span class="error_next_box"></span>
			</span>
		</div>
		<div>	
			<h3 class="join_title">
				<label for="nickname">닉네임</label>
			</h3>
			<span class="box int">
			<input class="input" id="nickname" type="text" name="nickname" size="10">
			<span class="error_next_box"></span>
			</span>
		</div>
		<div class="btn_area">
			<input id="btnJoin" type="submit" value=" 가입하기 ">
			<input type="hidden" name="action" value="signin">
		</div>
		
			
	</form>
	
</td></tr></table>
	</div>
</div>
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
function check_pw(){  //비밀번호 확인 
    var p = document.getElementById('pw').value; 
    var p_cf = document.getElementById('pw_cf').value; 
 
    if (p!=p_cf) { 
      document.getElementById('pw_check_msg').innerHTML = "비밀번호가 다릅니다. 다시 확인해 주세요."; 
    } 
    else { 
        document.getElementById('pw_check_msg').innerHTML = ""; 
    } 
    if (p_cf=="") { 
      document.getElementById('pw_check_msg').innerHTML = ""; 
    } 
 } 
</script>
</html>