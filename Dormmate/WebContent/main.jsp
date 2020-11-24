<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<title>동국 기숙사</title>
<link rel="stylesheet" type="text/css" href="project.css"/>

<style type="text/css">

body{
margin:30px;
}

#head{
position : relative;
left : 50px;
float:left;
}

#choose_btn{
width: 300px;
height: 150px;
float: center;
font-size: 20pt;
}

#board{
float:left;
margin:50px;
position : absolute;
top : 200px;
}

#board2{
position: absolute;
top : 200px;
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
position : relative;
top : 300px;
left : 50px;
}

</style>

</head>


<body>
	<%
	int id;
	String title="",passwd="",sql;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null; // 아이디와 패스워드 확인할 resultset
	ResultSet ts = null; // 공지글 혹은 민원글 데이터 베이스에서 제목 쿼리해 올 resultset 
	id = Integer.parseInt(request.getParameter("id"));
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
	     String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
	     conn = DriverManager.getConnection(url, "root", "0000");
	     stmt = conn.createStatement();
         sql = "select * from board_tbl where id = " + id; // 테이블 이름을 회원정보로 바꾸기 
         rs = stmt.executeQuery(sql);
	}catch(Exception e){
		out.println("DB 연동 오류입니다.: "+ e.getMessage());
	}
	
	passwd = request.getParameter("pwd");
	
	while(rs.next()){
		if(!passwd.equals(rs.getString("pwd")))
		{
	%>
	<center><h2> 잘못 입력된 패스워드입니다. </h2>
	<img src="image/green_tree.gif">
	<a href="Board-read.jsp?id=<%= request.getParameter("id") %>"> 뒤로 </a>
	</center>
	<%
		}
		else{
			sql = "select * from board_tbl order by ref desc, id asc "; 
			// 테이블 이름을 공지글 정보로 바꾸고 5개만 가져오기 
	    	ts = stmt.executeQuery(sql);
			while(ts.next()){ // 공지글 가져오기 
	%>
  <frame>

    <header>
     <div id="head">
        <h1>동국대 기숙사 룸메 찾기</h1>
        <input type="image" src="dongguk.png">
     </div>
     <div id="head" style="margin-left: 300px;">
        <h2>내 룸메이트는 누구?~</h2>
        <input type="button" id="choose_btn" value="룸메이트 고르러 가자!" href="choose.jsp">
     </div>
     <div id="head" style="float:right">
        <input type="image" src="ele.png">
        <h3 style="margin-right:60px;">'사용자'님 환영합니다!</h3><br>
        <input type="button" value="마이 페이지" href="mypage.jsp">
        <input type="button" value="로그아웃" href="login.jsp">
     </div>
    </header>
      
    <content>
      <div id="board">
        <br><br>
        <h3> 공지 게시판 </h3>
        <table>
      
          <tr>
            <td align = "left"> 
            <%=ts.getString("title") %> <!-- 제목만 읽어오기 -->
            </td>
          </tr>
          <%
			}
          %>
          <%
          sql = "select * from board_tbl order by ref desc, id asc "; 
			// 테이블 이름을 민원글 정보로 바꾸고 5개만 가져오기 
	    	ts = stmt.executeQuery(sql);
			while(ts.next()){ // 민원글 가져오기 
          %>
        </table> <br>
        <input type="button" value="공지 게시판 바로가기" href="notice.jsp">
      </div>
      <div id="board2"> <!--  민원도 공지와 비슷하게 하면 될듯  -->
        <br><br>
        <h3> 민원 게시판 </h3>
        <table>
          <td align = "left"> 
            <%=ts.getString("title") %> <!-- 제목만 읽어오기 -->
            </td>
          <%
			}}}
          %>
        </table> <br>
        <input type="button" value="민원 게시판 바로가기" href="complain.jsp">
      </div>
    </content>

    <footer>
      <br>
      <a href="http://www.dongguk.edu/"> 동국대학교 홈페이지 바로가기 </a>
    </footer>

  </frame>
</body>
</html>
