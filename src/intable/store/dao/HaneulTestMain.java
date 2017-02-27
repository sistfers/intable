package intable.store.dao;

import java.util.HashMap;

public class HaneulTestMain {

	public static void main(String[] args) {
		
		
		StoreDao dao = new StoreDao();
		
		HashMap<String, String> map = new HashMap<>();
		
//		map.put("store_id", "900019");
		
//		System.out.println(dao.do_detail(map));
		
//		System.out.println(dao.do_bestList());
		
		System.out.println(dao.do_search(1, 6, "NAME", "봉구"));

	}

}
