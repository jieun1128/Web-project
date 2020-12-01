<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="sideNavi.css">
</head>
<body>
   <%

	int board = Integer.parseInt(request.getParameter("board"));
   	String from_board = "";
   	if(board == 1) { from_board="notice";}
   	else{from_board="complain";}
	String href_board=from_board.concat(".jsp");
    
  	String title="", content="";
  	Connection conn = null;
  	Statement stmt = null;
  	ResultSet rs = null;

    int tableID1=Integer.parseInt(request.getParameter("tableID"));
	String id = (String)session.getAttribute("id");
  	title = request.getParameter("title");
  	content = request.getParameter("content");
  	
  	try{
  		
  		Class.forName("com.mysql.jdbc.Driver");
  	    String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
  	    conn = DriverManager.getConnection(url, "root", "0000");
  	    stmt = conn.createStatement();
        String sql = "update "+ from_board+ " set title = '"+ title+"', content = '" + content + "' where tableID = " + tableID1;
        stmt.executeUpdate(sql);
         
  	}catch(Exception e){
  		out.println("DB 연동 오류입니다.: "+ e.getMessage());
  	}
         %>
         <center>
         <h2>작성한 글이 등록되었습니다.</h2>
         <a href=<%= href_board%>><button> 게시글 목록 보기</button> </a><br>
         </center>
</body>
</html>