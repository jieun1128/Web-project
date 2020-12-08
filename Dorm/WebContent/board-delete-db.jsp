<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      	String sql, sql1;
      	Connection conn = null;
      	Statement stmt = null;
       	ResultSet rs = null;
   		
       	int board = Integer.parseInt(request.getParameter("board"));	// 공지글에서 왔는가 민원글에서 왔는가 
       	String from_board = "";
       	if(board == 1) { from_board="notice";}	// 공지글에서 왔다.
       	else{from_board="complain";}			// 민원글에서 왔다.
       	String href_board=from_board.concat(".jsp");	// <a>태그에 링크할 페이지 .jsp붙여 만들기
   		
   		String id = (String)session.getAttribute("id");		// 로그인한 회원의 id
   		int tableID1=Integer.parseInt(request.getParameter("tableID"));	// 글 번호 
   		
   		
      	try { 
      		Class.forName("com.mysql.jdbc.Driver");
      	    String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
      	    conn = DriverManager.getConnection(url, "root", "0000");
      	    stmt = conn.createStatement();	// 해당 게시판의 글 번호를 통해 해당 글을 찾아 삭제 
           	sql =  "delete from "+ from_board +" where tableID = " + tableID1;
            stmt.executeUpdate(sql);
		}catch(Exception e) {
			out.println("DB 연동 오류입니다. : " + e.getMessage());
		}
   		
    %>
    <center><h2> 게시글이 삭제되었습니다. </h2>	<!-- 삭제 완료 후 게시판으로 돌아가기 -->
     <a href=<%= href_board%>> <button>게시글 목록 보기</button></a>
    </center>
	<%
     stmt.close();
     conn.close();
   %>

      
</body>
</html>