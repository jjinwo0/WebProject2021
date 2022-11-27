<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.*"%>
<%@ page import="java.util.*" %>
    
<%
	MemberDAO member = new MemberDAO();
	MemberVO loginUser = (MemberVO)session.getAttribute("user");
	MemberVO usr = member.checkDB(loginUser.getId(), loginUser.getPwd());
	ArrayList<TodoVO> TodoList=new ArrayList<TodoVO>();
	String id=loginUser.getId();
	TodoList=member.selectTodoDB(id);
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
            .form_list {
               display: flex;
               justify-content: space-between;
               margin-left: 30%;
               margin-right: 30%;
            }
         .header_list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
         }
         .header{
          margin-right:10%;
         }
         .header > ul > li{
          margin-right:30px;
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
        <header>
         <div class = header_list> 
         <div class = header>
           <div class="thumb-wrapper stagger-item">
               <a><img class="thumb" src="img/dog.png"></a>
   
           </div>
   
           <div class="text-area">
               <h2 class="greeting stagger-item"> <%=usr.getUsername() %></h2>
               <div class="desc stagger-item">
               <%=usr.getIntroduce() %>
               </div>
           </div>
   
           <div class="mail mouse-effect stagger-item">
               <a> <%=usr.getEmail() %></a>  
           </div>
        </div>
        <div class = header>
      
            <form action="Ctrl_Member.jsp" method="get">
            <div class="container">
               <div id="myDIV" class="header">
                 <input type="text" name="content" placeholder="Input your task...">
                 <br>   
                  <input type="date" name="date"><input type="submit" value="추가" class="addBtn">
                 <input type="hidden" name="action" value="todo">
                 <input type="hidden" name="userId" value="<%= id%>">
               </div>
            </div>
            </form>
               <ul> 
                   <%for(TodoVO todo : TodoList){
                  if(loginUser.getId().equals(todo.getId())){%>
                  <li style="list-style: none; margin-left:-40px;">
                     <div class="selected">
                     <input type="checkbox" id="check">
                     <label id="cont" for="check"><%=todo.getContent() %></label>
                     <label id="dat" for="check"><%=todo.getDate() %></label>
                     <button onclick="deleteTodo('<%=todo.getId()%>', '<%=todo.getContent()%>', '<%=todo.getDate()%>')">삭제</button>
                     </div>
                  </li>      
                  <%}
               }%> 
               </ul>
            <script>
            function deleteTodo(id, content, date){
               location.href="Ctrl_Member.jsp?action=deletetodo&id="+id+"&date="+date+"&content="+content;
            }
            $(document).ready(function(){
               $("input:checkbox").on('click', function(){
                  if($(this).prop('checked')){
                     $(this).parent().addClass("selected");
                  }else{
                     $(this).parent().removeClass("selected");
                  }
               });
            });
            </script>

        </div>
        </div>
        </header>
   <div class=form_list>
      <form action="memberModify_user.jsp">
           <input type="submit" value="개인정보 수정">
        </form>
        <form action="myPage_Modify.jsp">
           <input type="submit" value="마이페이지 수정">
        </form>
        <%if(usr.getManager()==0){ %>
        <form action="index.jsp">
           <input type="submit" value="홈으로">
        </form>
            <%}else{ %>
        <form action="adminIndex.jsp">
           <input type="submit" value="홈으로">
        </form>
            <%} %>
       </div>
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
            <%=usr.getDogname() %>
            </div>
            <div class="right"></div>
        </li>

        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/cake.png"width="50px" />
                <div class="name">반려동물 생년월일</div>
              <%=usr.getDogdate() %>
            </div>
            <div class="right"></div>
        </li>

        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/dog-collar.png" width="50px"/>
                <div class="name">견종</div>
                <%=usr.getDogbreed() %>
            </div>
        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/location.png" width="50px"/>
                <div class="name">지역</div>
                <%=usr.getPlace() %>

            </div>
        <li class="item mouse-effect stagger-item">
            <div class="left">
                <img src="img/message.png" width="50px"/>
                <div class="name">전화번호</div>
                <%=usr.getTel() %>
            </div>  
        <li class="item mouse-effect stagger-item">
                <div class="left">
                    <img src="img/instagram.png" width="50px"/>
                    <div class="name">인스타그램 아이디</div>
                    <%=usr.getInstagram() %>
                </div>  
        <div class="todo">
            

        </div>
      </li>
    </ul>

    </body>
</html>