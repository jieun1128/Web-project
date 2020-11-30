<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<title>동국 기숙사</title>  <!-- main.jsp -> 메인 화면 -->
<link rel="stylesheet" type="text/css" href="project.css"/>

<style type="text/css">
body{
margin:30px;
}
#head1{
left : 50px;
float:left;
position : absolute;
}
#head2{
left : 550px;
float:left;
position : absolute;
}
#head3{
float:left;
left: 1000px;
position : absolute;
}
#choose_btn{
width: 300px;
height: 150px;
font-size: 20pt;
}
#board{  
float:left;
margin:50px;
position : absolute;
top : 300px;
}
#board2{
position: absolute;
top : 300px;
float:left;
left : 600px;
margin:50px;
}
table{
padding:5px;
width: 500px;
height: 200px;
border: 2px ridge white;
background-color:skyblue;
text-color:black;
border-radius: 1em;
}
footer{
clear:both;
position : absolute;
top : 700px;
left : 50px;
}
</style>

</head>


<body>
  <frame>

    <header>
     <div id="head1">
        <h1>동국대 기숙사 룸메 찾기</h1>
        <input type="image" src="dongguk.png">
     </div>
     <div id="head2">
        <h2>내 룸메이트는 누구?~</h2>
        <input type="button" id="choose_btn" value="룸메이트 고르러 가자!"  onClick="location.href='choose.jsp'">  <!-- 룸메이트 고르는 화면으로 이동 -->
     </div>
     <div id="head3">
        <input type="image" src="ele.png">
        <h3><%= session.getAttribute("id") %>님 환영합니다!</h3>  <!-- loginCheck.jsp에서 세션으로 저장한 id값 출력하기 -->
        <input type="button" value="마이 페이지"  onClick="location.href='mypage.jsp'">  <!-- 마이페이지 이동 -->
        <input type="button" value="로그아웃" onClick="location.href='login.jsp'">  <!-- 로그아웃 시 로그인 화면으로 이동 -->
     </div>
    </header>
        <content>
        <br>
      <div id="board">  <!-- 공지 게시판 -->
        <br><br>
        <h3> 공지 게시판 </h3>
        <table>
          <tr>
            <td> 리스트항목1 </td>
          </tr>
          <tr>
            <td> 리스트항목2 </td>
          </tr>
          <tr>
            <td> 리스트항목3 </td>
          </tr>
          <tr>
            <td> 리스트항목4 </td>
          </tr>
          <tr>
            <td> 리스트항목5 </td>
          </tr>
        </table> <br>
        <input type="button" value="공지 게시판 바로가기" href="notice.jsp">  <!-- 공지 게시판으로 이동 -->
      </div>

      <div id="board2">  <!-- 민원 게시판 -->
        <br><br>
        <h3> 민원 게시판 </h3>
        <table>
          <tr>
            <td> 리스트항목1 </td>
          </tr>
          <tr>
            <td> 리스트항목2 </td>
          </tr>
          <tr>
            <td> 리스트항목3 </td>
          </tr>
          <tr>
            <td> 리스트항목4 </td>
          </tr>
          <tr>
            <td> 리스트항목5 </td>
          </tr>
        </table> <br>
        <input type="button" value="민원 게시판 바로가기" href="complain.jsp">  <!-- 민원 게시판으로 이동 -->
      </div>
    </content>
    
    <footer>
      <br>
      <a href="http://www.dongguk.edu/"> 동국대학교 홈페이지 바로가기 </a>
    </footer>

  </frame>
</body>
</html>
