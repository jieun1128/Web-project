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
		String id = (String)session.getAttribute("id");		// session에 저장된 현재 로그인 한 이용자의 id를 불러온다.
		// 각 세부 정보를 각각 맞는 변수에 저장해 둔다.
		int washing = Integer.parseInt(request.getParameter("washing")); 
		int noise = Integer.parseInt(request.getParameter("noise"));
		int cleaning = Integer.parseInt(request.getParameter("cleaning"));
		int sleptOut = Integer.parseInt(request.getParameter("sleptOut"));
		int smoking = Integer.parseInt(request.getParameter("smoking"));
		String religion = request.getParameter("religion");
		int closeness = Integer.parseInt(request.getParameter("closeness"));
		String address = request.getParameter("address");
		String sleepTime = request.getParameter("sleepTime");
		String wakeTime = request.getParameter("wakeTime");
		Connection conn = null;
	  	Statement stmt = null;
	  	String sql_update = null;
	  	ResultSet rs = null;
	  
	  	
	  	try{
	  		Class.forName("com.mysql.jdbc.Driver");
	  		String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	  		conn = DriverManager.getConnection(url,"root","0000");
	  		stmt = conn.createStatement();
	  		sql_update = "insert into memberInfo values (" + washing+","+noise+","+
	  			     cleaning+"," + sleptOut +"," + smoking +",'" + religion +"'," + closeness +
	  			   ",'" + address +"','" + id +"','" + sleepTime +
	  			   "','" + wakeTime + "')";
	  	// 입력 받은 정보를 불러와서 데이터베이스에 저장 하기 
	  		stmt.executeUpdate(sql_update);
	  	}catch(Exception e){
	  		out.println("DB 연동 오류입니다. : " + e.getMessage());
	  	}
	  
	%>
<center>
<br><br>
<h3>생성이 완료되었습니다.</h3> <!-- 돌아가기 -->
<p><a href="mypage.jsp?id=<%=id %>" style="color: white">돌아가기</a></p>
</center>
</body>
</html>