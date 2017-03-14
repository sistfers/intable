<%@page import="java.util.HashMap"%>
<%@page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	request.setCharacterEncoding("UTF-8");
%> 

<%   
//No-Cache 설정..  항상 최신의 페이지를 보여주도록 하는 방법입니다
//데이터가 넘어가는 경우에만 '만료된 페이지입니다' 라는 메시지를 보여주게 됨.
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%>   

<link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>	

<!-- 네이게이션 바.. 상단고정 -->
<nav class="navbar navbar-default navbar-fixed-top">
	<!-- <div class="container-fluid"> -->
	<div class="container">
		<div class="navbar-header">
		
			<!-- 왼쪽로고. 클릭시 첫화면으로 이동함 -->
			<a href="/"><img src="../img/site_logo1.PNG" width="130"></a>
		</div>

<%
//로그인 상태 체크
	HashMap<String, String> login = session.getAttribute("login") instanceof HashMap<?, ?>
			? (HashMap<String, String>) session.getAttribute("login")
			: null;

if(login == null){			// 로그인전
%>
			<!-- 오른쪽 로그인/회원가입 버튼 -->
			<ul class="nav navbar-nav navbar-right">
				<li><!-- <a href="../main/login.jsp"> --><button class="btn btn-danger navbar-btn" onclick="do_login()">Login</button><!-- </a> --></li>
				<li>&nbsp;&nbsp;&nbsp;</li> <!-- 버튼 사이 공백 넣어주려고 --> 
				<li><!-- <a href="../sonnim/sonnim_join.jsp"> --><button class="btn btn-danger navbar-btn" onclick="do_join()">Join</button><!-- </a> --></li>
			</ul>
		
		<%}else{		// 로그인후
		
			System.out.println(login.toString());
		%>
			<!-- 로그인 후 보이는 화면 -->
			
			    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
			      <ul class="nav navbar-nav navbar-right">
			        <li class="dropdown">
			         <%--  <a class="dropdown-toggle" role="button" aria-expanded="true" href="#" data-toggle="dropdown"><%=sonnim.get("name") %>  님 로그인<span class="caret"></span></a> --%>
			          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-user"></span> 
                        <strong><%=login.get("name") %>  님 로그인</strong>
                        <span class="glyphicon glyphicon-chevron-down"></span>
                    </a>
			          <ul class="dropdown-menu" role="menu">
<%
	if (login.get("issonnim").equals("true")) { // 손님이면
%>
<!-- 						<li><a href="../sonnim/sonnim_mypage.jsp">마이페이지</a></li> -->
<!-- 			          	<li class="divider"></li> -->
			            <li><a href="../sonnim/mypage_update.jsp">정보수정</a></li>
			            <li class="divider"></li> 
			            <li><a href="../sonnim/mypage_heart.jsp">좋아요 한 음식점</a></li>
			            <li class="divider"></li> 
			            <li><a href="../sonnim/sonnim_mypage.jsp">예약확인</a></li>
<%
	} else if (login.get("issonnim").equals("false")) { // 음식점이면
%>
						<li><a href="../store/store.jsp">마이페이지</a></li>
			          	<li class="divider"></li>
			            <li><a href="../store/store_update.jsp">정보수정</a></li>
<%
	} else { // 둘다 아니면 ?! 
		System.out.println("누구냐? 넌!");
	}
%>

			          </ul>
			        </li>
				<li><button class="btn btn-danger navbar-btn" onclick="do_logout()">로그아웃</button></li>
				  </ul>
				</div>

<!--로그아웃 버튼 누르면  sonnim_control로 이동하기 위해서 임시 form 만듬 -->
<%
	if (login.get("issonnim").equals("true")) { // 손님이면
%>
 <form name="frmWrite" method="post" action="../sonnim/sonnim_control.jsp">   
    <input type="hidden" name="action" value="logout" />
</form>
<%
	} else if (login.get("issonnim").equals("false")) { // 음식점이면
%>
 <form name="frmWrite" method="post" action="../store/store_control.jsp">   
    <input type="hidden" name="action" value="logout" />
</form>
<%
	} else { // 둘다 아니면 ?! 
		System.out.println("누구냐? 넌!");
	}
%>
		
		<%} // else end %>
		</div>
</nav>



<!--페이지이동  -->
<script type="text/javascript">
$(document).ready(function () {
    $('.dropdown-toggle').dropdown();
});

function do_logout(){
	var frm = document.frmWrite;	
	frm.submit();
}
function do_login(){
	location.href = "../main/login.jsp";
}
function do_join(){
	location.href = "../sonnim/sonnim_join.jsp";
}
</script>