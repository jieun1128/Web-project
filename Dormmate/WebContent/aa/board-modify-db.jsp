<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<body>
   <%
   	  int board=Integer.parseInt(request.getParameter("board"));
      int cnt;
      int talbeID = 0;
      String nickName, title, content;
      int userID;
      int agree, disagree;
      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      String sql_update;
	  String from_board="";	
      if(board==1) from_board="notice";
      else if(board==2) from_board="complain";
      
      try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, "root", "0000");
            stmt = conn.createStatement();
            String sql = "select max(tableID) as max_id, count(*) as cnt from " + from_board;
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
      
      
      String id = request.getParameter("id"); 
      talbeID ++;
      nickName = request.getParameter("nickName");
      title = request.getParameter("title");
      content = request.getParameter("content");
      agree = 0;
      disagree = 0;

      sql_update = "insert into "+ from_board +" values (" +talbeID+","+"'"+id+"',"+"'"+nickName+"',"+"'"+title+"',"+"'"+content+"',"+agree+","+disagree+")";
      try{
         stmt.executeUpdate(sql_update);
      }
      catch(Exception e){
         out.println("DB 연동 오류입니다. :"+e.getMessage());
      }
         %>
         <center>
         <h2>작성한 글이 등록되었습니다.</h2>
         <a href="notice.jsp"> 게시글 목록 보기 </a><br>
         </center>
</body>
</html>