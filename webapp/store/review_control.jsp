<%@page import="intable.board.dao.ReviewDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>  
    
<%
	ReviewDao dao = new ReviewDao();

	System.out.println("Review_Control진입.");

	String store_id = request.getParameter("store_id").trim();
	
	System.out.println("store_id 1." + store_id);
	
	String sonnim_id = request.getParameter("sonnim_id").trim();
	
	System.out.println("sonnim_id 1." + sonnim_id);

	String memo = "";
	memo = request.getParameter("memo");
	System.out.println("memo" + memo);
	
	String starPoint = "";
	starPoint = (String)request.getParameter("starPoint");
	System.out.println("starPoint" + starPoint);

%>

<%
	String action = request.getParameter("action");

// 리뷰 작성 ===================================================
if ("insert".equalsIgnoreCase(action)) {
	
	// 작성권한 체크
	
	boolean check = dao.reviewStateCheck(sonnim_id, store_id);
	
	System.out.println("check" + check);
	
	String endUrl = (String)session.getAttribute("endUrl");
	StringBuilder script = new StringBuilder();
	
	if(check){
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("sonnim_id", sonnim_id);
		map.put("store_id", store_id);
		map.put("memo", memo);
		map.put("starpoint", starPoint);
		
		boolean insertCheck = dao.do_insert(map);
		
		System.out.println("insertCheck" + insertCheck);
		
		if(insertCheck){
			
	        script.append("<script>");
	        script.append("window.alert('리뷰가 등록되었습니다.');");
	        script.append("location.href = '"+endUrl+"';");
	        script.append("</script>");
	        out.write(script.toString());
			
		}else{
			
	        script.append("<script>");
	        script.append("window.alert('해당 업체에 이미 리뷰를 작성하셨습니다.');");
	        script.append("location.href = '"+endUrl+"';");
	        script.append("</script>");
	        out.write(script.toString());
		}
	}else{
		System.out.println("안됐을경우.");

		script.append("<script>");
        script.append("window.alert('해당 업체를 이용하신 적이 없습니다.');");
        script.append("location.href = '"+endUrl+"';");
        script.append("</script>");
        out.write(script.toString());
	}
// 삭제 ============================================
}else if("delete".equalsIgnoreCase(action)){
	
	HashMap<String, String> delMap = new HashMap<String, String>();
	System.out.println("여기는오니?");
	
	delMap.put("sonnim_id", sonnim_id);
	delMap.put("store_id", store_id);
	
	boolean delCheck = dao.do_delete(delMap);
	
	System.out.println("delCheck" + delCheck);
	
	String endUrl = (String)session.getAttribute("endUrl");
	StringBuilder script = new StringBuilder();
	
	if(delCheck){

        script.append("<script>");
        script.append("window.alert('리뷰가 삭제되었습니다.');");
        script.append("location.href = '"+endUrl+"';");
        script.append("</script>");
        out.write(script.toString());

	}else{
        script.append("<script>");
        script.append("window.alert('본인이 작성한 리뷰가 아닙니다.');");
        script.append("location.href = '"+endUrl+"';");
        script.append("</script>");
        out.write(script.toString());
	}
}

%>
