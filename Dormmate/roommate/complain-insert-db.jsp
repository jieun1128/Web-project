<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
      int temp = 0;
      int cnt;
      int tableID = 0;
      String title, content;
      int userID;
      int agree, disagree;
      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      String sql_update;

      try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, "root", "0000");
            stmt = conn.createStatement();
            String sql = "select max(tableID) as max_id, count(*) as cnt from complain "; // tableID 부여하기 위해 
            rs = stmt.executeQuery(sql);
      }
      catch(Exception e) {
            out.println("DB 연동 오류입니다.  : " + e.getMessage());
      }

      while(rs.next())
      {
         cnt = Integer.parseInt(rs.getString("cnt"));
         if(cnt != 0){
            tableID = Integer.parseInt(rs.getString("max_id"));	// 현재 제일 큰 숫사 +1로 테이블 아이디 부여 
         }
      }
      
  	  String id = (String)session.getAttribute("id"); // 아이디 (글쓴이)
      tableID ++;
      title = request.getParameter("title");			//제목
      content = request.getParameter("content");		//내용
      agree = 0;										//공감수
      disagree = 0;										//비공감수
					// 데이터베이스에 작성한 글 등록 
      sql_update = "insert into complain values (" +tableID+","+"'"+id+"',"+"'"+title+"',"+"'"+content+"',"+agree+","+disagree+")";
      try{
         stmt.executeUpdate(sql_update);
      }
      catch(Exception e){
         out.println("DB 연동 오류입니다. :"+e.getMessage());
      }
         %>
         <center>
         <h2>작성한 글이 등록되었습니다.</h2>
         <a href="complain.jsp"> 게시글 목록 보기 </a><br>
         </center>
        
</body>
</html>