<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>동국 기숙사</title>	<!-- findPW.jsp -> 비밀번호 찾는 화면 -->
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
    <h3>비밀번호 찾기</h3><br>
    <form method="post" action="notifyPW.jsp">	<!-- submit 클릭 시 notifyPW.jsp 화면으로 넘겨짐 -->
        <table>
        <tr>
            <td>ID</td> 
            <td><input type="text" name="id" placeholder="아이디"></td>	<!-- 아이디 입력받기 -->
        </tr>
        </table>
        <br>
        <input type="submit" value="비밀번호 확인하기">
    </form>
  </center>
</body>
</html>
