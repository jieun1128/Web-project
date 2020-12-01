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
            table { /* 테이블 속성 */
              width: 100%;
              border-collapse: collapse;
            }
            th, td { /* 테이블 세부 속성 */
              border-bottom: 1px solid lightgray;
              padding: 10px;
            }
          </style>
    </head>
    <body>
        <h1>기본 정보 수정</h1>
        <h3 style = "background-color: lightgray; color : black;">&nbsp;> 나의 정보</h3>
        <%
        String id = (String)session.getAttribute("id");	// session에 저장된 현재 로그인 한 이용자의 id를 불러온다.
      	Connection conn = null;	// DB연결
      	Statement stmt = null;	// DB연결
      	String sql = null;		// sql문
      	ResultSet rs = null;	// ResultSet
      
      	
      	try{
      		Class.forName("com.mysql.jdbc.Driver");
      		String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
      		conn = DriverManager.getConnection(url,"root","0000");
      		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
      		sql = "select * from member where id = '" + id + "'";	// 데이터 베이스 연결 후 현재 이용자의 정보를 select 해 온다.
      		rs = stmt.executeQuery(sql);	// 쿼리해 온 정보를 rs에 저장
      	}catch(Exception e){
      		out.println("DB 연동 오류입니다. : " + e.getMessage());
      	}
      	  while(rs.next())
            {		// radioBox에 사용할 grade, dorm, sex 정보를 데이터베이스에서 불러온다.
      		  String grade = rs.getString("grade");	
      		  String dorm = rs.getString("dorm");
      		  String gender = rs.getString("sex");
        %>
        <form method = "post" action = "compModifyInfo.jsp"> <!-- 수정한 기본정보를 compModifyInfo.jsp로 보낸다. -->
        <table>
            <tr>
            <td>이름 </td> <!-- text박스에 데이터베이스에 입력되어 있던 정보를 일단 출력해둔다. -->
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
                <td>학년 </td> <!-- radiobox에서는 데이터베이스에 입력되어있는 정보와 같은 항목에 먼저 체크해 둔다. -->
                <td><input type = "radio" name="grade" value="1"<%if("1".equals(grade)){%>checked<%} %>> 1학년
                	<input type = "radio" name="grade" value="2"<%if("2".equals(grade)){%>checked<%} %>> 2학년
                	<input type = "radio" name="grade" value="3"<%if("3".equals(grade)){%>checked<%} %>> 3학년
                	<input type = "radio" name="grade" value="4"<%if("4".equals(grade)){%>checked<%} %>> 4학년
                </td>
            </tr>
            <tr>
                <td>기숙사 </td>
                <td><input type = "radio" name="dorm" value="남산학사"<%if("남산학사".equals(dorm)){%>checked<%} %>> 남산학사
                	<input type = "radio" name="dorm" value="충무학사"<%if("충무학사".equals(dorm)){%>checked<%} %>> 충무학사</td>
            </tr>
            <tr>
                <td>나이 </td>
                <td><input type = "text" name="age" value = <%=rs.getInt("age") %>></td>
            </tr>
            <tr>
                <td>성별 </td>
                <td><input type = "radio" name="gender" value="남자"<%if("남자".equals(gender)){%>checked<%} %>> 남자
                	<input type = "radio" name="gender" value="여자"<%if("여자".equals(gender)){%>checked<%} %>> 여자</td>
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
        <center> <!-- 수정 완료버튼을 누르면 완료 페이지로 넘어간다. -->
            <input type="submit" style = "width : 100pt; height:40pt"value="수정 완료">
        </center>
        </form>
    </body>
</html>