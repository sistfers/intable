<%@page import="intable.sonnim.dao.HeartDao"%>
<%@page import="intable.sonnim.dao.SonnimDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>     

<%
	// 입력값 받아오기
	String store_id = request.getParameter("store_id");
	
	System.out.println("store_id 1." + store_id);
	
	HashMap<String, String> sonnimMap =
			(HashMap<String, String>)request.getSession().getAttribute("login");
	
	String sonnim_id = "";
	
	if(sonnimMap != null){
		
		sonnim_id = sonnimMap.get("sonnim_id");
	}
	
	System.out.println("sonnim_id 1." + sonnim_id);
	
	HashMap<String, String> data = new HashMap<>();
	
	data.put("store_id", store_id);
	data.put("sonnim_id", sonnim_id);
%>


<%
	HeartDao dao = new HeartDao();

	String action = request.getParameter("action");
	
	System.out.println("action2 : " + action);
	
	String endUrl = (String)session.getAttribute("endUrl");
	StringBuilder script = new StringBuilder();

	String str = null;
	int check = 0;
	
	check = dao.do_heartCount(store_id);
	
	// 하트추가 	=========================================================================================================
	if ("heartInsert".equalsIgnoreCase(action)) {
		System.out.println("추가에 들어왔어요");
		
		if(sonnim_id == null || sonnim_id.equals("")){
			str = "NotLogin";	
			out.println(str + "/" + check);

		}
		
		boolean heartInsert = dao.do_insert(data);
		
		if(heartInsert){
			str = "InsertOk";
			check = dao.do_heartCount(store_id);
			
			out.println(str + "/" + check);
// 			out.println(check);
		}else{
			str = "InsertFail";
			out.println(str + "/" + check);
		}
	
	// 하트삭제 	=======================================================================================================		
		
	} else if ("heartDelete".equalsIgnoreCase(action)) {
		System.out.println("delete에 들어왔어요");
		
		boolean heartDelete = dao.do_delete(data);
		
		if(heartDelete){
			
			str = "DeleteOk";
			check = dao.do_heartCount(store_id);

// 			out.println(str);
			out.println(str + "/" + check);
// 			out.println(check);
			
		}else{
			str = "DeleteFail";
// 			out.println(str);
			out.println(str + "/" + check);
		}	
		
		
	} else {
		throw new Exception("action Error");
	}
%>
