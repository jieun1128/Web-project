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
            
            .carrotbutton{	/* 수정하기를 출력할 당근 느낌의 버튼 */
              width : 100pt; height:40pt;
              background-color: #CD853F;
              color:white;
              font-style: bold;
            }

            th, td {	/* 테이블 속성 */
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
          	String id = (String)session.getAttribute("id"); 	// session에 저장된 현재 로그인 한 이용자의 id를 불러온다.
          	String version;	// 세부사항에서 이미 입력된걸 수정하는건지 새로 입력하는건지 구분할 변수
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
	            {
          %>	<!-- 현재 로그인한 회원의 정보 출력  -->
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
        <br>	 <!-- 현재 로그인한 회원의 기본정보를 수정하고 싶을때  -->
        <form method = "post" action = "modifyBase.jsp">
        	<input type="submit" class="carrotbutton" value="기본정보수정">
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
          // 데이터 베이스에서 현재 로그인한 회원의 세부 정보 가져오기 
          try{
        	rs = stmt.executeQuery(sql);
          }catch(Exception e){
        	  out.println("DB 연동 오류입니다. : " + e.getMessage());
          }
       
		if(rs.next()){	// 회원에게 이미 등록된 세부정보가 있다면 version을 modify로 설정 후 해당 정보 출력
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
		}else{	// 데이터베이스에 해당 회원의 id로 등록된 세부 정보가 없다면 version을 create로 수정 후 세부정보 입력 요청 
			version = "create";
			%>
			<h3 style="color:black">세부 정보 입력이 필요합니다.</h3>
			<% 
          }
        %>
        <br><br>
        <!-- 세부정보 수정 혹은 생성을 원할 경우 수정창으로 version 을 함께 넘겨주기-->
        <form method = "post" action = "modifyDetail.jsp">
			<input type="submit" class="carrotbutton" value="세부정보수정">
        	<input type="hidden" name = "version"value = "<%=version%>">
            <br><br>
        </form>
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
                <li>
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

            $('#dismiss, .overlay').on('click', function () {	/* 뒤로 가기 화살표 버튼을 눌렀을 때 */
                $('#sidebar').removeClass('active');
                $('.overlay').removeClass('active');
            });

            $('#sidebarCollapse').on('click', function () {		/* 메뉴 버튼을 눌렀을 때 */
                $('#sidebar').addClass('active');
                $('.overlay').addClass('active');
                $('.collapse.in').toggleClass('in');
                $('a[aria-expanded=true]').attr('aria-expanded', 'false');
            });
        });
    </script>
    </body>
</html>
