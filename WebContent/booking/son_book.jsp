<%@page import="intable.book.dao.BookDao"%>
<%@page import="intable.store.dao.StoreDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
	String store_id="";
	String storeName="";
	String storeImgUri = "";
	String note = "";
	String storephone = "";
	int open = 0;
	int close = 0;
	int maxbooking = 0;
	
	                    ;
	//손님 정보             
	String sonnim_id = "";
	String sonnimName = "";
	String email = "";
	String phone = "";
	
	HashMap<String, String> login = null;
	login = (HashMap<String, String>)session.getAttribute("login");	//sonnim
	HashMap<String, String> storeIdMap = new HashMap<>();
	storeIdMap.put("store_id", request.getParameter("store_id"));
	
	StoreDao dao = new StoreDao();
	HashMap<String, String> storemap = dao.do_detail(storeIdMap);		//store

	//로그아웃 상태이면 예약 창을 볼수없음
	if(login!=null){
		//스토어 정보
		store_id		= storemap.get("store_id");
		storeName       = storemap.get("name");
		storeImgUri     = storemap.get("imageuri1");
		
		open            = Integer.parseInt(storemap.get("open"));
		close           = Integer.parseInt(storemap.get("closed"));
		maxbooking      = Integer.parseInt(storemap.get("maxbooking"));
		note			= storemap.get("note")==null?"":storemap.get("note");
		storephone		= storemap.get("phone")==null?"":storemap.get("phone");
		
		//손님 정보
		sonnim_id	 = login.get("sonnim_id");
		sonnimName   = login.get("name");
		email        = login.get("email");
		phone        = login.get("phone");
		
		if(login.get("issonnim").equals("false")){
			String endUrl = request.getSession().getAttribute("endUrl").toString();
			System.out.println(request.getRequestURI()+" "+endUrl);
			
			StringBuilder script = new StringBuilder();
		    
		    script.append("<script>");
		    script.append("window.alert('You can not reservation! please login another account..');");
		    script.append("location.href = '/';");
		    script.append("</script>");
		     
		    out.write(script.toString());
		}
	}else if(login == null){
		String endUrl = request.getSession().getAttribute("endUrl").toString();
		System.out.println(request.getRequestURI()+" "+endUrl);
		
	 	StringBuilder script = new StringBuilder();
         
        script.append("<script>");
        script.append("window.alert('try again after login!');");
        script.append("location.href = '../main/login.jsp';");
        script.append("</script>");
         
        out.write(script.toString());
	
	}

%>

<html>
<head>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.1.1.min.js">
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약하기</title>

<%
	BookDao bookDao = new BookDao();
	String todayStr = bookDao.do_gettoday();
    String[] split = todayStr.split("-");
	Calendar cal = Calendar.getInstance();
	String yearStr = request.getParameter("year");
	String monthStr = request.getParameter("month");
	int today = cal.get(Calendar.DATE);
	int year = yearStr==null?Integer.parseInt(split[0]):Integer.parseInt(yearStr)<1?1:Integer.parseInt(yearStr);
	int month = monthStr==null?Integer.parseInt(split[1]):Integer.parseInt(monthStr);
	
    int thisYear = Integer.parseInt(split[0]);
    int thisMonth = Integer.parseInt(split[1]);
    System.out.println(thisYear + "년 " + thisMonth + "월");
        		
    if(monthStr!=null&&Integer.parseInt(monthStr)<1){
    	year=year-1;
    	month=12;
    }else if(monthStr!=null&&Integer.parseInt(monthStr)>12){
    	year=year+1;
    	month=1;
    }
        		
	cal.set(Calendar.DATE, 1);
	cal.set(Calendar.MONTH, (month)-1);
	cal.set(Calendar.YEAR, (year));
	
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
%>

<script type="text/javascript">

$(function(){
	
	$("td[name=seldate]").click(function(){
		var today=$("input[name=today]").val();
		var arrtoday = today.split('-');
		
		var selectdate = this.id;
		var arrselect = selectdate.split('-');
		
		var compto = new Date(arrtoday[0], arrtoday[1], arrtoday[2]);
		var compsel = new Date(arrselect[0], arrselect[1], arrselect[2]);
		
		if(compsel.getTime() < compto.getTime()){
			alert("오 매애앤! 타임머신 타고 가도 거기엔 예약 안돼있어 맨! 빼애앰!~ 과거는 잊어 맴!~");
		}else{
			$("input[name=bookdate]").val(this.id);
		}
	});
	
	$("button[name=complete]").click(function(){
		$("form").submit();
	});
	
	$("button[name=cancle]").click(function(){
		alert("cancle");
		history.go(-1);
	});
	
});
</script>

</head>
<body>
<!--헤더 -->
<jsp:include page="../main/site_header.jsp"></jsp:include>
<br><br>
<div id="container" class="container">
	<div id="page_header" class="page-header col-md-12">
		<h5>HOME<span class="glyphicon glyphicon-chevron-right"></span><%=storemap.get("sido") %><span class="glyphicon glyphicon-chevron-right"></span><%=storemap.get("sigungu") %><span class="glyphicon glyphicon-chevron-right"></span><%=storemap.get("name") %></h5>
	</div>
	
	<div id="contents_article" class="container row" align="center">
	<div class="col-md-1"></div>
		<div class="col-md-5">
			<div class="full">
				<img width="100%" heght="50" alt="yet" src="<%=storeImgUri %>">
			</div>
			<div class="full">
			<b align="left" ><pre>
	음식점 이름 : <%=storeName %>
	전화번호  :  <%=storephone %>
	영업시간 : <%=open %>시 ~ <%=close %>시
	※영업시간에 준수하여 가주세요!!
	※비매너 손님은 우리 사이트에서 사절!!!
			</pre></b>
			
			<pre>
---------소개글---------
<%=note %>
			</pre>
			</div>
			
		</div>
	
		<div class="col-md-5">
			<form class="form-horizontal" action="booking_control.jsp" method="post">
				<input type="hidden" name="action" value="insert">
				<input type="hidden" name="store_id" value="<%=store_id%>">
				<div class="full-left">
					<table class="table table-bordered" style="text-align: center;">
					<col width="100"/><col width="100"/><col width="100"/>
					<col width="100"/><col width="100"/><col width="100"/>
					<col width="100"/>
					
						<tr height="100" >
							<td colspan="7" align="center" style='vertical-align:middle'>
							<h3 style="color:#003399">
								<%if(year>thisYear) {%>
									<%if(month<thisMonth&&year-1<=thisYear){ %>
										<a href="?year=<%=year%>&month=<%=month-1%>&store_id=<%=store_id%>" style="color:#4374D9" data-toggle='tooltip' >◀</a>
									<%}else{ %>
										<a href="?year=<%=year-1%>&month=<%=month%>&store_id=<%=store_id%>" style="color:#4374D9" data-toggle='tooltip'><span class="glyphicon glyphicon-backward"></span></a>
										<a href="?year=<%=year%>&month=<%=month-1%>&store_id=<%=store_id%>" style="color:#4374D9" data-toggle='tooltip'>◀</a>
									<%} %>
								<%}else if(year==thisYear&&month>thisMonth){ %>
									<a href="?year=<%=year%>&month=<%=month-1%>&store_id=<%=store_id%>" style="color:#4374D9" data-toggle='tooltip'>◀</a>
								<%} %>
								<%=year %>년	<%=month %>월
								<a href="?year=<%=year%>&month=<%=month+1%>&store_id=<%=store_id%>" style="color:#4374D9" data-toggle='tooltip' data-placement='top' title='다음달'>▶</a>
								
								<a href="?year=<%=year+1%>&month=<%=month%>&store_id=<%=store_id%>" style="color:#4374D9" data-toggle='tooltip'><span class="glyphicon glyphicon-forward"></span></a> 
							</h3>
							</td>
						</tr>
					
						<tr class="info">
							<td><b>일</b></td><td><b>월</b></td><td><b>화</b></td><td><b>수</b></td><td><b>목</b></td><td><b>금</b></td><td><b>토</b></td>
						</tr>
					
						<tr height="50" align="left" valign="top">
						<%for(int i = 1; i < dayOfWeek; i++){ %>
							<td>&nbsp;</td>
						<%
						}	
						int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
						
						for(int i = 1;i <= lastDay; i++){
						%>
							<td style="cursor:pointer;" id="<%=year %>-<%=month %>-<%=i %>" style='vertical-align:middle' align="center" name="seldate">
								<span ><%=i %></span>
							</td>
						<%
							if((i + dayOfWeek - 1)%7==0){
						%>
							</tr><tr height="50" align="left" valign="top">
						<%}} 
						for(int i=0; i < (7-(dayOfWeek+lastDay-1)%7)%7; i++){
						%>
							<td>&nbsp;</td>
						<%} %>
						</tr>
					</table>
					<div class="right">
						<div class="form-group">
							<label class="col-lg-3 control-label">예약날짜 : </label>
							<div class="col-lg-9">
								<input type="hidden" value="<%=todayStr %>" name="today">
								<input class ="form-control" type="text" name="bookdate" value="<%=todayStr %>" readonly="readonly">
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-lg-3 control-label">시간   :</label>
							<div class="col-lg-9">
								<select class="form-control" name="booktime">
									<%if(open<=close){
											for(int i = open; i < close; i++){ %>
												<option value="<%=i%>" selected="selected"><%=i %>:00</option>
									<%}}else{
											for(int i = open; i < 24; i++){%>
												<option value="<%=i%>" selected="selected"><%=i %>:00</option>
											<%}for(int i = 0; i <close; i++){%>
												<option value="<%=i%>" selected="selected"><%=i %>:00</option>
									<%}} %>									
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-lg-3 control-label">인원   :</label>
							<div class="col-lg-9">
								<select class="form-control" name="bookperson">
									<% for(int i = 1; i < maxbooking && i<6; i++){ %>
											<option value="<%=i%>" selected="selected"><%=i %>명</option>
									<% } %>
								</select>
								<p><b>단체예약문의는 전화 때려주세요!</b></p>
							</div>
						</div>
						
						<hr style="border-color: #4374D9"><br>
						
						<div class="form-group">
							<label class="col-lg-3 control-label">예약자</label>
							<div class="col-lg-9">
								<input class ="form-control" type="text" name="sonnimName" value="<%=sonnimName %>" readonly="readonly">
							</div>
						</div>
						
						
						<div class="form-group">
							<label class="col-lg-3 control-label">연락처</label>
						<div class="col-lg-9">
								<input class ="form-control" type="text" name="sonnimPhone" value="<%=phone %>" readonly="readonly">
							</div>
						</div>
						
						
						<div class="form-group">
							<label class="col-lg-3 control-label">이메일</label>
						<div class="col-lg-9">
								<input class ="form-control" type="text" name="sonnimEmail" value="<%=email %>" readonly="readonly">
							</div>
						</div>
						
						<div class="form-group">
						<label class="col-lg-3 control-label">요구사항</label>
						<div class="col-lg-9">
						<textarea class ="form-control" rows="7" cols="10" name="note" style="resize:none;"></textarea>
						</div>
						</div>
						
						<div class="form-group">
							<button class="btn btn-info" name="complete">&nbsp;&nbsp;완료&nbsp;&nbsp;</button>				
							<button class="btn btn-info" name="cancle">&nbsp;&nbsp;취소&nbsp;&nbsp;</button>
						</div>
					</div>
				</div>
			</form>
		</div>
		
		<div class="col-md-1"></div>
	</div>

</div>
<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>	
</body>
</html>