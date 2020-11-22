<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
<title>게시판</title>
</head>
<body>

      <center>
      <h1><b>게시글 목록 보기</b></h1>
       <table border="1" align="center" width="603px;">
       
       <tr style="background-color:Lightgray;">
         <td align="center" width="75">글번호</td>
         <td align="center" width="75">글쓴이</td>
         <td align="center"width="275">글제목</td>
         <td align="center" width="175">전자우편</td>
       </tr>
      
      <%
      int id,ref;
      int rownum=0;
      Connection conn = null;
      Statement stmt = null;
      String sql = null;
      ResultSet rs = null;
      %>
      
      <%
      try{
    	  Class.forName("com.mysql.jdbc.Driver");
    	  String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
    	  conn = DriverManager.getConnection(url,"root","0000");
    	  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    	  sql = "select * from board_tbl order by ref desc, id asc ";
    	  rs = stmt.executeQuery(sql);
      }
      
      catch(Exception e ){
    	  out.println("DB 연동 오류입니다. : " + e.getMessage());
      }
      
      rs.last();
      rownum = rs.getRow();
      rs.beforeFirst();
      
      while(rs.next())
      {
    	 id = Integer.parseInt(rs.getString("id"));
    	 ref = Integer.parseInt(rs.getString("ref"));
    	  %>
          
           <tr>
             <td align="center"><%= rownum %> </td>
             <td align="left"><%=rs.getString("Name") %></td>
             <td align="left"><% if (id!=ref) out.println("┖---→"); %>
               <a href=Board-read.jsp?id=<%=rs.getString("id") %> style="width:250;"><%=rs.getString("title") %></a>
             </td>
             <td align="center"><%= rs.getString("E_mail") %></td>
      
            </tr>
        

      <%
      
           rownum--;
      }
      %>

   
      
     </table>
   
   
   <img src="./image/green_tree.gif"><a href="Board-insert.jsp">게시글 쓰기</a>
   <%
     stmt.close();
     conn.close();
   %>
   
   <img src="./image/island.gif" width="95%">
   </center>


</body>
</html>