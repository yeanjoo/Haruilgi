<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="loginChk"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>하루일기  웹 사이트</title>
</head>
<body>
 	<%
 	request.setCharacterEncoding("utf-8");
 	String userID = user.getUserID();
 	String userPassword = user.getUserPassword();
 	String loginChk = user.getLoginChk();
    
    UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, userPassword);
	
	if (result ==1){
		session.setAttribute("userID",userID);
		
		
		if(loginChk != null){
			Cookie cookie = new Cookie("userID", userID);
			cookie.setMaxAge(60);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
	else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");    // 이전 페이지로 사용자를 보냄
		script.println("</script>");
	}
	
	else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()");    // 이전 페이지로 사용자를 보냄
		script.println("</script>");
	}
	
	else if (result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB 오류가 발생했습니다.')");
		script.println("history.back()");    // 이전 페이지로 사용자를 보냄
		script.println("</script>");
	}
    %>
</body>
</html>