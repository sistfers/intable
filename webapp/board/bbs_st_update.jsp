<%@page import="intable.board.dao.BoardDao"%>
<%@page import="java.util.HashMap"%>

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
	HashMap<String, String> sesson = (HashMap<String, String>) session.getAttribute("login");
	if(sesson == null) {
%>
<jsp:forward page="/main/login.jsp" />
<%			
	}

	BoardDao dao = BoardDao.getBoardDao();
	
	String no = request.getParameter("no");
	System.out.println("컨트롤러:수정 글번호:" + no);
	
	sesson.put("no", no);	

	HashMap<String, String> data = dao.do_detail(sesson);
	int tmpRcnt = Integer.parseInt(data.get("readcount")) - 1;
	
	StringBuilder str = new StringBuilder();
	str.append(data.get("content"));
	
	String des = str.toString();
	des = des.replace("<br>", "\r\n");
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
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
</head>

<body>
	<!--헤더 -->
	<jsp:include page="../main/site_header.jsp"></jsp:include>
<br><br><br><br>
	<div id="container" class="container">
		<!-- 여기부터 시작 -->
		<!-- <main id="site_main" class="row">  -->
		<article id="page_article" class="col-md-10 row">
			<!-- 글을 읽자 -->
			<article id="contents_article" class="col-md-12">
				<!-- form 전송~~~ -->
				<form method="post" action="bbs_st_updt.jsp" name="bb_st_dpdt">
					<!-- 히든 value~~~~~~~~~~~~~~ -->
					<input type="hidden" value="<%=no %>" name="no" />
					<table class="table table-striped table-hover">
						<caption>수정</caption>
						<thead>
						</thead>
						<tbody>							
							<tr height="40px">
							<td width="120px">작성자</td>
							<%
							if (sesson.get("issonnim").equals("true")) {
								if (data.get("id").equals("999999999")) {
							%>
							<td>관리자</td>
							<%
								} else {
							%>
							<td><%=data.get("name")%></td>
							<%		
									}								
								} else {
							%>
							<td><%=data.get("name")%></td>
							<%
								}
							%>
							</tr>
							<tr height="40px">
								<td>제목</td>
								<td><input type="text" name="title" size="42" maxlength="26" value=<%=data.get("title") %> /></td>
							</tr>
							<tr height="40px">
								<td>작성일</td>
								<td><%=data.get("writedate").substring(0, 10).replace('-', '.')%></td>
							</tr>
							<tr height="40px">
								<td>조회수</td>
								<td><%=tmpRcnt%></td>
							</tr>
							<tr height="40px">
								<td colspan="2">내용</td>
							<tr>
								<td colspan="2">
								<textarea rows="10"cols="120" name="content"><%=des %></textarea></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" align="right">								
								<input type="button" value="등록" onClick="onAction()" class="btn btn-default" />
								<a href="son_help_control.jsp?action=page&pn=1" class="btn btn-default">취소</a></td>
							</tr>
						</tfoot>
					</table>
				</form>
			</article>
		</article>
		<!-- </main> -->
		<!-- 여기가 끝 -->
		<footer id="site_footer" class="col-md-12"> </footer>
	</div>

	<!--푸터  -->
	<jsp:include page="../main/site_footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	function onAction() {
		var frm = document.bb_st_dpdt;
		
		/*email Validation*/
		if(frm.title.value.length == 0 )
		{
			alert('제목을 입력하세요');
			frm.title.focus();
			return;
		}
		/*password Validation*/
		if(frm.content.value.length == 0 )
		{
			alert('내용를 입력하세요');
			frm.content.focus();
			return;
		}
		
		frm.submit();
	}
	</script>

	<script src="/js/jquery-3.1.1.min.js"></script>
	<!-- <script src="/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/bootstrap/flat-ui/js/bootstrap.min.js"></script> -->
	<script src="/js/site_script.js"></script>
</body>
</html>


