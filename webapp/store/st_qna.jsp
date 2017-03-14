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
	String store_id = request.getParameter("store_id");
	System.out.println(store_id);
%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<title>st_qna</title>
</head>

<body>

<div>
<table>
<tr>
<td>문의하기</td>
<td colspan="6">담당자가 직접 답변을 드립니다</td>
</tr>

<tr>
<td></td>
<td>문의유형(전체)</td>
<td align="right">검색창 검색버튼</td>
<!-- onClick 마지막 부분에 return false 를 넣어 클릭시 페이지 최상단으로 이동되는걸 막는다 -->
<td><a href="#" onClick="qPop(); return false;">문의하기</a></td>
<td>내 문의</td>
<td>전체 문의</td>
</tr>

<tr>
<td>번호</td>
<td>문의유형</td>
<td width="300">제목</td>
<td>조회수</td>
<td>문의자</td>
<td>내 등록일</td>
</tr>

<tr><td>공백</td></tr>

<tr>
<td>1</td>
<td>2</td>
<td>3</td>
<td>></td>
</tr>
</table>
</div>

<body>
	<script type="text/javascript">
	function qPop() {
		var popOption = "width=570, height=570;";
		window.open('st_qna_popup.jsp', "", popOption);
	}
	
	function opener1() {
		/* alert("ㅇㅇ"); */
	}
	</script>

</body>
</html>


