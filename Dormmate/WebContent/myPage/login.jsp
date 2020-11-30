<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<meta charset="UTF-8">
<html>
<head>
    <title>동국 기숙사</title>	<!-- login.jsp -> 첫 화면/ 로그인 화면 -->
    <link rel="stylesheet" type="text/css" href="project.css"/>	<!-- 외부 css 연결 -->
</head>
<body>
    <center>
    <br><br>
    <h1>동국 기숙사</h1>
    <br><br>
    <h3 >로그인</h3>
    <form method="post" action="loginCheck.jsp">	<!-- submit클릭 시 'loginCheck.jsp 이동 -->
        <input type = "text" name="id" size = "40" placeholder="아이디"><br><br>
        <input type="password" name="pw" size = "40" placeholder="비밀번호"><br><br>
        <input type="submit" value="로그인"><br><br>
        <input type="button" value="비밀번호 찾기" onClick="location.href='findPW.jsp' ">	<!-- '비밀번호 찾기' 버튼 클릭 시 'findPW.jsp' 이동 -->
        <input type="button" value="회원가입"  onClick="location.href='newID.jsp' ">	<!-- '회원가입' 버튼 클릭 시 'newID.jsp' 이동 -->
        </form>
</center>
    
</body>
</html>
