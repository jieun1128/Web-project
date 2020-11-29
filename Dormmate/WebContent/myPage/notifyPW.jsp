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
    String id = request.getParameter("id");
    boolean check = false;
	//String ans;
	//ans = request.getParameter("key");
     Connection conn = null;
     Statement stmt = null;
     ResultSet rs = null;
 
     try { 
           Class.forName("com.mysql.jdbc.Driver");
	       String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	       conn = DriverManager.getConnection(url, "root", "0000");
	       stmt = conn.createStatement();
           String sql = "select id, pwd from member";
           rs = stmt.executeQuery(sql);
     }
     catch(Exception e) {
           out.println("DB 연동 오류입니다. : " + e.getMessage());
     }
     
     while(rs.next()) {
		 if(id.equals(rs.getString("id")))
		 {
		   %>
       	   <center>
       	      <h2><%=id %>님의 비밀번호는</h2>
		      <p><%= rs.getString("pwd")%> 입니다.</p><br>
       	      <input type=button value="로그인하러 가기" onClick="location.href='login.jsp' ">
       	   </center>
       	   <% 
       	     check = true;
       	     break;
	         }
         }
     
        	if(check == false){
        		%>
        		<center>
			    <h2> 존재하지 않는 아이디입니다. </h2><br>
			    <input type=button value="뒤로가기" onClick="location.href='findPW.jsp' ">
			    <input type=button value="회원가입하기" onClick="location.href='newID.jsp' ">
			  </center>
			  <%
        	}
            %>
</body>
</html>