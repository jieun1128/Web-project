<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동국 기숙사</title>	 <!-- loginCheck.jsp -> 로그인 인증 jsp -->
<link rel="stylesheet" href="sideNavi.css">
</head>
<body>
   <%
    String id = request.getParameter("id");	//login.jsp에서 넘어온 'id' 파라미터
    String pw = request.getParameter("pw");	//login.jsp에서 넘어온 'pw' 파라미터
    int check = 0;			//아이디, 비밀번호 일치 경우를 나누기 위한 변수
    String sql, sql1;
     Connection conn = null;
     Statement stmt = null;
     ResultSet rs = null;
      
     try { 
         Class.forName("com.mysql.jdbc.Driver");
         String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";	//DB이름: dormitory
     	 conn = DriverManager.getConnection(url, "root", "0000");
    	 stmt = conn.createStatement();
         sql = "select id, pwd from member";	//DB에서 member테이블에서 id,pwd 속성값 불러오기
         rs = stmt.executeQuery(sql);
   }
   catch(Exception e) {
         out.println("DB 연동 오류입니다. : " + e.getMessage());
   }
       
   while(rs.next()) {
	 if(id.equals(rs.getString("id")))	//아이디가 일치할 경우
	 {
		 	check = 1;
			if(pw.equals(rs.getString("pwd"))){	//비밀번호가 일치할 경우
				check = 2;
				session.setAttribute("id", id);		 //id를 세션으로 저장
				response.sendRedirect("main.jsp");    //main화면으로 이동
				break;
			}
      }
   }
           
	 if(check == 0){	//아이디, 비밀번호 모두 일치하지 않는 경우
		 %>
	 		<center>
			    <h2> 존재하지 않는 아이디입니다. </h2><br>
			    <input type=button value="뒤로가기" onClick="location.href='login.jsp' ">	<!-- 로그인 화면으로 이동 -->
			    <input type=button value="회원가입하기" onClick="location.href='newID.jsp' ">	<!-- 회원가입 화면으로 이동 -->
			  </center>
			  <%
	 }
	 else if(check == 1){	//아이디는 일치하고, 비밀번호는 일치하지 않는 경우
		 %>
	 		<center>
			    <h2> 잘못된 비밀번호입니다. </h2><br>
			    <input type=button value="뒤로가기" onClick="location.href='login.jsp' ">		<!-- 로그인 화면으로 이동 -->
			    <input type=button value="비밀번호찾기" onClick="location.href='findPW.jsp' ">		<!-- 비밀번호 찾기 화면으로 이동 -->
			  </center>
	<%
	 }
     %>      
</body>
</html>