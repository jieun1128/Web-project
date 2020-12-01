<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동국 기숙사</title>		<!-- notifyPW.jsp -> 아이디에 일치하는 비밀번호 출력하는 화면 -->
<link rel="stylesheet" type="text/css" href="project.css"/>
</head>
<body>
<%
    String id = request.getParameter("id");		//findPW.jsp에서 넘어온 id 파라미터
    boolean check = false;		//아이디 일치 여부에 따른 경우를 나누기 위한 변수
     Connection conn = null;
     Statement stmt = null;
     ResultSet rs = null;
 
     try { 
           Class.forName("com.mysql.jdbc.Driver");
	       String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";	//DB이름: dormitory
	       conn = DriverManager.getConnection(url, "root", "0000");
	       stmt = conn.createStatement();
           String sql = "select id, pwd from member";	//DB에서 member테이블에서 id,pwd 속성값 불러오기
           rs = stmt.executeQuery(sql);
     }
     catch(Exception e) {
           out.println("DB 연동 오류입니다. : " + e.getMessage());
     }
     
     while(rs.next()) {
		 if(id.equals(rs.getString("id")))
		 {	//id가 DB에 존재하는 아이디일 경우
		   %>
       	   <center>
       	      <h2><%=id %>님의 비밀번호는</h2>
		      <p><%= rs.getString("pwd")%> 입니다.</p><br>	<!-- 아이디에 해당하는 비밀번호 출력 -->
       	      <input type=button value="로그인하러 가기" onClick="location.href='login.jsp' ">
       	   </center>
       	   <% 
       	     check = true;	//check에 true 저장
       	     break;
	         }
         }
     
        	if(check == false){		//id가 DB에 존재하지 않는 아이디일 경우
        		%>
        		<center>
			    <h2> 존재하지 않는 아이디입니다. </h2><br>	<!-- 존재하지 않는 아이디라는 멘트 출력 -->
			    <input type=button value="뒤로가기" onClick="location.href='findPW.jsp' ">		<!-- 뒤로가기 -> 비밀번호 찾는 화면으로 이동 -->
			    <input type=button value="회원가입하기" onClick="location.href='newID.jsp' ">	 <!-- 회원가입 화면으로 이동 -->
			  </center>
			  <%
        	}
            %>
</body>
</html>