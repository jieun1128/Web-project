<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head><title> 게시판 </title></head>
<body>
<center>

<h2> 게 시 판 </h2>
<form action="Board-insert-db.jsp" method="post">
<table border="0">

<tr>
  <td><img src="image/ball.gif"> 글 쓴 이 </td>
  <td><input type="text" name="name" size="15"></td>
</tr>
<tr>
  <td><img src="image/ball.gif"> 메일주소 : </td>
  <td><input type="text" name="e_mail" size="30"></td>
</tr>
<tr>
  <td><img src="image/ball.gif"> 글 제 목 : </td>
  <td><input type="text" name="title" size="50"></td>
</tr>
<tr>
  <td><img src="image/ball.gif"> 글 내 용 : </td>
  <td><textarea name="content" cols="65" rows="4"></textarea></td>
</tr>
<tr>
  <td><img src="image/ball.gif"> 패스워드 : </td>
  <td><input type="password" name="passwd" size="10" maxlength="8"></td>
</tr>
</table><br><br>

<input type="submit" value="등록하기">
<input type="reset" value="다시쓰기">



<%
   String flag = request.getParameter("flag");
   if("r".equals(flag)){%>
   		<input type="hidden" name="ref" value="<%=request.getParameter("ref") %>">
   		<input type="hidden" name="reply" value="y">
   <%} else %>
   		<input type="hidden" name="reply" value="n">
  </form>
	
<img src="image/green_tree.gif">
<a href="board_list.jsp"> 게시글 목록 보기 </a><br>
<img src="image/island.gif" width="95%">
</center>
</body>
</html>