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
<br><br><br><br><br><br><br><br><br><br><br>
<div class="container" align="center">
<h1><b>음식점 예약대행사이트</b></h1>
<img src="../img/site_logo_black.png" width="700">
<img src="../img/site_team.png" width="500">
<h3 style="color: #005766"><strong>박하늘 / 김미현 / 마제오 / 박성우 / 조영숙</strong></h3>
<br>
<h4>쌍용강북교육센터 - 웹 프로그래밍 실습 프로젝트</h4>
<h6>git_hub 기반의 스프링을 활용한 실전 프레임워크 설계와 구축 개발자</h6>
</div>
<!-- main -->
<br><br><br>


<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>	
<!--푸터  -->
</body>
</html>