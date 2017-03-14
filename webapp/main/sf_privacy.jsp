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

//%>
<%
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--헤더 -->
<jsp:include page="../main/site_header.jsp"></jsp:include>
<!--헤더 -->



<!-- main -->
<br><br><br>
<div class="container">
<h1>개인정보처리방침</h1><br>
        <div id="a1" class="section">
            <h4>1. 개인정보처리방침의 의의</h4>
            <p><strong class="b">intable는 본 개인정보처리방침을 정보통신망법을 기준으로 작성하되, intable 내에서의 이용자 개인정보 처리 현황을 최대한 알기 쉽고 상세하게 설명하기 위해 노력하였습니다.</strong><br>
                이는 쉬운 용어를 사용한 개인정보처리방침 작성 원칙인 ‘Plain Language Privacy Policy(쉬운 용어를 사용한 개인정보처리방침)’를 도입한 것입니다.</p>
            <div class="btn_area">
            </div>
            <p>개인정보처리방침은 다음과 같은 중요한 의미를 가지고 있습니다.</p>
            <ul class="bu">
                <li><i></i>intable가 어떤 정보를 수집하고, 수집한 정보를 어떻게 사용하며, 필요에 따라 누구와 이를 공유(‘위탁 또는 제공’)하며, 이용목적을 달성한 정보를 언제·어떻게 파기하는지 등 ‘개인정보의 한살이’와 관련한 정보를 투명하게 제공합니다.</li>
                <li><i></i>정보주체로서 이용자는 자신의 개인정보에 대해 어떤 권리를 가지고 있으며, 이를 어떤 방법과 절차로 행사할 수 있는지를 알려드립니다. 또한, 법정대리인(부모 등)이 만14세 미만 아동의 개인정보 보호를 위해 어떤 권리를 행사할 수 있는지도 함께 안내합니다.</li>
                <li><i></i>개인정보 침해사고가 발생하는 경우, 추가적인 피해를 예방하고 이미 발생한 피해를 복구하기 위해 누구에게 연락하여 어떤 도움을 받을 수 있는지 알려드립니다.</li>
                <li><i></i>그 무엇보다도, 개인정보와 관련하여 intable와 이용자간의 권리 및 의무 관계를 규정하여 이용자의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.</li>
            </ul>
        </div>
        <hr>
        <div id="a2" class="section">
            <h4>2. 수집하는 개인정보</h4>
            <p><strong class="b">이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 intable 서비스를 회원과 동일하게 이용할 수 있습니다. <br>
                이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, intable는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.</strong></p>
            <ul class="sec">
                <li class="first">
                    <p><strong>회원가입 시점에 intable가 이용자로부터 수집하는 개인정보는 아래와 같습니다.</strong></p>
                    <ul class="bu">
                        <li><i></i>회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 가입인증 휴대폰번호’를 필수항목으로 수집합니다. 만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년원일, 성별,  중복가입확인정보(DI), 휴대폰번호)를 추가로 수집합니다. 그리고 선택항목으로 이메일 주소를 수집합니다.</li>
                        <li><i></i>단체아이디로 회원가입 시 단체아이디, 비밀번호, 단체이름, 이메일주소, 가입인증 휴대폰번호를 필수항목으로 수집합니다. 그리고 단체 대표자명, 비밀번호 발급용 멤버 이름 및 이메일주소를 선택항목으로 수집합니다.</li>
                    </ul>
</li></ul></div>
<hr>
        <div id="a3" class="section">
            <h4>3. 수집한 개인정보의 이용</h4>
            <ul class="sec">
                <li class="first last"><p><strong>intable는 회원관리, 서비스 개발·제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.</strong></p>
                    <ul class="bu">
                        <li><i></i>회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.</li>
                        <li><i></i>콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.</li>
                        <li><i></i>법령 및 intable 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.</li>
                        <li><i></i>유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.</li>
                        <li><i></i>이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.</li>
                        <li><i></i>서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.</li>
                        <li><i></i>보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.</li>
                    </ul>
                </li>
            </ul>
        </div>

        <div id="a4" class="section">
            <h4>4. 개인정보의 제공 및 위탁</h4>
            <ul class="sec">
                <li class="first">
                    <p><strong>intable는 원칙적으로 이용자 동의 없이 개인정보를 외부에 제공하지 않습니다.</strong></p>
                    <p>intable는 이용자의 사전 동의 없이 개인정보를 외부에 제공하지 않습니다. 단, 이용자가 외부 제휴사의 서비스를 이용하기 위하여 개인정보 제공에 직접 동의를 한 경우, 그리고 관련 법령에 의거해 intable에 개인정보 제출 의무가 발생한 경우, 이용자의 생명이나 안전에 급박한 위험이 확인되어 이를 해소하기 위한 경우에 한하여 개인정보를 제공하고 있습니다.</p>

</li></ul></div>




</div>
<!-- main -->
<br><br>


<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>	
<!--푸터  -->
</body>
</html>