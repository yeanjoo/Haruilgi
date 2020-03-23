<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>하루일기 웹 사이트</title>
</head>
<body>
<%
    session.invalidate(); /* 이 페이지에 접속하면 session을 빼앗김 */
    

    Cookie[] cookies = request.getCookies();
    if(cookies != null){
    	for(Cookie tempCookie : cookies){
    		if(tempCookie.getName().equals("userID")){
    			tempCookie.setMaxAge(0);
    			tempCookie.setPath("/");
    			response.addCookie(tempCookie);
    		}
    	}
    }
%>
<script>
alert('정상적으로 로그아웃 되었습니다.');
    location.href = 'main.jsp';
</script>
</body>
</html> 
