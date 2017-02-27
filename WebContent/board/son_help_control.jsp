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
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	/* 사용자의 요청을 컨트롤러에서 action으로 분류, 처리 */
	String action = request.getParameter("action");

	/*  
	*  page: 사용자가 고객센터(손님) 페이지로 접속함
	*  pn  : 게시판 pageNum
	*/
	if (action.equals("page")) {
		String pageNum = request.getParameter("pn");		
		System.out.println("컨트롤러:페이지 인덱스:" + pageNum);		
%>
<jsp:forward page="bbs_sn_list.jsp?pn=<%=pageNum %>" />
<%

	/*  
	*  read: 사용자가 고객센터(손님) 게시글을 읽음 
	*  no  : 게시글 번호
	*/
	} else if (action.equals("read")) {		
		String no = request.getParameter("no");
		System.out.println("컨트롤러:선택 글번호:" + no);
%>
<jsp:forward page="bbs_sn_read.jsp?no=<%=no %>" />
<%

	/*  
	*  wirte : 사용자가 고객센터(손님) 게시글을 남기고자 함
	*  cat=wr: 게시글(일반 문의)
	*/
	} else if(action.equals("write")) {		
		System.out.println("컨트롤러:cat=wr:");
%>
<jsp:forward page="bbs_sn_write.jsp?cat=wr" />
<%

	/*  
	*  update: 사용자가 고객센터(손님) 게시글을 수정하고자 함
	*  no    : 게시글 번호
	*/
	} else if(action.equals("update")) {
		String no = request.getParameter("no");
		System.out.println("컨트롤러:수정 글번호:" + no);
%>
<jsp:forward page="bbs_sn_update.jsp?no=<%=no %>" />
<%		
	
	/*  
	*  delete: 사용자가 고객센터(손님) 게시글을 삭제하고자 함
	*  no    : 게시글 번호
	*/
	} else if(action.equals("delete")) {		
		String no = request.getParameter("no");
		System.out.println("컨트롤러:삭제 글번호:" + no);
%>
<jsp:forward page="bbs_sn_del.jsp?no=<%=no %>" />
<%		
	
	/*  
	*  reply   : 관리자가 고객센터(손님) 게시글에 답변을 남기고자 함
	*  no      : 답변을 남기고자 한 게시글 번호
	*  cat=repl: 게시글(답변)
	*/
	} else if(action.equals("reply")) {
		String no = request.getParameter("no");	
		System.out.println("컨트롤러:답변 원래 글번호:" + no);
%>
<jsp:forward page="bbs_sn_write.jsp?cat=repl&no=<%=no %>" />
<%	
	
	/*  
	*  notice  : 관리자가 고객센터(손님) 공지사항을 작성하고자 함
	*  cat=noti: 게시글(공지)
	*/
	} else if(action.equals("notice")) {
		System.out.println("컨트롤러:공지");
%>
<jsp:forward page="bbs_sn_write.jsp?cat=noti" />
<%		

	/*  
	*  blind  : 관리자가 고객센터(손님) 게시글 블라인드 처리
	*  cat=noti: 게시글(공지)
	*/
	} else if(action.equals("blind")) {
		String no = request.getParameter("no");	
		System.out.println("컨트롤러:블라인드 글번호:" + no);
		
		HashMap<String, String> sesson = (HashMap<String, String>) session.getAttribute("login");
	
		if(sesson == null) {
%>
<jsp:forward page="/main/login.jsp" />
<%				
		} else {
			sesson.put("no", no);
			sesson.put("table", "son_help");
			BoardDao dao = BoardDao.getBoardDao();
			dao.do_blind(sesson);
			response.sendRedirect("son_help_control.jsp?action=page&pn=1");
%>
<%-- <jsp:forward page="bbs_sn_list.jsp?pn=1" /> --%>
<%		
		}		
	} else if(action.equals("mine")) {
		String myid = request.getParameter("myid");
		System.out.println("컨트롤러:내 문의:" +myid);
%>
<jsp:forward page="bbs_sn_list.jsp?pn=1&id=<%=myid %>" />
<%		
	} else if(action.equals("rs")) {
		String search_wrod = request.getParameter("wd");
		System.out.println("컨트롤러:검색 단어:" +search_wrod);
%>
<jsp:forward page="bbs_sn_list_rs.jsp?pn=1&wd=<%=search_wrod %>" />
<%			
	}
%>	

<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1"> -->
<title>son_help_control</title>
<script>
	
</script>
<style>
</style>
</head>

<body>

</body>
</html>


