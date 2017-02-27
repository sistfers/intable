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
	HashMap<String, String> data = null;

	if (sesson == null) {
%>
<jsp:forward page="/main/lgoin.jsp" />
<%
	} else {
		BoardDao dao = BoardDao.getBoardDao();
		
		String no = request.getParameter("no");
		sesson.put("no", no);
		sesson.put("tb", "store_help");
		System.out.println("뷰:선택 글번호:" + sesson.get("no"));
		data = dao.do_detail(sesson);
	}
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
		<!-- <main id="site_main" class="row">  -->
		<article id="page_article" class="col-md-10 row">
			<!-- 글을 읽자 -->
			<article id="contents_article" class="col-md-12">
				<table class="table table-striped table-hover">
					<caption>게시글</caption>
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
						<%
							if (data.get("reply_yn").equals("2")) {							
						%>
						<td>관리자에 의해 블라인드 처리되었습니다</td>
						<%		
							} else {								
						%>
						<td><%=data.get("title")%></td>
						<%								
							}
						%>
						</tr>
						<tr height="40px">
							<td>작성일</td>
							<td><%=data.get("writedate").substring(0, 10).replace('-', '.')%></td>
						</tr>
						<tr>
							<td>조회수</td>
							<td><%=data.get("readcount")%></td>
						</tr>
						<tr height="40px">
							<td colspan="2">내용</td>
						</tr>
						<tr>
						<%
							if (data.get("reply_yn").equals("2")) {							
						%>
						<td colspan="2">바르고 고운말을 사용합시다<br> 2번 규칙 위반 시 탈퇴처리됩니다</td>
						<%		
							} else {								
						%>
						<td colspan="2"><%=data.get("content")%></td>
						<%								
							}
						%>							
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" align="right">
								<%
									// storeId? store_id????????????손님 다오
									System.out.println("store_id:"+sesson.get("store_id"));
									System.out.println("id:"+data.get("id"));
									
									/* 			parent notice reply_yn
									*	일반글	null	0		0
									*	답변후	null	0		1
									*   블라인드	null	0		2
									*
									*	답변		seq		0		1
									*	공지		-1		-1		1 									
									*/	
									// 관리자
									if(sesson.get("issonnim").equals("true")) {
										// 관리자 모드 시작
										if (sesson.get("sonnim_id").equals("999999999")) {
											// 공지 or 답변
											if (sesson.get("sonnim_id").equals(data.get("id"))) {
												%>
												<input type="button" value="수정" class="btn btn-default"
											onClick="location.href='store_help_control.jsp?action=update&no=<%=data.get("seq_no")%>'" />
												<%
												// 답변
												if(data.get("reply_yn").equals("0")) {
												
												// 공지
												} else if(data.get("notice").equals("-1")) {
												%>
												<input type="button" value="삭제" class="btn btn-default"
											onClick="location.href='store_help_control.jsp?action=delete&no=<%=data.get("seq_no")%>'" />
												<%	
												}
											// 상점 회원 게시글	
											} else {
												// 블라인드 or 답변 가능
												if (data.get("reply_yn").equals("0")) {
												%>	
												<input type="button" value="블라인드" class="btn btn-default"
											onClick="location.href='store_help_control.jsp?action=blind&no=<%=data.get("seq_no")%>'" />
												<input type="button" value="답변" class="btn btn-default"
											onClick="location.href='store_help_control.jsp?action=reply&no=<%=data.get("seq_no")%>'" />
												<%	
												} else if (data.get("reply_yn").equals("2")) {
													// 블라인드 된거는 더 이상 권한 없음
												}
											}
										}	
									// 스토어
									} else {
										// 본인이 작성한 게시글
										if (sesson.get("store_id").equals(data.get("id"))) {
											// 답변이 달리지 않은 글
											System.out.println("reply_yn:"+data.get("notice"));
											if (data.get("reply_yn").equals("0")) {
												%>
												<input type="button" value="수정" class="btn btn-default"
											onClick="location.href='store_help_control.jsp?action=update&no=<%=data.get("seq_no")%>'" />												
												<input type="button" value="삭제" class="btn btn-default"
											onClick="location.href='store_help_control.jsp?action=delete&no=<%=data.get("seq_no")%>'" />
												<%
											} else if (data.get("reply_yn").equals("2")) {
												// 블라인드 된 글은 수정 삭제 안됨
											}
										// 다른 사람의 게시글	
										} else {
											// 어떠한 권한도 없어야한다
										}
									}	
									%>
								<a href="javascript:history.back()" class="btn btn-default">뒤로가기</a>
							</td>
						</tr>
					</tfoot>
				</table>
			</article>
		</article>
		<!-- </main> -->
		<!-- 여기가 끝 -->
		<footer id="site_footer" class="col-md-12"> </footer>
	</div>

	<!--푸터  -->
	<jsp:include page="../main/site_footer.jsp"></jsp:include>

	<script src="/js/jquery-3.1.1.min.js"></script>
<!-- 	<script src="/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/bootstrap/flat-ui/js/bootstrap.min.js"></script> -->
	<script src="/js/site_script.js"></script>
</body>
</html>


