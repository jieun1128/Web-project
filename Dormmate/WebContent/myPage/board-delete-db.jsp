<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
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

</head>
  <body>
    <%
       int tableID;
       String sql, sql1;
       Connection conn = null;
       Statement stmt = null;
       ResultSet rs = null;
   		
       tableID = Integer.parseInt(request.getParameter("tableID"));
   		String from_board="";
   		int board=Integer.parseInt(request.getParameter("board"));
   		if(board==1) from_board = "notice";
   		else if(board==2) from_board = "complain";
   		
   		HttpSession session = request.getSession(false);
   		String id = (String)session.getAttribute("id");
   		
   		while(rs.next()) {
      		 try { 
         	    Class.forName("com.mysql.jdbc.Driver");
	     		String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
	     		conn = DriverManager.getConnection(url, "root", "0000");
	     		stmt = conn.createStatement();
           		sql =  "delete from "+ from_board +" where tableID = " + tableID;
            	rs = stmt.executeQuery(sql);
      		 }
     		  catch(Exception e) {
       	      out.println("DB 연동 오류입니다. : " + e.getMessage());
      		 }
   		}
    %>
    <center><h2> 게시글이 삭제되었습니다. </h2>
     <% if(board==1){ %> <a href="notice.jsp"> <button>게시글 목록 보기</button></a> <% } 
      else if(board==2){ %> <a href="complain.jsp"> <button>게시글 목록 보기</button></a> <% } %>
    </center>
	<%
     stmt.close();
     conn.close();
   %>

       <!-- Sidebar  -->
    <div class="wrapper">
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