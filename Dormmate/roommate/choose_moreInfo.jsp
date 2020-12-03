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
        #user .chooseMember {	/* 회원 나열한 테이블의 속성 */
          width: 100%;
          border-collapse: collapse;
        }
        .chooseMember .thA .tdA {	 /* 회원 나열한 테이블의 속성 */
          background-color: #7c9ee7;
          border-bottom: 1px solid #2168d1;
          padding: 10px;
        }
        
        #userpage .thB, .tdB {	/* 사용자 정보 페이지의 테이블의 속성 */
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
                <span>메뉴</span>		<!--  메뉴 버튼은 왼쪽에 위치 -->
            </button>
            <br>
            <br>
            <center>
            <h1>룸메정보</h1>
            <%
	          	String id = (String)session.getAttribute("id"); // session에 저장된 현재 로그인 한 이용자의 id를 불러온다.
            	Connection conn = null;		// DB연결
            	Statement stmt = null;		// DB상태 
            	String sql = null;			// sql문
            	ResultSet rs = null;		// ResultSet
            	String gender = "";			// 현재 이용자의 성별
            	String dorm = "";			// 현재 이용자가 살 기숙사
            	
            	try{
            		Class.forName("com.mysql.jdbc.Driver");
            		String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
            		conn = DriverManager.getConnection(url,"root","0000");
            		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            		sql = "select * from member where id = '"+id+"'";	// 데이터 베이스 연결 후 현재 이용자의 정보를 select 해 온다.
            		rs = stmt.executeQuery(sql);	// 쿼리해 온 정보를 rs에 저장
            		while(rs.next()){
            		dorm = rs.getString("dorm");	// 기숙사 정보 저장
            		gender = rs.getString("sex");	// 성별 정보 저장
            		}
            		sql = "select * from member where dorm = '"+dorm+"' and sex = '"+gender+"'";
            		// 현재 이용자의 기숙사와 성별이 같은 이용자들만 select 한다.
            		rs=stmt.executeQuery(sql);
            	}catch(Exception e){
            		out.println("DB 연동 오류입니다. : " + e.getMessage());
            	}
            	%>
			<br><br>
			<h3><%=id%>님과 같은 조건인<br> <%=dorm%>에 살고 <%=gender%>인<br> 이용자 목록입니다.</h3>            
            <br><br>
            </center>
            <center>
            <table class = "chooseMember">
            	<% 
            	  while(rs.next())	// 같은 정보를 가지고 있는 이용자 모두 출력
                  {
            %>
                <tr class="thA">	<!-- 성별과 기숙사가 같은 이용자의 닉네임과 기숙사,성별,학년 정보를 출력한다. -->
                    <td class="tdA"><a href=choose_sub.jsp?id=<%=rs.getString("id")%> style="width:250;"><%= rs.getString("nickName") %></a></td>
                    <td class = "tdA"><a href=choose_sub.jsp?id=<%=rs.getString("id")%> style="width:250;"><%= rs.getString("dorm") %> / 
                    <%=rs.getString("sex") %> / <%=rs.getString("grade") %>학년</a></td>
                    <!-- 해당 회원의 정보를 보기 위해서는 id를 넘겨주어야 한다. -->
                </tr>
            <%
                  }
            %>
            </table> 
           

            </center>
        </div>
        
        <%
		String value = request.getParameter("id");	// choose_sub.jsp에서 정보확인을 위해 선택한 회원의 id 가져오기
        sql = "select * from memberInfo where id = '" +value + "'";	
        rs = stmt.executeQuery(sql);	// 데이터베이스에서 해당 멤버의 정보 불러오기
		%>
		<div id="content2" style = "background-color: white;">
		<center>
		<%
		if(rs.next()){
		%>
		<h3 style = "background-color: lightgray; color : black;"> <%= request.getParameter("nickName") %> </h3>
			<img src="myface.jpg" alt="프로필이미지"/>	<!-- 닉네임 출력 -->
		
        <table id = "userpage"> <!--  일주일에 씻는 횟수, 시끄러운 정보등 세부사항에 등록된 정보들을 데이터베이스에서 불러와 출력 -->
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
            <!-- 다시 기본 정보를 보고 싶을 경우 뒤로가기 클릭, id를 넘겨준다. -->
        </form>
        <%
		}else{
			%>
			<h3 style="color:black">세부 정보가 아직 등록 되지 않았습니다.</h3>
			<form method="post" action="choose_sub.jsp">
            <input type="submit" style = "width : 100pt; height:40pt; font-style: bold;"value="뒤로가기">
            <input type="hidden" name="id" value="<%= request.getParameter("id")%>">
        	</form>
        	<!-- 세부 정보를 아직 등록하지 않은 경우 등록되지 않았다고 출력하고 위처럼 뒤로가기 버튼 출력 -->
			<% 
		}
        %>
        	
          </center>
        
		</div>
		
    <div class="wrapper">
        <!-- Sidebar  -->
        <nav id="sidebar">
            <div id="dismiss">
                <i class="fas fa-arrow-left"></i>	<!-- 왼쪽 가리키는 화살표 아이콘 -->
            </div>

            <div class="sidebar-header">	<!-- 사이드바의 맨 위에 동국 기숙사 출력  -->
                <h3>동국 기숙사</h3>
            </div>

            <ul class="list-unstyled components">	<!-- 사이드 바를 통해 이동 가능한 페이지의 목록이다. -->
                <li class="active">
                    <a href="choose.jsp">룸메정보</a>
                </li>
                <li>
                    <a href="complain.jsp">민원글</a>
                </li>
                <li>
                    <a href="notice.jsp">공지글</a>
                </li>
                <li>
                    <a href="main.jsp">홈화면</a>
                </li>
            </ul>
			<ul class="list-unstyled CTAs">		<!-- 마이페이지는 페이지 목록 밑에 따로 버튼을 만들어 둔다. -->
                <li>
                    <a href = "mypage.jsp" class="download">마이페이지</a>
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
        $(document).ready(function () {		/* 사이드바 스크롤 설정 */
            $("#sidebar").mCustomScrollbar({
                theme: "minimal"
            });

            $('#dismiss, .overlay').on('click', function () {		/* 뒤로 가기 화살표 버튼을 눌렀을 때 */
                $('#sidebar').removeClass('active');
                $('.overlay').removeClass('active');
            });

            $('#sidebarCollapse').on('click', function () {		/* 메뉴 버튼을 눌렀을 때 */
                $('#sidebar').addClass('active');
                $('.overlay').addClass('active');
                $('a[aria-expanded=true]').attr('aria-expanded', 'false');
            });
        });
    </script>
</body>

</html>
