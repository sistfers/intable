/**
 * 음식점 스트립트
 * 
 * namespace: store
 * 
 * @author magoon
 * 
 * @version 0.0.1-SNAPSHOT
 * 
 */

var store = store || {};

store.isSubmitted = false;

store.isEmailChecked = false;

store.isAddressChecked = false;

store.loginValidate = function(storeLogin) {

	console.log("store.loginValidate() called");

	if (storeLogin.email.value == "") {

		console.log("store.loginValidate() storeLogin.email.value: " + storeLogin.email.value);

		return false;

	}

	if (storeLogin.password.value == "") {

		console.log("store.loginValidate() storeLogin.password.value: " + storeLogin.password.value);

		return false;

	}

	return true;

};

store.formValidate = function(storeForm) {

	console.log("store.formValidate() called");

	if (storeForm.email.value == "") {

		alert("이메일을 입력 해주세요.");

		console.log("store.formValidate() storeForm.email.value: " + storeForm.email.value);

		return false;

	}

	if (!store.isEmailChecked) {

		alert("이메일 중복 확인을 해주세요.");

		console.log("store.formValidate() store.isEmailChecked: " + store.isEmailChecked);

		return false;

	}

	if (storeForm.password.value == "") {

		alert("패스워드를 입력 해주세요.");

		console.log("store.formValidate() storeForm.password.value: " + storeForm.password.value);

		return false;

	}

	if (storeForm.confirm.value == "") {

		alert("패스워드 확인을 입력 해주세요.");

		console.log("store.formValidate() storeForm.confirm.value: " + storeForm.confirm.value);

		return false;

	}

	if (!(storeForm.password.value === storeForm.confirm.value)) {

		alert("패스워드와 패스워드 확인이 다릅니다.");

		console.log("store.formValidate() storeForm.password.value: " + storeForm.password.value);
		console.log("store.formValidate() storeForm.confirm.value: " + storeForm.confirm.value);

		return false;

	}

	// TODO 나머지 추가

	if (!store.isAddressChecked) {

		alert("주소를 입력 해주세요.");

		console.log("store.formValidate() store.isAddressChecked: " + store.isAddressChecked);

		return false;

	}

	return true;

};

store.login = function() {

	console.log("store.login() called");

	if (store.isSubmitted) {

		console.log("store.login() store.isSubmitted: " + store.isSubmitted);

		return false;

	} else {

		store.isSubmitted = true;

	}

	var storeLogin = document.storeLogin;

	if (store.loginValidate(storeLogin)) {

		console.log("store.login() store.loginValidate(storeLogin): true");

		//		var loginAction = document.createElement("input");
		//
		//		loginAction.type = "hidden";
		//		loginAction.name = "action";
		//		loginAction.value = "login";
		//
		//		storeLogin.appendChild(loginAction);
		//
		//		storeLogin.action = "/store/store_control.jsp";
		//		storeLogin.method = "post";
		//
		//		storeLogin.submit();

		return true;

	} else {

		console.log("store.login() store.loginValidate(storeLogin): false");

		alert("이메일과 패스워드를 확인해 주세요.");

		store.isSubmitted = false;

		return false;

	}

};

store.join = function() {

	console.log("store.join() called");

	location.href = "/store/store_insert.jsp";

};

store.book = function(no, bookstate) {

	console.log("store.book(no, bookstate) called  no: " + no + ", bookstate: " + bookstate);

	$.ajax({
		url : "/store/store_control.jsp",
		method : "post",
		data : {
			"action" : "book",
			"no" : no,
			"bookstate" : bookstate
		},
		dataType : "JSON",
		success : function(data, textStatus, jqXHR) {

			console.log("store.book() $.ajax.success.data.book: " + data.book);
			console.log("store.book() $.ajax.success.data.no: " + data.no);
			console.log("store.book() $.ajax.success.data.bookstate: " + data.bookstate);

			if (data.book) {

				$("#book_" + data.no + "_bookstate").html(function() {

					console.log("data.bookstate:" + data.bookstate);

					switch (data.bookstate) {

						case "0":

							return "<span class=\"book_bookstate\">대기</span> <button onclick=\"store.book("

							+ data.no + ", 1);\" class=\"btn btn-success btn-xs\">승인</button> <button onclick=\"store.book("

							+ data.no + ", 2);\" class=\"btn btn-danger btn-xs\">취소</button>";

							break;

						case "1":

							return "<span class=\"book_bookstate\">승인</span> <button onclick=\"store.book("

							+ data.no + ", 0);\" class=\"btn btn-info btn-xs\">대기</button> <button onclick=\"store.book("

							+ data.no + ", 2);\" class=\"btn btn-danger btn-xs\">취소</button>";

							break;

						case "2":

							return "<span class=\"book_bookstate\">취소</span> <button onclick=\"store.book("

							+ data.no + ", 0);\" class=\"btn btn-info btn-xs\">대기</button> <button onclick=\"store.book("

							+ data.no + ", 1);\" class=\"btn btn-success btn-xs\">승인</button>";

							break;

						default:

							return "<span class=\"book_bookstate\">Error</span>";

							break;

					}
				});
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {

			alert("서버와 통신에 실패 했습니다.");

			console.error("store.book() $.ajax.error.textStatus: " + textStatus);

			console.error("store.book() $.ajax.error.errorThrown: " + errorThrown);

		}
	});

};

store.emailCheck = function() {

	console.log("store.emailCheck() called");

	if (storeForm.email.value == "") {

		console.log("store.emailCheck() storeForm.email.value: " + storeForm.email.value);

		alert("이메일을 확인해 주세요.");

		return false;

	} else {

		console.log("store.emailCheck() storeForm.email.value: " + storeForm.email.value);

		var requestUrl = "/store/store_control.jsp?action=check&email=" + storeForm.email.value;
		var requestMethod = "post";

		//		var formData = new FormData();
		//
		//		formData.append("action", "check");
		//		formData.append("email", storeForm.email.value);

		var ajax = new XMLHttpRequest();

		ajax.onloadstart = function() {

			console.log("store.emailCheck() ajax.onloadstart() called");

		};

		ajax.onprogress = function() {

			console.log("store.emailCheck() ajax.onprogress() called");

		};

		ajax.onabort = function() {

			console.log("store.emailCheck() ajax.onabort() called");

		};

		ajax.onerror = function() {

			console.log("store.emailCheck() ajax.onerror() called");

		};

		ajax.onload = function() {

			console.log("store.emailCheck() ajax.onload() called");

		};

		ajax.ontimeout = function() {

			console.log("store.emailCheck() ajax.ontimeout() called");

		};

		ajax.onloadend = function() {

			console.log("store.emailCheck() ajax.onloadend() called");

		};

		ajax.onreadystatechange = function() {

			console.log("store.emailCheck() ajax.onreadystatechange() called");

			console.log("store.emailCheck() ajax.readyState: " + ajax.readyState);
			console.log("store.emailCheck() ajax.status: " + ajax.status);

			if (ajax.readyState === XMLHttpRequest.DONE) {

				if (ajax.status === 200) {

					console.log("store.emailCheck() ajax.responseText: " + ajax.responseText);

					var jsonObject = JSON.parse(ajax.responseText);

					store.isEmailChecked = jsonObject.check;

					console.log("store.emailCheck() store.isEmailChecked: " + store.isEmailChecked);

					if (store.isEmailChecked) {

						alert("사용 가능한 이메일 입니다.");

					} else {

						alert("사용 불가능한 이메일 입니다.");

					}

				} else {

					alert("서버와 통신에 실패 했습니다.");

					console.error("store.emailCheck() ajax.readyState: " + ajax.readyState);

					console.error("store.emailCheck() ajax.status: " + ajax.status);

				}

			}

		};

		ajax.open(requestMethod, requestUrl);

		ajax.send();

	}

};

store.addressCheck = function() {

	console.log("store.addressCheck() called");

	new daum.Postcode({

		oncomplete : function(data) {

			var storeForm = document.storeForm;

			storeForm.sido.value = data.sido;

			storeForm.sigungu.value = data.sigungu;

			storeForm.zonecode.value = data.zonecode;

			storeForm.address1.value = data.address;

			storeForm.address2.focus();

			store.isAddressChecked = true;
		}

	}).open();

};

store.insert = function() {

	console.log("store.insert() called");

	if (store.isSubmitted) {

		console.log("store.insert() store.isSubmitted: " + store.isSubmitted);

		return false;

	} else {

		console.log("store.insert() store.isSubmitted: " + store.isSubmitted);

		store.isSubmitted = true;

	}

	var storeForm = document.storeForm;

	if (store.formValidate(storeForm)) {

		console.log("store.insert() store.formValidate(storeForm): true");

		//		var formAction = document.createElement("input");
		//
		//		formAction.type = "hidden";
		//		formAction.name = "action";
		//		formAction.value = "insert";
		//
		//		storeForm.appendChild(formAction);
		//
		//		storeForm.action = "/store/store_control.jsp";
		//		storeForm.method = "post";
		//
		//		storeForm.submit();

		return true;

	} else {

		console.log("store.insert() store.formValidate(storeForm): false");

		store.isSubmitted = false;

		return false;

	}

};

store.update = function() {

	console.log("store.update() called");

	if (store.isSubmitted) {

		console.log("store.update() store.isSubmitted: " + store.isSubmitted);

		return false;

	} else {

		console.log("store.update() store.isSubmitted: " + store.isSubmitted);

		store.isSubmitted = true;

	}

	var storeForm = document.storeForm;

	if (store.formValidate(storeForm)) {

		console.log("store.update() store.formValidate(storeForm): true");

		//		var formAction = document.createElement("input");
		//
		//		formAction.type = "hidden";
		//		formAction.name = "action";
		//		formAction.value = "update";
		//
		//		storeForm.appendChild(formAction);
		//
		//		storeForm.action = "/store/store_control.jsp";
		//		storeForm.method = "post";
		//
		//		storeForm.submit();

		return true;

	} else {

		console.log("store.update() store.formValidate(storeForm): false");

		store.isSubmitted = false;

		return false;

	}

};

store.uploadImage = function() {

	window.open("/store/store_upload_image_popup.jsp", "upload_image_popup", "left=300, top=200, width=350, height=450, toolbar=no, menubar=no, status=no, scrollbars=no, resizable=no")
};
