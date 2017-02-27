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

	HashMap<String, String> login = (HashMap) session.getAttribute("login");

	//로그인상태이면 회원가입 창을 볼수없음
	if (login != null) {
		String endUrl = request.getSession().getAttribute("endUrl").toString();
		System.out.println(request.getRequestURI() + " " + endUrl);
		response.sendRedirect(endUrl); // 이전페이지로 이동

		//마지막 페이지 저장용
		String nowUrl = request.getRequestURI() + "?" + request.getQueryString();
		session.setAttribute("endUrl", nowUrl);
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<style type="text/css">
</style>
<!-- Bootstrap -->
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</head>
<body>
	<!--헤더 -->
	<jsp:include page="../main/site_header.jsp"></jsp:include>
	<br><br><br><br><br><br>

<!-- 널값, 패스워드 불일치시 input 테두리 경고 표시 (부트스트랩) -->
				<p align="center">
					<strong style="color: black; font-size: 30px;">회원가입</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					음식점 회원가입은 여기 <a href="../store/store_insert.jsp"><strong style="color: red; font-size: 30px;"> Click!! </strong></a>
				</p><br>
        
        <div class="container">
        <div class="row">
        <div class="col-md-10">
             
            <!-- 모달창 -->
            <div class="modal fade" id="defaultModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">알림</h4>
                        </div>
                        <div class="modal-body">
                            <p class="modal-contents"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
                 

 
        <!-- <form class="form-horizontal" role="form" method="post" action="javascript:alert( 'success!' );"> -->
		<form class="form-horizontal" role="form" method="post" action="../sonnim/sonnim_control.jsp">
		 <input type="hidden" name="action" value="insert" />
            <div class="form-group" id="divEmail">
                <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
                 <div class="col-lg-8">
                 <input type="email" class="form-control" id="email" name="email" placeholder="이메일" maxlength="30">
                </div>  
                <div class="col-lg-2">
                <input class="btn btn-primary" id="emailCk" name="emailCk" value="email 중복확인" size="15" >
                </div>
                </div>
    

            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="password" name="password" data-rule-required="true" placeholder="패스워드" maxlength="15">
                </div>
            </div>
            
            <div class="form-group" id="divPasswordCheck">
                <label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="passwordCheck" data-rule-required="true" placeholder="패스워드 확인" maxlength="30">
                </div>
            </div>
            
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label">이름</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyHangul" id="name" name="name" data-rule-required="true" placeholder="한글만 입력 가능합니다." maxlength="15">
                </div>
            </div>
            
            <div class="form-group" id="divphone">
                <label for="inputphone" class="col-lg-2 control-label">전화번호</label>
                <div class="col-lg-10">
                    <input type="tel" class="form-control onlyNumber" id="phone" name="phone" data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11">
                </div>
            </div>
            
            <div class="form-group" id="divbirthday">
                <label for="inputbirthday" class="col-lg-2 control-label">생년월일</label>
                <div class="col-lg-10">
                    <input type="date" id="birthday" name="birthday">
                  	</div>
                 </div>
                  	
            
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <button type="submit" class="btn btn-default">회원가입</button>
                    <button type="reset" class="btn btn-default">취소</button>
                </div>
            </div>
        </form>
         </div>
         </div>
         </div>

	<script>


$(function(){
    //모달을 전역변수로 선언
    var modalContents = $(".modal-contents");
    var modal = $("#defaultModal");
     
    $('.onlyAlphabetAndNumber').keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val($(this).val().replace(/[^_a-z0-9]/gi,'')); //_(underscore), 영어, 숫자만 가능
        }
    });
     
    $(".onlyHangul").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[a-z0-9]/gi,''));
        }
    });
 
    $(".onlyNumber").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
        }
    });
     
    //------- 검사하여 상태를 class에 적용
         $('#email').keyup(function(event){
         
        var divEmail = $('#divEmail');
         
        if($.trim($('#email').val())==""){
            divEmail.removeClass("has-success");
            divEmail.addClass("has-error");  
        }else{
            divEmail.removeClass("has-error");
            divEmail.addClass("has-success");  
        }
    }); 
    
     $('#password').keyup(function(event){
         
        var divPassword = $('#divPassword');
         
        if($('#password').val()==""){
            divPassword.removeClass("has-success");
            divPassword.addClass("has-error");
        }else{
            divPassword.removeClass("has-error");
            divPassword.addClass("has-success");
        }
    }); 
     
    $('#passwordCheck').keyup(function(event){
         
        var passwordCheck = $('#passwordCheck').val();
        var password = $('#password').val();
        var divPasswordCheck = $('#divPasswordCheck');
         
        if((passwordCheck=="") || (password!=passwordCheck)){
            divPasswordCheck.removeClass("has-success");
            divPasswordCheck.addClass("has-error");
        }else{
            divPasswordCheck.removeClass("has-error");
            divPasswordCheck.addClass("has-success");
        }
    });
     
    $('#name').keyup(function(event){
         
        var divName = $('#divName');
         
        if($.trim($('#name').val())==""){
            divName.removeClass("has-success");
            divName.addClass("has-error");
        }else{
            divName.removeClass("has-error");
            divName.addClass("has-success");
        }
    });
     

     
    $('#phone').keyup(function(event){
         
        var divphone = $('#divphone');
         
        if($.trim($('#phone').val())==""){
            divphone.removeClass("has-success");
            divphone.addClass("has-error");
        }else{
            divphone.removeClass("has-error");
            divphone.addClass("has-success");
        }
    });
     
     
    //------- validation 검사
    $( "form" ).submit(function( event ) {
         
        var provision = $('#provision');
        var memberInfo = $('#memberInfo');
        var divId = $('#divId');
        var divPassword = $('#divPassword');
        var divPasswordCheck = $('#divPasswordCheck');
        var divName = $('#divName');
        var divEmail = $('#divEmail');
        var divphone = $('#divphone');
         
         //이메일
        if($('#email').val()==""){
            modalContents.text("이메일을 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divEmail.removeClass("has-success");
            divEmail.addClass("has-error");
            $('#email').focus();
            return false;
        }else{
            divEmail.removeClass("has-error");
            divEmail.addClass("has-success"); 
        } 
        
        //아이디 검사
        if($('#id').val()==""){
            modalContents.text("아이디를 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divId.removeClass("has-success");
            divId.addClass("has-error");
            $('#id').focus();
            return false;
        }else{
            divId.removeClass("has-error");
            divId.addClass("has-success");
        }
         
        //패스워드 검사
        if($('#password').val()==""){
            modalContents.text("패스워드를 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divPassword.removeClass("has-success");
            divPassword.addClass("has-error");
            $('#password').focus();
            return false;
        }else{
            divPassword.removeClass("has-error");
            divPassword.addClass("has-success");
        }
         
        //패스워드 확인
        if($('#passwordCheck').val()==""){
            modalContents.text("패스워드 확인을 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divPasswordCheck.removeClass("has-success");
            divPasswordCheck.addClass("has-error");
            $('#passwordCheck').focus();
            return false;
        }else{
            divPasswordCheck.removeClass("has-error");
            divPasswordCheck.addClass("has-success");
        }
         
        //패스워드 비교
        if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
            modalContents.text("패스워드가 일치하지 않습니다.");
            modal.modal('show');
             
            divPasswordCheck.removeClass("has-success");
            divPasswordCheck.addClass("has-error");
            $('#passwordCheck').focus();
            return false;
        }else{
            divPasswordCheck.removeClass("has-error");
            divPasswordCheck.addClass("has-success");
        }
         
        //이름
        if($('#name').val()==""){
            modalContents.text("이름을 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divName.removeClass("has-success");
            divName.addClass("has-error");
            $('#name').focus();
            return false;
        }else{
            divName.removeClass("has-error");
            divName.addClass("has-success");
        }
         
        //휴대폰 번호
        if($('#phone').val()==""){
            modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divphone.removeClass("has-success");
            divphone.addClass("has-error");
            $('#phone').focus();
            return false;
        }else{
            divphone.removeClass("has-error");
            divphone.addClass("has-success");
        }
     });
});
 
 $(function() {
			$("#emailCk").bind("click", function() {
				// null이면 동작 안하게 
				if($('#email').val()=="")return;
				
				$.ajax({
					type : "POST",
					url : "../sonnim/sonnim_control.jsp",
					data : {
						"email" : $("#email").val(),
						"action" : "emailcheck"
					},
					success : function(data) {
						console.log($.trim(data));

						if ($.trim(data) == "true") {
							alert("이미 사용중인 계정입니다!")
							//$('#email').val()=="";
						} else {
							alert("사용가능한 계정입니다!")
						}
					}
				});
			});
		});
	</script>

<!--푸터  -->
<jsp:include page="../main/site_footer.jsp"></jsp:include>

</body>
</html>