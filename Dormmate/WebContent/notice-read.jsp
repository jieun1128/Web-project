<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
   <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>동국 기숙사</title>
	<!-- Our Custom CSS -->
    <link rel="stylesheet" href="sideNavi.css">
   
  </head>
  <body>

        <!-- Page Content  -->
        <div id="content">
<%

	 String userID = "", title = "", content = "";
	 int agree=0, disagree=0;
     Connection conn = null;
	 Statement stmt = null;
	 ResultSet rs = null;
	 HttpSession session = request.getSession(false);
  
	 int tableID = Integer.parseInt(request.getParameter("tableID"));
	 
	 try {
               Class.forName("com.mysql.jdbc.Driver");
               String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
               conn = DriverManager.getConnection(url, "root", "0000");
               stmt = conn.createStatement();
               String sql = "select * from notice where tableID = " + tableID;
               rs = stmt.executeQuery(sql);
         }
         catch(Exception e) {
               out.println("DB 연동 오류입니다. : " + e.getMessage());
         } 

         while(rs.next())  {
	       userID = rs.getString("userID");
	       title = rs.getString("title");
	       content = rs.getString("content");
	       agree = rs.getInt("agree");
	       disagree = rs.getInt("disagree");
	 }
    %>     
    <center>
     <br><br><br>
	<h2><%= title %></h2>
    <br>
        작성자: <%= userID %> <br>
    <%
    int like=0; // 동의 비동의 눌렀는지
    int disliked=0;
    %>
    <input type="image" src="agree.png" style="width: 50px; height: 50px;" onClick="agree_clicked(like, dislike);"> 
    <input type="image" src="disagree.png" style="width: 50px; height: 50px;"  onClick="disagree_clicked(like, dislike);"> <br>

       동의  : <%= agree %> | 비동의 : <%= disagree %>
           
    <div class="line"></div>

	<div style="background-color:#F0E6FD ; color:black; width:60%; height: 400px; align: center;">
  <%= content %>

 </div>
 
 <br><br><br>
<%if(userID.equals((String)request.getParameter("id"))){ %>
     <a href="board-modify.jsp?tableID=<%=tableID%>&board=1"> <button>게시글 수정</button> </a>    

    <a href="board-delete-db.jsp?tableID=<%=tableID%>&board=1"> <button>게시글 삭제 </button> </a>
    <%
}
    %>
    <a href="notice.jsp"> <button>게시글 목록 보기 </button></a>
  </center>
        </div>
        
	<%

     stmt.close();
     conn.close();
   %>

</body>
</html>