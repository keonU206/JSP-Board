<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userPW" name="user"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		int loginResult = userDAO.login(request.getParameter("userID"), request.getParameter("userPW"));
		PrintWriter script = response.getWriter();
		
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID != null){
			script.println("<script>");
			script.println("alert('이미 로그인 되었습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if(loginResult == 1){
			session.setAttribute("userID", user.getUserID());
			script.println("<script>");
			script.println("alert('로그인 성공')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}else if(loginResult == 0){
			script.println("<script>");
			script.println("alert('비밀번호 오류')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else if(loginResult == -1){
			script.println("<script>");
			script.println("alert('아이디 오류')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else if(loginResult == -2){
			script.println("<script>");
			script.println("alert('DB 에러')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>