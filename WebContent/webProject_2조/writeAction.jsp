<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.*"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%		/*
			// 해당 폴더에 이미지를 저장시킨다
		 	String directory = application.getRealPath("/upload");
		 	
		 	//  총 100M 까지 저장 가능하게 함
		 	int maxSize = 1024 * 1024 * 100;
		 	String encoding ="UTF-8";
		 	
		 	// 사용자가 전송한 파일정보 토대로 업로드 장소에 파일 업로드 수행할 수 있게 함
			MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
			// 중복된 파일이름이 있기에 fileRealName이 실제로 서버에 저장된 경로이자 파일
            // fileName은 사용자가 올린 파일의 이름이다
			// 실제 서버에 업로드 된 파일시스템 네임
			//String fileName = multipartRequest.getOriginalFileName("image");
			String fileRealName = multipartRequest.getFilesystemName("image");
			*/
			// 현재 세션 상태를 체크한다
			String userID = null;
			MemberVO user=(MemberVO)session.getAttribute("user");
			if(user != null) {
				userID = user.getId();
			}
			// 로그인 했는지 확인
			if(userID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요')");
				script.println("location.href='sign.jsp'");
				script.println("</script>");
			} else{
				// 입력이 안 된 부분이 있는지 체크한다
				if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
					// 데이터베이스 오류인 경우
					if (result==-1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다')");
						script.println("history.back()");
						script.println("</script>");
						// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기 성공')");
						script.println("location.href='bbs1.jsp'");
						script.println("</script>");
					}
				}
			}
	
		
	%>
</body>
</html>