<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
      String id = session.getAttribute("id").toString();
      String pw =  request.getParameter("pw");
      String name = request.getParameter("name");
      String nick =  request.getParameter("nick");
      String college = request.getParameter("college");
      String major = request.getParameter("major");
      int grade = Integer.parseInt(request.getParameter("grade"));
      String dorm = request.getParameter("dorm");
      int age = Integer.parseInt(request.getParameter("age"));
      String gender = request.getParameter("gender");
      String nation = request.getParameter("nation");
      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      
      try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, "root", "0000");
            stmt = conn.createStatement();
            String sql = "insert into member values ('"+id+"' , '"+pw+"' , '"+name+"' , '"+nick+"' , '"+major+"' , "+grade+" , '"+dorm+"' , "+age+" , '"+gender+"' , '"+nation+"' , '"+college+"')";
            stmt.executeUpdate(sql);
      }
      catch(Exception e) {
            out.println("DB 연동 오류입니다.  : " + e.getMessage());
      } 

%>			
			
<center>
<br><br>
<h3 >가입을 환영합니다!</h3><br>
<input type=button value="로그인하러 가기" onClick="location.href='login.jsp' ">
</center>
</body>
</html>