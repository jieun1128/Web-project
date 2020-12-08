<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동국 기숙사</title>
<link rel="stylesheet" type="text/css" href="project.css"/>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");	// session에 저장된 현재 로그인 한 이용자의 id를 불러온다.
		String name = request.getParameter("name"); //이름 불러오기
		String nickName = request.getParameter("nickName");	// 닉네임 불러오기
		String major = request.getParameter("major");	// 전공 불러오기
		int grade = Integer.parseInt(request.getParameter("grade"));	//학년 불러오기
		String dorm = request.getParameter("dorm");	//기숙사 불러오기
		int age = Integer.parseInt(request.getParameter("age"));	//나이 불러오기
		String gender = request.getParameter("gender");	//성별 불러오기
		String nation = request.getParameter("nation");	//국적 불러오기
		String college = request.getParameter("college");	//단과 대학 불러오기
		Connection conn = null;	// DB연결
	  	Statement stmt = null;
	  	String sql_update = null;	//sql문
	  	ResultSet rs = null; 		//ResultSet 
	  
	  	
	  	try{
	  		Class.forName("com.mysql.jdbc.Driver");
	  		String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	  		conn = DriverManager.getConnection(url,"root","0000");
	  		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	  		// 수정 받은 정보를 불러와서 데이터베이스를 업데이트 하기 
	  		sql_update = "update member set name = '" + name+"',nickName = '"+nickName+"',major = '"+
	  			     major+"', grade = '" + grade +"', dorm = '" + dorm +"', age = '" + age +
	  			   "', sex = '" + gender +"', nation = '" + nation +"', college = '" + college +
	  			     "'where id = '" + id+"'";
	  		stmt.executeUpdate(sql_update);
	  	}catch(Exception e){
	  		out.println("DB 연동 오류입니다. : " + e.getMessage());
	  	}
	  
	%>
<center>
<br><br>
<h3 >수정이 완료되었습니다.</h3> <!-- 돌아가기 -->
<p><a href="mypage.jsp" style="color: white">돌아가기</a></p>
</center>
</body>
</html>