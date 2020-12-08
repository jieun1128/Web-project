<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>동국 기숙사</title>	<!-- newIdCheck.jsp -> 아이디 중복확인 -->
</head>
<body>
<%
	String id = request.getParameter("id");	//newID.jsp에서 넘겨받은 id 파라미터
	boolean check = false;		//중복 여부 경우를 나누기 위한 변수
	Connection conn = null;
     Statement stmt = null;
     ResultSet rs = null;
 
     try { 
    	 Class.forName("com.mysql.jdbc.Driver");
	       String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";	//DB이름: dormitory
	       conn = DriverManager.getConnection(url, "root", "0000");
	       stmt = conn.createStatement();
         String sql = "select id from member";	//DB에서 member 테이블에서 id 속성값 불러오기
         rs = stmt.executeQuery(sql);
     }
     catch(Exception e) {
           out.println("DB 연동 오류입니다. : " + e.getMessage());
     }
     
     if(id.equals("")){		//아무것도 입력받지 않았을 경우
    	 check = true;	//check에 true 저장
    	 response.sendRedirect("newID.jsp");  	//newID페이지에 머무름
     }
     
     while(rs.next()) {
		 if(id.equals(rs.getString("id")))	//id가 DB에 존재하는 아이디일 경우
		 {
			check = true;	//check에 true 저장
		    out.println("<script>alert('사용 불가능한 아이디입니다.'); history.back();</script>");	//사용 불가한 아이디라는 멘트를 팝업창으로 출력하고, 되돌아가기
       	     break;
	         }
         }
     
     	if(check == false){	//중복되는 아이디가 아닌 경우
     		session.setAttribute("id", id);	//id를 세션으로 저장하고
			response.sendRedirect("newMember.jsp");    	//newMember.jsp로 이동   
     	}
     %>
</body>
</html>