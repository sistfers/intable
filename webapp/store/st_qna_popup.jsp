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
/* 스토어 정보 가져오기


손님 정보 가져오기 */
%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<title>st_qna_popup</title>
</head>

<body>
<div>
<form name="frm_qna" method="post" action="/store/st_qna.jsp?action=write">
<input type="hidden" name="store_id" value="2000900018" />
<input type="hidden" name="store_name" value="찜닭" />
<input type="hidden" name="sonnim_id" value="1000000171" />
<input type="hidden" name="sonnim_name" value="성" />
<input type="hidden" name="chk_" value="일반" />
<input type="hidden" name="title" value="제목" />
<input type="hidden" name="content" value="내용" />

<table>
<thead>
<tr>
<td colspan="2">
<h3>XXX에 문의하기</h3>
<hr>
</td>
</tr>
</thead>

<colgroup>
<col style="width:25%">
<col style="width:75%">
</colgroup>

<tbody>
<tr>
<td>문의유형</td>
<td>
<!-- <input type="radio" name="chk_" value="general">일반
<input type="radio" name="chk_" value="reserve">예약
<input type="radio" name="chk_" value="other">기타 -->
</td>
</tr>

<tr>
<td>식당명</td>
<td></td>
</tr>

<tr>
<td>이름</td>
<td></td>
</tr>

<tr>
<td>제목</td>
<td><input type="text" name="subject" size="50" style="width:300px" /></td>
</tr>

<tr>
<td>내용</td>
<td><textarea cols="5" rows="5" style="width:320px; height:120px"></textarea>
<p>문의 시 유의해주세요!</p>
<ul>
<li>회원간 직거래로 발생하는 피해에 대해 책임지지 않습니다.</li>
<li>연락처 등의 정보는 타인에게 노출될 경우 개인정보 도용의
<br>위험이 있으니 주의해 주시기 바랍니다.</li>
<li>비방, 광고, 불건전한 내용의 글은 관리자에 의해 
사전 동의 없이 삭제될 수 있습니다.</li>
</ul>
</td>
</tr>
</tbody>

<tr>
<td colspan="2" align="center"><input type="button" value="확인" onClick="fm_wr()" />
&nbsp;<input type="button" value="취소" onClick="qPop_close()" /></td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
function fm_wr() {
	/* 여기다가 인풋 검증~~~~~~~~~~~~~~~ */
	
	/* window.opener.name = "st_qna";
	document.frm_qna.target = "st_qna";
	document.frm_qna.action = "st_qna.jsp";
	document.frm_qna.submit();
	opener.parent.opener1();
	self.close(); */
	
	//객체 생성부분
	var xmlhttp;  
	if (window.XMLHttpRequest) {  
	    xmlhttp = new XMLHttpRequest();
	} 
	else {  
	    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}	
	
	//Ajax구현부분
	xmlhttp.onreadystatechange = function() {  
	    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	         //통신 성공시 구현부분
	    }
	}
	xmlhttp.open("GET", "exam.xml", true);  
	xmlhttp.send();  
}

function qPop_close() {
	window.close();
}
</script>

</body>
</html>


