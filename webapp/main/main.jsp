<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="intable.store.dao.StoreDao"%>
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

	//마지막 페이지 저장용
	String nowUrl = request.getRequestURI() +"?"+ request.getQueryString();  	
	session.setAttribute("endUrl", nowUrl ); 

%>
<%
	session.getAttribute("login");
	
	StoreDao dao = new StoreDao();

	int pageNum = 1; // 1페이지
	int pageSize = 5; // 첫표출때는 카테고리관계없이 뿌리기.

	int totalCount = 0; // 게시물의 총갯수. pageSize로 나누어서 페이지목록을 뿌리면된다.

	// pageSize가 없을때 0으로 설정. 
	String strPageSize = (request.getParameter("pageSize") == null || request.getParameter("pageSize") == "") ? "8": request.getParameter("pageSize");
	pageSize = Integer.parseInt(strPageSize);

	// pageNum이 없을때 1로 설정. (기본값)
	String strPageNum = (request.getParameter("pageNum") == null || request.getParameter("pageNum") == "")
			? "1": request.getParameter("pageNum");
	pageNum = Integer.parseInt(strPageNum);

	String search_div = (request.getParameter("search_div") == null) ? "NAME" : request.getParameter("search_div");
	String search_word = (request.getParameter("search_word") == null) ? ""	: request.getParameter("search_word");
	System.out.println("search_word:" + search_word);

	// 추천업체
	ArrayList<HashMap<String, String>> besgLists = dao.do_bestList();
	// 전체업체
	ArrayList<HashMap<String, String>> datas = dao.do_search(pageNum, pageSize, search_div, search_word);

	HashMap dataCnt = null;

    if(datas.size()== 0) dataCnt = new HashMap();
    else dataCnt = (HashMap)datas.get(0);
    
    if(datas.size()== 0){
    	totalCount = 0;
    }else{
    	totalCount = Integer.parseInt(dataCnt.get("TOT_CNT").toString());
    }
	

	int intPageCount = (totalCount / pageSize); // 나눈값
	if (totalCount % pageSize != 0)
		intPageCount++; // 만약 0이 아니면 페이지수 하나더늘려줘.
		
	Iterator iter = datas.iterator();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>inTable</title>
        <!-- Bootstrap -->
        <link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript">

/*
검색으로 이동
*/
$(function(){
	
})

function do_search(){
	
//console.log("do_search");
var frm = document.listForm;
	frm.submit();
}

/*
Enter Event처리
*/
function on_keydown(){		
	if(f.keyCode == 13){ 
		do_search();
	}
}

function do_goPage(pageNum)
{	
	var frm = document.listForm;
	frm.pageNum.value=pageNum;
	console.log("pageNum:"+pageNum);

	frm.submit();
	
}

</script>

</head>
<body>

<!--헤더 -->
<jsp:include page="../main/site_header.jsp"></jsp:include>

<div class="container" align="center">
<!--  -->
<br><br><br><br>
<form name="listForm" action="/" method="post">
<input type="hidden" name="pageNum" value="" />

<!-- 검색창 테이블 -->

 	<%
 		String keyword = "검색어를 입력하세요." ;
 	%>
<table cellpadding=5 cellspacing=0 border="0" >
 <tr>
 	<td>
    	<select name="search_div" id="search_keyword" class="form-control">
	   		<option value="">선택</option>
	   		<option value="CATEGORY"  <%if(search_div.equalsIgnoreCase("CATEGORY"))out.print("selected"); %> >카테고리</option>
	   		<option value="NAME" <%if(search_div.equalsIgnoreCase("NAME"))out.print("selected"); %> >이름</option>
	   		<option value="ADDRESS1" <%if(search_div.equalsIgnoreCase("ADDRESS1"))out.print("selected"); %> >주소</option>
	   	</select> 	
 	</td>
    <td align="right">
   		<input type="text" class="form-control" name="search_word" size="50" max="100" placeholder="<%=keyword %>" value="<%=search_word %>" >
    </td>
    <td>
    	<input type="button" onclick="Javascript:do_search()" class="btn btn-info" onkeypress="JavaScript:on_keydown(this.form)" size="40" value="검색"/>
    </td>
 </tr>
</table>

<%
	if(search_word == null || search_word==""){ //검색키워드가 없을경우엔 추천업체를 표시.
%>

<!-- 추천업체 -->
<div id ="bestList">
<br>
<h4 style="color: #0054FF; text-align: left;"><b><span class="glyphicon glyphicon-thumbs-up"></span> 추천업체[★점 높은순]</b></h4>

<table cellpadding="-5" class="table table-striped table-hover">
 <tr class="info">
<%
	if(besgLists.size()>0){
		Iterator biter = besgLists.iterator();
		while(biter.hasNext()) {
			
			HashMap data = (HashMap)biter.next();
%>
		<td align="center">
			<p><%= data.get("RNUM") %>위</p>
			<a href="../store/store_control.jsp?action=detail&store_id=<%=data.get("store_id")%>">
			<p><img src="<%= data.get("IMAGEURI1") %>" width="210" height="130"></p>		
			<h5 style="color: #030066; text-align: center;"><b><%= data.get("name") %></b></h5></a>
		</td>
	<%
			System.out.println("추천: " + data.get("store_id"));
			if(Integer.parseInt((String)data.get("RNUM")) % 4 == 0){
				biter.remove();
	%>
	  </tr>

    <%
			}
		}
	}

%>
</table>
</div>
<%
	}
%>

<!-- 아래 음식점 보여주기 -->

<div id="list">
<h4 style="color: #F15F5F; text-align: left;"><b><span class="glyphicon glyphicon-glass"></span>예약가능한 음식점들[가,나,다순]</b></h4>
<table cellpadding=5 cellspacing=0 width=500 class="table">
<tr>
<%
	// 빈즈에서 가져온 ArrayList 에서 HashMap 을 가져와 반복해서 출력함.
	if(datas.size()>0){
	while(iter.hasNext()) {
			// ArrayList 에서 HashMap 을 가져옴. Object 로 저장되어 있기 때문에 형변환 필요
			HashMap data = (HashMap)iter.next();

	if(data.get("store_id") != "999999999"){ // 매니저 표출 x
%>
		<td align="center">
			<%-- <p><%= data.get("ROWNUM") %></p> --%>
			<a href="../store/store_control.jsp?action=detail&store_id=<%=data.get("store_id")%>">
			<p><img src="<%= data.get("IMAGEURI1") %>" width="210" height="130"></p>		
			<h5 style="color: #030066; text-align: center;"><b><%= data.get("name") %></b></h5></a>
		</td>
		
		
	<%
		System.out.println("일반 : " + data.get("store_id"));
		if(Integer.parseInt((String)data.get("ROWNUM")) % 4 == 0){
		
	%>
	  </tr>
	  <tr>	

    <%
			}
		}
	}
	%>
    </tr>
<%
	}else{ // if		
%>
    <tr><td colspan="70" align="center">:::조회 데이터가 없습니다.:::</td></tr> 			
<%
	}//else
%>			
     
	</table>
</div>
	
	<!-- 페이징부분 -->
<%if(datas.size()>0){ %>	
	<table cellpadding=5 cellspacing=0 border="0">
      <tr >
        <td colspan="6" class="list_num">
        <ul class="pagination">
       <li> <a href="javascript:;" onclick="do_goPage(1)"> < </a></li>
<%
          String pageDiv ="&nbsp;&nbsp;";
          StringBuilder pageCont=new StringBuilder();
		  for(int i=1;i<=intPageCount;i++){
			  
// 			  	if(i == pageNum){
			  		
// 			  		pageCont.append("<b>"+i+"</b>");
// 					if(i==intPageCount)pageCont.append("");
// 					else pageCont.append(pageDiv);	
// 			  	}else{
			  		pageCont.append("<li><a href='javascript:;' "+" "+"onclick='do_goPage("+i+")'>"+i+"</a></li>");
			  		if(i==intPageCount)pageCont.append("");
					else pageCont.append(pageDiv);
// 			  	}
		  }
          out.println(pageCont.toString());

%>
           <li> <a href="javascript:;" onclick="do_goPage(<%=intPageCount %>)"> > </a></li>
        </td> 
      </tr> 	
	</table>
<% } %>	

	</form>
</div>
<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>	
</body>
</html>

