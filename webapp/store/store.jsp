<%@page import="java.util.ArrayList"%>
<%@page import="intable.store.dao.StoreDao"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashMap"%>
<%@page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:requestEncoding value="UTF-8" />
<fmt:setLocale value="ko_KR" />
<%!//

	//%>
<%
	HashMap<String, String> login = session.getAttribute("login") instanceof HashMap<?, ?>
			? (HashMap<String, String>) session.getAttribute("login")
			: null;

	if (login == null || !(login.get("issonnim").equals("false"))) {

		String endUrl = request.getSession().getAttribute("endUrl") == null
				? "/"
				: request.getSession().getAttribute("endUrl").toString();

		response.sendRedirect(endUrl);

	}

	StoreDao storeDao = new StoreDao();

	HashMap<String, String> paramMap = new HashMap<String, String>();

	paramMap.put("store_id", login.get("store_id") != null ? login.get("store_id") : null);

	paramMap.put("bookstate", request.getParameter("state") == null || request.getParameter("state").equals("")
			? null
			: request.getParameter("state"));
	paramMap.put("from", request.getParameter("from") == null || request.getParameter("from").equals("")
			? null
			: request.getParameter("from"));
	paramMap.put("to", request.getParameter("to") == null || request.getParameter("to").equals("")
			? null
			: request.getParameter("to"));
	paramMap.put("query", request.getParameter("query") == null || request.getParameter("query").equals("")
			? null
			: request.getParameter("query"));
	paramMap.put("size", request.getParameter("size") == null || request.getParameter("size").equals("")
			? null
			: request.getParameter("size"));
	paramMap.put("page", request.getParameter("page") == null || request.getParameter("page").equals("")
			? null
			: request.getParameter("page"));

	request.setAttribute("list", storeDao.do_book(paramMap));

	// TODO 리디렉션 버그 잡기
	// 1. 로그인 되어 있는가?
	// 2. endUrl 이 현재 페이지와 같은가?
	// 3. 요청 쿼리가 null인가?
	// 4. ...?

	/*
	} else {
	
			String nowUrl = request.getRequestURI()
					+ (request.getQueryString() == null ? "" : "?" + request.getQueryString());
	
			session.setAttribute("endUrl", nowUrl);
	 */
%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약 확인</title>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/site_script.js"></script>
<script src="../js/store_script.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/site_style.css">
<link rel="stylesheet" href="../css/store_style.css">
<script>

</script>
<style>
@import url("http://fonts.googleapis.com/earlyaccess/notosanskr.css");

* {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
</head>
<body>
	<c:if test="${not empty param.state}">
		<c:set var="param_state" value="&state=${param.state}" />
	</c:if>
	<c:if test="${not empty param.from}">
		<c:set var="param_from" value="&from=${param.from}" />
	</c:if>
	<c:if test="${not empty param.to}">
		<c:set var="param_to" value="&to=${param.to}" />
	</c:if>
	<c:if test="${not empty param.query}">
		<c:set var="param_query" value="&query=${param.query}" />
	</c:if>
	<c:if test="${not empty param.size}">
		<c:set var="param_size" value="&size=${param.size}" />
	</c:if>
	<div id="container" class="container">
		<header id="site_header" class="row"><jsp:include
				page="../main/site_header.jsp" /></header>
		<main id="site_main" class="row container">
		<nav id="page_nav" class="navbar-left containercol-md-2">
			<ul id="page_menu" class="list-unstyled list-group table-of-contents">
				<li><div style="margin: 110px 5px 10px 0;">
						<a href="?"><button class="btn btn-primary btn-block btn-inverse">전체
								예약 목록</button></a>
					</div></li>
				<li><div style="margin: 0 5px 10px 0;">
						<a href="?state=0${param_from}${param_to}${param_query}${param_size}"><button class="btn btn-info btn-block">예약
								대기 목록</button></a>
					</div></li>
				<li><div style="margin: 0 5px 10px 0;">
						<a href="?state=1${param_from}${param_to}${param_query}${param_size}"><button class="btn btn-success btn-block">예약
								승인 목록</button></a>
					</div></li>
				<li><div style="margin: 0 5px 10px 0;">
						<a href="?state=2${param_from}${param_to}${param_query}${param_size}"><button class="btn btn-danger btn-block">예약
								취소 목록</button></a>
					</div></li>
				<li><div style="margin: 0 5px 10px 0;">
						<a
							href="../store/store_control.jsp?action=detail&store_id=${login.store_id}"><button
								class="btn btn-warning btn-block">내 상점</button></a>
					</div></li>
				<li><div style="margin: 0 5px 10px 0;">
						<a href="../store/store_update.jsp"><button
								class="btn btn-warning btn-block">내 정보 수정</button></a>
					</div></li>
				<li><div style="margin: 0 5px 10px 0;">
						<a href="../board/store_help_control.jsp?action=page&pn=1"><button
								class="btn btn-default btn-block">관리자에게 문의하기</button></a>
					</div></li>
			</ul>
		</nav>
		<header id="page_header" class="col-md-10 row">
			<h1 class="col-md-12">
				<strong style="color: black; font-size: 30px;">${login.name}</strong>
			</h1>
		</header>
		<article id="page_article" class="col-md-10 row">
			<table id="book_list" class="table table-striped table-bordered table-hover">
				<caption>
					<form>
						<c:choose>
							<c:when test="${param.state eq 0}">
								<span class="book_list_state">예약 대기 목록</span>
							</c:when>
							<c:when test="${param.state eq 1}">
								<span class="book_list_state">예약 승인 목록</span>
							</c:when>
							<c:when test="${param.state eq 2}">
								<span class="book_list_state">예약 취소 목록</span>
							</c:when>
							<c:otherwise>
								<span class="book_list_state">전체 예약 목록</span>
							</c:otherwise>
						</c:choose>
						<input type="hidden" name="state" value="${param.state}" /> <input
							type="date" name="from" id="from" value="${param.from}" size="15"
							placeholder="예약일1"> ~ <input type="date" name="to" id="to"
							value="${param.to}" size="15" placeholder="예약일2"> <input
							type="text" name="query" id="query"
							value="${not empty param.query ? param.query : null}" size="30"
							placeholder="예약번호, 손님이름, 손님전화번호"> <input type="submit"
							value="예약검색">
					</form>
				</caption>
				<thead>
					<tr id="book_head">
						<th id="book_head_no">예약번호</th>
						<th id="book_head_bookdate">예약일</th>
						<th id="book_head_booktime">예약시간</th>
						<th id="book_head_bookperson">예약인원</th>
						<th id="book_head_name">손님이름</th>
						<th id="book_head_phone">손님전화번호</th>
						<th id="book_head_note">요청사항</th>
						<th id="book_head_bookstate">예약상태</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="8"
								style="height: 400px; text-align: center; vertical-align: middle;">예약
								내역이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty list}">
						<c:forEach items="${list}" var="book" varStatus="bookListStatus">
							<tr id="book_${book.no}">
								<td id="book_${book.no}_no" class="book_no">${book.no}</td>
								<td id="book_${book.no}_bookdate" class="book_bookdate"><fmt:parseDate
										value="${book.bookdate}" var="formatDate" pattern="yyyy-MM-dd" /> <fmt:formatDate
										value="${formatDate}" pattern="yyyy-MM-dd" /></td>
								<td id="book_${book.no}_booktime" class="book_booktime">${book.booktime}</td>
								<td id="book_${book.no}_bookperson" class="book_bookperson">${book.bookperson}</td>
								<td id="book_${book.no}_name" class="book_name">${book.name}</td>
								<td id="book_${book.no}_phone" class="book_phone">${book.phone}</td>
								<td id="book_${book.no}_note" class="book_note">${book.note}</td>
								<td id="book_${book.no}_bookstate" class="book_bookstate"><c:choose>
										<c:when test="${book.bookstate eq 0}">
											<span class="book_bookstate">대기</span>
											<button onclick="store.book(${book.no}, 1);"
												class="btn btn-success btn-xs">승인</button>
											<button onclick="store.book(${book.no}, 2);"
												class="btn btn-danger btn-xs">취소</button>
										</c:when>
										<c:when test="${book.bookstate eq 1}">
											<span class="book_bookstate">승인</span>
											<button onclick="store.book(${book.no}, 0);"
												class="btn btn-info btn-xs">대기</button>
											<button onclick="store.book(${book.no}, 2);"
												class="btn btn-danger btn-xs">취소</button>
										</c:when>
										<c:when test="${book.bookstate eq 2}">
											<span class="book_bookstate">취소</span>
											<button onclick="store.book(${book.no}, 0);"
												class="btn btn-info btn-xs">대기</button>
											<button onclick="store.book(${book.no}, 1);"
												class="btn btn-success btn-xs">승인</button>
										</c:when>
										<c:otherwise>
											<span>Error</span>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="8" style="text-align: center;"><c:if
								test="${ not empty list }">
								<ul id="book_list_page" class="list-inline">
									<c:set var="book_count" value="${ list[0].book_count }" />
									<c:set var="page_block" value="${ 10 }" />
									<c:set var="page_page" value="${ empty param.page ? 1 : param.page }" />
									<c:set var="page_size" value="${ empty param.size ? 10 : param.size }" />
									<fmt:parseNumber var="page_count" value="${ book_count / page_size }"
										integerOnly="true" />
									<c:set var="page_count"
										value="${ page_count + ( ( book_count % page_size ) == 0 ? 0 : 1 ) }" />
									<fmt:parseNumber var="page_begin"
										value="${ ( page_page - 1 ) / page_block }" integerOnly="true" />
									<c:set var="page_begin" value="${ page_begin * page_block + 1 }" />
									<c:set var="page_end" value="${ page_begin + page_block - 1 }" />
									<c:if test="${ page_end > page_count }">
										<c:set var="page_end" value="${ page_count }" />
									</c:if>
									<c:if test="${ page_begin > page_block }">
										<li><a
											href="?page=1${param_state}${param_from}${param_to}${param_query}${param_size}">&lt;&lt;</a></li>
										<li><a
											href="?page=${ page_begin - 1 }${param_state}${param_from}${param_to}${param_query}${param_size}">&lt;</a></li>
									</c:if>
									<c:forEach var="i" begin="${ page_begin }" end="${ page_end }">
										<c:if test="${ i eq page_page }">
											<li><a
												href="?page=${ i }${param_state}${param_from}${param_to}${param_query}${param_size}"><b>[${ i }]</b></a></li>
										</c:if>
										<c:if test="${i ne page_page}">
											<li><a
												href="?page=${ i }${param_state}${param_from}${param_to}${param_query}${param_size}">[${ i }]</a></li>
										</c:if>
									</c:forEach>
									<c:if test="${ page_end < page_count }">
										<a
											href="?page=${ page_begin + page_block }${param_state}${param_from}${param_to}${param_query}${param_size}">&gt;</a>
										<a
											href="?page=${ page_count }${param_state}${param_from}${param_to}${param_query}${param_size}">&gt;&gt;</a>
									</c:if>
								</ul>
							</c:if></td>
					</tr>
				</tfoot>
			</table>
		</article>
		</main>
		<jsp:include page="../main/site_footer.jsp" />
	</div>
</body>
</html>
