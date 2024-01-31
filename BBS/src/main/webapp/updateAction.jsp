<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
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
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}else {
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null 
					|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")){
					script.println("<script>");
					script.println("alert('올바른 형식을 입력하세요')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
					if(result == -1){
						script.println("<script>");
						script.println("alert('글수정에 실패했습니다.')");
						script.println("history.back()'");
						script.println("</script>");
					}else{
						script.println("<script>");
						script.println("alert('글을 수정하였습니다.')");
						script.println("location.href = 'board.jsp'");
						script.println("</script>");
					}
				}
		}
	%>
</body>
</html>