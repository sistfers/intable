<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
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
	
	//마지막 페이지 저장용
 	String nowUrl = request.getRequestURI() +"?"+ request.getQueryString();  	
	session.setAttribute("endUrl", nowUrl ); 

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>정보수정</title>
<style type="text/css">
/* 헤더로 가려지는 부분 여백 */
#page_header {
	margin-top: 50px;
}
#collapseOne {
	display: none;
}
/* 그림옆에 글씨 바로 안붙게 여백 */
.glyphicon { margin-right:10px; }

.panel-body { padding:0px; }
.panel-body table tr td { padding-left: 15px }
.panel-body .table {margin-bottom: 0px; }
</style>
        <!-- Bootstrap -->
        <link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>	
</head>
<body>
<!--헤더 -->
<jsp:include page="../main/site_header.jsp"></jsp:include>
<!--헤더 -->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    $(".panel-heading").click(function() {
      if($(this).next("div").is(":visible")){
        //$(this).next("div").slideUp("fast");
      } else {
        //$(".panel-heading").slideUp("fast");
        $(this).next("div").slideToggle("fast");
      }
    });
  });
</script>
<!-- main -->

<!-- page_header -->
<div id="page_header" class="page-header col-md-12" style="background-color: #FFD8D8">
	<div class="container">
	<br>
	<span> &nbsp;&nbsp;&nbsp;&nbsp; H O M E <span class="glyphicon glyphicon-chevron-right"></span> 마이페이지 
	<span class="glyphicon glyphicon-chevron-right"></span> 정보수정</span>
	</div>
</div>
		
<!-- 왼쪽메뉴 -->
<div class="container">
		<div class="container col-md-2">
            <div class="panel-group" id="accordion">

               <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a href="../sonnim/mypage_update.jsp"><span class="glyphicon glyphicon-user">
                            </span>정보수정</a>
                        </h4>
                    </div>
                </div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a href="../sonnim/mypage_heart.jsp"><span class="glyphicon glyphicon-heart">
							</span>좋아요 한 음식점</a>
						</h4>
					</div>
				</div>

				<div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"><span class="glyphicon glyphicon-folder-close">
                            </span>예약확인 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-chevron-down"></span></a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <table class="table">
                                 <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-list text-primary"></span><a href="../sonnim/sonnim_mypage.jsp?">전체예약목록</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-pencil text-primary"></span><a href="../sonnim/sonnim_mypage.jsp?state=0">이용예정</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-flash text-success"></span><a href="../sonnim/sonnim_mypage.jsp?state=1">이용완료</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-file text-info"></span><a href="../sonnim/sonnim_mypage.jsp?state=2">예약취소</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                </div>
                </div>
<!-- 왼쪽메뉴 end-->

<!-- 내용 -->
<%
//세션값 받아오기
	String sonnim_id = ((HashMap<String, String>)session.getAttribute("login")).get("sonnim_id"); ;
	String name 	= ((HashMap<String, String>)session.getAttribute("login")).get("name");
	String email	= ((HashMap<String, String>)session.getAttribute("login")).get("email");
	String password = ((HashMap<String, String>)session.getAttribute("login")).get("password");
	String phone 	= ((HashMap<String, String>)session.getAttribute("login")).get("phone");
	String birthday = ((HashMap<String, String>)session.getAttribute("login")).get("birthday");
	
%> 
<div class="container col-md-10">
<p align="center">
<br><br>
<strong style="color: black; font-size: 30px;">회원정보수정</strong></p>
	<form class="form-horizontal" role="form" method="post" action="../sonnim/sonnim_control.jsp">
		 <input type="hidden" name="action" value="update" />

				<div class="form-group" id="divEmail">
					<label for="inputEmail" class="col-lg-2 control-label">회원번호</label>
					<div class="col-lg-8">
						<input type="text" class="form-control" id="sonnim_id" name="sonnim_id"
							value="<%=sonnim_id%>" maxlength="40" readonly="readonly">
					</div>
					<div class="col-lg-2"></div>
				</div>


				<div class="form-group" id="divEmail">
                <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
                 <div class="col-lg-8">
                 <input type="text" class="form-control" id="email" name="email" value="<%=email %>" maxlength="40" readonly="readonly">
                </div>  <div class="col-lg-2"></div>
                </div>
    
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-8">
                    <input type="password" class="form-control" id="password" name="password" data-rule-required="true" value="<%=password %>" maxlength="30">
                </div><div class="col-lg-2"></div>
            </div>
            
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label">이름</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control onlyHangul" id="name" name="name" data-rule-required="true" maxlength="15" value="<%=name %>">
                </div><div class="col-lg-2"></div>
            </div>
            
            <div class="form-group" id="divphone">
                <label for="inputphone" class="col-lg-2 control-label">전화번호</label>
                <div class="col-lg-8">
                    <input type="tel" class="form-control onlyNumber" id="phone" name="phone" data-rule-required="true" value="<%=phone %>" maxlength="11">
                </div><div class="col-lg-2"></div>
            </div>
            
            <div class="form-group" id="divbirthday">
                <label for="inputbirthday" class="col-lg-2 control-label">생년월일</label>
                <div class="col-lg-8">
                	<input type="text" class="form-control onlyNumber id="birthday" name="birthday" value="<%=birthday.substring(0,10) %>">
                  	</div><div class="col-lg-2"></div>
                 </div>
                  	
            
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
					<input type="submit" id="update_submit" class="btn btn-primary" value="정보수정"> 
					<input type="button" id="can_btn" value="취소" class="btn btn-primary" onclick="go_can();">
					<input type="button" value="탈퇴" class="btn btn-danger" onclick="go_out();">
                </div>
            </div>
        </form>
</div>
</div>
		
<!--탈퇴 버튼 누르면  sonnim_control로 이동하기 위해서 임시 form 만듬 -->
 <form name="deletefrm" method="post"  action="../sonnim/sonnim_control.jsp">   
    <input type="hidden" name="action" value="delete" />
	<input type="hidden" id="sonnim_id" name="sonnim_id" value="<%=sonnim_id%>">
</form>		
<script type="text/javascript">
function go_out(){
	if(confirm("진짜탈퇴할래?")){
		var frm = document.deletefrm;	
		frm.submit();
	}else{
		return;
	}	
}
function go_can(){
	location.href = "../sonnim/sonnim_mypage.jsp";
}
</script>
<br><br><br><br><br><br><br><br>		
<!--main end  -->

<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>	
<!--푸터  -->
</body>
</html>