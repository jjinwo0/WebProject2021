<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.*"%>
    
<%
	MemberVO loginUser = (MemberVO)session.getAttribute("user");
%>
<div class="header_right">
	<ul>
        <li><%=loginUser.getUsername() %> 님</li>
	    <li><a href="Ctrl_Member.jsp?action=logout">Logout</a></li>
        <li><a href="myPage.jsp">My Page</a></li>
    </ul>
</div>