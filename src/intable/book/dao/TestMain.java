package intable.book.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class TestMain {
	public static void main(String[] args) {
		BookDao bookDAO = new BookDao();
		HashMap<String, String> map = new HashMap<>();
//		//insert test
//		map.put("sonnimId", "100007");
//		map.put("storeId", "900015");
//		map.put("bookDate", "2017/02/24");
//		map.put("bookTime", "16");
//		map.put("bookPerson", "3");
//		map.put("note", "부디 최고의 메뉴를 준비해주세요");
//									//(sonnimId, storeId, bookdate, booktime, bookperson, note)
//		boolean result = bookDAO.do_insert(map);
//		System.out.println(result);
//		System.out.println("---------------------------------------------------------------------");
//		
//		//update bookstate test
//		map = new HashMap<>();
//		map.put("no", "26");
//		boolean updateResult = bookDAO.do_update(map);
//		System.out.println("updateResult : " + updateResult);
//		System.out.println("---------------------------------------------------------------------");
//		
//		//예약 상태 갯수들 불러오기
//		HashMap<String, String> sonnim = new HashMap<>();
//		sonnim.put("sonnimId", "100001");
//		
//		List<Integer> list = bookDAO.do_getStateCount(sonnim);
//		int number = 1;
//		
//		for (Integer integer : list) {
//			System.out.println(number++ + " :"
//					+ " " + integer);
//		}
//		
//		System.out.println("---------------------------------------------------------------------");

//		//do_getList
//		ArrayList<HashMap<String, String>> wholeBook = bookDAO.do_getList(1, 10, "100001");
//		
//		for (HashMap<String, String> hashMap : wholeBook) {
//			System.out.println(hashMap.toString());
//		}
		
		
//		//do_getList_state
//		ArrayList<HashMap<String, String>> stateBook = bookDAO.do_getList(1, 5, "100005", "0");
//		
//		for (HashMap<String, String> hashMap : stateBook) {
//			System.out.println(hashMap.toString());
//		}
		
//		//do_search
//		ArrayList<HashMap<String, String>> wholeSearch = bookDAO.do_search(1, 5, "NAME", "먹", "100001");
//		
//		for (HashMap<String, String> hashMap : wholeSearch) {
//			System.out.println(hashMap.toString());
//		}
		
		//do_search state
		ArrayList<HashMap<String, String>> wholeSearch = bookDAO.do_search(1, 5, "NAME", "먹", "100", "1");
		
		for (HashMap<String, String> hashMap : wholeSearch) {
			System.out.println(hashMap.toString());
		}
	}
}
