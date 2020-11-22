<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<html>
<body>
	<%
	int id;
	String name = "", e_mail="",title="",content="",passwd="",sql;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	id = Integer.parseInt(request.getParameter("id"));
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
	     String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
	     conn = DriverManager.getConnection(url, "root", "0000");
	     stmt = conn.createStatement();
         sql = "select * from board_tbl where id = " + id;
         rs = stmt.executeQuery(sql);
	}catch(Exception e){
		out.println("DB 연동 오류입니다.: "+ e.getMessage());
	}
	
	passwd = request.getParameter("passwd");
	
	while(rs.next()){
		if(!passwd.equals(rs.getString("passwd")))
		{
	%>
	<center><h2> 잘못 입력된 패스워드입니다. </h2>
	<img src="image/green_tree.gif">
	<a href="Board-read.jsp?id=<%= request.getParameter("id") %>"> 뒤로 </a>
	</center>
	<%
		}
		else{
	%>
	<center><h2>게시글 수정</h2><br><br>
	<form action = "Board-modify-db.jsp" method="post">
	<table border = "0">
	<tr>
		<td><img src="image/ball.gif"> 글 쓴 이: </td>
		<td><input type = "text" name = "name" size = "15" value = " <%= rs.getString("name") %>"></td>
	</tr>
	<tr>
		<td><img src="image/ball.gif"> 메일 주소 : </td>
		<td><input type = "text" name="e_mail" size="30" value="<%= rs.getString("e_mail") %>"></td>
	</tr>
	<tr>
		<td><img src="image/ball.gif"> 글 제 목 : </td>
		<td><input type = "text" name="title" size="50" value="<%= rs.getString("title") %>"></td>
	</tr>
	<tr>
		<td valign = "top"><img src="image/ball.gif"> 글 내 용 : </td>
		<td><textarea name="content" cols="65" rows="4"><%=rs.getString("content") %></textarea></td>
	</tr>
	</table><br><br>
	
	<input type = "hidden" name="id" value="<%= request.getParameter("id") %>">
	
	<input type = "submit" value="등록하기">
	<input type = "reset" value="다시쓰기">
	</form>
	
	<img src ="image/green_tree.gif">
	<a href="Board-read.jsp?id=<%= request.getParameter("id") %>">취소</a>
	</center>
	<%
		}
	}
	%>
</body>
</html>