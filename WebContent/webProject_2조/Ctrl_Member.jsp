<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.*"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean class="member.MemberDAO" id="memberdao" scope="session"/>
<jsp:useBean class="member.MemberVO" id="memberadd" scope="session"/>
<jsp:setProperty name="memberadd" property="*"/>

<%
	String action = request.getParameter("action");

	if(action.equals("signin")){
			
		boolean result=memberdao.insertDB(memberadd);
		if(result==true){
			System.out.println("회원가입 완료");	
			response.sendRedirect("index.jsp");
		} else{
			System.out.println("회원가입 실패");%>
			<script>
			alert("동일한 id가 존재합니다.")
			history.back();
			</script><%
		}
	}
	else if(action.equals("sign")){
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		MemberVO user = new MemberVO();
		user = memberdao.checkDB(id, pwd);
		session.setAttribute("user", user);
		MemberVO mem = (MemberVO)session.getAttribute("user");
		if(mem.getId() == null){%>
			<script>
				alert("일치하는 id가 없습니다.");
				history.back();
			</script><%
		}else{
			if(mem.getManager()==1){
				response.sendRedirect("adminIndex.jsp");
			}else{
			response.sendRedirect("index.jsp");
			}
		}
	}
	else if(action.equals("logout")){
		session.invalidate();
		response.sendRedirect("index.jsp");
	}
	else if(action.equals("delete")){
		String mem = request.getParameter("member");
		boolean del=memberdao.deleteDB(mem.trim());
		if(del==true){
			System.out.println("회원 삭제 완료");
			response.sendRedirect("adminIndex.jsp");
		} else{
			System.out.println("회원 삭제 실패");
			response.sendRedirect("adminIndex.jsp");
		}
	}
	else if(action.equals("modify")){
		String mod = request.getParameter("id");
		boolean result=memberdao.modifyDB(memberadd, mod.trim());
		if(result==true){
			System.out.println("회원 정보 수정 완료");
			response.sendRedirect("adminIndex.jsp");
		} else{
			System.out.println("회원 정보 수정 실패");
			response.sendRedirect("adminIndex.jsp");
		}
	}
	else if(action.equals("usermodify")){
		String mod = request.getParameter("id");
		boolean result=memberdao.modifyDB(memberadd, mod.trim());
		if(result==true){
			System.out.println("회원 정보 수정 완료");
			response.sendRedirect("myPage.jsp");
		} else{
			System.out.println("회원 정보 수정 실패");
			response.sendRedirect("memberModify_user.jsp");
		}
	}
	else if(action.equals("myModify")){
		String my = request.getParameter("id");
		boolean result=memberdao.myModify(memberadd, my.trim());
		if(result==true){
			System.out.println("마이페이지 정보 수정 완료.");
			response.sendRedirect("myPage.jsp");
		} else{%>
			<script>
				alert("수정에 실패하였습니다.")
				history.back();
			</script><%
			}
	}
	else if(action.equals("todo")){
		String id=request.getParameter("userId");
		String content=request.getParameter("content");
		String date=request.getParameter("date");
		System.out.println(id);
		boolean result=memberdao.setTodoList(id, date, content);
		if(result==true){
			System.out.println("Todo List 입력 완료");
			response.sendRedirect("myPage.jsp");
		}else{%>
			<script>
			alert("등록에 실패하였습니다.")
			history.back();
			</script><%
		}
	}
	else if(action.equals("deletetodo")){
		String id=request.getParameter("id");
		String cont=request.getParameter("content");
		String date=request.getParameter("date");
		System.out.println(id);
		System.out.println(cont);
		System.out.println(date);
		boolean result=memberdao.deleteTodoList(id, date, cont);
		if(result==true){
			System.out.println("Todo List 삭제 완료");
			response.sendRedirect("myPage.jsp");
		}else{%>
			<script>
			alert("삭제에 실패하였습니다.")
			history.back();
			</script><%
		}
	}else if(action.equals("managerApp")){
	      String mod = request.getParameter("member");
	      int result=memberdao.managerApp(mod.trim());
	      if(result != -1){
	         System.out.println("관리자 임명 완료");
	         response.sendRedirect("adminIndex.jsp");
	      } else{
	         System.out.println("관리자 임명 실패");
	         response.sendRedirect("adminIndex.jsp");
	      }
	   }
	   else if(action.equals("managerDis")){
	      String mod = request.getParameter("member");
	      int result = memberdao.managerDis(mod.trim());
	      if(result != -1){
	         System.out.println("관리자 해임 완료");
	         response.sendRedirect("adminIndex.jsp");
	      } else{
	         System.out.println("관리자 해임 실패");
	         response.sendRedirect("adminIndex.jsp");
	      }
	 }
%>