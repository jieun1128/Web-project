<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동국 기숙사</title>	<!-- newJoin.jsp -> 회원정보 DB에 저장 -->
<link rel="stylesheet" type="text/css" href="project.css"/>
</head>
<body>
			
<%	
		//newMember에서 넘겨받은 파라미터 값 저장
      String id = session.getAttribute("id").toString();	//object to string
      String pw =  request.getParameter("pw");
      String name = request.getParameter("name");
      String nick =  request.getParameter("nick");
      String college = request.getParameter("college");
      String major = request.getParameter("major");
      int grade = Integer.parseInt(request.getParameter("grade"));	//string to integer
      String dorm = request.getParameter("dorm");
      int age = Integer.parseInt(request.getParameter("age"));	//string to integer
      String gender = request.getParameter("gender");
      String nation = request.getParameter("nation");
      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      
      try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";	//DB 이름: dormitory
            conn = DriverManager.getConnection(url, "root", "0000");
            stmt = conn.createStatement();
            String sql = "insert into member values ('"+id+"' , '"+pw+"' , '"+name+"' , '"+nick+"' , '"+major+"' , "+grade+" , '"+dorm+"' , "+age+" , '"+gender+"' , '"+nation+"' , '"+college+"')";
          //DB의 member테이블에 회원정보 insert
            stmt.executeUpdate(sql);
      }
      catch(Exception e) {
            out.println("DB 연동 오류입니다.  : " + e.getMessage());
      } 

%>			
			
<center>
<br><br>
<h3 >가입을 환영합니다!</h3><br>
<input type=button value="로그인하러 가기" onClick="location.href='login.jsp' ">	<!-- 로그인 화면으로 이동 -->
</center>
</body>
</html>