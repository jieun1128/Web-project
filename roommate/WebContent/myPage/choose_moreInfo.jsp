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
        #user .chooseMember {
          width: 100%;
          border-collapse: collapse;
        }
        .chooseMember .thA .tdA {
          background-color: #7c9ee7;
          border-bottom: 1px solid #2168d1;
          padding: 10px;
        }
        
        #userpage .thB, .tdB {
        	color : black;
        	border-bottom: 1px solid lightgray;
            padding: 10px;
        }
        
      </style>
</head>

<body>

        <!-- Page Content  -->
        <div id = "user">
            <button type="button" id="sidebarCollapse" class="btn btn-info">
                <i class="fas fa-align-left"></i>
                <span>메뉴</span>
            </button>
            <br>
            <br>
            <center>
            <h1>룸메정보</h1>
            </center>
            
            <br><br>
            <center>
            <table class = "chooseMember">
            <%
	          	String id = request.getParameter("id");
	        	//String id = "RM";
            	Connection conn = null;
            	Statement stmt = null;
            	String sql = null;
            	ResultSet rs = null;
            	String gender = "";
            	String dorm = "";
            	
            	try{
            		Class.forName("com.mysql.jdbc.Driver");
            		String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
            		conn = DriverManager.getConnection(url,"root","0000");
            		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            		sql = "select * from member where id = '"+id+"'";
            		rs = stmt.executeQuery(sql);
            		while(rs.next()){
            		dorm = rs.getString("dorm");
            		gender = rs.getString("sex");
            		}
            		sql = "select * from member where dorm = '"+dorm+"' and sex = '"+gender+"'";
            		rs=stmt.executeQuery(sql);
            	}catch(Exception e){
            		out.println("DB 연동 오류입니다. : " + e.getMessage());
            	}
            	  while(rs.next())
                  {
            %>
                <tr class="thA">
                    <td class="tdA"><a href=choose_sub.jsp?id=<%=rs.getString("id") %> style="width:250;"><%= rs.getString("nickName") %></a></td>
                    <td class = "tdA"><a href=choose_sub.jsp?id=<%=rs.getString("id") %> style="width:250;"><%= rs.getString("dorm") %> / 
                    <%=rs.getString("sex") %> / <%=rs.getString("grade") %>학년</a></td>
                </tr>
            <%
                  }
            %>
            </table> 
           

            </center>
        </div>
        
        <%
		String value = request.getParameter("id");
        sql = "select * from memberInfo where id = '" +value + "'";
        rs = stmt.executeQuery(sql);
		%>
		<div id="content2" style = "background-color: white;">
		<center>
		<%
		if(rs.next()){
		%>
		<h3 style = "background-color: lightgray; color : black;"> <%= request.getParameter("nickname") %> </h3>
			<img src="myface.jpg" alt="프로필이미지"/>
		
        <table id = "userpage">
        	<tr class = "thB">
        	  <td class = "tdB">
        	  일주일에 씻는 횟수 
        	  </td>
        	  <td class = "tdB">
        	  <%=rs.getInt("washing") %>번
        	  </td>
        	</tr>
        	<tr class = "thB">
        	  <td class = "tdB">
        	  시끄러운 정도 (1~5사이) 
        	  </td>
        	  <td class = "tdB">
        	  <%=rs.getInt("noise") %>
        	  </td>
        	</tr>
        	<tr class = "thB">
        	  <td class = "tdB">
        	  일주일에 청소 횟수 
        	  </td>
        	  <td class = "tdB">
        	  <%=rs.getInt("cleaning") %>번
        	  </td>
        	</tr>
        	<tr class = "thB">
        	  <td class = "tdB">
        	  한달에 외박 횟수 
        	  </td>
        	  <td class = "tdB">
        	  <%=rs.getInt("sleptOut") %>번
        	  </td>
        	</tr>
        	<tr class = "thB">
        	  <td class = "tdB">
        	  흡연 여부 
        	  </td>
        	  <td class = "tdB">
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
        	<tr class = "thB">
        	  <td class = "tdB">
        	  종교
        	  </td>
        	  <td class = "tdB">
        	  <%=rs.getString("religion") %>
        	  </td>
        	</tr>
        	<tr class = "thB">
        	  <td class = "tdB">
        	  룸메와 친해지고 싶은 정도(1~5사이)
        	  </td>
        	  <td class = "tdB">
        	  <%=rs.getInt("closeness") %>
        	  </td>
        	</tr>
        	<tr class = "thB">
              <td class = "tdB">
                취침시간
              </td>
              <td class = "tdB">
                <%=rs.getString("sleepTime") %> ~ <%=rs.getString("wakeTime") %>
              </td>
            </tr>
            <tr class = "thB">
        	  <td class = "tdB">
        	  오픈 카톡 주소
        	  </td>
        	  <td class = "tdB">
        	  <%=rs.getString("address") %>
        	  </td>
        	</tr>
        </table>
        <br><br>
        <form method="post" action="choose_sub.jsp">
            <input type="submit" style = "width : 100pt; height:40pt; font-style: bold;"value="뒤로가기">
 			<input type="hidden" name="id" value="<%= request.getParameter("id")%>">
 			<input type="hidden" name="nickname" value="<%=request.getParameter("nickName") %>">
        </form>
        <%
		}else{
			%>
			<h3 style="color:black">세부 정보가 아직 등록 되지 않았습니다.</h3>
			<% 
		}
        %>
        	
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
                <li class="active">
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
