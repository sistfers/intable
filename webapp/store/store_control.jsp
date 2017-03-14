<%@page import="intable.book.dao.BookDao"%>
<%@page import="javax.json.JsonObject"%>
<%@page import="javax.json.JsonObjectBuilder"%>
<%@page import="javax.json.Json"%>
<%@page import="java.lang.StringBuilder"%>
<%@page import="java.util.HashMap"%>
<%@page import="intable.store.dao.StoreDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
	// TODO 로그인 사용자 판단
	
	HashMap<String, String> login = session.getAttribute("login") instanceof HashMap<?, ?>
			
			? (HashMap<String, String>) session.getAttribute("login")
			
			: null;
	
	StoreDao storeDao = new StoreDao();
	
	HashMap<String, String> paramMap = new HashMap<String, String>();
	
	String action = request.getParameter("action");
	String store_id = request.getParameter("store_id");
	
	System.out.println("store_control.jsp action: " + action);
	
	if ("insert".equalsIgnoreCase(action)) {
		
		paramMap.put("email", request.getParameter("email"));
		paramMap.put("password", request.getParameter("password"));
		paramMap.put("phone", request.getParameter("phone"));
		paramMap.put("name", request.getParameter("name"));
		paramMap.put("zonecode", request.getParameter("zonecode"));
		paramMap.put("sido", request.getParameter("sido"));
		paramMap.put("sigungu", request.getParameter("sigungu"));
		paramMap.put("address1", request.getParameter("address1"));
		paramMap.put("address2", request.getParameter("address2"));
		paramMap.put("maxbooking", request.getParameter("maxbooking"));
		paramMap.put("imageuri1", request.getParameter("imageuri1"));
		paramMap.put("imageuri2", request.getParameter("imageuri2"));
		paramMap.put("imageuri3", request.getParameter("imageuri3"));
		paramMap.put("imageuri4", request.getParameter("imageuri4"));
		paramMap.put("imageuri5", request.getParameter("imageuri5"));
		paramMap.put("open", request.getParameter("open"));
		paramMap.put("closed", request.getParameter("closed"));
		paramMap.put("category", request.getParameter("category"));
		
		paramMap.put("note",
				
				request.getParameter("note")
						
						.replace("\"", "&quot;")
						
						.replace("\'", "&apos;")
						
						.replace("&", "&amp;")
						
						.replace("<", "&lt;")
						
						.replace(">", "&gt;")
						
						.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;")
						
						.replace("\r\n", "<br>")
		
		);
		
		if (storeDao.do_insert(paramMap)) {
			
			HashMap<String, String> store = storeDao.do_login(paramMap);
			
			if (store != null) {
				
				store.put("issonnim", "false");
				
				session.setAttribute("login", store);
				session.setMaxInactiveInterval(30 * 60);
				
				StringBuilder script = new StringBuilder();
				
				script.append("<script src=\"../js/store_script.js\"></script>");
				script.append("<script>");
				script.append("store.uploadImage();");
				script.append("location.href=\"../store/store.jsp\"");
				script.append("</script>");
				
				out.write(script.toString());
				
			} else {
				
				response.sendRedirect("/main/login.jsp");
				
			}
			
		} else {
			
			StringBuilder script = new StringBuilder();
			
			script.append("<script>");
			script.append("alert(\"회원 가입 실패\");");
			script.append("history.back();");
			script.append("</script>");
			
			out.write(script.toString());
			
		}
		
	} else if ("update".equalsIgnoreCase(action)) {
		
		paramMap.put("email", request.getParameter("email"));
		paramMap.put("password", request.getParameter("password"));
		paramMap.put("phone", request.getParameter("phone"));
		paramMap.put("name", request.getParameter("name"));
		paramMap.put("zonecode", request.getParameter("zonecode"));
		paramMap.put("sido", request.getParameter("sido"));
		paramMap.put("sigungu", request.getParameter("sigungu"));
		paramMap.put("address1", request.getParameter("address1"));
		paramMap.put("address2", request.getParameter("address2"));
		paramMap.put("maxbooking", request.getParameter("maxbooking"));
		paramMap.put("imageuri1", request.getParameter("imageuri1"));
		paramMap.put("imageuri2", request.getParameter("imageuri2"));
		paramMap.put("imageuri3", request.getParameter("imageuri3"));
		paramMap.put("imageuri4", request.getParameter("imageuri4"));
		paramMap.put("imageuri5", request.getParameter("imageuri5"));
		paramMap.put("open", request.getParameter("open"));
		paramMap.put("closed", request.getParameter("closed"));
		paramMap.put("category", request.getParameter("category"));
		
		paramMap.put("note",
				
				request.getParameter("note")
						
						.replace("\"", "&quot;")
						
						.replace("\'", "&apos;")
						
						.replace("&", "&amp;")
						
						.replace("<", "&lt;")
						
						.replace(">", "&gt;")
						
						.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;")
						
						.replace("\r\n", "<br>")
		
		);
		
		paramMap.put("signed_store_id", login.get("store_id"));
		paramMap.put("signed_store_email", login.get("email"));
		paramMap.put("signed_store_password", login.get("password"));
		
		if (storeDao.do_update(paramMap)) {
			
			HashMap<String, String> store = storeDao.do_login(paramMap);
			
			if (store != null) {
				
				store.put("issonnim", "false");
				
				session.setAttribute("login", store);
				session.setMaxInactiveInterval(30 * 60);
				
				StringBuilder script = new StringBuilder();
				
				script.append("<script src=\"../js/store_script.js\"></script>");
				script.append("<script>");
				script.append("location.href=\"../store/store.jsp\"");
				script.append("</script>");
				
				out.write(script.toString());
				
			} else {
				
				response.sendRedirect("/main/login.jsp");
				
			}
			
		} else {
			
			StringBuilder script = new StringBuilder();
			
			script.append("<script>");
			script.append("alert(\"정보 수정 실패\");");
			script.append("history.back();");
			script.append("</script>");
			
			out.write(script.toString());
			
		}
		
	} else if ("delete".equalsIgnoreCase(action)) {
		
	} else if ("check".equalsIgnoreCase(action)) {
		
		paramMap.put("email", request.getParameter("email"));
		
		JsonObject jsonObject = Json.createObjectBuilder().add("check", storeDao.do_check(paramMap)).build();
		
		out.write(jsonObject.toString());
		
	} else if ("login".equalsIgnoreCase(action)) {
		
		paramMap.put("email", request.getParameter("email"));
		paramMap.put("password", request.getParameter("password"));
		
		HashMap<String, String> store = storeDao.do_login(paramMap);
		
		if (store != null) {
			
			store.put("issonnim", "false");
			
			session.setAttribute("login", store);
			session.setMaxInactiveInterval(30 * 60);
			
			response.sendRedirect("/store/store.jsp");
			
		} else {
			
			StringBuilder script = new StringBuilder();
			
			script.append("<script>");
			script.append("alert(\"이메일과 패스워드를 확인해 주세요.\");");
			script.append("history.back();");
			script.append("</script>");
			
			out.write(script.toString());
			
		}
		
	} else if ("detail".equalsIgnoreCase(action)) {
		
		HashMap<String, String> map = new HashMap<>();
		
		map.put("store_id", store_id);
		
		HashMap<String, String> detailMap = storeDao.do_detail(map);
		
		if (detailMap != null) {
			request.setAttribute("detailMap", detailMap);
			request.setAttribute("store_id", store_id);
			pageContext.forward("store_detail.jsp");
			
		} else {
			System.out.println("목록에 따른 리스트가 없습니다.");
			pageContext.forward("/");
		}
		
	} else if ("logout".equalsIgnoreCase(action)) {
		
		session.invalidate();
		
		response.sendRedirect("/");
		
	} else if ("book".equalsIgnoreCase(action)) {
		
		paramMap.put("bookstate", request.getParameter("bookstate"));
		paramMap.put("no", request.getParameter("no"));
		
		paramMap.put("signed_store_account", "signed_account");
		
		paramMap.put("signed_store_id", login.get("store_id"));
		paramMap.put("signed_store_email", login.get("email"));
		paramMap.put("signed_store_password", login.get("password"));
		
		BookDao bookDao = new BookDao();
		
		JsonObjectBuilder jsonObjectBuilder = Json.createObjectBuilder();
		
		jsonObjectBuilder.add("book", bookDao.do_update(paramMap));
		
		jsonObjectBuilder.add("bookstate", paramMap.get("bookstate"));
		jsonObjectBuilder.add("no", paramMap.get("no"));
		
		out.write(jsonObjectBuilder.build().toString());
		
	} else {
		
		String endUrl = request.getSession().getAttribute("endUrl") == null
				
				? "/" : request.getSession().getAttribute("endUrl").toString();
		
		response.sendRedirect(endUrl);
		
	}
%>
