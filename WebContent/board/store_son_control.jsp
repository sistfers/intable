<%@page import="intable.board.dao.QnADao"%>
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
	QnADao dao = QnADao.getQnADao();
%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<title>bbs_ctrl</title>
<%
	/* 사용자의 요청을 컨트롤러에서 action으로 분류, 처리 */
	String action = request.getParameter("action");

/*  
*  wirte : 사용자가 qna 등록
*  cat=wr: 게시글(일반 문의)
*/
	if (action.equals("write")) {
		System.out.println("컨트롤러:cat=wr:");
		
		String store_id = request.getParameter("store_id");
		String store_name = request.getParameter("store_name");
		String sonnim_id = request.getParameter("sonnim_id");
		String sonnim_name = request.getParameter("sonnim_name");
		String chk_ = request.getParameter("chk_");
		String title = request.getParameter("title");
		String content = request.getParameter("content");		
%>
	<script type="text/javascript">
		window.close();
	</script>	
<%
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("sonnim_id", sonnim_id);
		data.put("store_id", store_id);
		data.put("title", title);
		data.put("content", content);
		
		if(dao.do_insert(data)) {
			System.out.println("컨트롤러:질문:성공");
			dao.do_search(1, 10, "", "");
		}
	}
%>
	<script type="text/javascript">
		opener.parent.opener1();
		window.close();
	</script>	
</head>

<body>

</body>
</html>


