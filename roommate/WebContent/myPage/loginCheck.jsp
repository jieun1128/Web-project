<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="sideNavi.css">
</head>
<body>
   <%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    int check = 0;
    String sql, sql1;
     Connection conn = null;
     Statement stmt = null;
     ResultSet rs = null;
      
     try { 
         Class.forName("com.mysql.jdbc.Driver");
         String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
     	 conn = DriverManager.getConnection(url, "root", "0000");
    	 stmt = conn.createStatement();
         sql = "select id, pwd, nickName from member";
         rs = stmt.executeQuery(sql);
   }
   catch(Exception e) {
         out.println("DB 연동 오류입니다. : " + e.getMessage());
   }
       
   while(rs.next()) {
	 if(id.equals(rs.getString("id")))
	 {
		 	check = 1;
			if(pw.equals(rs.getString("pwd"))){
				check = 2;
				session.setAttribute("id", id);
				String nickName= rs.getString("nickName");
				session.setAttribute("nickName", nickName);
				response.sendRedirect("main.jsp?id='id'");    
				break;
			}
      }
   }
           
	 if(check == 0){
		 %>
	 		<center>
			    <h2> 존재하지 않는 아이디입니다. </h2><br>
			    <input type=button value="뒤로가기" onClick="location.href='login.jsp' ">
			    <input type=button value="회원가입하기" onClick="location.href='newID.jsp' ">
			  </center>
			  <%
	 }
	 else if(check == 1){
		 %>
	 		<center>
			    <h2> 잘못된 비밀번호입니다. </h2><br>
			    <input type=button value="뒤로가기" onClick="location.href='login.jsp' ">
			    <input type=button value="비밀번호찾기" onClick="location.href='findPW.jsp' ">
			  </center>
	<%
	 }
     %>      
</body>
</html>