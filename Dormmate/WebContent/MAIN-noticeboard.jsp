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

</head>

<body>

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
                    <a href="#">룸메정보</a>
                </li>
                <li>
                    <a href="#">민원글</a>
                </li>
                <li class="active">
                    <a href="#">공지글</a>
                </li>
                <li>
                    <a href="#">홈화면</a>
                </li>
            </ul>


        </nav>

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
                <h1><b>게시글 목록 보기</b></h1>
                 <table border="1" align="center" width="603px;">

                 <tr style="background-color:Lightgray;">
                   <td align="center" width="100">글번호</td>
                   <td align="center" width="100">글쓴이</td>
                   <td align="center"width="375">글제목</td>
                   <td align="center" width="50">공감수</td>
                   <td align="center" width="50">비공감수</td>
                 </tr>
<!-- 게시글 data 받아오기 -->
      <%
      int id,ref;
      int rownum=0;
      Connection conn = null;
      Statement stmt = null;
      String sql = null;
      ResultSet rs = null;
      %>
      
      <%
      try{
    	  Class.forName("com.mysql.jdbc.Driver");
    	  String url = "jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
    	  conn = DriverManager.getConnection(url,"root","0000");
    	  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    	  sql = "select * from notice order by talbeID asc";
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
    	 id = Integer.parseInt(rs.getString("id"));
    	 ref = Integer.parseInt(rs.getString("ref"));
    	  %>
          
           <tr>
             <td align="center"><%= rownum %> </td>
             <td align="left"><%=rs.getString("userID") %></td>
             <td align="left">
               <a href=notice-read.jsp?id=<%=rs.getString("talbeID") %> style="width:250;"><%=rs.getString("title") %></a>
             </td>
             <td align="center"><%= rs.getString("liked") %></td>
             <td align="center"><%= rs.getString("disliked") %></td>
      
            </tr>
        

      <%
      
           rownum--;
      }
      %>    
                 
                 
            </table>

            <a href="notice-insert.jsp"><button value="게시글 쓰기"></button></a>

            </center>

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
