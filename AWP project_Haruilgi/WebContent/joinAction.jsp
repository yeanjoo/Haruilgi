<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>하루일기  웹 사이트</title>
</head>
<body>
    <%
    String userID = null;
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
    	for(Cookie tempCookie : cookies){
    		if(tempCookie.getName().equals("userID")){
    			session.setAttribute("userID", tempCookie.getValue());
    		}
    	}
    }
	 if(session.getAttribute("userID") != null)
	 {
        userID = (String) session.getAttribute("userID");
    }
    if(userID != null)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어있습니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }    
        if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
                        user.getUserGender() == null || user.getUserEmail() == null){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
    } else {
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(user);
            if(result == -1){
                PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
                script.println("<script>");
                script.println("alert('이미 존재하는 아이디 입니다..')");
                script.println("history.back()");
                script.println("</script>");
            }
            else if(result == 1){
                session.setAttribute("userID", user.getUserID());
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href= 'main.jsp'");
                script.println("</script>");
                }
        }
    %>
</body>
</html>