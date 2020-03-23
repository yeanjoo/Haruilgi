<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<link rel="stylesheet" href="css/custom.css">
<link rel="shortcut icon" type="image/x-icon" href="images/icon.png">
<title>하루일기 웹 사이트</title>
</head>
<body>
<%
    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
    	for(Cookie tempCookie : cookies){
    		if(tempCookie.getName().equals("userID")){
    			session.setAttribute("userID", tempCookie.getValue());
    		}
    	}
    }
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");
    }
    if (userID == null)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    int bbsID = 0;
    if (request.getParameter("bbsID") != null)
    {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID);
    if (!userID.equals(bbs.getUserID()))//실제 글 작성 사람과 아이디값 동일 x
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    
%>
    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">하루일기 게시판 웹 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>
<%--        <%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
            %> 
--%>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false"><%=userID%>님 환영합니다!<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
<%--             
            <%
                }
            %> 
--%>
        </div>
    </nav>
    <div class="container">
        <div class="row">
        <form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 수정 양식</th>
 
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="text" class="form-control" placeholder="글 제목"  name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>" ></td>
                    </tr>
                    <tr>
                        <td><textarea class="form-control" placeholder="글 내용"  name="bbsContent" maxlength="2048" style="height:350px"><%=bbs.getBbsContent() %></textarea></td>
                    </tr>
                </tbody>
            </table>
                <input type="submit"  class="btn btn-primary pull-right" value="글수정">
            </form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>
