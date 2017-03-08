<%@page import="java.util.Iterator"%>
<%@page import="intable.sonnim.dao.SonnimDao"%>
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
<%
	request.setCharacterEncoding("UTF-8");
	
	//마지막 페이지 저장용
 	String nowUrl = request.getRequestURI() +"?"+ request.getQueryString();  	
	session.setAttribute("endUrl", nowUrl ); 

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>좋아요</title>
<style type="text/css">
/* 헤더로 가려지는 부분 여백 */
#page_header {
	margin-top: 50px;
}
#collapseOne {
	display: none;
}
/* 그림옆에 글씨 바로 안붙게 여백 */
.glyphicon { margin-right:10px; }

.panel-body { padding:0px; }
.panel-body table tr td { padding-left: 15px }
.panel-body .table {margin-bottom: 0px; }
</style>
        <!-- Bootstrap -->
        <link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
<!-- 		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>	 -->
</head>
<body>
<!--헤더 -->
<jsp:include page="../main/site_header.jsp"></jsp:include>
<!--헤더 -->


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    $(".panel-heading").click(function() {
      if($(this).next("div").is(":visible")){
        //$(this).next("div").slideUp("fast");
      } else {
        //$(".panel-heading").slideUp("fast");
        $(this).next("div").slideToggle("fast");
      }
    });
  });
</script>

<!-- main -->

<!-- page_header -->
<div id="page_header" class="page-header col-md-12" style="background-color: #FFD8D8">
	<div class="container">
	<br>
	<span> &nbsp;&nbsp;&nbsp;&nbsp; H O M E <span class="glyphicon glyphicon-chevron-right"></span> 마이페이지 
	<span class="glyphicon glyphicon-chevron-right"></span> 좋아요 한 음식점</span>
	</div>
</div>
		
<!-- 왼쪽메뉴 -->
<div class="container">
		<div class="container col-md-2">
            <div class="panel-group" id="accordion">

               <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a href="../sonnim/mypage_update.jsp"><span class="glyphicon glyphicon-user">
                            </span>정보수정</a>
                        </h4>
                    </div>
                </div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a href="../sonnim/mypage_heart.jsp"><span class="glyphicon glyphicon-heart">
							</span>좋아요 한 음식점</a>
						</h4>
					</div>
				</div>

				<div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"><span class="glyphicon glyphicon-folder-close">
                            </span>예약확인 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-chevron-down"></span></a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <table class="table">
                            	 <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-list text-primary"></span><a href="../sonnim/sonnim_mypage.jsp?">전체예약목록</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-pencil text-primary"></span><a href="../sonnim/sonnim_mypage.jsp?state=0">이용예정</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-flash text-success"></span><a href="../sonnim/sonnim_mypage.jsp?state=1">이용완료</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-file text-info"></span><a href="../sonnim/sonnim_mypage.jsp?state=2">예약취소</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                </div>
                </div>
<!-- 왼쪽메뉴 end-->



<!-- 내용 -->
<div class="col-md-1"></div>
<div class="container col-md-8">

<h2>좋아요 한 음식점 list</h2>
<%
	SonnimDao dao = new SonnimDao();	

	//세션값 받아오기
	String sonnim_id = ((HashMap<String, String>)session.getAttribute("login")).get("sonnim_id"); ;

	int page_num  = 1;
	int page_size = 4;
	int intTotalCount = 0;

/* 	String strPageSize = (request.getParameter("page_size")==null || request.getParameter("page_size")=="" )?"4":request.getParameter("page_size");
	page_size = Integer.parseInt(strPageSize); */
	
	String strPageNum = (request.getParameter("page_num")==null   || request.getParameter("page_num")=="")?"1":request.getParameter("page_num");
	page_num = Integer.parseInt(strPageNum);

	HashMap<String, String> data = new HashMap<>();
	// sonnim_id, pageNum
	data.put("sonnim_id"	, sonnim_id);
	data.put("pageNum"		, page_num+"");
	
	ArrayList<HashMap> heart_list = dao.do_selectHeartList(data);
	
	HashMap dataCnt  = null;
    
    if(heart_list.size()== 0) dataCnt = new HashMap();
    else dataCnt = (HashMap)heart_list.get(0);
   
    
    
    if(heart_list.size()== 0){
    	intTotalCount = 0;
    }else{
    	intTotalCount = Integer.parseInt(dataCnt.get("totCnt").toString());
    	//System.out.println("intTotalCount"+intTotalCount);
    }
    
    int intPageCount  = (intTotalCount/page_size);
    if(intTotalCount%page_size != 0) intPageCount++;
    
    int intRowCount = 0;  	
	
	Iterator iter = heart_list.iterator();
	if(heart_list.size()>0){
		while(iter.hasNext()) {
		// ArrayList 에서 HashMap 을 가져옴. Object 로 저장되어 있기 때문에 형변환 필요
		HashMap heart = (HashMap)iter.next();
			//System.out.println(heart.get("starpoint")+"\t"+heart.get("storeName"));
	%>
	
	<!-- 내용 뿌려주는 곳 -->
	
	<table class="table" width="400">
	<col width="100"><col width="200"><col width="300">
	<tr style="vertical-align:middle"><td rowspan="2" style="va">No : <%=heart.get("RNUM") %></td>
	<td rowspan="2"><img src='<%=heart.get("storeImage") %>' width="150" height="100"></td>
	<td>음식점명 : <%=heart.get("storeName") %></td></tr>
	<tr><td>
	
	<%
	if(heart.get("starpoint").equals("0")){
		%>
		별점 : <span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span> (0)
		<%
	}else if(heart.get("starpoint").equals("1")){
		%>
		별점 : <span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span> (1)
		<%
	}else if(heart.get("starpoint").equals("2")){
		%>
		별점 : <span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span> (2)
		<%
	}else if(heart.get("starpoint").equals("3")){
		%>
		별점 : <span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star-empty"></span><span class="glyphicon glyphicon-star-empty"></span> (3)
		<%
	}else if(heart.get("starpoint").equals("4")){
		%>
		별점 : <span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star-empty"></span> (4)
		<%
	}else if(heart.get("starpoint").equals("5")){
		%>
		별점 : <span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span><span class="glyphicon glyphicon-star"></span> (5)
		<%
	}
	%>
	
	
	
	
	
	
	
	
	</td></tr>
	</table>
	
	
	
	
<%
		} // end while
	}else{ // if		
%>
  <br><br><br><br><br><br><br><br>
  <h2 style="color: red">:::조회 데이터가 없습니다.:::</h2>
  <br><br><br><br><br><br><br> 			
<%
	}//else
%>			

<!-- 페이지 갯수 -->
<%if(heart_list.size()>0){ %>	
	<table cellpadding=5 cellspacing=0 border="0" width=640>
      <tr>
        <td colspan="6" height="40" align="center">
        <ul class="pagination pagination-sm">
        <li> <a href="javascript:;" onclick="do_goPage(1)"> < </a></li>
<%
          String pageDiv ="&nbsp;&nbsp;";
          StringBuilder pageCont=new StringBuilder();
		  for(int i=1;i<=intPageCount;i++){
			  
		  
//  			  	if(i == page_num){			  		
// 			  		pageCont.append("<li>"+i+"</li>");
// 					if(i==intPageCount)pageCont.append("");
// 					else pageCont.append(pageDiv);	
// 			  	}else{
			  		pageCont.append("<li><a href='javascript:;'+ "+" "+"onclick='do_goPage("+i+")'>"+i+"</a></li>");
			  		if(i==intPageCount)pageCont.append("");
					else pageCont.append(pageDiv);
// 			  	 } 
		  }
          out.println(pageCont.toString());

%>
            <li><a href="javascript:;" onclick="do_goPage(<%=intPageCount %>)"> > </a></li>
            </ul>
        </td> 
      </tr> 	
	</table>
<% } %>	


<!-- <ul class="pagination pagination-sm">
  <li class="disabled"><a href="#">&laquo;</a></li>
  <li class="active"><a href="#">1</a></li>
  <li><a href="#">2</a></li>
  <li><a href="#">3</a></li>
  <li><a href="#">4</a></li>
  <li><a href="#">5</a></li>
  <li><a href="#">&raquo;</a></li>
</ul> -->





<form name="searchForm" method="post">
<input type="hidden" name="page_num" value="" />
</form>
<script type="text/javascript">
	function do_goPage(page_num)
	{		
		var frm = document.searchForm;
		
		frm.page_num.value=page_num;
		console.log("page_num:"+page_num);
		frm.submit();
	}	
</script>



</div>
</div>
		
		<br><br>	
<!--main end  -->

<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>	
<!--푸터  -->
</body>
</html>