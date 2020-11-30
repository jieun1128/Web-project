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
top : 400px;
left : 50px;
}
</style>

</head>


<body>
  <frame>

    <header>
     <div id="head">
        <h1>동국대 기숙사 룸메 찾기</h1>
        <input type="image" src="dongguk.png">
     </div>
     <div id="head" style="margin-left: 300px;">
        <h2>내 룸메이트는 누구?~</h2>
        <form method="post" action="choose.jsp">
            <input type="submit" style = "width : 120pt; height:40pt; font-style: bold;"value="룸메이트 고르러 가자!">
 			<input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
        </form>
     </div>
     <div id="head" style="float:right">
        <input type="image" src="ele.png">
        <h3 style="margin-right:60px;"><%= session.getAttribute("id") %>님 환영합니다!</h3><br>
        <form method="post" action="mypage.jsp">
            <input type="submit" style = "width : 100pt; height:40pt; font-style: bold;"value="마이페이지">
 			<input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
        </form>
        <input type="button" value="로그아웃" onClick="location.href='login.jsp'">
     </div>
    </header>
<%

    int tableID;
    int rownum1=1, rownum2=1;
    Connection conn = null;
    Statement stmt = null;
    String sql1 = null;
    ResultSet rs1 = null;    
    String sql2 = null;
    ResultSet rs2 = null; 
    String id = (String)request.getParameter("id");// 변경 
    
    try{
    	  Class.forName("com.mysql.jdbc.Driver");
    	  String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";//localhost:3306/dormitory?serverTimezone=UTC"; // 바꾸기 
    	  conn = DriverManager.getConnection(url,"root","0000"); // 바꾸기 
    	  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    	  sql1="select * from notice order by tableID desc";
    	  rs1 = stmt.executeQuery(sql1);
  	  
      }
      
     catch(Exception e ){
    	  out.println("DB 연동 오류입니다. : " + e.getMessage());
      }
  /*
    try{
    	sql2="select * from complain order by tableID desc";
        rs2 = stmt.executeQuery(sql2);
     }
     catch(Exception e){
        out.println("DB 연동 오류입니다. :"+e.getMessage());
     }*/
 %>
   
        <content>
      <div id="board">
        <br><br>
        <h3> 공지 게시판 </h3>
        <table>
      <tr style="background-color:Lightgray; height:20;">
                   <td align="center" width="10">글번호</td>
                   <td align="center" width="15">글쓴이</td>
                   <td align="center"width="50">글제목</td>
                   <td align="center" width="10">공감수</td>
                   <td align="center" width="10">비공감수</td>
   </tr>
  <%
      while(rs1.next() && rownum1<6)
      {
    	  %>
    	  
    	  <tr style="background-color:white; color: black; height:20;">
             <td align="center"><%= rownum1 %> </td>
             <td align="left"><%=rs1.getString("nickName") %></td>
             <td align="left"><a href=notice-read.jsp?tableID=<%=rs1.getString("tableID") %>><%=rs1.getString("title") %></td>
             <td align="center"><%= rs1.getString("agree") %></td>
      		 <td align="center"><%= rs1.getString("disagree") %></td>
          </tr>
        
      <%
      
           rownum1++;
      }
      %>  
        </table> <br>
        <a href="complain.jsp?id=<%= id %>"><input type="button" value="공지 게시판 바로가기"></a>

      </div>

      <div id="board2">
        <br><br>
        <h3> 민원 게시판 </h3>
        <table>
     <tr style="background-color:Lightgray; height:20;">
                   <td align="center" width="10">글번호</td>
                   <td align="center" width="15">글쓴이</td>
                   <td align="center"width="50">글제목</td>
                   <td align="center" width="10">공감수</td>
                   <td align="center" width="10">비공감수</td>
   </tr> 
        </table> <br>
        <a href="complain.jsp?id=<%= id %>"><input type="button" value="민원 게시판 바로가기"></a>
      </div>
    </content>
    
    <footer>
      <br>
      <a href="http://www.dongguk.edu/"> 동국대학교 홈페이지 바로가기 </a>
    </footer>

  </frame>
</body>
</html>
