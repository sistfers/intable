<%@page import="intable.book.dao.BookDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page trimDirectiveWhitespaces="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%!
//테이블 그린다!!
public String tableDisplay(int pageNum, int pageSize, ArrayList<HashMap<String, String>> list){
	int total_count = Integer.parseInt(list.get(0).get("count"));
	int rowCount = ((int)(Math.sqrt(pageSize)));
	String s = "<table>";
	
	for(int i = 0; i < list.size(); i=i + rowCount){
		s += "<tr>";
		for(int j = 0; ((j < rowCount)&&((i+j) < list.size())); j++){
			s += "<td>";
			
			s += "<table border='1' class='nav-pills'>";
			
			s += "<tr><td align='center' colspan='2'>";
			s += list.get(i+j).get("bookstate");
			s += "</td></tr>";
			s += "<tr><td>음식점</td>";
			s += "<td>" + list.get(i+j).get("name") + "</td></tr>";
			s += "<tr><td>예약날짜</td>";
			s += "<td>" + list.get(i+j).get("bookdate") + " " + list.get(i+j).get("booktime") + "시" + "</td></tr>";
			s += "<tr><td>예약 인원</td>";
			s += "<td>" + list.get(i+j).get("bookperson") + "</td></tr>";
			s += "<tr><td>요청사항</td>";
			s += "<td>" + list.get(i+j).get("note") + "</td></tr>";
			s += "<tr><td align='center' colspan='2'><button>state별 내용다른 버튼</button></td></tr>";
			
			s += "</table>";
			
			s += "</td>";
		}
		s += "</tr>";
	}
	
	s += "</table>";
	
	s += "<center><ol class='list-inline'>";
	int page_count = (total_count%pageSize)!=0?(total_count/pageSize)+1:(total_count/pageSize);
	for(int i = 1; i <= page_count; i++){
		s += "<li><a href='?page=" + i + "'>" + i + "</a></li>";
	}
	
	s += "</ol></center>";
	
	return s;
}

%>

<%
	HashMap<String, String> login = (HashMap<String, String>)request.getSession().getAttribute("login");
	HashMap<String, String> infoMap = (HashMap<String, String>)request.getAttribute("infoMap");
	ArrayList<HashMap<String, String>> list = (ArrayList<HashMap<String, String>>)request.getAttribute("list");
	BookDao dao = new BookDao();
	
	%><%--<%//음식점 로그인상태이면 예약 창을 볼수없음
	if(map.get("issonnim").equals("false")){
	String endUrl = request.getSession().getAttribute("endUrl").toString();
	System.out.println(request.getRequestURI()+" "+endUrl);
	--%>
<!-- 	<script type="text/javascript"> 
 		alert("사장님! 남에 가게 예약 하시게요?");
 	</script> -->
	<%--<%
	response.sendRedirect(endUrl);		// 이전페이지로 이동
	
	//마지막 페이지 저장용
	String nowUrl = request.getRequestURI() +"?"+ request.getQueryString();  
	session.setAttribute("endUrl", nowUrl );
	} --%><%
	//ArrayList<Integer> count = dao.do_getStateCount(login);
	
	String pageNumStr ;
	String pageSizeStr;
	//testcode
	infoMap = new HashMap<>();
	infoMap.put("state", "0");
	infoMap.put("search_div", "NAME");
	infoMap.put("search_word", "안녕");
	infoMap.put("pageNum", "1");
	infoMap.put("pageSize", "9");
	
	HashMap<String, String> son_id = new HashMap<>();
	son_id.put("sonnim_id", "2000100007");
	ArrayList<Integer> count = dao.do_getStateCount(son_id);
	//list = dao.do_getList(1, 9, son_id.get("sonnim_id"));
	list = dao.do_search(1, 9, "NAME", "먹", son_id.get("sonnim_id"));
	//list = dao.do_search(2, 10, "NAME", "먹", son_id.get("sonnim_id"));
	
	//testcode end
	
	pageNumStr = infoMap.get("pageNum");
	pageSizeStr = infoMap.get("pageSize");
	
	int pageNum = (pageNumStr == null || pageNumStr == "")?1:Integer.parseInt(pageNumStr);
	int pageSize = (pageSizeStr == null || pageSizeStr == "")?10:Integer.parseInt(pageSizeStr);
	
	String search_div = (infoMap.get("search_div") == null)?"":infoMap.get("search_div");
	String search_word = (infoMap.get("search_word") == null)?"":infoMap.get("search_word");
	
	String state = (infoMap.get("state") == null)?"":infoMap.get("state");
	out.println(pageNum+ " , " + pageSize + " , " + search_div + ", " + search_word + ", " + state);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<title>마이페이지 > 예약확인</title>
</head>
<body>
<!--헤더 -->
<jsp:include page="../main/site_header.jsp"></jsp:include>
<div class="col-md-11 container">
	<div id="page_header" class="page-header col-md-12">
		<h5>HOME>마이페이지>예약확인</h5>
	</div>
	<div class="contents-articleb row">
		<div class="navbar-left container col-md-2">
			<div class="list-group table-of-contents">
				<a class="list-group-item">정보수정</a>
	          	<a class="list-group-item">좋아요한 목록</a>
				<a href="#" class="list-group-item dropdown-toggle" data-toggle="dropdown">
					예약확인
				</a>
				<ul class="dropdown-menu" role="menu">
		            <li class="list-group-item"><a href="#">이용예정목록</a></li>
		          	<li class="list-group-item"><a href="#">이용완료목록</a></li>
		            <li class="list-group-item"><a href="#">예약취소목록</a></li>
	          	</ul>
			</div>
		</div>
		
		<div class="container col-md-10">
			<div class="col-md-12">
				<div class="col-md-3">손님이름</div>
				<div class="col-md-2">
					전체 이용건수<br>
					<%=count.get(0) %>
				</div>
				<div class="col-md-2">
					현재예약 건수<br>
					<%=count.get(1) %>
				</div>
				<div class="col-md-2">
					이용완료 건수<br>
					<%=count.get(2) %>
				</div>
				<div class="col-md-2">
					취소건수<br>
					<%=count.get(3) %>
				</div>
			</div>
			<br><br><br>
			<div align="center" border="1" class="col-md-9">
			호잇 이제 예약 목록을 확인해보자.
			<%=
			tableDisplay(pageNum, pageSize, list)
			%>
			</div>

			
		</div>
	</div>
	<!--푸터  -->
	<jsp:include page="../main/site_footer.jsp"></jsp:include>
</div>

<script type="text/javascript">
$(document).ready(function () {

    $('.dropdown-toggle').dropdown();
});
</script>
</body>
</html>