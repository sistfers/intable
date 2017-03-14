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
<%!//

//%>
<%
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--헤더 -->
<jsp:include page="../main/site_header.jsp"></jsp:include>
<!--헤더 -->



<!-- main -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<div class="container" align="center">
<h1>회원가입을 축하!</h1><br><br>
<img src="../img/site_logo_black.png" width="500">
</div>
<!-- main -->
<br><br><br><br><br><br><br><br><br><br><br><br>


<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>	
<!--푸터  -->
</body>
</html>