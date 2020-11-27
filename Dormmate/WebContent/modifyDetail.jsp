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
        <h1>세부 정보 수정</h1>
        <h3 style = "background-color: lightgray; color : black;">&nbsp;> 나의 세부 정보</h3>
        <%
		String id = request.getParameter("id");
        String version = request.getParameter("version");
        String url="";
        if(version.equals("create")){url = "compCreatetDetailInfo.jsp";}
        else if(version.equals("modify")){url = "compModifyDetailInfo.jsp";}
        %>
        <form method = "post" action = "<%=url%>">
        <table>
            <tr>
            <td>일주일에 씻는 횟수 (0에서 7 사이로 표현) </td>
                <td><select name="washing">
                	<option disabled selected>선택해 주세요</option>
                	<option value="1" >1</option>
			        <option value="2" >2</option>
			        <option value="3" >3</option>
			        <option value="4" >4</option>
			        <option value="5" >5</option>
			        <option value="6" >6</option>
			        <option value="5" >7</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>시끄러운 정도(1에서 5사이, 조용하면 1 시끄러우면 5) </td>
                <td><select name="noise">
                	<option disabled selected>선택해 주세요</option>
                	<option value="1" >1</option>
			        <option value="2" >2</option>
			        <option value="3" >3</option>
			        <option value="4" >4</option>
			        <option value="5" >5</option>
                </select>
                </td>
            </tr>
             <tr>
                <td>일주일에 청소 횟수(0에서 7사이) </td>
                <td><select name="cleaning">
                	<option disabled selected>선택해 주세요</option>
                	<option value="1" >1</option>
			        <option value="2" >2</option>
			        <option value="3" >3</option>
			        <option value="4" >4</option>
			        <option value="5" >5</option>
			        <option value="6" >6</option>
			        <option value="5" >7</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>한달에 외박 횟수 </td>
                <td><input type = "text" name="sleptOut" value = "ex)4"></td>
            </tr>
            <tr>
                <td>흡연 여부</td>
                <td><select name="smoking">
                	<option disabled selected>선택해 주세요</option>
                	<option value="0" >안한다</option>
			        <option value="1" >한다</option>
			        </select>
			    </td>
            </tr>
            <tr>
                <td>종교 </td>
                <td><select name="religion">
                	<option disabled selected>선택해 주세요</option>
                	<option value="기독교" >기독교</option>
			        <option value="불교" >불교</option>
			        <option value="천주교" >천주교</option>
			        <option value="없음" >무교</option>
			        <option value="그외" >그외</option>
			        </select>
			    </td>
            </tr>
            <tr>
                <td>룸메와 친해지고 싶은 정도(1~5사이) </td>
                <td><select name="closeness">
                	<option disabled selected>선택해 주세요</option>
                	<option value="1" >1</option>
			        <option value="2" >2</option>
			        <option value="3" >3</option>
			        <option value="4" >4</option>
			        <option value="5" >5</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>취침시간 잠에드는 시간/ 일어나는 시간 </td>
                <td><input type = "text" name="sleepTime" value="ex) P.M. 11:00"%>
                	<input type = "text" name="wakeTime" value="ex) A.M. 10:00"%>
                </td>
            </tr>
            <tr>
                <td > 오픈 카톡 주소 </td>
                <td><input type = "text" name="address" value = "https://open.kakao.com//"></td>
            </tr>
        </table>
        
        <br><br>
        <center>
            <input type="submit" style = "width : 100pt; height:40pt"value="수정 완료">
        	<input type="hidden" name = "id" value="<%=id %>">
        </center>
        </form>
	</body>
</html>