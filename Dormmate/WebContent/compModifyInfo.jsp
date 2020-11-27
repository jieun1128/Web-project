<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동국 기숙사</title>
<link rel="stylesheet" type="text/css" href="project.css"/>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String nickName = request.getParameter("nickName");
		String major = request.getParameter("major");
		int grade = Integer.parseInt(request.getParameter("grade"));
		String dorm = request.getParameter("dorm");
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");
		String nation = request.getParameter("nation");
		String college = request.getParameter("college");
		Connection conn = null;
	  	Statement stmt = null;
	  	String sql_update = null;
	  	ResultSet rs = null;
	  
	  	
	  	try{
	  		Class.forName("com.mysql.jdbc.Driver");
	  		String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	  		conn = DriverManager.getConnection(url,"root","0000");
	  		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	  		sql_update = "update member set name = '" + name+"',nickName = '"+nickName+"',major = '"+
	  			     major+"', grade = '" + grade +"', dorm = '" + dorm +"', age = '" + age +
	  			   "', sex = '" + gender +"', nation = '" + nation +"', college = '" + college +
	  			     "'where id = '" + id+"'";
	  		stmt.executeUpdate(sql_update);
	  	}catch(Exception e){
	  		out.println("DB 연동 오류입니다. : " + e.getMessage());
	  	}
	  
	%>
<center>
<br><br>
<h3 >수정이 완료되었습니다.</h3>
<p><a href="mypage.jsp?id=<%=id %>" style="color: white">돌아가기</a></p>
</center>
</body>
</html>