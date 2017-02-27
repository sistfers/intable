package intable.board.dao;

import java.util.HashMap;

public class HaneulTestMain {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		ReviewDao dao = new ReviewDao();
		
		String sonnim_id = "3";
		String store_id = "9";
		
//		HashMap<String, String> map = new HashMap<String, String>();
		
//		System.out.println(dao.do_starList(1, 5));
		
		System.out.println(dao.reviewStateCheck(sonnim_id, store_id));
		
		
//		map.put("sonnim_id", "100010");
//		map.put("store_id", "900011");
//		map.put("memo", "great");
//		map.put("starpoint", "5");
		
//		map.put("sonnim_id", "100010");
//		map.put("store_id", "900011");
//		
//		System.out.println(dao.do_insert(map));
		
//		System.out.println(dao.do_delete(map));
	}

}
