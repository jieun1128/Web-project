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
        <h1>회원가입</h1>
        <h3 style = "background-color: lightgray; color : black;">>나의 정보</h3>
        <table>
            <tr>
                <td>아이디 </td>
                <td><input type = "text">
                    <input type="button" value="중복확인">
                </td>   
            </tr>
            <tr>
                <td>비밀번호 </td>
                <td><input type = "text"></td>
            </tr>
            <tr>
            <td>이름 </td>
                <td><input type = "text">
                </td>
            </tr>
            <tr>
                <td>닉네임 </td>
                <td><input type = "text"></td>
            </tr>
            <tr>
                <td>학과 </td>
                <td><input type = "text"></td>
            </tr>
            <tr>
                <td>학년 </td>
                <td><input type = "text"></td>
            </tr>
            <tr>
                <td>기숙사 </td>
                <td><input type = "text"></td>
            </tr>
            <tr>
                <td>나이 </td>
                <td><input type = "text"></td>
            </tr>
            <tr>
                <td>성별 </td>
                <td><input type = "text"></td>
            </tr>
            <tr>
                <td >국적 </td>
                <td><input type = "text"></td>
            </tr>
        </table>
        <br><br>
        <form method = "post" action = "newJoin.jsp">
        <center>
            <input type="submit" style = "width : 100pt; height:40pt"value="회원가입 완료">
        </center>
        </form>
    </body>
</html>