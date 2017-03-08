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
%>
<%
	HashMap<String, String> sesson = (HashMap<String, String>) session.getAttribute("login");
	String id = sesson.get("sonnim_id");
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
	<!--헤더 -->
	<jsp:include page="../main/site_header.jsp"></jsp:include>
	<br><br><br><br>
	<div id="container" class="container">
		<!-- 여기부터 시작 -->
		<!-- <main id="site_main" class="row"> -->
		<article id="page_article" class="col-md-10 row">
			<!-- 글을 쓰자 -->
			<article id="contents_article" class="col-md-12">
				<!-- form 전송~~~ -->
				<form method="post" action="bbs_sn_form.jsp" name="bbs_sn">
					<!-- 히든 value~ -->
					<% // 일반 게시글 등록
					if(request.getParameter("cat").equals("wr")) {						
					%>	
					<input type="hidden" name="cat" value="wr" />
					<input type="hidden" name="id" value="<%=id %>" />
					<% // 관리자 답변 등록
					} else if(request.getParameter("cat").equals("repl")) {
					%>
					<input type="hidden" name="cat" value="repl" />
					<input type="hidden" name="no" value="<%=request.getParameter("no") %>" />
					<input type="hidden" name="id" value="<%=id %>" />
					<% // 관리자 공지 등록
					} else if(request.getParameter("cat").equals("noti")) {
					%>
					<input type="hidden" name="cat" value="noti" />
					<input type="hidden" name="id" value="<%=id %>" />
					<%
					}
					%>
					<table class="table table-striped table-hover">
						<caption>글작성</caption>
						<thead>
						</thead>
						<tbody>
							<tr height="40px">
								<td width="120px">제목</td>
								<td><input type="text" name="title" size="42" maxlength="26"></td>
							</tr>
							<tr height="40px">
								<td>내용</td>
								<td></td>
							</tr>
							<tr>
								<td colspan="2"><textarea name="content" rows="10"cols="120"></textarea></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" align="right">								
								<input type="button" value="등록" onClick="onAction()" class="btn btn-default"/>
								<a href="javascript:history.back()" class="btn btn-default">취소</a></td>
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
		var frm = document.bbs_sn;
		
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

	<script src="/js/jquery.min.js"></script>
	<!-- <script src="/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/bootstrap/flat-ui/js/bootstrap.min.js"></script> -->
	<script src="/js/site_script.js"></script>
</body>
</html>


