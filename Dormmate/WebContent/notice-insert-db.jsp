<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<body>
   <%
      int temp = 0;
      int cnt;
      int talbeID = 0;
      int ref = 0;
      String nickname, title, content, writtendate;
      int userID;
      int agree, disagree;
      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      String sql_update;

      try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, "root", "0000");
            stmt = conn.createStatement();
            String sql = "select max(id) as max_id, count(*) as cnt from board_tbl ";
            rs = stmt.executeQuery(sql);
      }
      catch(Exception e) {
            out.println("DB 연동 오류입니다.  : " + e.getMessage());
      }

      while(rs.next())
      {
         cnt = Integer.parseInt(rs.getString("cnt"));
         if(cnt != 0){
            talbeID = Integer.parseInt(rs.getString("max_id"));
         }
      }
      
      
      
      talbeID ++;
      nickname = request.getParameter("nickname");
      title = request.getParameter("title");
      content = request.getParameter("content");
      agree = 0;
      disagree = 0;
      writtendate = request.getParameter("writtendate");

      sql_update = "insert into board_tbl values (" +talbeID+","+nickname+","+"'"+title+"',"+"'"+content+"',"+agree+","+disagree+")";
      try{
         stmt.executeUpdate(sql_update);
      }
      catch(Exception e){
         out.println("DB 연동 오류입니다. :"+e.getMessage());
      }
         %>
         <center>
         <h2>작성한 글이 등록되었습니다.</h2>
         <img src="image/green_tree.gif"><a href="MAIN-noticeBoard.jsp"> 게시글 목록 보기 </a><br>
         </center>
</body>
</html>