<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
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

  </head>
  <body>

        <!-- Page Content  -->
        <div id="content">


            <button type="button" id="sidebarCollapse" class="btn btn-info">
                <i class="fas fa-align-left"></i>
                <span>메뉴</span>
            </button>

            <br>
            <br>
 
            <h1>공지글</h1>

            <div class="line"></div>
            <center>
                <h1><b>게시글 목록 보기</b></h1> <br><br>
              
                 <table border="1" align="center" width="603px;">

                 <tr style="background-color:Lightgray;">
                   <td align="center" width="100">글번호</td>
                   <td align="center" width="150">글쓴이</td>
                   <td align="center"width="500">글제목</td>
                   <td align="center" width="100">공감수</td>
                   <td align="center" width="100">비공감수</td>
                 </tr>
            
           
			<%

			String id = (String)session.getAttribute("id");// 변경 
			
		 	String radioValue = request.getParameter("sort_check");
			String selectsql;	// 게시물 순서 선택에 따른 select문
	  		selectsql="select * from notice order by tableID asc";  
	  	
	  
    		int tableID;
      		int rownum=0;
      		Connection conn = null;
     		Statement stmt = null;
     		String sql = null;
      		ResultSet rs = null;
      		
      try{
    	  Class.forName("com.mysql.jdbc.Driver");
    	  String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
    	  conn = DriverManager.getConnection(url,"root","0000"); // 바꾸기 
    	  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    	  sql="select * from notice order by tableID desc"; // tableID 가 큰 순으로 불러오기 
    	  rs = stmt.executeQuery(sql);
      }
      
      catch(Exception e ){
    	  out.println("DB 연동 오류입니다. : " + e.getMessage());
      }
      
      rs.last();
      rownum = rs.getRow();
      rs.beforeFirst();
      
      while(rs.next())
      {
    	 tableID = Integer.parseInt(rs.getString("tableID"));
    	  %>
    	  
    	  <tr style="background-color:white; color: black;">
             <td align="center"><%= rownum %> </td>				<!-- 글 순서 번호  -->
             <td align="left"><%=rs.getString("userID") %></td>	<!-- 글쓴이  -->
             <td align="left">
               <a href="notice-read.jsp?tableID=<%=rs.getString("tableID")%>&id=<%=id%>" style="width:400;"><%=rs.getString("title") %></a>
             </td>		<!-- 글제목 (누르면 글 번호를 참조해 글 내용을 불러옴) -->
             <td align="center"><%= rs.getString("agree") %></td>		<!-- 공감 -->
      		 <td align="center"><%= rs.getString("disagree") %></td>		<!-- 비공감 -->
            </tr>
        
      <%
      
           rownum--;
      }
      %>

   
      
     </table>
     
     
     
     <br><br>
            <a href="notice-insert.jsp"><button>게시글 쓰기</button></a>

            </center>

        </div>
	<%
     stmt.close();
     conn.close();
   %>

       <!-- Sidebar  -->
    <div class="wrapper">
        <!-- Sidebar  -->
        <nav id="sidebar">
            <div id="dismiss">
                <i class="fas fa-arrow-left"></i>		<!-- 왼쪽 가리키는 화살표 아이콘 -->
            </div>

            <div class="sidebar-header">			<!-- 사이드바의 맨 위에 동국 기숙사 출력  -->
                <h3>동국 기숙사</h3>
            </div>

            <ul class="list-unstyled components">		<!-- 사이드 바를 통해 이동 가능한 페이지의 목록이다. -->
                <li>
                    <a href="choose.jsp">룸메정보</a>
                </li>
                <li>
                    <a href="complain.jsp">민원글</a>
                </li>
                <li class="active">
                    <a href="notice.jsp">공지글</a>
                </li>
                <li>
                    <a href="main.jsp">홈화면</a>
                </li>
            </ul>
			<ul class="list-unstyled CTAs">			<!-- 마이페이지는 페이지 목록 밑에 따로 버튼을 만들어 둔다. -->
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
        $(document).ready(function () {	/* 사이드바 스크롤 설정 */
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