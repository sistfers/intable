<%@page import="javax.websocket.SendResult"%>
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
	HashMap<String, String> data = (HashMap<String, String>) session.getAttribute("login");
	String no = request.getParameter("no");
	data.put("seq", no);	
	data.put("table", "son_help");
	
	if(dao.do_delete(data)) {
		System.out.println("bbs_sn_del.jsp:글삭제 성공");
		response.sendRedirect("son_help_control.jsp?action=page&pn=1");
	}
%>
<%-- 	<jsp:forward page="son_help_control.jsp?action=page&pn=1" /> --%>
<%
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


