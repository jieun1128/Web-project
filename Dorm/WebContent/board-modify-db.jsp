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

	int board = Integer.parseInt(request.getParameter("board"));	//어떤 게시판에서 왔는가
   	String from_board = "";	
   	if(board == 1) { from_board="notice";}	// 공지 게시판에서 왔다.
   	else{from_board="complain";}			// 민원 게시판에서 왔다.
	String href_board=from_board.concat(".jsp");	// <a>태그에 링크할 페이지 .jsp붙여 만들기
    
  	String title="", content="";
  	Connection conn = null;
  	Statement stmt = null;
  	ResultSet rs = null;

    int tableID1=Integer.parseInt(request.getParameter("tableID"));	//글번호 
	String id = (String)session.getAttribute("id");	//아이디
  	title = request.getParameter("title");			//제목
  	content = request.getParameter("content");		//내용
  	
  	try{
  		
  		Class.forName("com.mysql.jdbc.Driver");
  	    String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
  	    conn = DriverManager.getConnection(url, "root", "0000");
  	    stmt = conn.createStatement();	// 해당 글에 맞는 데이터 베이스 업데이트  
        String sql = "update "+ from_board+ " set title = '"+ title+"', content = '" + content + "' where tableID = " + tableID1;
        stmt.executeUpdate(sql);
         
  	}catch(Exception e){
  		out.println("DB 연동 오류입니다.: "+ e.getMessage());
  	}
         %>
         <center>
         <h2>작성한 글이 등록되었습니다.</h2>	<!-- 게시판으로 돌아가기  -->
         <a href=<%= href_board%>><button> 게시글 목록 보기</button> </a><br>
         </center>
</body>
</html>