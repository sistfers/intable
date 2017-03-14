<%@page import="java.util.Collections"%>
<%@page import="java.util.HashMap"%>
<%@page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:requestEncoding value="UTF-8" />
<fmt:setLocale value="ko_KR" />
<%!//

	//%>
<%
	HashMap<String, String> login = session.getAttribute("login") instanceof HashMap<?, ?>

			? (HashMap<String, String>) session.getAttribute("login")

			: null;

	if (login != null) {

		String endUrl = request.getSession().getAttribute("endUrl") == null

				? "/"
				: request.getSession().getAttribute("endUrl").toString();

		response.sendRedirect(endUrl);

	}

	// TODO 리디렉션 버그 잡기
	// 1. 로그인 되어 있는가?
	// 2. endUrl 이 현재 페이지와 같은가?
	// 3. 요청 쿼리가 null인가?
	// 4. ...?

	/*
	} else {
	
			String nowUrl = request.getRequestURI()
					+ (request.getQueryString() == null ? "" : "?" + request.getQueryString());
	
			session.setAttribute("endUrl", nowUrl);
	 */
%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>음식점 사용자 가입</title>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/site_script.js"></script>
<script src="../js/store_script.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/site_style.css">
<link rel="stylesheet" href="../css/store_style.css">
<script>
	
</script>
<style>
</style>
</head>
<body>
	<div id="container" class="container">
		<header id="site_header"><jsp:include page="../main/site_header.jsp" /></header>
		<main id="site_main" class="row container"> <header id="page_header"
			class="row">
			<h1 class="col-md-7 col-md-offset-1">
				<strong style="color: black; font-size: 30px;">음식점 등록</strong>
			</h1>
			<p class="col-md-4">
				손님 회원가입은 여기 <a href="../sonnim/sonnim_join.jsp"><strong
					style="color: red; font-size: 30px;"> Click!! </strong></a>
			</p>
		</header>
		<article id="page_article" class="row">
			<form name="storeForm" id="storeForm" action="../store/store_control.jsp"
				method="post" onsubmit="return store.insert();" class="form-horizontal">
				<input type="hidden" name="action" value="insert"> <input
					type="hidden" name="sido" id="sido" value="${sessionScope.login.sido}">
				<input type="hidden" name="sigungu" id="sigungu"
					value="${sessionScope.login.sigungu}">
				<div class="form-group">
					<label for="email" class="col-md-2 control-label">이메일</label>
					<div class="col-md-7">
						<input type="email" name="email" id="email"
							value="${sessionScope.login.email}" class="form-control" tabindex="1"
							maxlength="50" placeholder="이메일을 입력해 주세요." title="이메일을 입력해 주세요." required>
					</div>
					<div class="col-md-2">
						<input type="button" name="emailCheck" id="emailCheck" value="중복 확인"
							class="btn btn-primary" tabindex="2" placeholder="이메일 중복 확인"
							title="이메일 중복 확인" onclick="store.emailCheck();">
					</div>
				</div>
				<div class="form-group">
					<label for="password" class="col-md-2 control-label">패스워드</label>
					<div class="col-md-7">
						<input type="password" name="password" id="password"
							value="${sessionScope.login.password}" class="form-control" tabindex="3"
							maxlength="50" placeholder="패스워드를 입력해 주세요." title="패스워드를 입력해 주세요."
							required>
					</div>
				</div>
				<div class="form-group">
					<label for="confirm" class="col-md-2 control-label">패스워드 확인</label>
					<div class="col-md-7">
						<input type="password" id="confirm" class="form-control" tabindex="4"
							maxlength="50" placeholder="패스워드 확인을 입력해 주세요." title="패스워드 확인을 입력해 주세요."
							required>
					</div>
				</div>
				<div class="form-group">
					<label for="name" class="col-md-2 control-label">음식점 이름</label>
					<div class="col-md-7">
						<input type="text" name="name" id="name"
							value="${sessionScope.login.name}" class="form-control" tabindex="5"
							maxlength="100" placeholder="음식점 이름을 입력해 주세요." title="음식점 이름을 입력해 주세요."
							required>
					</div>
				</div>
				<div class="form-group">
					<label for="phone" class="col-md-2 control-label">전화 번호</label>
					<div class="col-md-7">
						<input type="tel" name="phone" id="phone"
							value="${sessionScope.login.phone}" class="form-control" tabindex="6"
							maxlength="20" placeholder="전화 번호를 입력해 주세요." title="전화 번호를 입력해 주세요."
							required>
					</div>
				</div>
				<div class="form-group">
					<label for="zonecode" class="col-md-2 control-label">우편 번호</label>
					<div class="col-md-3">
						<input type="text" name="zonecode" id="zonecode"
							value="${sessionScope.login.zonecode}" class="form-control" tabindex=""
							maxlength="10" placeholder="주소를 검색해 주세요." title="주소를 검색해 주세요."
							onclick="store.addressCheck();" readonly required>
					</div>
					<div class="col-md-2 col-md-offset-4">
						<input type="button" name="addressCheck" id="addressCheck" value="주소 검색"
							class="btn btn-primary" tabindex="7" placeholder="주소 검색" title="주소 검색"
							onclick="store.addressCheck();">
					</div>
				</div>
				<div class="form-group">
					<label for="address1" class="col-md-2 control-label">주소</label>
					<div class="col-md-7">
						<input type="text" name="address1" id="address1"
							value="${sessionScope.login.address1}" class="form-control" tabindex=""
							maxlength="100" placeholder="주소를 검색해 주세요." title="주소를 검색해 주세요."
							onclick="store.addressCheck();" readonly required>
					</div>
				</div>
				<div class="form-group">
					<label for="address2" class="col-md-2 control-label">상세 주소</label>
					<div class="col-md-7">
						<input type="text" name="address2" id="address2"
							value="${sessionScope.login.address2}" class="form-control" tabindex="8"
							maxlength="100" placeholder="상세 주소를 입력해 주세요." title="상세 주소를 입력해 주세요."
							required>
					</div>
				</div>
				<div class="form-group">
					<label for="category" class="col-md-1 col-md-offset-1 control-label">카테고리</label>
					<div class="col-md-1">
						<select name="category" id="category" class="form-control"
							style="width: 100px;" tabindex="9" title="카테고리를 선택해 주세요." required><option
								value="${sessionScope.login.category}">${sessionScope.login.category}</option>
							<option value="한식">한식</option>
							<option value="중식">중식</option>
							<option value="일식">일식</option>
							<option value="양식">양식</option>
							<option value="기타">기타</option></select>
					</div>
					<label for="maxbooking" class="col-md-1 control-label">최대예약</label>
					<div class="col-md-1">
						<select name="maxbooking" id="maxbooking" class="form-control"
							tabindex="10" style="width: 100px;" title="" required><option
								value="${sessionScope.login.maxbooking}">${sessionScope.login.maxbooking}</option>
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="30">30</option>
							<option value="40">40</option>
							<option value="50">50</option>
							<option value="60">60</option>
							<option value="70">70</option>
							<option value="80">80</option>
							<option value="90">90</option>
							<option value="100">100</option>
							<option value="120">120</option>
							<option value="140">140</option>
							<option value="160">160</option>
							<option value="180">180</option>
							<option value="200">200</option>
							<option value="250">250</option>
							<option value="300">300</option>
							<option value="350">350</option>
							<option value="400">400</option>
							<option value="450">450</option>
							<option value="500">500</option>
							<option value="600">600</option>
							<option value="700">700</option>
							<option value="800">800</option>
							<option value="900">900</option>
							<option value="1000">1000</option>
							<option value="10000">10000</option></select>
					</div>
					<label for="open" class="col-md-1 control-label">시작시간</label>
					<div class="col-md-1">
						<select name="open" id="open" class="form-control" tabindex="11"
							style="width: 100px;" title="" required><option
								value="${sessionScope.login.open}">${sessionScope.login.open}</option>
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option></select>
					</div>
					<label for="closed" class="col-md-1 control-label">마감시간</label>
					<div class="col-md-1">
						<select name="closed" id="closed" class="form-control"
							style="width: 100px;" tabindex="12" title="" required><option
								value="${sessionScope.login.closed}">${sessionScope.login.closed}</option>
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option></select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-7 col-md-offset-2">
						<textarea name="note" id="note" class="" tabindex=""
							placeholder="상세 설명을 입력해 주세요." title="상세 설명을 입력해 주세요." rows="20"
							cols="100" required>${sessionScope.login.note}</textarea>
					</div>
					<span id="" class="store_form_span"></span>
				</div>
				<div class="form-group">
					<div class="col-md-5 col-md-offset-4">
						<input type="submit" id="store_form_submit" value="등록"
							class="btn btn-default"> <input type="reset"
							id="store_login_reset" value="초기화" class="btn btn-default"> <input
							type="button" id="store_login_join" value="취소" class="btn btn-default"
							onclick="history.back();">
					</div>
				</div>
			</form>
		</article>
		<footer id="page_footer" class=""></footer></main>
		<jsp:include page="../main/site_footer.jsp" />
	</div>
</body>
</html>
