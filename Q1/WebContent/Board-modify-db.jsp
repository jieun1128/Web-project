<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<body>
	<%
	int id;
	String name="", e_mail="", title="", content="";
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	id = Integer.parseInt(request.getParameter("id"));
	name = request.getParameter("name");
	e_mail = request.getParameter("e_mail");
	title = request.getParameter("title");
	content = request.getParameter("content");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
	     String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
	     conn = DriverManager.getConnection(url, "root", "0000");
	     stmt = conn.createStatement();
        String sql_update = "update board_tbl set name = '" + name+"',e_mail = '"+e_mail+"',title = '"+
	     title+"', content = '" + content + "'where id = " + id;
        stmt.executeUpdate(sql_update);
	}catch(Exception e){
		out.println("DB 연동 오류입니다.: "+ e.getMessage());
	}
	
	%>
	<center><h2>게시글이 수정되었습니다.</h2>
	<img src = "image/red_tree.gif">
	<a href="Board-read.jsp?id=<%= request.getParameter("id") %>">작성한 글 보기</a>
	<img src = "image/green_tree.gif">
	<a href="Board-list.jsp">게시글 목록 보기</a>
	
	</center>
</body>
</html>