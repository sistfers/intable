<%@page import="intable.board.dao.BoardDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%!int total_cnt = 0;int pageNum = 0;%>
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
	
	String wd = null;
	wd = request.getParameter("wd");
	
	if(wd != null) {
		System.out.println(1);
		total_cnt = dao.do_words_pagi("store_help", wd);	
	} else {
		System.out.println(2);
		// 답변 공지를 제외한 총 게시글의 수는?
		// total_cnt = dao.do_pagination("store_help");		
	}
	pageNum = Integer.parseInt(request.getParameter("pn"));
	System.out.println(total_cnt);
	
	int total_pg = total_cnt / 10; // 10 is pageSize
	if (total_cnt % 10 > 0) {
		total_pg++;
	}
	
	// 현재 페이지가 최대 페이지를 넘어서면?
	if (total_pg < pageNum) {
		pageNum = total_pg;
	}	
	
	if (1 > pageNum) {
		pageNum = 1;		
	}

	int startPage = ((pageNum - 1) / 10) * 10 + 1;	
	int endPage = startPage + 10 - 1;
	
	//  여기서 마지막 페이지를 보정해줍니다.
	if (endPage > total_pg) {
	    endPage = total_pg;			
	}			
	
	ArrayList<HashMap<String, String>> n = dao.do_search_notice("store_help");
	ArrayList<HashMap<String, String>> s = null;
	if(wd != null) {
		s = dao.do_words_result(pageNum, 10, wd, "store", "store_help");
	} else {
		
	}	

	System.out.println("게시판:페이지번호" + pageNum);
	/* System.out.println("게시판:공지" + n.size()); */
	System.out.println("게시판:질문+답변" + s.size());		
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고객센터</title>
<!-- Bootstrap -->
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css" />

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script> -->
</head>
<body>
<!--헤더 -->
<jsp:include page="../main/site_header.jsp"></jsp:include>

<!--main -->
<br><br><br><br>
<div id="container" class="container">
<center><h2 style="color: #993800">고객센터 Q & A 게시판</h2></center>
<div class=col-md-1></div>
	
<div class=col-md-10>
	<!-- <main id="site_main" class="row"> -->
	<!-- <article id="page_article" class="col-md-10 row"> -->
		<!-- 리스트를 만들어주자 -->
		<article id="contents_article" class="col-md-12">
			<!-- 테두리 있는거 -->
			<!-- <table class="table table-striped table-bordered table-hover"> --> 
			<!--테두리 없는거  -->
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th width="12%">No.</th>
						<th width="46%">제목</th>
						<th width="14%">작성자</th>
						<th width="16%">작성일</th>
						<th width="10%">조회수</th>
					</tr>
				</thead>
				<tbody>
				<%
					for (int i = 0; i < n.size(); i++) {
						HashMap<String, String> map = n.get(i);
				%>
				<!-- 공 지 사 항  리 스 트 -->
				<%-- <tr class="danger" height="40px">
					<td>공지사항</td>
					<td><a
						href='store_help_control.jsp?action=read
						&no=<%=map.get("seq_no")%>'><%=map.get("title")%></a></td>
					<td>관리자</td>
					<td><%=map.get("writedate").substring(0, 10).replace('-', '.')%></td>
					<td><%=map.get("readcount")%></td>
				</tr> --%>
				<%
					}
				%>
				<%
					for (int i = 0; i < s.size(); i++) {
						HashMap<String, String> map = s.get(i);
				%>
				<!-- 유저(손님) 게 시 글  리 스 트 -->
				<tr height="40px">
					<!-- 출 력 내 용
					<td >No.</td>
					<td >제목</td>
					<td >작성자</td>
					<td >작성일</td>
					<td >조회수</td> -->
				<%
					if (map.get("parent") == null) {
				%>
				<td><%=map.get("seq_no")%></td>
				<%
					} else {
				%>
				<td style="text-align: right;">[re:]</td>
				<%
					}
					if (map.get("reply_yn").equals("2")) {							
				%>
				<td><a
					href='store_help_control.jsp?action=read
					&no=<%=map.get("seq_no")%>'>관리자에 의해 블라인드 처리되었습니다</a></td>
				<%		
					} else {								
				%>
				<td><a
					href='store_help_control.jsp?action=read
					&no=<%=map.get("seq_no")%>'><%=map.get("title")%></a></td>
				<%								
					}
					if (map.get("parent") == null) {
				%>
				<td><%=map.get("name")%> <%-- <%=map.get("id")%> --%></td>
				<%
					} else {
				%>
				<td>관리자</td>
				<%
					}
				%>
				<td><%=map.get("writedate").substring(0, 10).replace('-', '.')%></td>
				<td><%=map.get("readcount")%></td>
				</tr>
				<%
					}
				%>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" >
					
					<form method="post" action="store_help_control.jsp?action=rs" name="search">
					<div class="col-xs-10">
					<input type="text" name="wd" size="5" maxlength="14" class="form-control" placeholder="검색할 단어를 입력하세요" />
					</div><div class="col-xs-2">
					<input type="button" value="검색" onClick="onAction()" class="btn btn-info"/>
					</div></form>
					</td><td colspan="3" >
				<%
					if (sesson.get("issonnim").equals("true")) {
						System.out.println("<<<주의>>>관리자라면" + sesson.get("sonnim_id"));
						if (sesson.get("sonnim_id").equals("999999999")) {
				%>
						<p align="right"><input type="button" value="손님 게시판" class="btn btn-default"
							onClick="location.href='son_help_control.jsp?action=page&pn=1'" />
						<input type="button" value="전체 문의" class="btn btn-default" 
							onClick="window.location='store_help_control.jsp?action=page&pn=1'" />
						<input type="button" value="공지" class="btn btn-default"
							onClick="location.href='store_help_control.jsp?action=notice'" />
				<%
						} 	
					// 스토어 글쓰기
					} else {
				%>
					<p align="right">
					<input type="button" value="전체 문의" class="btn btn-default" 
						onClick="window.location='store_help_control.jsp?action=page&pn=1'" />
					<input type="button" value="글쓰기" class="btn btn-default" 
						onClick="window.location='store_help_control.jsp?action=write'" /></p>
					<%
						}
					%>
					</td>
				</tr>
				<!-- <tr>
				<td colspan="5"><div align="center">
					<form method="post" action="store_help_control.jsp?action=rs" name="search">
					<input type="text" name="wd" size="30" maxlength="14" value="" />
					<input type="button" value="검색" onClick="onAction()" /></form></div></td>
				</tr> -->
			</tfoot>
			</table>
		</article>
		<footer id="contents_footer" class="col-md-12">
		<div id="pagination" align="center">			
			<ul class="pagination pagination-sm">
				<li><a href="store_help_control.jsp?action=page&pn=<%=startPage-10 %>">&lt;</a></li>
				<li>
					<!-- <ol class="list-inline"> -->
					<%
					for (int iCount = startPage; iCount <= endPage; iCount++) {
					%>
					
					<a href="store_help_control.jsp?action=page&pn=<%=iCount %>"><%=iCount %></a>				
					<%
						if(iCount < endPage) {
					%>		&nbsp;&nbsp;
					<%		
						}
					}
					%>
					<!-- </ol> -->
				</li>
				<li><a href="store_help_control.jsp?action=page&pn=<%=startPage+10 %>">&gt;</a></li>
			</ul></div>
		</footer> 
	<!-- </article> -->
	<!-- 여기가 끝 -->
</div>
<div class=col-md-1></div>
	</div>

	<!--푸터  -->
	<jsp:include page="../main/site_footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	function onAction() {
		var frm = document.search;
		
		/*검색창*/
		if(frm.wd.value.length == 0 )
		{
			alert('제목을 입력하세요');
			frm.wd.focus();
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


