package intable.store.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class StoreDaoTest {
	
	public static void main(String[] args) {
		
		StoreDaoTest storeDaoTest = new StoreDaoTest();
		
		//		storeDaoTest.do_searchTest();
		//		storeDaoTest.do_detailTest();
		//		storeDaoTest.do_insertTest();
		//		storeDaoTest.do_updateTest();
		//		storeDaoTest.do_deleteTest();
		//		storeDaoTest.do_upsertTest();
		//		storeDaoTest.do_checkTest();
		storeDaoTest.do_loginTest();
		//		storeDaoTest.do_bookTest();
		//		storeDaoTest.do_selectTest();
		//storeDaoTest.dataTypeTest();
		
	}
	
	private void dataTypeTest() {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			String driver = "oracle.jdbc.OracleDriver";
			
			String url = "jdbc:oracle:thin:@magoon.co.kr:1521:sist";
			String user = "sky";
			String password = "sky";
			
			String sql = "SELECT store.* FROM STORE WHERE store_id = ?";
			
			Class.forName(driver);
			connection = DriverManager.getConnection(url, user, password);
			preparedStatement = connection.prepareStatement(sql);
			
			//preparedStatement.setString(1, null);
			//preparedStatement.setInt(1, 1000000008); // 성공
			preparedStatement.setString(1, "1000000008");
			
			resultSet = preparedStatement.executeQuery();
			
			System.out.println(connection);
			System.out.println(preparedStatement);
			System.out.println(resultSet);
			System.out.println(sql);
			
			StringBuilder stringBuilder = new StringBuilder();
			
			stringBuilder.append(resultSet + "\r\n");
			
			while (resultSet.next()) {
				
				for (int i = 1; i < resultSet.getMetaData().getColumnCount(); i++) {
					
					stringBuilder.append(resultSet.getMetaData().getColumnName(i));
					stringBuilder.append(": ");
					stringBuilder.append(resultSet.getString(resultSet.getMetaData().getColumnName(i)));
				}
				
				stringBuilder.append("\r\n");
			}
			
			System.out.println(stringBuilder);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (preparedStatement != null) {
						preparedStatement.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if (connection != null) {
							connection.close();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	private void do_searchTest() {
		
		int pageNum = 1;
		int pageSize = 10;
		String search_div = "";
		String search_word = "";
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("store_id", "1000000010");
		map.put("bookstate", "1");
		map.put("from", "2016-10-31");
		map.put("to", "2017-04-20");
		map.put("query", "마제오");
		map.put("size", "20");
		map.put("page", "1");
		
		StoreDao storeDao = new StoreDao();
		
		ArrayList<HashMap<String, String>> results = storeDao.do_search(pageNum, pageSize, search_div, search_word);
		
		StringBuilder stringBuilder = new StringBuilder();
		
		Iterator<HashMap<String, String>> iterator = results.iterator();
		
		while (iterator.hasNext()) {
			
			HashMap<String, String> result = iterator.next();
			
			Set<String> keySet = result.keySet();
			
			Iterator<String> keySetIterator = keySet.iterator();
			
			while (keySetIterator.hasNext()) {
				
				String key = keySetIterator.next();
				
				stringBuilder.append(key);
				stringBuilder.append(": ");
				stringBuilder.append(result.get(key));
				stringBuilder.append("\t");
			}
			stringBuilder.append("\r\n");
		}
		
		System.out.println(stringBuilder);
	}
	
	private void do_detailTest() {
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		StoreDao storeDao = new StoreDao();
		
		System.out.println(storeDao.do_detail(map));
	}
	
	private void do_insertTest() {
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		param.put("email", "magoon85@me.com");
		param.put("password", "magoon85");
		param.put("phone", "010-9658-9116");
		param.put("name", "마제오");
		param.put("zonecode", "04100");
		param.put("sido", "서울");
		param.put("sigungu", "마포구");
		param.put("address1", "서울 마포구 백범로 18");
		param.put("address2", "미화빌딩 2, 3층");
		param.put("maxbooking", "15");
		param.put("imageuri1", "/image/magoon85@me.com.1.png");
		param.put("imageuri2", "/image/magoon85@me.com.2.png");
		param.put("imageuri3", "/image/magoon85@me.com.3.png");
		param.put("imageuri4", "/image/magoon85@me.com.4.png");
		param.put("imageuri5", "/image/magoon85@me.com.5.png");
		param.put("open", "9");
		param.put("closed", "20");
		param.put("category", "빵식");
		param.put("note", "좋아요<br>좋습니다<br>좋다구요");
		param.put("signed_store_id", "999999999");
		param.put("signed_store_email", "magoon85@me.com");
		param.put("signed_store_password", "magoon85");
		
		StoreDao storeDao = new StoreDao();
		
		System.out.println("StoreDaoTest.do_insertTest(): " + storeDao.do_insert(param));
	}
	
	private void do_updateTest() {
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		param.put("email", "magoon85@me.com");
		param.put("password", "magoon85");
		param.put("phone", "010-9658-9116");
		param.put("name", "마제오");
		param.put("zonecode", "04100");
		param.put("sido", "서울");
		param.put("sigungu", "마포구");
		param.put("address1", "서울 마포구 백범로 18");
		param.put("address2", "미화빌딩 2, 3층");
		param.put("maxbooking", "15");
		param.put("imageuri1", "/image/magoon85@me.com.1.png");
		param.put("imageuri2", "/image/magoon85@me.com.2.png");
		param.put("imageuri3", "/image/magoon85@me.com.3.png");
		param.put("imageuri4", "/image/magoon85@me.com.4.png");
		param.put("imageuri5", "/image/magoon85@me.com.5.png");
		param.put("open", "9");
		param.put("closed", "20");
		param.put("category", "빵식");
		param.put("note", "좋아요<br>좋습니다<br>좋다구요");
		param.put("signed_store_id", "999999999");
		param.put("signed_store_email", "magoon85@me.com");
		param.put("signed_store_password", "magoon85");
		
		StoreDao storeDao = new StoreDao();
		
		System.out.println("StoreDaoTest.do_updateTest(): " + storeDao.do_update(param));
	}
	
	private void do_deleteTest() {
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		//		map.put("email", "magoon85@me.com");
		//		map.put("password", "magoon85");
		//		map.put("phone", "010-9658-9116");
		//		map.put("name", "마제오");
		//		map.put("zonecode", "04100");
		//		map.put("sido", "서울");
		//		map.put("sigungu", "마포구");
		//		map.put("address1", "서울 마포구 백범로 18");
		//		map.put("address2", "미화빌딩 2, 3층");
		//		map.put("maxbooking", "15");
		//		map.put("imageuri1", "/image/magoon85@me.com.1.png");
		//		map.put("imageuri2", "/image/magoon85@me.com.2.png");
		//		map.put("imageuri3", "/image/magoon85@me.com.3.png");
		//		map.put("imageuri4", "/image/magoon85@me.com.4.png");
		//		map.put("imageuri5", "/image/magoon85@me.com.5.png");
		//		map.put("open", "9");
		//		map.put("closed", "20");
		//		map.put("category", "빵식");
		//		map.put("note", "좋아요<br>좋습니다<br>좋다구요");
		param.put("signed_store_id", "999999999");
		param.put("signed_store_email", "magoon85@me.com");
		param.put("signed_store_password", "magoon85");
		
		StoreDao storeDao = new StoreDao();
		
		System.out.println("StoreDaoTest.do_deleteTest(): " + storeDao.do_delete(param));
	}
	
	private void do_upsertTest() {
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		param.put("email", "magoon85@me.com");
		param.put("password", "magoon85");
		param.put("phone", "010-9658-9116");
		param.put("name", "마제오");
		param.put("zonecode", "04100");
		param.put("sido", "서울");
		param.put("sigungu", "마포구");
		param.put("address1", "서울 마포구 백범로 18");
		param.put("address2", "미화빌딩 2, 3층");
		param.put("maxbooking", "15");
		param.put("imageuri1", "/image/magoon85@me.com.1.png");
		param.put("imageuri2", "/image/magoon85@me.com.2.png");
		param.put("imageuri3", "/image/magoon85@me.com.3.png");
		param.put("imageuri4", "/image/magoon85@me.com.4.png");
		param.put("imageuri5", "/image/magoon85@me.com.5.png");
		param.put("open", "9");
		param.put("closed", "20");
		param.put("category", "빵식");
		param.put("note", "좋아요<br>좋습니다<br>좋다구요");
		param.put("signed_store_id", "999999999");
		param.put("signed_store_email", "magoon85@me.com");
		param.put("signed_store_password", "magoon85");
		
		StoreDao storeDao = new StoreDao();
		
		System.out.println("StoreDaoTest.do_upsertTest(): " + storeDao.do_upsert(param));
	}
	
	public void do_checkTest() {
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		param.put("email", "magoon85@me.com");
		
		StoreDao storeDao = new StoreDao();
		
		System.out.println("StoreDaoTest.do_checkTest(): " + storeDao.do_check(param));
	}
	
	public void do_loginTest() {
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		param.put("email", "magoon85@me.com");
		param.put("password", "magoon85");
		
		StoreDao storeDao = new StoreDao();
		
		System.out.println("StoreDaoTest.do_loginTest(): " + storeDao.do_login(param));
	}
	
	private void do_bookTest() {
		
		int pageNum = 1;
		int pageSize = 10;
		String search_div = "";
		String search_word = "";
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		param.put("store_id", "1000000010");
		//map.put("bookstate", "1");
		//map.put("from", "2016-10-31");
		//map.put("to", "2017-04-20");
		//map.put("query", "마제오");
		//map.put("size", "20");
		//map.put("page", "1");
		
		StoreDao storeDao = new StoreDao();
		
		ArrayList<HashMap<String, String>> results = storeDao.do_book(param);
		
		StringBuilder stringBuilder = new StringBuilder();
		
		Iterator<HashMap<String, String>> iterator = results.iterator();
		
		while (iterator.hasNext()) {
			
			HashMap<String, String> result = iterator.next();
			
			Set<String> keySet = result.keySet();
			
			Iterator<String> keySetIterator = keySet.iterator();
			
			while (keySetIterator.hasNext()) {
				
				String key = keySetIterator.next();
				
				stringBuilder.append(key);
				stringBuilder.append(": ");
				stringBuilder.append(result.get(key));
				stringBuilder.append("\t");
			}
			stringBuilder.append("\r\n");
		}
		
		System.out.println(stringBuilder);
	}
	
	private void do_selectTest() {
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		//		param.put("store_id", "1000000141");
		//		param.put("email", "magoon85@me.com");
		//		param.put("password", "magoon85");
		
		StoreDao storeDao = new StoreDao();
		
		System.out.println("StoreDaoTest.do_selectTest(): " + storeDao.do_login(param));
	}
	
}
