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
<%

	 
	 String userID = "", title = "", content = "";
	 int agree=0, disagree=0;
     Connection conn = null;
	 Statement stmt = null;
	 ResultSet rs = null;
  
	 int tableID = Integer.parseInt(request.getParameter("tableID"));
     

	 try {
               Class.forName("com.mysql.jdbc.Driver");
               String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
               conn = DriverManager.getConnection(url, "root", "0000");
               stmt = conn.createStatement();
               String sql = "select * from complain where tableID = " + tableID;
               rs = stmt.executeQuery(sql);
         }
         catch(Exception e) {
               out.println("DB 연동 오류입니다. : " + e.getMessage());
         } 

         while(rs.next())  {
	       userID = rs.getString("userID");
	       title = rs.getString("title");
	       content = rs.getString("content");
	       agree = rs.getInt("agree");
	       disagree = rs.getInt("disagree");
	 }
    %>     
    <center>

     <br><br><br>
	<h2><%= title %></h2>
    <br>
        작성자: <%= userID %> <br>
    <%
    int like=0; // 동의 비동의 눌렀는지
    int disliked=0;
    %>
    <input type="image" src="agree.png" style="width: 50px; height: 50px;""> 
    <input type="image" src="disagree.png" style="width: 50px; height: 50px;""> <br>

       동의  : <%= agree %> | 비동의 : <%= disagree %>
           
    <div class="line"></div>

	<div style="background-color:#F0E6FD ; color:black; width:60%; height: 400px; align: center;">
  <%= content %>

 </div>
 
 <br><br><br>
<% if(userID.equals((String)request.getParameter("id"))){ %>
     <a href="board-modify.jsp?tableID=<%=tableID%>&board=2"> <button>게시글 수정</button> </a>    

    <a href="board-delete-db.jsp?tableID=<%=tableID%>&board=2"> <button>게시글 삭제 </button> </a>
<% } %>    
    <a href="complain.jsp"> <button>게시글 목록 보기 </button></a>
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
                <i class="fas fa-arrow-left"></i>
            </div>

            <div class="sidebar-header">
                <h3>동국 기숙사</h3>
            </div>

            <ul class="list-unstyled components">
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
			<ul class="list-unstyled CTAs">
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
                $('a[aria-expanded=true]').attr('aria-expanded', 'false');
            });
        });
    </script>
</body>
</html>