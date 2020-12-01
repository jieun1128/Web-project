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


            <button type="button" id="sidebarCollapse" class="btn btn-info">
                <i class="fas fa-align-left"></i>
                <span>메뉴</span>
            </button>

            <br>
            <br>

<form action="complain-insert-db.jsp" method="post">
<center>
<h3 style="color:white"> 민원글 작성하기 </h3> <br><br>
<table border="0">

<tr>
  <td> 글 쓴 이 : </td>
  <td>
  <% 
	String id = (String)session.getAttribute("id");// 변경 
  %>
  <%= id %>
  </td>
</tr>
<tr>
  <td>글 제 목 : </td>
  <td><input type="text" name="title" size="50"></td>
</tr>
<tr>
  <td> 글 내 용 : </td>
  <td><textarea name="content" cols="65" rows="4"></textarea></td>
</tr>
</table><br><br>

<input type="submit" value="등록하기" style="background-color: lightgrey; width:100px; height: 50px;">
<input type="reset" value="다시쓰기" style="background-color: lightgrey; width:100px; height: 50px;">

</center>


</body>
</html>