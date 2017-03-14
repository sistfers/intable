<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="intable.book.dao.BookDao"%>
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
	BookDao bookDao = new BookDao();
	
	HashMap<String, String> map = (HashMap<String, String>)request.getSession().getAttribute("login");
	
	String store_id = request.getParameter("store_id");
	String bookdate = request.getParameter("bookdate");
	String booktime = request.getParameter("booktime");
	String bookperson = request.getParameter("bookperson");
	String note = request.getParameter("note");
	String no = request.getParameter("no");
	int pageSize        = Integer.parseInt(request.getParameter("pageSize")==null?"1":request.getParameter("pageSize"));
	int pageNum         = Integer.parseInt(request.getParameter("pageNum")==null?"4":request.getParameter("pageNum"));
	String search_div   = request.getParameter("search_div")==null?"":request.getParameter("search_div");
	String search_word  = request.getParameter("search_word")==null?"":request.getParameter("search_word");
	String state		= request.getParameter("state")==null?"":request.getParameter("state");
%>

<%
	String action = request.getParameter("action");
	HashMap<String, String> infoMap = (HashMap<String, String>)request.getAttribute("infoMap");	//new HashMap<>();
	
	if("insert".equalsIgnoreCase(action)){
		HashMap<String, String> insertMap = new HashMap<>();
		insertMap.put("sonnim_id", 	map.get("sonnim_id"));
		insertMap.put("store_id", 	store_id);
		insertMap.put("bookdate", 	bookdate);
		insertMap.put("booktime", 	booktime   );
		insertMap.put("bookperson", bookperson );
		insertMap.put("note", 		note       );
		
		if(bookDao.do_insert(insertMap)){
			%>
			<script type="text/javascript">
				if(confirm("예약 되었습니다. 우리 같이 확인하러 가볼까요!?")){
					location.href="../sonnim/sonnim_mypage.jsp";
				}else{
					location.href="/";
				}
			</script>
			<%
		}else{
			throw new Exception("insert exception");
		}
		
	}else if("update".equalsIgnoreCase(action)){
		//업데이트라고 되어있지만 사실상 예약 취소입니다.
// 		pageSize 		= Integer.parseInt(request.getParameter("pageSize"));
// 		pageNum			= Integer.parseInt(request.getParameter("pageNum"));

// 		search_div 	= infoMap.get("searchDiv");
// 		search_word 	= infoMap.get("searchWord");

// 		state 		= infoMap.get("state");
		
		HashMap<String, String> deleteMap = new HashMap<>();
		deleteMap.put("no", no);

		System.out.println("no : " + no);
		if(bookDao.do_update(deleteMap)){
			String endUrl = (String)session.getAttribute("endUrl");
			response.sendRedirect(endUrl);
		}else{
			throw new Exception("book delete exception");
		}
			
	}else if("alllist".equalsIgnoreCase(action)){
		
		ArrayList<HashMap<String, String>> list = bookDao.do_getList(pageNum, pageSize, 
				map.get("sonnim_id"));
		
		if(list != null){
			//리스트 보내야함
			request.setAttribute("list", list);
			for(HashMap<String, String> data : list){
				System.out.println(data.toString());
			}
			//다 들고 마이페이지 예약확인으로 가야함
			infoMap = new HashMap<>();
			infoMap.put("pageSize", pageSize + "");
			infoMap.put("pageNum", pageNum   + "");
			
			request.setAttribute("infoMap", infoMap);
			pageContext.forward("../sonnim/sonnim_mypage.jsp");
		}else{
			throw new Exception("do_getList exception");
		}
	}else if("statelist".equalsIgnoreCase(action)){
// 		String state 		= infoMap.get("state");
// 		int pageSize 		= Integer.parseInt(infoMap.get("pageSize"));
// 		int pageNum			= Integer.parseInt(infoMap.get("pageNum"));
		
		//testcode
		state = "0";
		pageSize = 5;
		pageNum = 1;
		
		ArrayList<HashMap<String, String>> list = bookDao.do_getList(pageNum, pageSize,
				"2000100001", state);//map.get("sonnim_id"));
		
		if(list != null){
			//리스트 보내야함
			request.setAttribute("list", list);
			for(HashMap<String, String> data : list){
				System.out.println(data.toString());
			}
			//다 들고 마이페이지 예약확인으로 가야함
			infoMap = new HashMap<>();
			infoMap.put("pageSize", pageSize+ "");
			infoMap.put("pageNum", pageNum  + "");
			infoMap.put("state", state);
			
			request.setAttribute("infoMap", infoMap);
			//pageContext.forward("mypage_booking.jsp");
		}else{
			throw new Exception("do_getList exception");
		}
	}else if("allsearch".equalsIgnoreCase(action)){
// 		int pageSize 		= Integer.parseInt(infoMap.get("pageSize"));
// 		int pageNum			= Integer.parseInt(infoMap.get("pageNum"));
// 		String search_div 	= infoMap.get("searchDiv");
// 		String search_word 	= infoMap.get("searchWord");
		
		//testcode
		pageSize = 5;
		pageNum = 1;
		search_div = "NAME"; 
		search_word = "먹";
	
		ArrayList<HashMap<String, String>> list = bookDao.do_search(pageNum, pageSize,
				search_div, search_word, "2000100001");//map.get("sonnim_id"));
	
		if(list != null){
			//리스트 보내야함
			request.setAttribute("list", list);
			for(HashMap<String, String> data : list){
				System.out.println(data.toString());
			}
			//다 들고 마이페이지 예약확인으로 가야함
			//what I need
			infoMap = new HashMap<>();
			infoMap.put("pageSize", ""+pageSize);
			infoMap.put("pageNum", ""+pageNum);
			infoMap.put("search_div", search_div);
			infoMap.put("search_word", search_word);
			
			request.setAttribute("infoMap", infoMap);
			//pageContext.forward("mypage_booking.jsp");
		}else{
			throw new Exception("do_search exception");
		}
	}else if("statesearch".equalsIgnoreCase(action)){
// 		String state 		= infoMap.get("state");
// 		int pageSize 		= Integer.parseInt(infoMap.get("pageSize"));
// 		int pageNum			= Integer.parseInt(infoMap.get("pageNum"));
// 		String search_div 	= infoMap.get("searchDiv");
// 		String search_word 	= infoMap.get("searchWord");
		
			//testcode
			state = "0";
			pageSize = 5;
			pageNum = 1;
			search_div = "NAME"; 
			search_word = "먹";
		
			ArrayList<HashMap<String, String>> list = bookDao.do_search(pageNum, pageSize, 
					search_div, search_word, "2000100001", state);//map.get("sonnim_id"));
		
			if(list != null){
				//리스트 보내야함
				request.setAttribute("list", list);
				for(HashMap<String, String> data : list){
					System.out.println(data.toString());
				}
				//다 들고 마이페이지 예약확인으로 가야함
				//what I need
				infoMap = new HashMap<>();
				infoMap.put("pageSize", ""+pageSize);
				infoMap.put("pageNum", ""+pageNum);
				infoMap.put("search_div", search_div);
				infoMap.put("search_word", search_word);
				infoMap.put("state", state);								
				
				request.setAttribute("infoMap", infoMap);
				//pageContext.forward("mypage_booking.jsp");
			}else{
				throw new Exception("do_stateSearch exception");
			}
	}else{
		throw new Exception("action Error");
	}
%>
