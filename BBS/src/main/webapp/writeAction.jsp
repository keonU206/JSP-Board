<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty property="bbsTitle" name="bbs"/>
<jsp:setProperty property="bbsContent" name="bbs"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인 후 이용하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else {
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null ){
					script.println("<script>");
					script.println("alert('올바른 회원정보를 입력하세요')");
					script.println("location.href = 'join.jsp'");
					script.println("</script>");
				}else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
					if(result == -1){
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("location.href = 'write.jsp'");
						script.println("</script>");
					}else{
						script.println("<script>");
						script.println("alert('글을 작성하였습니다.')");
						script.println("location.href = 'board.jsp'");
						script.println("</script>");
					}
				}
		}
	%>
</body>
</html>