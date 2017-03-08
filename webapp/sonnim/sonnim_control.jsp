<%@page import="intable.sonnim.dao.SonnimDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>     
<%
	// 입력값 받아오기
	String sonnim_id = request.getParameter("sonnim_id");
	String email	= request.getParameter("email");
	String password = request.getParameter("password");
	String phone 	= request.getParameter("phone");
	String birthday = request.getParameter("birthday");
	String name 	= request.getParameter("name");
	String pageNum 	= request.getParameter("pageNum");

	HashMap<String, String> data = new HashMap<>();
	data.put("sonnim_id"	, sonnim_id);
	data.put("email"	, email);		// 같은 email은 인서트 할수없음
	data.put("password"	, password);
	data.put("phone"	, phone);
	data.put("birthday"	, birthday);
	data.put("name"		, name);
	
	
%>


<%
	SonnimDao dao = new SonnimDao();

	String action = request.getParameter("action");

	// 로그인		 =========================================================================================================
	if ("login".equalsIgnoreCase(action)) {
		// email, password
		HashMap<String, String> sonnim = dao.do_login(data);

		if (sonnim != null) {
			System.out.println("로그인정보" + sonnim.toString());
			
			sonnim.put("issonnim"	, "true");			// 손님/음식점 구분자

			// 세션에 로그인 정보 넣기
			session.setAttribute("login", sonnim);
			//session.setMaxInactiveInterval(30 * 60);
			
			String endUrl = request.getSession().getAttribute("endUrl").toString();
			response.sendRedirect(endUrl);

		} else {
			// alert 띄우기
			StringBuilder script = new StringBuilder();			
			script.append("<script>");
			script.append("window.alert('email이나 비밀번호가 틀렸습니다');");
			script.append("window.history.back();");
			script.append("</script>");			
			out.write(script.toString());

			System.out.println("email이나 비밀번호가 틀렸음");
		}

	//email 중복체크 =========================================================================================================
	} else if ("emailcheck".equalsIgnoreCase(action)) {
		// email
		boolean ck;
		if(data.get("email") != null && !data.get("email").equals("")){
			ck = dao.do_checkEmail(data);
		}else{
			ck=true;
		}

		if (ck == true) {
			out.println("true");
			System.out.println("이메일중복, "+ck+" 다른거 넣어!"+data.toString());
		} else {
			out.println("false");
			System.out.println("이메일중복없음, "+ck+" 가입가능"+data.toString());
			
		}

	// 회원탈퇴 	=========================================================================================================
	} else if ("delete".equalsIgnoreCase(action)) {
		
		// sonnim_id
		boolean ck = dao.do_delete(data);
		
		if(ck == true){
			session.invalidate();
			
			System.out.println("삭제완료");
			
			// alert 띄우기
			StringBuilder script = new StringBuilder();			
			script.append("<script>");
			script.append("window.alert('회원탈퇴 되었습니다');");
			script.append("location.href = '/';");
			script.append("</script>");			
			out.write(script.toString());
		}else{
			System.out.println("삭제못했음");
		}
		
	// 회원가입  ==========================================================================================================
	} else if ("insert".equalsIgnoreCase(action)) {
		// SONNIM_ID가 같으면 update
		// SONNIM_ID,EMAIL,PASSWORD,PHONE,BIRTHDAY,NAME
		boolean ck = dao.do_upsert(data);
		if(ck == true){
			System.out.println("회원가입성공"+ck);
			
			// alert 띄우기
			StringBuilder script = new StringBuilder();			
			script.append("<script>");
			script.append("window.alert('회원가입을 축하합니다!!');");
			script.append("location.href = '/';");
			script.append("</script>");			
			out.write(script.toString());
			
			//첫화면으로 이동
			//response.sendRedirect("/");
		}else{
			System.out.println("회원가입실패"+ck);
			
			// alert 띄우기
			StringBuilder script = new StringBuilder();			
			script.append("<script>");
			script.append("window.alert('회원가입실패');");
			script.append("window.history.back();");
			script.append("</script>");			
			out.write(script.toString());
		}
		
	// 정보수정  ==========================================================================================================
	} else if ("update".equalsIgnoreCase(action)) {
		// SONNIM_ID가 같으면 update
		// SONNIM_ID,EMAIL,PASSWORD,PHONE,BIRTHDAY,NAME
		System.out.println("정보수정 들어가는 데이타"+data.toString());
		
		boolean ck = dao.do_upsert(data);
		
		if(ck == true){
			System.out.println("정보수정성공"+ck);
			
			data.put("issonnim"	, "true");			// 손님/음식점 구분자
			// 세션에 정보 넣기
			session.setAttribute("login", data);
			
			// alert 띄우기
			StringBuilder script = new StringBuilder();			
			script.append("<script>");
			script.append("window.alert('정보수정성공');");
			script.append("location.href = '../sonnim/sonnim_mypage.jsp';");
			script.append("</script>");			
			out.write(script.toString());
			
			//마이페이지로 이동... 위의 out.write 사용하면 response.sendRedirect사용하면 안됩니다.
			//response.sendRedirect("../sonnim/sonnim_mypage.jsp");
		}else{
			System.out.println("실패"+ck);
			
			// alert 띄우기
			StringBuilder script = new StringBuilder();			
			script.append("<script>");
			script.append("window.alert('정보수정실패');");
			script.append("window.history.back();");
			script.append("</script>");			
			out.write(script.toString());
		}	
		
/* 	// 하트상점 확인(상점명순 소트) ==========================================================================================
	} else if ("heart".equalsIgnoreCase(action)) {
		// sonnim_id, pageNum
		data.put("pageNum"	, pageNum);
		
		ArrayList<HashMap> heart_list = dao.do_selectHeartList(data);
		
		Iterator iter = heart_list.iterator();
		while(iter.hasNext()) {
			// ArrayList 에서 HashMap 을 가져옴. Object 로 저장되어 있기 때문에 형변환 필요
			HashMap heart = (HashMap)iter.next();
			System.out.println(heart.get("starpoint")+"\t"+heart.get("storeName"));
		} */

	// 로그아웃 ==========================================================================================
	} else if ("logout".equalsIgnoreCase(action)) {
		session.invalidate();
		
		// alert 띄우기
		StringBuilder script = new StringBuilder();			
		script.append("<script>");
		script.append("window.alert('빠이염~');");
		script.append("location.href = '/';");
		script.append("</script>");			
		out.write(script.toString());
		//response.sendRedirect("/");
		
		
	} else {
		throw new Exception("action Error");
	}
%>