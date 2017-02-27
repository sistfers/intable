<%@page import="java.util.HashMap"%>
<%@page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:requestEncoding value="UTF-8" />
<fmt:setLocale value="ko_KR" />
<%!//

//%>
<%
	HashMap<String, String> login = session.getAttribute("login") instanceof HashMap<?, ?>
			? (HashMap<String, String>) session.getAttribute("login")
			: null;

	if (login != null) {

		String endUrl = request.getSession().getAttribute("endUrl") == null

				? "/"
				: request.getSession().getAttribute("endUrl").toString();

		response.sendRedirect(endUrl);

	}

	// TODO 리디렉션 버그 잡기
	// 1. 로그인 되어 있는가?
	// 2. endUrl 이 현재 페이지와 같은가?
	// 3. 요청 쿼리가 null인가?
	// 4. ...?

	/*
	} else {
	
			String nowUrl = request.getRequestURI()
					+ (request.getQueryString() == null ? "" : "?" + request.getQueryString());
	
			session.setAttribute("endUrl", nowUrl);
	 */
%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>login</title>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/site_script.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/site_style.css">
<script>

</script>
<style>

</style>
</head>
<body>
<!--헤더 -->
<jsp:include page="site_header.jsp"></jsp:include>
<!--헤더 end -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<!-- Main Form -->
<div class="container">
<div class="modal-body">
		<div class="row">
	
			<div class="col-xs-5">				
				<div class="well" style="background-color:#EBF7FF">
				<h1 align="center">사용자</h1>
				    <form action="../sonnim/sonnim_control.jsp" method="post" name="son_login">
   					<input type=hidden name="action" value="login">
						<div class="form-group">
							<label for="username" class="control-label">UserEmail</label> 
							<input type="text" class="form-control" id="email" name="email"
								value="" required="" placeholder="example@gmail.com" maxlength="30">
						</div>
						
						<div class="form-group">
							<label for="password" class="control-label">Password</label> 
							<input type="password" class="form-control" id="password" name="password" maxlength="15"> 
						</div>
						</form>
						<button class="btn btn-info" onclick="onAction()">Login</button>
						<button class="btn btn-primary" onclick="do_son_join()">Join</button>
					
					
				</div>
			</div>
			
			<!-- 여백용 -->
			<div class="col-xs-2"></div>

			<div class="col-xs-5">
				<div class="well" style="background-color:#FFEAEA">
				<h1 align="center">음식점</h1>
<!-- 음식점 로그인 -->
						<script src="../js/store_script.js"></script>
						<form id="store_login" name="storeLogin"
							action="../store/store_control.jsp" method="post"
							onsubmit="return store.login();">
							<input type="hidden" name="action" value="login">
							<div class="form-group">
								<label for="store_login_email" class="control-label">UserEmail</label>
								<input type="email" id="store_login_email" name="email" class="form-control"
									placeholder="example@gmail.com" title="Please enter you Email" required>
								<!-- <span class="help-block"></span> -->
							</div>
							<div class="form-group">
								<label for="store_login_password" class="control-label">Password</label>
								<input type="password" id="store_login_password" name="password" class="form-control"
									placeholder="password" title="Please enter your Password" required>
								<span class="help-block"></span>
							</div>
							<input type="submit" id="store_login_submit" value="Login" class="btn btn-info">
							<input type="button" id="store_login_join" value="Join" class="btn btn-primary"
								onclick="store.join();">
						</form>
<!-- 음식점 로그인 -->
				</div>
			</div>
		</div>
	</div>
	<br><br><br><br><br><br><br>
</div>
	<!-- end:Main Form -->


<script type="text/javascript">
//손님회원가입페이지로 이동
function do_son_join(){
	location.href = "../sonnim/sonnim_join.jsp";
}
//음식점 회원가입페이지로 이동
function do_store_join(){
	location.href = "../store/store_insert.jsp";
}

// Validation 체크
function onAction(){	
	var frm = document.son_login;

	/*email Validation*/
	if(frm.email.value.length == 0 )
	{
		alert('email을 입력하세요');
		frm.email.focus();
		return;
	}
	/*password Validation*/
	if(frm.password.value.length == 0 )
	{
		alert('password를 입력하세요');
		frm.password.focus();
		return;
	}
	
	frm.submit();
}

</script>
	
<!--푸터  -->
<jsp:include page="site_footer.jsp"></jsp:include>	
<!--푸터 end -->
</body>
</html>