<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
<title>게시글 수정</title>
</head>
<body>
	<center><h2>패스워드를 입력하시오.</h2>
	<form action = "Board-modify.jsp" method="post">
		<table border="0">
		<tr>
			<td><img src="image/ball.gif">패스워드: </td>
			<td><input type = "password" name = "passwd" size="30"></td>
			<td><input type = "hidden" name = "id" value = "<%= request.getParameter("id") %>"></td>
		</tr>
		</table><br><br>
		
		<input type="submit" value="수정하기">
		<input type="reset" value="다시쓰기">
	</form>
	
	<img src = "image/green_tree.gif">
	<a href="Board-read.jsp?id=<%= request.getParameter("id") %>">수정 취소</a>
	
	<img src = "image/island.gif" width="99%">
	</center>
</body>
</html>