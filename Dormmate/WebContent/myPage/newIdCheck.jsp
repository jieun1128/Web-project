<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>동국 기숙사</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	boolean check = false;
	Connection conn = null;
     Statement stmt = null;
     ResultSet rs = null;
 
     try { 
    	 Class.forName("com.mysql.jdbc.Driver");
	       String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	       conn = DriverManager.getConnection(url, "root", "0000");
	       stmt = conn.createStatement();
         String sql = "select id from member";
         rs = stmt.executeQuery(sql);
     }
     catch(Exception e) {
           out.println("DB 연동 오류입니다. : " + e.getMessage());
     }
     
     if(id.equals("")){
    	 check = true;
    	 response.sendRedirect("newID.jsp");  
     }
     
     while(rs.next()) {
		 if(id.equals(rs.getString("id")))
		 {
			check = true;
		    out.println("<script>alert('사용 불가능한 아이디입니다.'); history.back();</script>");
       	     break;
	         }
         }
     
     	if(check == false){
     		session.setAttribute("id", id);
			response.sendRedirect("newMember.jsp");    
     	}
     %>
</body>
</html>