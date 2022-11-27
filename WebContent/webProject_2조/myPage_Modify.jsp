<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.*"%>
    
<%
	MemberDAO member = new MemberDAO();
	MemberVO loginUser = (MemberVO)session.getAttribute("user");
	MemberVO usr = member.checkDB(loginUser.getId(), loginUser.getPwd());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Page Title</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <h1>마이페이지</h1>
        <style type="text/css">
            /* 헤더 */
            header {
                text-align: 20%;
                margin-top: 75px;
                margin-bottom: 25px;
                background-color: blanchedalmond;
            }

            header .thumb {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                box-shadow: 0 6px 12px 0 rgba(0, 0, 0, 0.1),
                0 12px 24px 0 rgba(0, 0, 0, 0.24);
            }

            header .thumb-wrapper {
                position: relative;
                display: inline-block;
                margin-bottom: 36px;
            }


            header .greeting {
                margin-bottom: 10px;
            }

            header .mail {
                padding: 8px 22px 10px 22px;
                background-color: rgba(0, 0, 0, 0.05);
                display: inline-block;
                border-radius: 20px;
                box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.08);
                margin-top: 18px;
            }
            
            /* 리스트 */
            .list {
                margin-top: 48px;
            }

            .list .item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid rgba(0, 0, 0, 0.08);
                font-size: 15px;
            }

            .list .item .left {
                display: flex;
                align-items: center;
            }

            .list .item .left .name {
                margin-left: 6px;
                font-family: "Malgun Gothic";
                font-weight: bold; 
                margin-right:20px;
            }

            .list .item .right {
                opacity: 0.5;
            }

            .list .item img {
                padding: 20px 22px;
            }

            .list .item .right img {
                padding-right: 14px;
            }

        </style>
    </head>
    <body>
        <form action="Ctrl_Member.jsp" method="post">
        <header>
        
        <div class="thumb-wrapper stagger-item">
            <a><img class="thumb" src="img/dog.png"></a>
            <input type="file" accept="image/*" name="Photo">

        </div>

        <div class="text-area">
            <h2 class="greeting stagger-item"> <%=usr.getUsername() %></h2>
            <div class="desc stagger-item">
               <input type="text" size="100" name="introduce" value="<%=usr.getIntroduce() %>">
            </div>
        </div>

        <div class="mail mouse-effect stagger-item">
            <a> <%=usr.getEmail() %></a>  
        </div>
        </header>

        
           <input type="submit" value="수정완료" id="finish">
           <input type="hidden" name="action" value="myModify">
           <input type="hidden" name="id" value=<%=usr.getId() %>>



    <ul class="list">
        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/id.png" width="50px"/>
                <div class="name">닉네임</div>
                    <%=usr.getNickname() %>

            </div>
         <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/id.png" width="50px"/>
                <div class="name">사용자 이름</div>
                    <%=usr.getUsername() %>

            </div>
            <div class="right"></div>
        </li>

        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/dog.png" width="50px"/>
            <div class="name">반려동물 이름</div>
               <input type="text" name="dogname" size="10" value="<%=usr.getDogname() %>">
            </div>
            <div class="right"></div>
        </li>

        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/cake.png"width="50px" />
                <div class="name">반려동물 생년원일</div>
                <input type="date" name="dogdate" value="<%=usr.getDogdate() %>">
            </div>
        </li>

        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/dog-collar.png" width="50px"/>
                <div class="name">견종</div>
                <input type="text" name="dogbreed" size="10" value="<%=usr.getDogbreed() %>">
            </div>
        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/location.png" width="50px"/>
                <div class="name">지역</div>
                <%=loginUser.getPlace() %>

            </div>
        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/message.png" width="50px"/>
                <div class="name">전화번호</div>
                <input id="Tel" name="tel" type="tel"
                   placeholder="010-1234-5678" value="<%=usr.getTel() %>">
            </div>  
        <li class="item mouse-effect stagger-item">
                <div class="left">
                    <img src="img/instagram.png" width="50px"/>
                    <div class="name">인스타그램 아이디</div>
                    <input type="text" name="instagram" size="10" value="<%=usr.getInstagram() %>">
                </div> 
         </li>
    </ul>
    </form>
    </body>
</html>