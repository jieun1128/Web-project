<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동국 기숙사</title>	<!-- newID.jsp -> 아이디 생성하는 화면 -->
<link rel="stylesheet" type="text/css" href="project.css"/>
</head>
<body>
<form method="post" action="newIdCheck.jsp">	<!-- submit클릭 시 newIdCheck.jsp로 넘겨짐 -->
	<center>
	<h3>아이디 생성하기</h3>
		 <table>
            <tr>
                <td>아이디 </td>
                <td>
                    <input type = "text" name="id">	<!-- 아이디 입력 받기 -->
                    <input type="submit" value="중복확인">
                </td>   
                </tr>
                </table>
		</center>		
</form>
</body>
</html>