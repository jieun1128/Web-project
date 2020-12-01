<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>

<head>
   
    <title>동국 기숙사</title>

    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="sideNavi.css">
    
</head>

<body>
	<%
	String from_board="";
	int board=Integer.parseInt(request.getParameter("board"));
	
	int tableID = Integer.parseInt(request.getParameter("tableID"));
	String title="",content="", userID="";
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	if(board==1) from_board = "select * from notice where tableID= " + tableID;
	else if(board==2) from_board = "select * from complain where tableID= " + tableID;

	
	try{
		Class.forName("com.mysql.jdbc.Driver");
	     String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	     conn = DriverManager.getConnection(url, "root", "0000");
	     stmt = conn.createStatement();
         rs = stmt.executeQuery(from_board);
	}catch(Exception e){
		out.println("DB 연동 오류입니다.: "+ e.getMessage());
	}
	 
		HttpSession session = request.getSession(false);
	  String id = (String)session.getAttribute("id");// 변경 
	
	while(rs.next()){
		if(!id.equals(rs.getString("userID")))
		{
	%>
	<center><h2> 게시글은 작성자만 수정가능합니다. </h2>
	</center>
	<%
		}
		else{
	%>
	<center><h2>게시글 수정</h2><br><br>
	<%if(board == 1){ %>
	<form action = "board-modify-db.jsp?tableID=<%=tableID%>&board=1" method="post">
	<%}else if(board == 2){ %>
	<form action = "board-modify-db.jsp?tableID=<%=tableID%>&board=2" method="post">
	<%} %>
<table border="0">

<tr>
  <td> 글 쓴 이 : </td>
  <td>
 	<%= id %>
  </td>
</tr>
<tr>
  <td>글 제 목 : </td>
  <td><input type="text" name="title" size="50"></td>
</tr>
<tr>
  <td> 글 내 용 : </td>
  <td><textarea name="content" cols="65" rows="4"></textarea></td>
</tr>
</table><br><br>
	
	<input type = "hidden" name="tableID" value="<%= request.getParameter("tableID") %>">
	
	<input type = "submit" value="등록하기">
	<input type = "reset" value="다시쓰기">
	</form>
	<%if(board==1){ %>
		<a href="notice-read.jsp?tableID=<%= request.getParameter("tableID") %>?board=1"><button>취소</button></a>
	<%}else if(board==2){ %>
		<a href="complain-read.jsp?tableID=<%= request.getParameter("tableID") %>?board=2"><button>취소</button></a>
	</center>
	<%}
		}
	}
	%>
  </form>
</body>

</html>