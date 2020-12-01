<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
    <head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	    <title>동국 기숙사</title>
	
	    <!-- Bootstrap CSS CDN -->
	    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
	    <!-- Our Custom CSS -->
	    <link rel="stylesheet" href="sideNavi.css">
	    <!-- Scrollbar Custom CSS -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
	
	    <!-- Font Awesome JS -->
	    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
	    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
	    
        <style>
            
            .carrotbutton{
              width : 100pt; height:40pt;
              background-color: #CD853F;
              color:white;
              font-style: bold;
            }

            th, td {
              border-bottom: 1px solid lightgray;
              padding: 10px;
            }

          </style>
    </head>
    <body>
        
        <div id="user">
        <button type="button" id="sidebarCollapse" class="btn btn-info">
                <i class="fas fa-align-left"></i>
                <span>메뉴</span>
            </button><br>
          <center><br>
          <%
          	String id = request.getParameter("id");
          	//String id = "Crystal";
          	String version;
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
          <h3> <%=rs.getString("nickName") %>의 마이페이지 </h3>
          <img src="myface.jpg" alt="프로필이미지"/><br><br><br>
          <table style = "color : white">
            <tr>
                <td>
                  <%=rs.getString("name") %>
                </td>
                <td>
                  <%=rs.getString("id") %>
                </td>
            </tr>
            <tr>
                <td> 동국대학교 <%= rs.getString("dorm")%> </td>
                </td>
            </tr>
            <td> 2020학년도 2학기</td>
            <tr>
              <td><%= rs.getString("college")%></td>
              <td><%= rs.getString("major")%></td>
            </tr>
            <tr>
              <td><%= rs.getString("sex")%></td>
              <td><%= rs.getInt("age")%>세</td>
            </tr>
            <tr>
              <td><%= rs.getString("nation")%></td>
              <td><%= rs.getInt("grade")%>학년</td>
            </tr>
            <%
                  }
            %>
        </table>
        <br>
        <form method = "post" action = "modifyBase.jsp">
        	<input type="submit" class="carrotbutton" value="기본정보수정">
        	<input type="hidden" name = "id" value="<%=id %>">
        </form>
          </center>
        </div>
        <div id="content2" style = "background-color: white;">
        <center>
        <br><br>
        <caption>
          <h2 style = "color : black">세부 정보</h2>
          </caption>
          <%
        sql = "select * from memberInfo where id = '" +id + "'";
          try{
        	rs = stmt.executeQuery(sql);
          }catch(Exception e){
        	  out.println("DB 연동 오류입니다. : " + e.getMessage());
          }
       
		if(rs.next()){
			version = "modify";
		%>
		<table style = "color : black"><br><br>
            <tr>
        	  <td>
        	  일주일에 씻는 횟수 
        	  </td>
        	  <td>
        	  <%=rs.getInt("washing") %>번
        	  </td>
        	</tr>
            <tr>
        	  <td>
        	  시끄러운 정도 (1~5사이) 
        	  </td>
        	  <td>
        	  <%=rs.getInt("noise") %>
        	  </td>
        	</tr>
            <tr>
        	  <td>
        	  일주일에 청소 횟수 
        	  </td>
        	  <td>
        	  <%=rs.getInt("cleaning") %>번
        	  </td>
        	</tr>
            <tr>
        	  <td>
        	  한달에 외박 횟수 
        	  </td>
        	  <td>
        	  <%=rs.getInt("sleptOut") %>번
        	  </td>
        	</tr>
            <tr>
        	  <td>
        	  흡연 여부 
        	  </td>
        	  <td>
        	  <%
        	   int smoke = Integer.parseInt(rs.getString("smoking"));
        	  if(smoke == 0){
        		  out.println("안함");
        	  }else{
        		  out.println("함");
        	  }
        	  %>
        	  </td>
        	</tr>
            <tr>
        	  <td>
        	  종교
        	  </td>
        	  <td>
        	  <%=rs.getString("religion") %>
        	  </td>
        	</tr>
        	<tr>
        	  <td>
        	  룸메와 친해지고 싶은 정도(1~5사이)
        	  </td>
        	  <td>
        	  <%=rs.getInt("closeness") %>
        	  </td>
        	</tr>
        	<tr>
              <td>
                취침시간
              </td>
              <td>
                <%=rs.getString("sleepTime") %> ~ <%=rs.getString("wakeTime") %>
              </td>
            </tr>
            <tr>
        	  <td>
        	  오픈 카톡 주소
        	  </td>
        	  <td>
        	  <%=rs.getString("address") %>
        	  </td>
        	</tr>
        </table>
            <%
		}else{
			version = "create";
			%>
			<h3 style="color:black">세부 정보 입력이 필요합니다.</h3>
			<% 
          }
        %>
        <br><br>
        <form method = "post" action = "modifyDetail.jsp">
			<input type="submit" class="carrotbutton" value="세부정보수정">
        	<input type="hidden" name = "id" value="<%=id %>">
        	<input type="hidden" name = "version"value = "<%=version%>">
            <br><br>
        </form>
          </center>
        
		</div>
		
		<div class="wrapper">
        <!-- Sidebar  -->
        <nav id="sidebar">
            <div id="dismiss">
                <i class="fas fa-arrow-left"></i>
            </div>

            <div class="sidebar-header">
                <h3>동국 기숙사</h3>
            </div>

            <ul class="list-unstyled components">
                <li>
                    <a href="choose.jsp?id=<%=id %>">룸메정보</a>
                </li>
                <li>
                    <a href="complain.jsp?id=<%=id %>">민원글</a>
                </li>
                <li>
                    <a href="notice.jsp?id=<%=id %>">공지글</a>
                </li>
                <li>
                    <a href="main.jsp?id=<%=id %>">홈화면</a>
                </li>
            </ul>
			<ul class="list-unstyled CTAs">
                <li>
                    <a href = "mypage.jsp?id=<%=id %>" class="download">마이페이지</a>
                </li>
            </ul>

        </nav>
	</div>
	
		<div class="overlay"></div>
		

    <!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <!-- Popper.JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    <!-- jQuery Custom Scroller CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#sidebar").mCustomScrollbar({
                theme: "minimal"
            });

            $('#dismiss, .overlay').on('click', function () {
                $('#sidebar').removeClass('active');
                $('.overlay').removeClass('active');
            });

            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').addClass('active');
                $('.overlay').addClass('active');
                $('.collapse.in').toggleClass('in');
                $('a[aria-expanded=true]').attr('aria-expanded', 'false');
            });
        });
    </script>
    </body>
</html>
