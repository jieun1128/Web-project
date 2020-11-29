<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <form method = "post" action = "newJoin.jsp">
        <h1>회원가입</h1>
        <h3 style = "background-color: lightgray; color : black;">>나의 정보</h3>
        <table>
            <tr>
                <td>아이디 </td>
                <td>
                	<b><%= session.getAttribute("id") %></b>
                	(사용 가능한 아이디입니다.)&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" value="아이디 다시 만들기" onClick="location.href='newID.jsp' ">
                </td>   
            </tr>
            <tr>
                <td>비밀번호 </td>
                <td><input type = "text" name="pw"></td>
            </tr>
            <tr>
            <td>이름 </td>
                <td><input type = "text" name="name">
                </td>
            </tr>
            <tr>
            <td>닉네임 </td>
                <td><input type = "text" name="nick">
                </td>
            </tr>
            <tr>
                <td>단과 대학 </td>
                <td><input type = "text" name="college"></td>
            </tr>
            <tr>
                <td>학과 </td>
                <td><input type = "text" name="major"></td>
            </tr>
            <tr>
                <td>학년 </td>
                <td>
                	<input type = "radio" name="grade" value="1"> 1학년
                	<input type = "radio" name="grade" value="2"> 2학년
                	<input type = "radio" name="grade" value="3"> 3학년
                	<input type = "radio" name="grade" value="4"> 4학년
                </td>
            </tr>
            <tr>
                <td>기숙사 </td>
                <td>
                	<input type = "radio" name="dorm" value="남산학사"> 남산학사
                	<input type = "radio" name="dorm" value="충무학사"> 충무학사
                </td>
            </tr>
            <tr>
                <td>나이 </td>
                <td><input type = "text" name="age">&nbsp;세</td>
            </tr>
            <tr>
                <td>성별 </td>
                <td>
                	<input type = "radio" name="gender" value="남자"> 남자
                	<input type = "radio" name="gender" value="여자"> 여자
                </td>
            </tr>
            <tr>
                <td >국적 </td>
                <td><input type = "text" name="nation"></td>
            </tr>
        </table>
        <br><br>
        <center>
            <input type="submit" style = "width : 100pt; height:40pt"value="회원가입 완료">
        </center>
        </form>
    </body>
</html>