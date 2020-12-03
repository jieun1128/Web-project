<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
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
	int board=Integer.parseInt(request.getParameter("board"));	// 공지글에서 왔는가 민원글에서 왔는가 
	int tableID = Integer.parseInt(request.getParameter("tableID"));	// 글 번호 
	String title="",content="", userID="";			// 제목 내용 글을 수정하는 회원의 id
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	if(board==1) from_board = "select * from notice where tableID= " + tableID;	// 공지글에서 왔을 때 해당 글 찾기 
	else if(board==2) from_board = "select * from complain where tableID= " + tableID;	// 민원글에서 왔을 때 해당 글 찾기

	
	try{
		Class.forName("com.mysql.jdbc.Driver");
	     String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	     conn = DriverManager.getConnection(url, "root", "0000");
	     stmt = conn.createStatement();
         rs = stmt.executeQuery(from_board);
	}catch(Exception e){
		out.println("DB 연동 오류입니다.: "+ e.getMessage());
	}
	 	
	  String id = (String)session.getAttribute("id");// 아이디 받아오기 
	
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
	<%if(board == 1){ %>		<!-- 데이터 베이스에 적용 할 페이지 고르기 -->
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
	<%if(board==1){ %>	<!-- 취소 버튼을 눌렀을때 왔던 게시판으로 돌아가기  -->
		<a href="notice-read.jsp?tableID=<%= request.getParameter("tableID") %>&board=1"><button>취소</button></a>
	<%}else if(board==2){ %>
		<a href="complain-read.jsp?tableID=<%= request.getParameter("tableID") %>&board=2"><button>취소</button></a>
	</center>
	<%}
		}
	}
	%>
  </form>
</body>

</html>