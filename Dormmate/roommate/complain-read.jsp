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

	 String userID = "", title = "", content = "";		// 사용자 id,
	 int agree=0, disagree=0;
	 int userAgree=0;
	 
	 String board="complain";
	 session.setAttribute("board", board);
	 int tableID = Integer.parseInt(request.getParameter("tableID"));
	 String id = (String)session.getAttribute("id");
	 
	Connection conn = null;
	Statement stmt=null,stmt1 = null;
	ResultSet rs=null, rs1 = null;
	 
	 try {
		 	 Class.forName("com.mysql.jdbc.Driver");
		     String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC";
		     conn = DriverManager.getConnection(url, "root", "0000");
			 stmt = conn.createStatement();
			 stmt1 = conn.createStatement();
             String sql = "select * from complain where tableID = " + tableID;
        	 String sql1 = "select * from complain_agree where tableID="+tableID+" AND userID='"+id +"'";
        	 rs = stmt.executeQuery(sql);      
        	 rs1 = stmt1.executeQuery(sql1);
         }
         catch(Exception e) {
               out.println("DB 연동 오류입니다. : " + e.getMessage());
         } 

	 while(rs.next()){
      userID = rs.getString("userID");
      title = rs.getString("title");
      content = rs.getString("content"); 
      agree = rs.getInt("agree");
      disagree = rs.getInt("disagree");
	 }
	 if(rs1==null) userAgree=0;
	 else {
		 while(rs1.next()) {
    	 userAgree = rs1.getInt("agree");
    	 }
	 }
        
    %>     
    <center>
     <br><br><br>
	<h2><%= title %></h2>
    <br>
        작성자: <%= userID %> <br>
<% 
String style1= "grey_agree.png", style2="grey_disagree.png";
if(userAgree==1) style1="agree.png";
else if(userAgree==-1) style2="disagree.png";
%>

<!-- 공감 비공감 버튼 -->
    
    <img src=<%=style2%> style="width:70px; height:70px; float:right;"id="disagree">
	<img src=<%=style1%> style="width:70px; height:70px; float:right;  margin-right:15px;" id="agree">
	<!-- 버튼 클릭시 notice-read.js 파일의 event 실행됨. 실행된 결과 반영하기 위해 현재시간 불러오는 파라미터 사용함 -->
	<br><br><br>
	
<form action="complain-read-db.jsp" method="post"> 
	<input type="hidden" id="l_hidden" name="l_hidden" value=<%=userAgree%>>	<!-- 공감/비공감 정보. 공감은 1 비공감은-1 둘다아니면 0-->
	<div style="float:right;"> 
	동의  : <input type="number" id="l_agree" name="l_agree" value=<%=agree%> style="width:50px" readonly>  
	비동의 : <input type="number" id="l_disagree" name="l_disagree" value=<%=disagree%> style="width:50px" readonly> </div>
  	
<br><br><br>
    <div class="line"></div>

	<div style="background-color:#F0E6FD ; color:black; width:60%; height: 400px; align: center;">
  <%= content %>

 </div>
 
 <br><br><br>
<% if(userID.equals(id)){ // 사용자와 게시물 작성자가 일치해서 수정/삭제 버튼이 보임 %>
     <a href="board-modify.jsp?tableID=<%=tableID%>&baord=2"> <button>게시글 수정</button> </a>    

    <a href="board-delete-db.jsp?tableID=<%=tableID%>%board=2"> <button>게시글 삭제 </button> </a>
<% } %>   


	<input type="hidden" name="tableID" value=<%=tableID%>>
	<input type="hidden" name="id" value="<%=id%>">	
   <input type="submit" value="게시글 목록 보기">
</form>  

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
                    <a href="choose.jsp?id=<%=id %>">룸메정보</a>
                </li>
                <li>
                    <a href="complain.jsp?id=<%=id %>">민원글</a>
                </li>
                <li>
                    <a href="notice.jsp?id=<%=id %>">공지글</a>
                </li>
                <li>
                    <a href="main.jsp?id=<%= id %>">홈화면</a>
                </li>
            </ul>
			<ul class="list-unstyled CTAs">
                <li>
                 	<a href = "mypage.jsp?id=<%= id%>" class="download">마이페이지</a>              
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


<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">
	$(function(){
		$('#agree').click(function(){
			var disagree= $("#disagree").attr('src'); // 게시글의 비공감 클릭여부 disagree.png이면 공감함
			var agree= $(this).attr('src'); // 게시글의 공감 클릭여부 agree.png이면 공감함
			var aCnt = $("#l_agree").val(); // 게시글의 공감 개수
			 // 공감과 비공감 int형으로
		if(disagree=="disagree.png") { // 이미 비공감을 눌렀는데 공감버튼 누른 경우
			alert("이미 비공감을 눌렀습니다.");		
			return;
		}
		else if(agree=="grey_agree.png") {	// 공감할 경우
			$(this).attr("src", "agree.png");	
			aCnt++;
			$("#l_agree").val(aCnt);
			$("#l_hidden").val(1);
		}
		else {	// 공감 취소
			$(this).attr("src", "grey_agree.png");
			aCnt--;
			$("#l_agree").val(aCnt);
			$("#l_hidden").val(0);
		}	
	});
	$('#disagree').click(function(){
		var disagree= $(this).attr('src'); // 게시글의 비공감 클릭여부 disagree.png이면 공감함
		var agree= $("#agree").attr('src'); // 게시글의 공감 클릭여부 agree.png이면 공감함
		var dCnt = $("#l_disagree").val(); // 게시글의 비공감 개수
		dCnt = parseInt(dCnt); 
		if(agree=="agree.png") { // 이미 공감을 눌렀는데 비공감버튼 누른 경우
			alert("이미 공감을 눌렀습니다.");		
			return;
		}
		else if(disagree=="grey_disagree.png") {	// 비공감할 경우
			$(this).attr("src", "disagree.png");
			dCnt++;
			$("#l_disagree").val(dCnt);
			$("#l_hidden").val(-1);
		}
		else {	// 비공감 취소
			$(this).attr("src", "grey_disagree.png");
			dCnt--;
			$("#l_disagree").val(dCnt);
			$("#l_hidden").val(0);
		}	
	});
	});	
	</script>           

	
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