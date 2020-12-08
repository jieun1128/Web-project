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
            table {	/* 테이블 속성 */
              width: 100%;
              border-collapse: collapse;
            }
            th, td {	/* 테이블 세부 속성 */
              border-bottom: 1px solid lightgray;
              padding: 10px;
            }
          </style>
    </head>
    <body>
        <h1>세부 정보 수정</h1>
        <h3 style = "background-color: lightgray; color : black;">&nbsp;> 나의 세부 정보</h3>
        <%
		String id = (String)session.getAttribute("id");	// session에 저장된 현재 로그인 한 이용자의 id를 불러온다.
        String version = request.getParameter("version"); // 생성인지 수정인지에 관한 정보 받아오기
        String url1=""; 
        if(version.equals("create")){url1 = "compCreatetDetailInfo.jsp"; //생성일 경우 입력완료 후 넘어갈 URL
        %>
        <form method = "post" action = "<%=url1%>">
        <table>
            <tr> <!-- 각종 세부 정보 입력받기 default는 맨 윗값으로  -->
            <td>일주일에 씻는 횟수 (0에서 7 사이로 표현) </td>
                <td><select name="washing">
                	<option value="1" selected>1</option>
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
                	<option value="1" selected>1</option>
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
                	<option value="1" selected>1</option>
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
                <td><input type = "text" name="sleptOut" value = "4"></td>
            </tr>
            <tr>
                <td>흡연 여부</td>
                <td><select name="smoking">
                	<option value="0" selected>안한다</option>
			        <option value="1" >한다</option>
			        </select>
			    </td>
            </tr>
            <tr>
                <td>종교 </td>
                <td><select name="religion">
                	<option value="기독교" selected>기독교</option>
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
                	<option value="1" selected>1</option>
			        <option value="2" >2</option>
			        <option value="3" >3</option>
			        <option value="4" >4</option>
			        <option value="5" >5</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>취침시간 잠에드는 시간/ 일어나는 시간 </td>
                <td><input type = "text" name="sleepTime" value="P.M. 11:00">
                	<input type = "text" name="wakeTime" value="A.M. 07:00">
                </td>
            </tr>
            <tr>
                <td > 오픈 카톡 주소 </td>
                <td><input type = "text" name="address" value = "http://open.kakao.com/"></td>
            </tr>
        </table>
        <br><br>
        <center>
            <input type="submit" style = "width : 100pt; height:40pt"value="수정 완료">
        	<input type="hidden" name = "id" value="<%=id %>">
        </center>
        </form>
        <% 
        }
        else if(version.equals("modify")){url1 = "compModifyDetailInfo.jsp";  //수정일 경우 입력완료 후 넘어갈 URL
	        Connection conn = null;
	      	Statement stmt = null;
	      	String sql = null;
	      	ResultSet rs = null;
	      
	      	
	      	try{
	      		Class.forName("com.mysql.jdbc.Driver");
	      		String url2 = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	      		conn = DriverManager.getConnection(url2,"root","0000");
	      		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	      		sql = "select * from memberInfo where id = '" + id + "'";
	      		// 데이터 베이스 연결 후 현재 이용자의 세부 정보를 select 해 온다.
	      		rs = stmt.executeQuery(sql);
	      	}catch(Exception e){
	      		out.println("DB 연동 오류입니다. : " + e.getMessage());
	      	}
	      	  while(rs.next())
	            {  // 각 세부 정보를 각각 맞는 변수에 저장해 둔다.
        		String washing = rs.getString("washing");
        		String noise = rs.getString("noise");
        		String cleaning = rs.getString("cleaning");
        		String sleptOut = rs.getString("sleptOut");
        		String smoking = rs.getString("smoking");
        		String religion = rs.getString("religion");
        		String closeness = rs.getString("closeness");
        		String sleepTime = rs.getString("sleepTime");
        		String wakeTime = rs.getString("wakeTime");
        		String address = rs.getString("address");
        %>
        <form method = "post" action = "<%=url1%>">
        <table>
            <tr>
            <td>일주일에 씻는 횟수 (0에서 7 사이로 표현) </td>
                <td><select name="washing">	<!-- selectbox에서는 데이터베이스에 입력되어있는 정보와 같은 항목에 먼저 체크해 둔다. -->
                	<option value="1" <%="1".equals(washing)?"selected":"" %>>1</option>
			        <option value="2" <%="2".equals(washing)?"selected":"" %>>2</option>
			        <option value="3" <%="3".equals(washing)?"selected":"" %>>3</option>
			        <option value="4" <%="4".equals(washing)?"selected":"" %>>4</option>
			        <option value="5" <%="5".equals(washing)?"selected":"" %>>5</option>
			        <option value="6" <%="6".equals(washing)?"selected":"" %>>6</option>
			        <option value="5" <%="7".equals(washing)?"selected":"" %>>7</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>시끄러운 정도(1에서 5사이, 조용하면 1 시끄러우면 5) </td>
                <td><select name="noise">
                	<option value="1" <%="1".equals(noise)?"selected":"" %>>1</option>
			        <option value="2" <%="2".equals(noise)?"selected":"" %>>2</option>
			        <option value="3" <%="3".equals(noise)?"selected":"" %>>3</option>
			        <option value="4" <%="4".equals(noise)?"selected":"" %>>4</option>
			        <option value="5" <%="5".equals(noise)?"selected":"" %>>5</option>
                </select>
                </td>
            </tr>
             <tr>
                <td>일주일에 청소 횟수(0에서 7사이) </td>
                <td><select name="cleaning">
                	<option value="1" <%="1".equals(cleaning)?"selected":"" %>>1</option>
			        <option value="2" <%="2".equals(cleaning)?"selected":"" %>>2</option>
			        <option value="3" <%="3".equals(cleaning)?"selected":"" %>>3</option>
			        <option value="4" <%="4".equals(cleaning)?"selected":"" %>>4</option>
			        <option value="5" <%="5".equals(cleaning)?"selected":"" %>>5</option>
			        <option value="6" <%="6".equals(cleaning)?"selected":"" %>>6</option>
			        <option value="5" <%="7".equals(cleaning)?"selected":"" %>>7</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>한달에 외박 횟수 </td>
                <td><input type = "text" name="sleptOut" value = <%= sleptOut%>></td>
            </tr>
            <tr>
                <td>흡연 여부</td>
                <td><select name="smoking">
                	<option value="0" <%="0".equals(smoking)?"selected":"" %>>안한다</option>
			        <option value="1" <%="1".equals(smoking)?"selected":"" %>>한다</option>
			        </select>
			    </td>
            </tr>
            <tr>
                <td>종교 </td>
                <td><select name="religion">
                	<option value="기독교" <%="기독교".equals(religion)?"selected":"" %>>기독교</option>
			        <option value="불교" <%="불교".equals(religion)?"selected":"" %>>불교</option>
			        <option value="천주교" <%="천주교".equals(religion)?"selected":"" %>>천주교</option>
			        <option value="없음" <%="없음".equals(religion)?"selected":"" %>>무교</option>
			        <option value="그외" <%="그외".equals(religion)?"selected":"" %>>그외</option>
			        </select>
			    </td>
            </tr>
            <tr>
                <td>룸메와 친해지고 싶은 정도(1~5사이) </td>
                <td><select name="closeness">
                	<option value="1" <%="1".equals(closeness)?"selected":"" %>>1</option>
			        <option value="2" <%="2".equals(closeness)?"selected":"" %>>2</option>
			        <option value="3" <%="3".equals(closeness)?"selected":"" %>>3</option>
			        <option value="4" <%="4".equals(closeness)?"selected":"" %>>4</option>
			        <option value="5" <%="5".equals(closeness)?"selected":"" %>>5</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>취침시간 잠에드는 시간/ 일어나는 시간 </td>	<!-- text박스에 데이터베이스에 입력되어 있던 정보를 일단 출력해둔다. -->
                <td><input type = "text" name="sleepTime" value=<%=sleepTime %>>
                	<input type = "text" name="wakeTime" value=<%=wakeTime %>>
                </td>
            </tr>
            <tr>
                <td > 오픈 카톡 주소 </td>
                <td><input type = "text" name="address" value = <%=address %>></td>
            </tr>
        </table>
        <br><br>
        <center>	<!-- 수정 완료버튼을 누르면 완료 페이지로 넘어간다. -->
            <input type="submit" style = "width : 100pt; height:40pt"value="수정 완료">
        </center>
        </form>
        <%
            }
        }
        %>
        
	</body>
</html>