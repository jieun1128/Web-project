<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동국 기숙사</title>
<link rel="stylesheet" type="text/css" href="project.css"/>
</head>
<body>
<% int id = 0;
	id = Integer.parseInt(request.getParameter("id"));
	String ans;
	ans = request.getParameter("key");
	String pwd = ""; // 데이터 베이스에서 비밀번호 불러오기 
%>
<center>
<h2><%=id %>님의 비밀번호는</h2>
<p><%= pwd%> 입니다.</p>
</center>
</body>
</html>