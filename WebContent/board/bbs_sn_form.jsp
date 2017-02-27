<%@page import="java.util.HashMap"%>
<%@page import="intable.board.dao.BoardDao"%>

<%@page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%!%>
<%
	request.setCharacterEncoding("UTF-8");	
	BoardDao dao = BoardDao.getBoardDao();
%>
<%
	HashMap<String, String> sesson = (HashMap<String, String>) session.getAttribute("login");
	String cat = request.getParameter("cat");
	String title = request.getParameter("title");
	
	StringBuilder sttr = new StringBuilder();
	sttr.append(title);
	
	String toTitle = sttr.toString();
	toTitle = toTitle.replace(" ", "&nbsp;");
	
	StringBuilder str = new StringBuilder();
	str.append(request.getParameter("content"));
	
	String des = str.toString();
	des = des.replace("\r\n", "<br>");	
	
	HashMap<String, String> map = new HashMap<String, String>();
	map.put("id", request.getParameter("id"));
	map.put("title", toTitle);
	map.put("content", des);
	map.put("table", "son_help");
	map.put("issonnim", sesson.get("issonnim"));	
	
	if(cat.equals("wr")) {
		if(dao.do_insert(map)) {               
			System.out.println("손님:글등록 성공");
		} else {
			System.out.println("손님:글등록 실패");
		}
	} else if(cat.equals("repl")) {
		String no = request.getParameter("no");
		map.put("seq", no);
		
		if(dao.do_reply(map)) {
			System.out.println("관리자:답변 성공");
		} else {
			System.out.println("관리자:답변 실패");
		}
	} else if(cat.equals("noti")) {
		if(dao.do_notice(map)) {
			System.out.println("관리자:공지 성공");
		} else {
			System.out.println("관리자:공지 실패");
		}
	}
	
	 response.sendRedirect("son_help_control.jsp?action=page&pn=1");
%>
<%-- 	<jsp:forward page="son_help_control.jsp?action=page&pn=1" /> --%>
<%
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>inTable</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

* {
	font-family: 'Nanum Gothic', sans-serif;
}
</style>
<!-- Bootstrap -->
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css" />
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script> -->
</head>

<body>

</body>
</html>


