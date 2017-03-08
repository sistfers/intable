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
%>
<%
	HashMap<String, String> map = (HashMap<String, String>) session.getAttribute("login");
	if(map == null) {
%>
<jsp:forward page="/main/login.jsp" />
<%			
	}

	BoardDao dao = BoardDao.getBoardDao();

	String no = request.getParameter("no");
	String title = request.getParameter("title");
	
	StringBuilder sttr = new StringBuilder();
	sttr.append(title);
	
	String toTitle = sttr.toString();
	toTitle = toTitle.replace(" ", "&nbsp;");
	
	StringBuilder str = new StringBuilder();
	str.append(request.getParameter("content"));
	
	String des = str.toString();
	des = des.replace("\r\n", "<br>");	

	System.out.println("updt.jsp:수정 글번호:" + no);
	System.out.println("updt.jsp:수정 글제목:" + title);
	
	map.put("seq_no", no);
	map.put("title", toTitle);
	map.put("content", des);
	map.put("table", "son_help");
	
	if(dao.do_update(map)) {
		System.out.println("updt.jsp:글수정 성공");	
		response.sendRedirect("son_help_control.jsp?action=page&pn=1");
%>
<%-- 	<jsp:forward page="son_help_control.jsp?action=page&pn=1" /> --%>
<%
	}
%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<script>
	
</script>
<style>
</style>
</head>

<body>

</body>
</html>


