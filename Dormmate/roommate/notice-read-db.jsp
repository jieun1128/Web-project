<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
  <head>
   <meta charset="utf-8">
  </head>
  <body>

   <%
   int l_agree=0, l_disagree=0, l_hidden=0, tableID;
   String id="";
  
   l_agree= Integer.parseInt(request.getParameter("l_agree"));	//공감개수
   l_disagree= Integer.parseInt(request.getParameter("l_disagree"));		//비공감개수
   l_hidden= Integer.parseInt(request.getParameter("l_hidden"));	// 공감: 1, 비공감:-1, 둘다 아닐 경우:0
   tableID= Integer.parseInt(request.getParameter("tableID"));	//테이블 아이디
   id = request.getParameter("id");	// 사용자 아이디

      if(l_hidden==0){	// 아무 버튼도 누르지 않았을 때
    	  response.sendRedirect("notice.jsp;");
      }
     
      else{
      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      String sql_update1, sql_update2;

      try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, "root", "0000");
            stmt = conn.createStatement();
 
            String sql = "select * from notice_agree where userID='"+id+"' AND tableID="+tableID;
            rs = stmt.executeQuery(sql);
      }catch(Exception e) {
            out.println("select DB 연동 오류입니다  : " + e.getMessage());
      }
      
      /* notice 테이블의 agree와 disagree 개수 변경하기 */
      sql_update1 = "update notice set agree="+l_agree+", disagree="+l_disagree+" where tableID="+tableID;
	

      if(!rs.next()){
    	 sql_update2="insert into notice_agree values ('"+id+"', "+tableID+", "+l_hidden+")";	// notice_table에 사용자가 존재하지 않을 때   
      }
      else {
    	  sql_update2="update notice_agree set agree="+l_hidden+" where userID='"+id+"' AND tableID="+tableID;
      }
      
      try{
         stmt.executeUpdate(sql_update2);
         stmt.executeUpdate(sql_update1);
      }catch(Exception e){
         out.println("insert/update DB 연동 오류입니다. :"+e.getMessage());
      }
      
    response.sendRedirect("notice.jsp;");
     }
     
         %>

</body>
</html>