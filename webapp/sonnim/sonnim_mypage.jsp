<%@page import="java.text.DecimalFormat"%>
<%@page import="intable.book.dao.BookDao"%>
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
<%!//
//테이블 그린다!!
public String tableDisplay(int pageNum, int pageSize, String search_div, String search_word, String state, ArrayList<HashMap<String, String>> list){
	if(list != null){
		int total_count = Integer.parseInt(list.get(0).get("count"));
		int rowCount = ((int)(Math.sqrt(pageSize)));
		
		String s = "<br><br><div>";
		/* String s = "<div><table class='col-md-10'>"; */
		
		for(int i = 0; i < list.size(); i=i + rowCount){
			for(int j = 0; ((j < rowCount)&&((i+j) < list.size())); j++){
				String eachstate = list.get(i+j).get("bookstate").trim();
				
				s += "<tr>";
				
				s += "<table class='table' width='400'>";
				s += "<col width='200'><col width='100'><col width='400'>";
				
				s += "<tr><td align='center' style='vertical-align:middle' rowspan='8'>";
				s += "<img src='" + list.get(i+j).get("image") + "' width='190' height='170'>";
				s += "</td></tr>";
				s += "<tr><th>NO</th><td>" + list.get(i+j).get("no") + "</td><tr>";
				s += "<tr><th>음식점</th>";
				s += "<td><a href='/store/store_control.jsp?action=detail&store_id=" + list.get(i+j).get("store_id") + "'>" + list.get(i+j).get("name") + "</a></td></tr>";
				s += "<tr><th>예약날짜</th>";
				s += "<td>" + list.get(i+j).get("bookdate") + " " + list.get(i+j).get("booktime") + "시" + "</td></tr>";
				s += "<tr><th>예약 인원</th>";
				s += "<td>" + list.get(i+j).get("bookperson") + "</td></tr>";
				s += "<tr><th>요청사항</th>";
				s += "<td>" + list.get(i+j).get("note") + "</td></tr>";
				s += "<tr><td align='center' colspan='2'>";
				if(eachstate.equals("0")){
					s += "<button class='btn btn-info btn-sm btn-block' name='bookcancle' id='" + list.get(i+j).get("no") + "'><b>예약취소하기</b></button></td></tr>";
				}else if(eachstate.equals("1")){
					s += "<a class='btn btn-primary btn-sm btn-block' href='../store/store_control.jsp?action=detail&store_id=" + list.get(i+j).get("store_id") + "'><b>리뷰작성하기</b></a></td></tr>";
				}else if(eachstate.equals("2")){
					s += "<a class='btn btn-warning btn-sm btn-block' href='../booking/son_book.jsp?store_id=" + list.get(i+j).get("store_id") + "'><b>다시예약하기</b></a></td></tr>";
				}
				
				s += "</table>";
				
				/* s += "</tr>"; */
			}
		}
		
		/* s += "</table></div><br><br><br><div align='center'>"; */
		s += "</div><br><div align='center'>";
		
		s += "<ol class='pagination pagination-sm'>";
		int page_count = (total_count%pageSize)!=0?(total_count/pageSize)+1:(total_count/pageSize);
		System.out.println("page_count = " + page_count);
		if(pageNum>10){
			s += "<li><a href='?pageNum=" + (pageNum - 10) + "&search_div=" + search_div + "&search_word=" + search_word + "&state=" + state + "'><<</a></li>";
			s += "<li><a href='?pageNum=" + (pageNum - 5) + "&search_div=" + search_div + "&search_word=" + search_word + "&state=" + state + "'><</a></li>";
		}else if(pageNum > 5){
			s += "<li><a href='?pageNum=" + (pageNum - 5) + "&search_div=" + search_div + "&search_word=" + search_word + "&state=" + state + "'><</a></li>";
		}
		
		for(int i = pageNum-5; ((i <= page_count)&&(i<=pageNum+5)); i++){
			if(i<1) continue;
			if(i == pageNum){
				s += "<li><a href='?pageNum=" + i + "&search_div=" + search_div + "&search_word=" + search_word + "&state=" + state + "'><b style='color:red;'>" + i + "</b></a></li>";
			}else{
				s += "<li><a href='?pageNum=" + i + "&search_div=" + search_div + "&search_word=" + search_word + "&state=" + state + "'>" + i + "</a></li>";
			}
		}
		
		if(pageNum < page_count-10){
			s += "<li><a href='?pageNum=" + (pageNum + 5) + "&search_div=" + search_div + "&search_word=" + search_word + "&state=" + state + "'>></a></li>";
			s += "<li><a href='?pageNum=" + (pageNum + 10) + "&search_div=" + search_div + "&search_word=" + search_word + "&state=" + state + "'>>></a></li>";
		}else if(pageNum < page_count-5){
			s += "<li><a href='?pageNum=" + (pageNum + 10) + "&search_div=" + search_div + "&search_word=" + search_word + "&state=" + state + "'>>></a></li>";
		}
		
		s += "</ol></div>";
		
		return s;
	}else{
		return "<br><br><br><br><br><br><br><br><h2 style='color: red'>:::조회 데이터가 없습니다.:::</h2><br><br><br><br><br><br><br> ";
	}
	
}
//%>
<%
	DecimalFormat comma = new DecimalFormat("#,###");
	String strPageSize = (request.getParameter("pageSize")==null || request.getParameter("pageSize")=="" )?"4":request.getParameter("pageSize");
	int pageSize = Integer.parseInt(strPageSize);
	
	String strPageNum = (request.getParameter("pageNum")==null || request.getParameter("pageNum")=="")?"1":request.getParameter("pageNum");
	int pageNum = Integer.parseInt(strPageNum);
	
	String search_div   = (request.getParameter("search_div")==null)?"":request.getParameter("search_div");
	String search_word  = (request.getParameter("search_word")==null)?"":request.getParameter("search_word");

	String state = (request.getParameter("state")==null)?"":request.getParameter("state");
	String stateString = "<h3>";
	
	if(state.equals("")){
		stateString += "<i class='fa fa-ticket' aria-hidden='true'></i><전체 예약 목록></h3>";
	}else if(state.equals("0")){
		stateString += "<예약 완료 목록></h3>";
	}else if(state.equals("1")){
		stateString += "<이용 완료 목록></h3>";
	}else if(state.equals("2")){
		stateString += "<취소 건수 목록></h3>";
	}
	
	HashMap<String, String> login = (HashMap<String, String>)request.getSession().getAttribute("login");
	
	ArrayList<HashMap<String, String>> list = null;
	
	BookDao dao = new BookDao();
	
	ArrayList<Integer> count = dao.do_getStateCount(login);
	
	
	//로그인상태가 아니면 여기를 올 수 없습니다
	if(login != null){
		if(login.get("issonnim").equals("false")){
			String endUrl = request.getSession().getAttribute("endUrl").toString();
			System.out.println(request.getRequestURI()+" "+endUrl);
			
			StringBuilder script = new StringBuilder();
		    
		    script.append("<script>");
		    script.append("window.alert('You can not reservation! please login another account..');");
		    script.append("location.href = '/';");
		    script.append("</script>");
		     
		    out.write(script.toString());
		}else if(state == ""&&search_word == ""){
			list = dao.do_getList(pageNum, pageSize, login.get("sonnim_id"));
		}else if(state!=""&&search_word == ""){
			list = dao.do_getList(pageNum, pageSize, login.get("sonnim_id"), state);
		}else if(state==""&&search_word != ""){
			list = dao.do_search(pageNum, pageSize, search_div.trim(), search_word.trim(), login.get("sonnim_id"));
		}else{
			list = dao.do_search(pageNum, pageSize, search_div, search_word, login.get("sonnim_id"), state);
		}
		
	}else if(login == null){
		String endUrl = request.getSession().getAttribute("endUrl").toString();
		
		response.sendRedirect(endUrl);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약확인</title>
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
   
	$("td[name=all]").click(function(){
		location.href="../sonnim/sonnim_mypage.jsp";
	});
	
	$("td[name=0]").click(function(){
		location.href="../sonnim/sonnim_mypage.jsp?state=0";
	});
	
	$("td[name=1]").click(function(){
		location.href="../sonnim/sonnim_mypage.jsp?state=1";
	});
	
	$("td[name=2]").click(function(){
		location.href="../sonnim/sonnim_mypage.jsp?state=2";
	});
	
	$("button[name=bookcancle]").click(function(){
		var frm = document.frmupdate;
		frm.no.value = this.id;
		
		if(confirm("진심 레알??? 여기 진심 맛있는데????진짜로???? 후회각인데??????")){
			frm.submit();
		}else{
			alert("그럴줄 알았어 실수지 께헤헷ㅋㅋ 이집 맛있어 잡솨봐");
		}
	});
  });
</script>

<!-- main -->
<!-- page_header -->
<div id="page_header" class="page-header col-md-12" style="background-color: #FFD8D8">
	<div class="container">
	<br>
	<span> &nbsp;&nbsp;&nbsp;&nbsp; H O M E <span class="glyphicon glyphicon-chevron-right"></span> 마이페이지<span class="glyphicon glyphicon-chevron-right"></span> 예약확인 </span>
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
                                        <span class="glyphicon glyphicon-list text-primary"></span><a href="../sonnim/sonnim_mypage.jsp">전체예약목록</a>
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

<!-- 오른쪽 위내용 -->
<div class="container col-md-10">
	<div class="col-md-4">
		<%=stateString %>
	</div>
	
	<div class="col-md-7">
		<table class="table table-striped table-bordered" style="text-align: center;">
			<tr class="info" align="center"><td style="cursor:pointer;" name="all">전체예약</td> <td style="cursor:pointer;" name="0">예약완료</td> <td style="cursor:pointer;" name="1">이용완료</td> <td style="cursor:pointer;" name="2">취소건수</td></tr>
			<tr><td style="cursor:pointer;" name="all" id="all"><%=comma.format(count.get(0))%></td>
				<td style="cursor:pointer;" name="0" id="st0"><%=comma.format(count.get(1)) %></td> 
				<td style="cursor:pointer;" name="1" id="st1"><%=comma.format(count.get(2)) %></td> 
				<td style="cursor:pointer;" name="2" id="st2"><%=comma.format(count.get(3)) %></td></tr>
		</table>
			</div>
</div>

<div class="col-md-8">
	<form action="?" class="col-md-12" method="post">
		<input type="hidden" name="state" value="<%=state%>">
		<input type="hidden" name="pageSize" value="4">
		<input type="hidden" name="pageNum" value="1">
		<table><tr>
			<td class="col-lg-3">
				<select class="form-control" name="search_div">
					<option value="NAME">상호명</option>
					<%if(search_div.equals("CATEGORY")){ %>
						<option value="CATEGORY" selected="selected">종류</option>
					<%}else{ %>
						<option value="CATEGORY">종류</option>
					<%} %>
				</select>
			</td>
			<td class="col-lg-8">
				<input type="text" class="form-control" name="search_word" value="<%=search_word%>" placeholder="검색어를 입력해주세요">
			</td>
			<td class="col-lg-2">
				<input type="submit" class="btn btn-info" value="검색">
			</td>
		</tr></table>
	</form>
</div>		
		
<!--예약 내역 뿌려주기  -->
<div class="col-md-1"></div>
<div class="container col-md-8">
	<%=	tableDisplay(pageNum, pageSize,search_div, search_word, state, list)%>
</div>
	
</div>
<!--main end  -->
<form name="frmupdate" action="../booking/booking_control.jsp" method="post">
<input type="hidden" name="action" value="update">
<input type="hidden" name="pageSize" value="<%=pageSize%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="search_div" value="<%=search_div%>">
<input type="hidden" name="search_word" value="<%=search_word%>">
<inpput type="hidden" name="state" value="<%=state %>">
<input type="hidden" name="no">
</form>

<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>	
<!--푸터  -->
</body>
</html>