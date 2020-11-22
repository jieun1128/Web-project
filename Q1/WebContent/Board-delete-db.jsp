<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<html>
  <body>
    <%
       int id;
       String passwd = "", sql, sql1;
       Connection conn = null;
       Statement stmt = null;
       ResultSet rs = null;
       id = Integer.parseInt(request.getParameter("id"));
   
       try { 
             Class.forName("com.mysql.jdbc.Driver");
	     String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
	     conn = DriverManager.getConnection(url, "root", "0000");
	     stmt = conn.createStatement();
             sql = "select * from board_tbl where id = " + id;
             rs = stmt.executeQuery(sql);
       }
       catch(Exception e) {
             out.println("DB 연동 오류입니다. : " + e.getMessage());
       }

       passwd = request.getParameter("passwd");      
       while(rs.next()) {
		 if(!passwd.equals(rs.getString("passwd")))
		 {
    %>
    <center><h2> 잘못 입력된 패스워드입니다. </h2>
      <img src="image/green_tree.gif">
      <a href="Board-read.jsp?id=<%= request.getParameter("id") %>"> 뒤로 </a>
    </center>
    <%      
	         }
                 else
		 {
		    sql1 = "delete from board_tbl where id = " + id;
                    try { 		     
                          stmt.executeUpdate(sql1); 
                    }  
	            catch(Exception e) {
                          out.println("DB 연동 오류입니다. : " + e.getMessage());
                    }
    %>
    <center><h2> 게시글이 삭제되었습니다. </h2>
      <img src="image/green_tree.gif"> 
      <a href="Board-list.jsp"> 게시글 목록 보기</a> 
    </center>
    <%
		    break;
		 }
	}
    %>
  </body>
</html>