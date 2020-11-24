<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>동국 기숙사</title>
    <link rel="stylesheet" type="text/css" href="project.css"/>
        <style>
            table {
              border-collapse: collapse;
            }
            tr, td {
              padding: 12px;
            }
          </style>
</head>

<body>
  <center>
    <input type="image" src="dongguk.png">
    <h3>비밀번호 찾기</h3><br>
    <form method="post" action="notifyPW.jsp">
        <table>
        <tr>
            <td>ID</td> 
            <td><input type="text" name="id" placeholder="아이디"></td>
        </tr>
        <tr>
             <td>어머니의 고향은?</td> 
             <td><input type="text" name="key" placeholder="어머니의 고향은?"></td>
        </tr>
        </table>
        <br>
        <input type="submit" value="비밀번호 확인하기">
    </form>
  </center>
</body>
</html>
