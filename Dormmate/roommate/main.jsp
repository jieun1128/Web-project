<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<title>동국 기숙사</title>  <!-- main.jsp -> 메인 화면 -->
<link rel="stylesheet" type="text/css" href="sideNavi.css"/>

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
#dgu{
font-size: 10px;
fot-color:black;
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
a { text-decoration:none;
 }
</style>

</head>


<body>
  <frame>

    <header>
     <div id="head1">
        <h1>동국대 기숙사 룸메 찾기</h1>
        <input type="image" src="dongguk.png">
       <a href="http://www.dongguk.edu/"><p id="dgu"> 동국대학교 홈페이지 바로가기 </p></a>
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
        <%
        String id = (String)session.getAttribute("id");// 변경 
        Connection conn = null;
 		Statement stmt = null;
 		String sql = null;
  		ResultSet rs = null;
        try{
      	  Class.forName("com.mysql.jdbc.Driver");
      	  String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";//localhost:3306/dormitory?serverTimezone=UTC"; // 바꾸기 
      	  conn = DriverManager.getConnection(url,"root","0000"); // 바꾸기 
      	  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
      	  sql="select * from notice order by agree desc";
      	  rs = stmt.executeQuery(sql);
        }
        
        catch(Exception e ){
      	  out.println("DB 연동 오류입니다. : " + e.getMessage());
        }
        int rownum=1;
        %>
        <table>
         <tr style="background-color:Lightgray; height:40px;">
                   <td align="center" width="30">글번호</td>
                   <td align="center" width="50">글쓴이</td>
                   <td align="center"width="100">글제목</td>
                   <td align="center" width="30">공감수</td>
                   <td align="center" width="30">비공감수</td>
         </tr>
        <% 
       	while(rs.next()){
       		if(rownum == 6)break;
        %>
          <tr>
              <tr style="background-color:white; color: black; height:30px;">
             <td align="center"><%= rownum %> </td>
             <td align="left"><%=rs.getString("userID") %></td>
             <td align="left">
               <a href="complain-read.jsp?tableID=<%=rs.getString("tableID") %>"><%=rs.getString("title") %></a>
             </td>
             <td align="center"><%= rs.getInt("agree") %></td>	 <!-- int형정보 agree, disagree -->
      		 <td align="center"><%= rs.getInt("disagree") %></td>
            </tr>
          </tr>
          <%
          rownum++;
       	}
          %>
        </table> <br>
        <input type="button" value="공지 게시판 바로가기" onClick="location.href='notice.jsp'">  <!-- 공지 게시판으로 이동 -->
      </div>

      <div id="board2">  <!-- 민원 게시판 -->
        <br><br>
        <h3> 민원 게시판 </h3>
        <table>
           <tr style="background-color:Lightgray; height:40px;">
                   <td align="center" width="30">글번호</td>
                   <td align="center" width="50">글쓴이</td>
                   <td align="center"width="100">글제목</td>
                   <td align="center" width="30">공감수</td>
                   <td align="center" width="30">비공감수</td>
         </tr>
        <%
        try{	
        	sql="select * from complain order by agree desc";
  	  		rs = stmt.executeQuery(sql);
        }catch(Exception e){
        	out.println("DB 연동 오류입니다. : " + e.getMessage());
        }
        rownum=1;
        while(rs.next()){
        	if(rownum == 6)break;
        %>
          <tr style="background-color:white; color: black; height:30px;">
             <td align="center"><%= rownum %> </td>
             <td align="left"><%=rs.getString("userID") %></td>
             <td align="left">
               <a href="complain-read.jsp?tableID=<%=rs.getString("tableID") %>"><%=rs.getString("title") %></a>
             </td>
             <td align="center"><%= rs.getInt("agree") %></td>	 <!-- int형정보 agree, disagree -->
      		 <td align="center"><%= rs.getInt("disagree") %></td>
            </tr>
          <%
          rownum++;
        }
          %>
        </table> <br>
        <input type="button" value="민원 게시판 바로가기" onClick="location.href='complain.jsp'">  <!-- 민원 게시판으로 이동 -->
      </div>
    </content>
    
  



  </frame>
</body>
</html>
