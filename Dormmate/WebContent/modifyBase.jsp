<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
    <head>
        <title>동국 기숙사</title>
        <link rel="stylesheet" type="text/css" href="project.css"/>
        <style>
            table {
              width: 100%;
              border-collapse: collapse;
            }
            th, td {
              border-bottom: 1px solid lightgray;
              padding: 10px;
            }
          </style>
    </head>
    <body>
        <h1>기본 정보 수정</h1>
        <h3 style = "background-color: lightgray; color : black;">&nbsp;> 나의 정보</h3>
        <%
        String id = request.getParameter("id");
      	Connection conn = null;
      	Statement stmt = null;
      	String sql = null;
      	ResultSet rs = null;
      
      	
      	try{
      		Class.forName("com.mysql.jdbc.Driver");
      		String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
      		conn = DriverManager.getConnection(url,"root","0000");
      		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
      		sql = "select * from member where id = '" + id + "'";
      		rs = stmt.executeQuery(sql);
      	}catch(Exception e){
      		out.println("DB 연동 오류입니다. : " + e.getMessage());
      	}
      	  while(rs.next())
            {
        %>
        <form method = "post" action = "compModifyInfo.jsp">
        <table>
            <tr>
            <td>이름 </td>
                <td><input type = "text" name = "name" value= <%=rs.getString("name") %> >
                </td>
            </tr>
            <tr>
                <td>닉네임 </td>
                <td><input type = "text" name="nickName" value = <%=rs.getString("nickName") %>></td>
            </tr>
             <tr>
                <td>단과대 </td>
                <td><input type = "text" name="college" value = <%=rs.getString("college") %>></td>
            </tr>
            <tr>
                <td>학과 </td>
                <td><input type = "text" name="major" value = <%=rs.getString("major") %>></td>
            </tr>
            <tr>
                <td>학년 </td>
                <td><input type = "text" name="grade" value = <%=rs.getInt("grade") %>></td>
            </tr>
            <tr>
                <td>기숙사 </td>
                <td><input type = "text" name="dorm" value = <%=rs.getString("dorm") %>></td>
            </tr>
            <tr>
                <td>나이 </td>
                <td><input type = "text" name="age" value = <%=rs.getInt("age") %>></td>
            </tr>
            <tr>
                <td>성별 </td>
                <td><input type = "text" name="gender" value = <%=rs.getString("sex") %>></td>
            </tr>
            <tr>
                <td >국적 </td>
                <td><input type = "text" name="nation" value = <%=rs.getString("nation") %>></td>
            </tr>
        </table>
        <%
            }
        %>
        <br><br>
        <center>
            <input type="submit" style = "width : 100pt; height:40pt"value="수정 완료">
        	<input type="hidden" name = "id" value="<%=id %>">
        </center>
        </form>
    </body>
</html>