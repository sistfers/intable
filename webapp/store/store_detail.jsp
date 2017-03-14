<%@page import="intable.sonnim.dao.HeartDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="intable.board.dao.ReviewDao"%>
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

	//마지막 페이지 저장용
	String nowUrl = "../store/store_control.jsp?action=detail&store_id=" + request.getAttribute("store_id");
	session.setAttribute("endUrl", nowUrl);
%>

<%
	HashMap<String, String> sonnimMap = (HashMap<String, String>) request.getSession().getAttribute("login");

	String sonnim_id = "";
	String store_id = "";

	if (sonnimMap != null) {

		sonnim_id = sonnimMap.get("sonnim_id");
	}

	HashMap<String, String> map = (HashMap) request.getAttribute("detailMap");

	if (map != null) {
		store_id = map.get("store_id");
	}

	// Review 부분
	ReviewDao dao = new ReviewDao();

	String starAvg = dao.do_starAvg(store_id);
	
	if(starAvg==""){
		starAvg="0";
	}

	int pageNum = 1; // 1페이지
	int pageSize = 5; // 첫표출때는 카테고리관계없이 뿌리기.

	int totalCount = 0; // 게시물의 총갯수. pageSize로 나누어서 페이지목록을 뿌리면된다.

	// pageSize가 없을때 0으로 설정. 
	String strPageSize = (request.getParameter("pageSize") == null || request.getParameter("pageSize") == "")
			? "5"
			: request.getParameter("pageSize");
	pageSize = Integer.parseInt(strPageSize);

	// pageNum이 없을때 1로 설정. (기본값)
	String strPageNum = (request.getParameter("pageNum") == null || request.getParameter("pageNum") == "")
			? "1"
			: request.getParameter("pageNum");
	pageNum = Integer.parseInt(strPageNum);

	ArrayList<HashMap<String, String>> starList = dao.do_starList(pageNum, pageSize, map.get("store_id"));
	System.out.println(map.get("store_id"));

	System.out.println("지금니가 널인거니? " + starList);

	HashMap dataCnt = null;

	if (starList.size() == 0)
		dataCnt = new HashMap();
	else
		dataCnt = (HashMap) starList.get(0);
	System.out.println("1");

	if (starList.size() == 0) {
		totalCount = 0;
		System.out.println("2-1");
	} else {
		totalCount = Integer.parseInt(dataCnt.get("TOT_CNT").toString());
		System.out.println("totalCount" + totalCount);
		System.out.println("2-2");
	}
	System.out.println("3");

	int intPageCount = (totalCount / pageSize); // 나눈값
	if (totalCount % pageSize != 0)
		intPageCount++; // 만약 0이 아니면 페이지수 하나더늘려줘.

	// heart부분

	HeartDao hDao = new HeartDao();

	int heartCount = hDao.do_heartCount(store_id);

	System.out.println("sonnim_id : " + sonnim_id);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=map.get("name")%> 상세설명</title>
<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=418a4218062520f8e24d7d6c945c37b6"></script>
<style type="text/css">
/* 헤더로 가려지는 부분 여백 */
#page_header {
	margin-top: 50px;
}

#collapseOne {
	display: none;
}
/* 그림옆에 글씨 바로 안붙게 여백 */
.glyphicon {
	margin-right: 10px;
}

.panel-body {
	padding: 0px;
}

.panel-body table tr td {
	padding-left: 15px
}

.panel-body .table {
	margin-bottom: 0px;
}
</style>
<!-- Bootstrap -->
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css" />
<!-- 		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>	 -->

</head>
<body>
	<!--헤더 -->
	<jsp:include page="../main/site_header.jsp"></jsp:include>
	<div class="container">
	
		<!-- 페이지헤더 -->
		<br>
		<div id="page_header" class="page-header col-md-12">
			<h5>
				HOME<span class="glyphicon glyphicon-chevron-right"></span><%=map.get("category")%>
				<span class="glyphicon glyphicon-chevron-right"></span><%=map.get("name")%>
				<span class="glyphicon glyphicon-chevron-right"></span>음식점 소개
			</h5>
		</div>
		<br>
		<br>
		<br>
		<br>
		<br>
<div class="col-md-1"></div>
<div class="col-md-10">
		<table class="table">
			<%-- 		<tr><td>store_id</td> <td><%= map.get("store_id") %>	</td>  </tr> --%>
			<tr>
				<td class="col-md-9">
					<h3><b><%=map.get("name")%></b></h3>
					<h4 style="color: #FFCC00; display: inline;">
					
					<%
						if(starAvg==""){
							starAvg="0";
						}
					
						double avg = Double.parseDouble(starAvg);
					%>
						<%if(Math.floor(avg) == 0){ %>☆☆☆☆☆
						<%}else if(Math.floor(avg) == 1){ %>★☆☆☆☆
						<%}else if(Math.floor(avg) == 2){ %>★★☆☆☆
						<%}else if(Math.floor(avg) == 3){ %>★★★☆☆
						<%}else if(Math.floor(avg) == 4){ %>★★★★☆
						<%}else if(Math.floor(avg) == 5){ %>★★★★★
						<%} %>
					</h4><b><%=Double.parseDouble(starAvg) %></b>/5.0
				</td>
				<td class="col-md-1" style="vertical-align: middle;">
					<form action="../booking/son_book.jsp">
						<input type="hidden" name="store_id" value="<%=map.get("store_id")%>" />
						<button type="submit" class="btn btn-info">예약하기</button>
					</form>
				</td>
				<td class="col-md-2">
					<div id="heart" align="center">
						<input type="hidden" id="storeId" name="store_id" value="<%=store_id%>">
						<%-- <input type="hidden" id="sonnimId" name="sonnim_id" value="<%=sonnim_id %>"> --%>
						<%
							HashMap<String, String> heartMap = new HashMap<>();

							heartMap.put("sonnim_Id", sonnim_id);
							heartMap.put("store_id", store_id);

							boolean heartCheck = hDao.do_heartCheck(sonnim_id, store_id);

							if (heartCheck == true) {
								System.out.println("하트를 칠해줘요");
						%>
						<img src="../img/fullHeart.png" style="cursor: pointer;" id="heartImg"> 
						<input type="hidden" id="heartStatus" value="heartDelete">
						<%
							} else {
								System.out.println("하트를 칠하지마세요");
						%>
						<img src="../img/emptyHeart.png" style="cursor: pointer;" id="heartImg"> 
						<input type="hidden" id="heartStatus" value="heartInsert">
						<%
							}
						%>
						<p id="count"> 좋아요 수 :<%=heartCount%></p>
					</div>

				</td>
			</tr>
			<tr>
				<td colspan="3" align="center">
				<img src="<%=map.get("imageuri1")%>" width="900" height="500" name="bigimg">
										
				<button style="filter:alpha(opacity=1);position:absolute;top:360px;left:30px;z-index:100" name="backward" class="btn btn-sm"><span style="filter:alpha(opacity=1);font-size: 40px;" class="glyphicon glyphicon-chevron-left"></span></button>
				
				<button style="filter:alpha(opacity=1);position:absolute;top:360px;right:23px;z-index:100" name="forward" class="btn btn-sm"><span style="filter:alpha(opacity=1);font-size: 40px;" class="glyphicon glyphicon-chevron-right"></span></button>
				</td>
			</tr>
			<tr>	
				<td colspan="3" align="center">
<!-- 					<p align="center">※사진을 누르면 위에 크게 확대되어 보입니다</p> -->
					<img src="<%=map.get("imageuri1")%>" width="170" height="180" name="smallimg" id="1">
					<img src="<%=map.get("imageuri2")%>" width="170" height="180" name="smallimg" id="2">
					<img src="<%=map.get("imageuri3")%>" width="170" height="180" name="smallimg" id="3"> 
					<img src="<%=map.get("imageuri4")%>" width="170" height="180" name="smallimg" id="4"> 
					<img src="<%=map.get("imageuri5")%>" width="170" height="180" name="smallimg" id="5">
					<p name="ppp" align="center">※사진을 누르면 위에 크게 확대되어 보입니다</p>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="col-md-1">주소 </div>
					<div class="col-md-5"> <%=map.get("sido")%>&nbsp;<%=map.get("sigungu")%>&nbsp;<%=map.get("address1")%>&nbsp;<%=map.get("address2")%> 우편번호(<%=map.get("zonecode")%>)</div>
				</td>
			</tr>
			<tr>
				<td colspan="3"><%=map.get("note")%> <br>
					<br> 영업시간 : <%=map.get("open")%>시 
					<br> 영업종료시간 : <%=map.get("closed")%>시
					<br> 수용가능한 최대인원 : <%=map.get("maxbooking")%>명 <br><br>
					<br> 연락처 : <%=map.get("phone")%>
				</td>
			</tr>
		</table>
		<hr style="border-color: #D5D5D5">
		<br>
		<br>

		<div align="center" id="star">
			<form id="starWrite" action="review_control.jsp" method="post">
				<table>
						<col width="150">
						<col width="600">
						<col width="130">
					<tr>
						<td><input type="hidden" name="action" value="insert">
							<input type="hidden" name="store_id" value="<%=store_id%>">
							<input type="hidden" name="sonnim_id" value="<%=sonnim_id%>">
							<select name="starPoint" id="starPoint" class="form-control">
								<option value="5">★★★★★</option>
								<option value="4">★★★★☆</option>
								<option value="3">★★★☆☆</option>
								<option value="2">★★☆☆☆</option>
								<option value="1">★☆☆☆☆</option>
							</select>
						</td>
						<td><input type="text" size="50" id="memo" name="memo" class="form-control"></td>
						<td><input type="submit" class="btn btn-info" onClick="do_write()"value="리뷰 등록하기"></td>
					</tr>

				</table>
			</form>
			<br>
			<form id="starDelete" action="review_control.jsp" method="post">
				<input type="hidden" name="action" value="delete"> <input
					type="hidden" name="store_id" value="<%=store_id%>"> <input
					type="hidden" name="sonnim_id" value="<%=sonnim_id%>">
				<table class="table">
					<col width="300">
					<col width="500">
					<col width="80">
					<%
						// 빈즈에서 가져온 ArrayList 에서 HashMap 을 가져와 반복해서 출력함.
						if (starList.size() > 0) {
							for (int i = 0, len = starList.size(); i < len; i++) {

								// ArrayList 에서 HashMap 을 가져옴. Object 로 저장되어 있기 때문에 형변환 필요
								HashMap data = (HashMap) starList.get(i);
					%>
					<tr>
						<td>
							<p>
								<%
									double avg1 = Double.parseDouble((String) data.get("starPoint"));

											if (Math.floor(avg1) == 0) {
								%>
								별점 : <span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<%
									} else if (Math.floor(avg1) == 1) {
								%>
								별점 : <span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<%
									} else if (Math.floor(avg1) == 2) {
								%>
								별점 : <span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<%
									} else if (Math.floor(avg1) == 3) {
								%>
								별점 : <span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<%
									} else if (Math.floor(avg1) == 4) {
								%>
								별점 : <span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star-empty"></span>
								<%
									} else if (Math.floor(avg1) == 5) {
								%>
								별점 : <span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<span class="glyphicon glyphicon-star"></span>
								<%
									}
								%>
							</p>
							<p>
								작성일자 :
								<%=data.get("wirtedate")%></p>
							<p>
								작성자 :
								<%=data.get("name")%></p>
						</td>
						<td align="left"><%=data.get("memo")%></td>

						<%
							if (sonnim_id == null || sonnim_id.equals("")) {
						%>
<!-- 						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
						<%
							} else if (sonnim_id != null) {
										// 일치한 사람에게만 삭제버튼 보이게하는부분				
										if (data.get("sonnim_id").equals(sonnim_id)) {
											System.out.println("data 의 sonnim_id" + data.get("sonnim_id"));
											System.out.println("session 의 sonnim_id" + sonnim_id);
						%>
						<td><button class="btn btn-warning" type="submit">삭제</button></td>
						<%
							} else {
						%>
						<td></td>
						<%
							}
									}
						%>
						<td></td>
					</tr>
					<%
						}
						} else { // if
					%>
					    <tr><td colspan="70" align="center">:::리뷰를 작성해보세요!:::</td></tr> 			
					<%
						} //else
					%>

				</table>
			</form>
		</div>

		<!-- 페이징부분 -->
		<%
			if (starList.size() > 0) {
		%>
		<table cellpadding=5 cellspacing=0 border="0" align="center">
			<tr>
				<td colspan="6" class="list_num">
					<ul class="pagination">  <!-- bootstrap -->
						<li><a href="javascript:;" onclick="do_goPage(1)"> < </a></li>
						<%
							String pageDiv = "&nbsp;&nbsp;";
								StringBuilder pageCont = new StringBuilder();

								for (int i = 1; i <= intPageCount; i++) {

									pageCont.append(
											"<li><a href='javascript:;' " + " " + "onclick='do_goPage(" + i + ")'>" + i + "</a></li>");
									if (i == intPageCount)
										pageCont.append("");
									else
										pageCont.append(pageDiv);
								}
								out.println(pageCont.toString());
						%>
						<li><a href="javascript:;"
							onclick="do_goPage(<%=intPageCount%>)"> > </a></li>
				</td>
			</tr>
		</table>
		<%
			}
		%>
</div>
<div class="col-md-1"></div>
	</div>

	<script type="text/javascript">


$(function() {
	var imgNum=1;
	$("[name=forward]").click(function(){
		if(imgNum==5){
			imgNum=1;
		}else{
			imgNum = imgNum+1;
		}
		
		$("img[name=bigimg]").attr("src", $("img#"+imgNum).attr("src"));
	});
	
	$("[name=backward]").click(function(){
		if(imgNum==1){
			imgNum=5;
		}else{
			imgNum = imgNum-1;
		}
		
		$("img[name=bigimg]").attr("src", $("img#"+imgNum).attr("src"));
	});
	
	$("#heartImg").bind("click", function() {
		 
		var heartStatus = document.getElementById('heartStatus').value;
		var storeId = document.getElementById('storeId').value;
		var heartImg = document.getElementById('heartImg');
		
// 		alert(heartStatus);
		
		$.ajax({
			type : "POST",
			url : "../sonnim/heart_control.jsp",
			data : {
				"action" : heartStatus,
				"store_id" : storeId
			},
			success : function(data) {
				
				var result = $.trim(data);
// 				alert("result : " + result);

				
				var array = result.split("/");
// 				alert("array : " + array[0]);
// 				alert("array : " + array[1]);

				document.getElementById('count').innerHTML = "좋아요 수 : " + array[1];

				if (array[0] == "NotLogin") {
					alert('손님으로 로그인 후 이용해주십시오.');
					location.href = '../main/login.jsp';
				} else if(array[0] == "InsertOk") {
					alert('좋아요 등록에 성공했습니다.');
					heartImg.src =  '../img/fullHeart.png';
				} else if(array[0] == "InsertFail") {
					alert('좋아요 등록에 실패했습니다');
				}else if(array[0] == "DeleteOk"){
					alert('좋아요가 취소되었습니다.');
					heartImg.src =  '../img/emptyHeart.png';
				}else if(array[0] == "DeleteFail"){
					alert('좋아요 취소에 실패했습니다.');
				}else{
					alert('기타문제 발생..');
				}
			}
		});
	});
	
	$("[name=smallimg]").bind("click", function(){
		var smallsrc = $(this).attr("src");
		$("[name=bigimg]").attr("src", smallsrc);
		imgNum= parseInt($(this).attr("id"));
	});
});

function do_write(){
	
	var frm = document.starWrite;
	
	var select = document.getElementById("star_count");
	var starPoint = select.options[select.selectedIndex].value;

// 	VAR MEMO = DOCUMENT.GETELEMENTBYID("MEMO");
	if(frm.memo.value.length==0){
		alert('평가를 적어주세요.');
		memo.focus();
		return;
	}
	
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

	<!--푸터  -->
	<jsp:include page="../main/site_footer.jsp"></jsp:include>
</body>
</html>