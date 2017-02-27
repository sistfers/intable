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

HashMap<String, String> login = session.getAttribute("login") instanceof HashMap<?, ?>
	? (HashMap<String, String>) session.getAttribute("login")
	: null;
/* 	if(sesson != null)
		System.out.println("접속자:" + sesson.get("issonnim")); */
%>
<hr>

<footer class="footer text-center footer-fixed-bottom">
<div class="container">
		<div class="row">
			<div class="col-xs-1">
				<img src="../img/site_team.png" width="150"></div>		
			<div class="col-xs-11">
				<ul class="list-inline social-buttons">
					<li><a href="../main/sf_intable.jsp" style="color: black;  font-weight: bold;">inTable 소개</a></li>
					<li><a href="../main/sf_service.jsp" style="color: black;  font-weight: bold;">이용약관</a></li>
					<!-- <li><a href="../main/sf_policy.jsp" style="color: black;  font-weight: bold;">운영정책</a></li> -->
					<li><a href="../main/sf_privacy.jsp" style="color: black;  font-weight: bold;">개인정보처리방침</a></li>
					<%
					if(login == null) {
					%>
					<li><a href="/main/login.jsp" style="color: black;  font-weight: bold;">고객센터</a></li> 
					<%
					} else {
						// 손님 접속
						if(login.get("issonnim").equals("true")) {
							// 관리자 처리 필요 if() 또는 관리자도 고객 게시판 먼저 접속		
					%>
					<li><a href="/board/son_help_control.jsp?action=page&pn=1" style="color: black;  font-weight: bold;">고객센터</a></li>
					<%
						// 음식점 접속
						} else if(login.get("issonnim").equals("false")) {
					%>
					<li><a href="/board/store_help_control.jsp?action=page&pn=1" style="color: black;  font-weight: bold;">고객센터</a></li>
					<%		
						} else {
							System.out.println("누구냐? 넌!");
						}
					}
					%>
					<!-- <li><a href="../main/sf_sitemap.jsp" style="color: black;  font-weight: bold;">사이트맵</a></li> -->
				</ul>
			</div>
			<h6>Copyright 2017. ⓒ 삼시n끼 All Rights Reserved.</h6>
		</div>
	</div>
</footer>