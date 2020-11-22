<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<html>
  <head><title> 게시글 삭제 </title></head>
  <body>
    <center><h2> 패스워드를 입력하시오 </h2><br><br>
      <form action="Board-delete-db.jsp" method="post">
        <table border="0">
          <tr>
             <td><img src="image/ball.gif"> 패스워드 : </td>
             <td><input type="password" name="passwd" size="30"></td>
             <td><input type="hidden" name="id" value="<%= request.getParameter("id") %>"></td>
          </tr>           
       </table><br><br>
       <input type="submit" value="삭제하기">  
       <input type="reset" value="다시쓰기">
     </form>
     <img src="image/green_tree.gif">
     <a href="Board-read.jsp?id=<%= request.getParameter("id") %>"> 삭제 취소 </a>
     <img src="image/island.gif" width="99%">
   </center>
  </body>
</html>