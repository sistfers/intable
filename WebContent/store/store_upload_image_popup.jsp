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

	if (login == null || !(login.get("issonnim").equals("false"))) {

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
<title>사진 업로드</title>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/site_script.js"></script>
<script src="../js/store_script.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/site_style.css">
<link rel="stylesheet" href="../css/store_style.css">
<script>
	
</script>
<style>
body {
	background-color: #d9edf7;
}

#container {
	width: 300px;
	height: 400px;
	padding: 20px;
}

#uploadForm {
	margin: 0 auto;
}
</style>
</head>
<body>
	<div id="container" class="container">
		<form name="uploadForm" id="uploadForm" action="/store/upload/image"
			method="post" enctype="multipart/form-data" class="form-horizontal">
			<fieldset>
				<legend>사진 업로드</legend>
				<div class="form-group">
					<label for="${sessionScope.login.store_id}.1" class="">이미지1</label> <input
						type="file" name="${sessionScope.login.store_id}.1"
						id="${sessionScope.login.store_id}.1" accept="image/*" class="">
				</div>
				<div class="form-group">
					<label for="${sessionScope.login.store_id}.2" class="">이미지2</label> <input
						type="file" name="${sessionScope.login.store_id}.2"
						id="${sessionScope.login.store_id}.2" accept="image/*" class="">
				</div>
				<div class="form-group">
					<label for="${sessionScope.login.store_id}.3" class="">이미지3</label> <input
						type="file" name="${sessionScope.login.store_id}.3"
						id="${sessionScope.login.store_id}.3" accept="image/*" class="">
				</div>
				<div class="form-group">
					<label for="${sessionScope.login.store_id}.4" class="">이미지4</label> <input
						type="file" name="${sessionScope.login.store_id}.4"
						id="${sessionScope.login.store_id}.4" accept="image/*" class="">
				</div>
				<div class="form-group">
					<label for="${sessionScope.login.store_id}.5" class="">이미지5</label> <input
						type="file" name="${sessionScope.login.store_id}.5"
						id="${sessionScope.login.store_id}.5" accept="image/*" class="">
				</div>
				<div class="form-group" style="text-align: center; padding-top: 15px;">
					<input type="submit" value="전송" class=""> <input type="button"
						value="취소" onclick="window.close();" class="">
				</div>
			</fieldset>
		</form>
	</div>
</body>
</html>