<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userPW" name="user"/>
<jsp:setProperty property="userName" name="user"/>
<jsp:setProperty property="userGender" name="user"/>
<jsp:setProperty property="userEmail" name="user"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		UserDAO userDAO = new UserDAO();
		
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
		
		if(user.getUserID() == null || user.getUserPW() == null || user.getUserName() == null ||
			user.getUserGender() == null || user.getUserEmail() == null){
			script.println("<script>");
			script.println("alert('올바른 회원정보를 입력하세요')");
			script.println("location.href = 'join.jsp'");
			script.println("</script>");
		}else {
			int result = userDAO.join(user);
			if(result == -1){
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디 입니다.')");
				script.println("location.href = 'join.jsp'");
				script.println("</script>");
			}else{
				session.setAttribute("userID", user.getUserID());
				script.println("<script>");
				script.println("alert('가입이 완료되었습니다..')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>