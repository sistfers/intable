package intable.store.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import intable.abstracts.WorkArea;

/**
 * 음식점_Dao
 * 
 * @author magoon
 *
 */
public class StoreDao implements WorkArea {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String jdbc_driver = "oracle.jdbc.OracleDriver";
	private String jdbc_url = "jdbc:oracle:thin:@magoon.co.kr:1521:sist";
	
	private void connect() {
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "sky", "sky");
			//conn = ((javax.sql.DataSource) (new javax.naming.InitialContext()).lookup("java:/comp/env/jdbc/orcl")).getConnection();
		} catch (Exception e) {
			System.out.println("connect(): " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	private void disConnect() {
		
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			System.out.println("disConnect(): rs.close() " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				System.out.println("disConnect(): pstmt.close() " + e.getMessage());
				e.printStackTrace();
			} finally {
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (Exception e) {
					System.out.println("disConnect(): conn.close() " + e.getMessage());
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * 베스트 추천업체 4개.
	 * 
	 * @return list
	 */
	public ArrayList<HashMap<String, String>> do_bestList() {
		
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		try {
			connect();
			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
			
			// sql 작성
				
			sql.append("	SELECT TT1.RNUM,                           ");
			sql.append("	  TT1.STORE_ID,                            ");
			sql.append("	  TT1.NAME,                                ");
			sql.append("	  TT1.imageuri1                            ");
			sql.append("	FROM                                       ");
			sql.append("	  (SELECT ROWNUM AS RNUM,                  ");
			sql.append("	    T1.*                                   ");
			sql.append("	  FROM                                     ");
			sql.append("	    (SELECT SUM(starpoint) AS starpoint,   ");
			sql.append("	      s.store_id,                          ");
			sql.append("	      s.name,                              ");
			sql.append("	      s.imageuri1                          ");
			sql.append("	    FROM review r                          ");
			sql.append("	    INNER JOIN store s                     ");
			sql.append("	    ON r.store_id = s.store_id             ");
			sql.append("	    GROUP BY s.store_id,                   ");
			sql.append("	      s.name,                              ");
			sql.append("	      s.imageuri1                          ");
			sql.append("	    ORDER BY starpoint DESC                ");
			sql.append("	    ) T1                                   ");
			sql.append("	  )TT1                                     ");
			sql.append("	WHERE RNUM < 5                             ");

//			// 관리자 제거 @author magoon 시작
//			sql.append("  WHERE store_id > 999999999                                ");
//			// 관리자 제거 @author magoon 끝
//			
//			sql.append("  ORDER BY                                                  ");
//			sql.append("    (SELECT SUM(STARPOINT) FROM REVIEW                      ");
//			sql.append("    ) DESC                                                  ");
//			sql.append("  ) B                                                       ");
//			sql.append("WHERE RNUM < " + 5);
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			// parameter 입력
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				data = new HashMap<String, String>();
				// 쿼리 결과 저장
				data.put("RNUM", rs.getString("RNUM"));
				data.put("store_id", rs.getString("store_id"));
				data.put("name", rs.getString("name"));
				data.put("IMAGEURI1", rs.getString("IMAGEURI1"));
				
				selected_list.add(data);
			}
			System.out.println("반환o");
			return selected_list;
			
		} catch (Exception e) {
			System.out.println("do_search() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		System.out.println("반환x");
		return null;
	}
	
	/**
	 * 
	 * @param pageNum
	 * @param pageSize
	 * @param search_div
	 * @param search_word
	 * @return
	 */
	@Override
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		StringBuilder sqlParam = new StringBuilder();
		
		// 관리자 제거 @author magoon 시작
		sqlParam.append("  WHERE store_id > 999999999                                ");
		if (search_div.equals("NAME")) {
			sqlParam.append("  And name like '" + search_word + "%' \n");
			// sqlParam.append("WHERE name like '" + search_word + "%' \n");
		} else if (search_div.equals("CATEGORY")) {
			sqlParam.append("  And category like '" + search_word + "%' \n");
			// sqlParam.append("WHERE category like '" + search_word + "%' \n");
		} else if (search_div.equals("ADDRESS1")) {
			sqlParam.append("  And address1 like '" + search_word + "%' \n");
			// sqlParam.append("WHERE address1 like '" + search_word + "%' \n");
		} else {
			sqlParam.append("");
		}
		//		if (search_div.equals("NAME")) {
		//			//			sqlParam.append("And name like '" + search_word + "%' \n");
		//			sqlParam.append("WHERE name like '" + search_word + "%' \n");
		//		} else if (search_div.equals("CATEGORY")) {
		//			//			sqlParam.append("And category like '" + search_word + "%' \n");
		//			sqlParam.append("WHERE category like '" + search_word + "%' \n");
		//		} else if (search_div.equals("ADDRESS1")) {
		//			//			sqlParam.append("And sido like '" + search_word + "%' \n");
		//			sqlParam.append("WHERE address1 like '" + search_word + "%' \n");
		//		} else {
		//			sqlParam.append("");
		//		}
		// 관리자 제거 @author magoon 끝
		
		try {
			connect();
			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
			
			// sql 작성
			
			//			sql.append(" SELECT ROWNUM,                                          ");
			//			sql.append("   TT1.store_id,                                         ");
			//			sql.append("   TT1.name,                                             ");
			//			sql.append("   TT1.IMAGEURI1,                                        ");
			//			sql.append("   TOT_CNT,                                              ");
			//			sql.append("   RNUM	                                                 ");
			sql.append(" SELECT  TT1.*                                        \n ");
			sql.append(" FROM (		                                          \n ");
			sql.append("   SELECT                               	   		  \n ");
			sql.append("     ROWNUM AS RNUM,                           		  \n ");
			sql.append("     T1.*,                                            \n ");
			sql.append("     T2.*                                             \n ");
			sql.append("   FROM                                               \n ");
			sql.append("     ( SELECT * 									  \n ");
			sql.append("     	FROM store       							  \n ");
			//검색
			sql.append(sqlParam.toString());
			sql.append("   		ORDER BY NAME ASC							  \n ");
			sql.append("     )T1 NATURAL                                      \n ");
			sql.append("   JOIN                                               \n ");
			sql.append("     ( SELECT COUNT(*) TOT_CNT FROM store             \n ");
			//검색
			sql.append(sqlParam.toString());
			sql.append("     )T2                                                 ");
			sql.append("   )TT1                                                  ");
			sql.append("   WHERE RNUM BETWEEN (? * (?-1)+1) AND ((? * (?-1))+? ) ");
			
			System.out.println("sqlParam.toString(): " + sqlParam.toString());
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			// pstmt 인자값 채우기
			pstmt.setInt(1, pageSize);
			pstmt.setInt(2, pageNum);
			pstmt.setInt(3, pageSize);
			pstmt.setInt(4, pageNum);
			pstmt.setInt(5, pageSize);
			
			System.out.println("rs1");
			
			// parameter 입력
			rs = pstmt.executeQuery();
			System.out.println("rs2");
			
			while (rs.next()) {
				
				data = new HashMap<String, String>();
				
				System.out.println("ROWNUM" + rs.getString("RNUM"));
				System.out.println("TOT_CNT" + rs.getString("TOT_CNT"));
				// 쿼리 결과 저장
				data.put("TOT_CNT", rs.getString("TOT_CNT"));
				data.put("ROWNUM", rs.getString("RNUM"));
				data.put("store_id", rs.getString("store_id"));
				data.put("name", rs.getString("name"));
				data.put("IMAGEURI1", rs.getString("IMAGEURI1"));
				
				selected_list.add(data);
			}
			return selected_list;
			
		} catch (Exception e) {
			System.out.println("do_search() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return null;
	}
	
	@Override
	public HashMap<String, String> do_detail(HashMap<String, String> map) {
		
		HashMap<String, String> data = null;
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// sql 작성
			sql.append("SELECT STORE_ID,  ");
			sql.append("  EMAIL,          ");
			sql.append("  PASSWORD,       ");
			sql.append("  PHONE,          ");
			sql.append("  NAME,           ");
			sql.append("  ZONECODE,       ");
			sql.append("  SIDO,           ");
			sql.append("  SIGUNGU,        ");
			sql.append("  ADDRESS1,       ");
			sql.append("  ADDRESS2,       ");
			sql.append("  MAXBOOKING,     ");
			sql.append("  IMAGEURI1,      ");
			sql.append("  IMAGEURI2,      ");
			sql.append("  IMAGEURI3,      ");
			sql.append("  IMAGEURI4,      ");
			sql.append("  IMAGEURI5,      ");
			sql.append("  OPEN,           ");
			sql.append("  CLOSED,         ");
			sql.append("  CATEGORY,       ");
			sql.append("  NOTE            ");
			sql.append("FROM store        ");
			sql.append("WHERE store_id = ?");
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, map.get("store_id"));
			
			// parameter 입력
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				data = new HashMap<String, String>();
				
				// 쿼리 결과 저장
				data.put("store_id", rs.getString(1));
				data.put("email", rs.getString(2));
				data.put("password", rs.getString(3));
				data.put("phone", rs.getString(4));
				data.put("name", rs.getString(5));
				data.put("zonecode", rs.getString(6));
				data.put("sido", rs.getString(7));
				data.put("sigungu", rs.getString(8));
				data.put("address1", rs.getString(9));
				data.put("address2", rs.getString(10));
				data.put("maxbooking", rs.getString(11));
				data.put("imageuri1", rs.getString(12));
				data.put("imageuri2", rs.getString(13));
				data.put("imageuri3", rs.getString(14));
				data.put("imageuri4", rs.getString(15));
				data.put("imageuri5", rs.getString(16));
				data.put("open", rs.getString(17));
				data.put("closed", rs.getString(18));
				data.put("category", rs.getString(19));
				data.put("note", rs.getString(20));
			}
			
			return data;
			
		} catch (Exception e) {
			System.out.println("do_detail() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return null;
	}
	
	@Override
	public boolean do_insert(HashMap<String, String> paramMap) {
		
		paramMap.put("signed_store_account", "signed_account");
		
		return merge(paramMap);
	}
	
	@Override
	public boolean do_update(HashMap<String, String> paramMap) {
		
		paramMap.put("signed_store_account", "signed_account");
		
		return merge(paramMap);
	}
	
	@Override
	public boolean do_delete(HashMap<String, String> paramMap) {
		
		paramMap.put("signed_store_account", "dismiss_account");
		
		return merge(paramMap);
	}
	
	@Override
	public boolean do_upsert(HashMap<String, String> paramMap) {
		
		paramMap.put("signed_store_account", "signed_account");
		
		return merge(paramMap);
	}
	
	public boolean do_check(HashMap<String, String> paramMap) {
		
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		try {
			
			connect();
			
			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("		SELECT           \r\n");
			sql.append("			*            \r\n");
			sql.append("		FROM             \r\n");
			sql.append("			store        \r\n");
			sql.append("		WHERE            \r\n");
			sql.append("			email = ?    \r\n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("StoreDao.do_check() sql: ");
			System.out.println(sql.toString());
			
			System.out.println("StoreDao.do_check() paramMap: " + paramMap);
			
			pstmt.setString(1, paramMap.get("email"));
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				System.out.println("StoreDao.do_check() rs.getRow(): " + rs.getRow());
				
				data = new HashMap<String, String>();
				
				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					
					data.put(rs.getMetaData().getColumnName(i).toLowerCase(),
							
							rs.getString(rs.getMetaData().getColumnName(i)));
				}
				
				selected_list.add(data);
			}
			
			// 이거 좀 위험하다 나중에 바꾸자
			
			return (selected_list.size() == 0);
			
		} catch (Exception e) {
			System.out.println("StoreDao.do_check(): " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}
	
	public HashMap<String, String> do_login(HashMap<String, String> paramMap) {
		
		String email = paramMap.get("email");
		String password = paramMap.get("password");
		
		if (email == null || email.equals("")) {
			
			return null;
		}
		
		if (password == null || password.equals("")) {
			
			return null;
		}
		
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		try {
			
			connect();
			
			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("		SELECT              \r\n");
			sql.append("			*               \r\n");
			sql.append("		FROM                \r\n");
			sql.append("			store           \r\n");
			sql.append("		WHERE               \r\n");
			sql.append("			email = ?       \r\n");
			sql.append("			AND             \r\n");
			sql.append("			password = ?    \r\n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("StoreDao.do_login() sql: ");
			System.out.println(sql.toString());
			
			System.out.println("StoreDao.do_login() paramMap: " + paramMap);
			
			pstmt.setString(1, paramMap.get("email"));
			pstmt.setString(2, paramMap.get("password"));
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				System.out.println("StoreDao.do_login() rs.getRow(): " + rs.getRow());
				
				data = new HashMap<String, String>();
				
				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					
					data.put(rs.getMetaData().getColumnName(i).toLowerCase(),
							
							rs.getString(rs.getMetaData().getColumnName(i)));
					
				}
				
				selected_list.add(data);
			}
			
			return ((selected_list.size() != 1) ? null : selected_list.get(0));
			
		} catch (Exception e) {
			System.out.println("StoreDao.do_login(): " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return null;
	}
	
	ArrayList<HashMap<String, String>> select(HashMap<String, String> paramMap) {
		
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		try {
			
			connect();
			
			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("SELECT * FROM store WHERE store_id = ? AND");
			
			sql.append("		SELECT              \r\n");
			sql.append("			*               \r\n");
			sql.append("		FROM                \r\n");
			sql.append("			store           \r\n");
			sql.append("		WHERE               \r\n");
			sql.append("			store_id = ?    \r\n");
			sql.append("			AND             \r\n");
			sql.append("			email = ?       \r\n");
			sql.append("			AND             \r\n");
			sql.append("			password = ?    \r\n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("StoreDao.select() sql: ");
			System.out.println(sql.toString());
			
			System.out.println("StoreDao.select() paramMap: " + paramMap);
			
			int store_id = -1;
			
			try {
				store_id = Integer.parseInt(paramMap.get("store_id"));
			} catch (Exception e) {
				System.out.println("StoreDao.select() paramMap.get(\"store_id\"): " + paramMap.get("store_id") + ", " + e.getMessage());
				e.printStackTrace();
			}
			
			pstmt.setInt(1, store_id);
			
			pstmt.setString(2, paramMap.get("email"));
			pstmt.setString(3, paramMap.get("password"));
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				System.out.println("StoreDao.select() rs.getRow(): " + rs.getRow());
				
				data = new HashMap<String, String>();
				
				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					
					data.put(rs.getMetaData().getColumnName(i).toLowerCase(),
							
							rs.getString(rs.getMetaData().getColumnName(i)));
				}
				
				selected_list.add(data);
			}
			
			return ((selected_list.size() != 1) ? null : selected_list);
			
		} catch (Exception e) {
			System.out.println("StoreDao.select(): " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return null;
	}
	
	private boolean merge(HashMap<String, String> paramMap) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("	MERGE INTO                                                     \r\n");
			sql.append("		store t                                                    \r\n");
			sql.append("	USING                                                          \r\n");
			sql.append("		(                                                          \r\n");
			sql.append("			SELECT                                                 \r\n");
			sql.append("				new_store.*,                                       \r\n");
			sql.append("				old_store.email AS old_email,                      \r\n");
			sql.append("				old_store.password AS old_password,                \r\n");
			sql.append("				old_store.phone AS old_phone,                      \r\n");
			sql.append("				old_store.name AS old_name,                        \r\n");
			sql.append("				old_store.zonecode AS old_zonecode,                \r\n");
			sql.append("				old_store.sido AS old_sido,                        \r\n");
			sql.append("				old_store.sigungu AS old_sigungu,                  \r\n");
			sql.append("				old_store.address1 AS old_address1,                \r\n");
			sql.append("				old_store.address2 AS old_address2,                \r\n");
			sql.append("				old_store.maxbooking AS old_maxbooking,            \r\n");
			sql.append("				old_store.imageuri1 AS old_imageuri1,              \r\n");
			sql.append("				old_store.imageuri2 AS old_imageuri2,              \r\n");
			sql.append("				old_store.imageuri3 AS old_imageuri3,              \r\n");
			sql.append("				old_store.imageuri4 AS old_imageuri4,              \r\n");
			sql.append("				old_store.imageuri5 AS old_imageuri5,              \r\n");
			sql.append("				old_store.open AS old_open,                        \r\n");
			sql.append("				old_store.closed AS old_closed,                    \r\n");
			sql.append("				old_store.category AS old_category,                \r\n");
			sql.append("				old_store.note AS old_note                         \r\n");
			sql.append("			FROM                                                   \r\n");
			sql.append("				(                                                  \r\n");
			sql.append("					SELECT                                         \r\n");
			sql.append("						? AS email,                                \r\n"); // 1
			sql.append("						? AS password,                             \r\n"); // 2
			sql.append("						? AS phone,                                \r\n"); // 3
			sql.append("						? AS name,                                 \r\n"); // 4
			sql.append("						? AS zonecode,                             \r\n"); // 5
			sql.append("						? AS sido,                                 \r\n"); // 6
			sql.append("						? AS sigungu,                              \r\n"); // 7
			sql.append("						? AS address1,                             \r\n"); // 8
			sql.append("						? AS address2,                             \r\n"); // 9
			sql.append("						? AS maxbooking,                           \r\n"); // 10
			sql.append("						? AS imageuri1,                            \r\n"); // 11
			sql.append("						? AS imageuri2,                            \r\n"); // 12
			sql.append("						? AS imageuri3,                            \r\n"); // 13
			sql.append("						? AS imageuri4,                            \r\n"); // 14
			sql.append("						? AS imageuri5,                            \r\n"); // 15
			sql.append("						? AS open,                                 \r\n"); // 16
			sql.append("						? AS closed,                               \r\n"); // 17
			sql.append("						? AS category,                             \r\n"); // 18
			sql.append("						? AS note,                                 \r\n"); // 19
			sql.append("						? AS signed_store_id,                      \r\n"); // 20
			sql.append("						? AS signed_store_email,                   \r\n"); // 21
			sql.append("						? AS signed_store_password,                \r\n"); // 22
			sql.append("						? AS signed_store_account                  \r\n"); // 23
			sql.append("					FROM                                           \r\n");
			sql.append("						DUAL                                       \r\n");
			sql.append("				) new_store                                        \r\n");
			sql.append("			LEFT OUTER JOIN                                        \r\n");
			sql.append("				store old_store                                    \r\n");
			sql.append("			ON                                                     \r\n");
			sql.append("				new_store.signed_store_id = old_store.store_id     \r\n");
			sql.append("		) d                                                        \r\n");
			sql.append("	ON                                                             \r\n");
			sql.append("		(                                                          \r\n");
			sql.append("			t.store_id = d.signed_store_id                         \r\n");
			sql.append("		)                                                          \r\n");
			sql.append("	WHEN MATCHED THEN                                              \r\n");
			sql.append("		UPDATE                                                     \r\n");
			sql.append("		SET                                                        \r\n");
			sql.append("			t.email = NVL(d.email, d.old_email),                   \r\n");
			sql.append("			t.password = NVL(d.password, d.old_password),          \r\n");
			sql.append("			t.phone = NVL(d.phone, d.old_phone),                   \r\n");
			sql.append("			t.name = NVL(d.name, d.old_name),                      \r\n");
			sql.append("			t.zonecode = NVL(d.zonecode, d.old_zonecode),          \r\n");
			sql.append("			t.sido = NVL(d.sido, d.old_sido),                      \r\n");
			sql.append("			t.sigungu = NVL(d.sigungu, d.old_sigungu),             \r\n");
			sql.append("			t.address1 = NVL(d.address1, d.old_address1),          \r\n");
			sql.append("			t.address2 = NVL(d.address2, d.old_address2),          \r\n");
			sql.append("			t.maxbooking = NVL(d.maxbooking, d.old_maxbooking),    \r\n");
			sql.append("			t.imageuri1 = NVL(d.imageuri1, d.old_imageuri1),       \r\n");
			sql.append("			t.imageuri2 = NVL(d.imageuri2, d.old_imageuri2),       \r\n");
			sql.append("			t.imageuri3 = NVL(d.imageuri3, d.old_imageuri3),       \r\n");
			sql.append("			t.imageuri4 = NVL(d.imageuri4, d.old_imageuri4),       \r\n");
			sql.append("			t.imageuri5 = NVL(d.imageuri5, d.old_imageuri5),       \r\n");
			sql.append("			t.open = NVL(d.open, d.old_open),                      \r\n");
			sql.append("			t.closed = NVL(d.closed, d.old_closed),                \r\n");
			sql.append("			t.category = NVL(d.category, d.old_category),          \r\n");
			sql.append("			t.note = NVL(d.note, d.old_note)                       \r\n");
			sql.append("		WHERE                                                      \r\n");
			sql.append("			t.store_id = d.signed_store_id                         \r\n");
			sql.append("			AND                                                    \r\n");
			sql.append("			t.email = d.signed_store_email                         \r\n");
			sql.append("			AND                                                    \r\n");
			sql.append("			t.password = d.signed_store_password                   \r\n");
			sql.append("		DELETE                                                     \r\n");
			sql.append("		WHERE                                                      \r\n");
			sql.append("			d.signed_store_account = 'dismiss_account'             \r\n");
			sql.append("	WHEN NOT MATCHED THEN                                          \r\n");
			sql.append("		INSERT                                                     \r\n");
			sql.append("			(                                                      \r\n");
			sql.append("				t.store_id,                                        \r\n");
			sql.append("				t.email,                                           \r\n");
			sql.append("				t.password,                                        \r\n");
			sql.append("				t.phone,                                           \r\n");
			sql.append("				t.name,                                            \r\n");
			sql.append("				t.zonecode,                                        \r\n");
			sql.append("				t.sido,                                            \r\n");
			sql.append("				t.sigungu,                                         \r\n");
			sql.append("				t.address1,                                        \r\n");
			sql.append("				t.address2,                                        \r\n");
			sql.append("				t.maxbooking,                                      \r\n");
			sql.append("				t.imageuri1,                                       \r\n");
			sql.append("				t.imageuri2,                                       \r\n");
			sql.append("				t.imageuri3,                                       \r\n");
			sql.append("				t.imageuri4,                                       \r\n");
			sql.append("				t.imageuri5,                                       \r\n");
			sql.append("				t.open,                                            \r\n");
			sql.append("				t.closed,                                          \r\n");
			sql.append("				t.category,                                        \r\n");
			sql.append("				t.note                                             \r\n");
			sql.append("			)                                                      \r\n");
			sql.append("		VALUES                                                     \r\n");
			sql.append("			(                                                      \r\n");
			sql.append("				seq_store.NEXTVAL,                                 \r\n");
			sql.append("				d.email,                                           \r\n");
			sql.append("				d.password,                                        \r\n");
			sql.append("				d.phone,                                           \r\n");
			sql.append("				d.NAME,                                            \r\n");
			sql.append("				d.zonecode,                                        \r\n");
			sql.append("				d.sido,                                            \r\n");
			sql.append("				d.sigungu,                                         \r\n");
			sql.append("				d.address1,                                        \r\n");
			sql.append("				d.address2,                                        \r\n");
			sql.append("				d.maxbooking,                                      \r\n");
			sql.append("				d.imageuri1,                                       \r\n");
			sql.append("				d.imageuri2,                                       \r\n");
			sql.append("				d.imageuri3,                                       \r\n");
			sql.append("				d.imageuri4,                                       \r\n");
			sql.append("				d.imageuri5,                                       \r\n");
			sql.append("				d.open,                                            \r\n");
			sql.append("				d.closed,                                          \r\n");
			sql.append("				d.category,                                        \r\n");
			sql.append("				d.note                                             \r\n");
			sql.append("			)                                                      \r\n");
			sql.append("		WHERE                                                      \r\n");
			sql.append("			NOT EXISTS                                             \r\n");
			sql.append("				(                                                  \r\n");
			sql.append("					SELECT                                         \r\n");
			sql.append("						*                                          \r\n");
			sql.append("					FROM                                           \r\n");
			sql.append("						store                                      \r\n");
			sql.append("					WHERE                                          \r\n");
			sql.append("						store.email = d.email                      \r\n");
			sql.append("				)                                                  \r\n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("StoreDao.merge() sql: ");
			System.out.println(sql.toString());
			
			System.out.println("StoreDao.merge() paramMap: " + paramMap);
			
			// TODO 형변환
			
			pstmt.setString(1, paramMap.get("email"));
			pstmt.setString(2, paramMap.get("password"));
			pstmt.setString(3, paramMap.get("phone"));
			pstmt.setString(4, paramMap.get("name"));
			pstmt.setString(5, paramMap.get("zonecode"));
			pstmt.setString(6, paramMap.get("sido"));
			pstmt.setString(7, paramMap.get("sigungu"));
			pstmt.setString(8, paramMap.get("address1"));
			pstmt.setString(9, paramMap.get("address2"));
			pstmt.setString(10, paramMap.get("maxbooking"));
			pstmt.setString(11, paramMap.get("imageuri1"));
			pstmt.setString(12, paramMap.get("imageuri2"));
			pstmt.setString(13, paramMap.get("imageuri3"));
			pstmt.setString(14, paramMap.get("imageuri4"));
			pstmt.setString(15, paramMap.get("imageuri5"));
			pstmt.setString(16, paramMap.get("open"));
			pstmt.setString(17, paramMap.get("closed"));
			pstmt.setString(18, paramMap.get("category"));
			pstmt.setString(19, paramMap.get("note"));
			pstmt.setString(20, paramMap.get("signed_store_id"));
			pstmt.setString(21, paramMap.get("signed_store_email"));
			pstmt.setString(22, paramMap.get("signed_store_password"));
			pstmt.setString(23, paramMap.get("signed_store_account"));
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (Exception e) {
			System.out.println("StoreDao.merge(): " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}
	
	public ArrayList<HashMap<String, String>> do_book(HashMap<String, String> paramMap) {
		
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		try {
			
			connect();
			
			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("	SELECT                                                                                                     \r\n");
			sql.append("		*                                                                                                      \r\n");
			sql.append("	FROM                                                                                                       \r\n");
			sql.append("		(                                                                                                      \r\n");
			sql.append("			SELECT                                                                                             \r\n");
			sql.append("				ROWNUM AS rnum,                                                                                \r\n");
			sql.append("				b.*                                                                                            \r\n");
			sql.append("			FROM                                                                                               \r\n");
			sql.append("				(                                                                                              \r\n");
			sql.append("					SELECT                                                                                     \r\n");
			sql.append("						ROW_NUMBER() OVER(ORDER BY booking.no DESC) AS row_num,                                \r\n");
			sql.append("						count(*) OVER() AS book_count,                                                         \r\n");
			sql.append("						booking.no,                                                                            \r\n");
			sql.append("						booking.sonnim_id,                                                                     \r\n");
			sql.append("						booking.store_id,                                                                      \r\n");
			sql.append("						booking.bookdate,                                                                      \r\n");
			sql.append("						booking.bookstate,                                                                     \r\n");
			sql.append("						booking.booktime,                                                                      \r\n");
			sql.append("						booking.bookperson,                                                                    \r\n");
			sql.append("						booking.writedate,                                                                     \r\n");
			sql.append("						booking.note,                                                                          \r\n");
			sql.append("						sonnim.email,                                                                          \r\n");
			sql.append("						sonnim.password,                                                                       \r\n");
			sql.append("						sonnim.phone,                                                                          \r\n");
			sql.append("						sonnim.birthday,                                                                       \r\n");
			sql.append("						sonnim.name                                                                            \r\n");
			sql.append("					FROM                                                                                       \r\n");
			sql.append("						booking                                                                                \r\n");
			sql.append("					INNER JOIN                                                                                 \r\n");
			sql.append("						sonnim                                                                                 \r\n");
			sql.append("					ON                                                                                         \r\n");
			sql.append("						booking.sonnim_id = sonnim.sonnim_id                                                   \r\n");
			sql.append("					WHERE                                                                                      \r\n");
			sql.append("						booking.store_id = ?                                                                   \r\n"); // 1
			sql.append("						AND                                                                                    \r\n");
			
			if (paramMap.get("bookstate") != null) {
				sql.append("					booking.bookstate = NVL(?, 0)                                                          \r\n"); // 2
			} else {
				sql.append("					-1 = ?                                                                                 \r\n"); // 2
			}
			
			sql.append("						AND                                                                                    \r\n");
			sql.append("						booking.bookdate >= NVL(?, TO_DATE('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))    \r\n"); // 3
			sql.append("						AND                                                                                    \r\n");
			sql.append("						booking.bookdate <= NVL(?, TO_DATE('2038-01-19 03:14:07', 'YYYY-MM-DD HH24:MI:SS'))    \r\n"); // 4
			sql.append("						AND                                                                                    \r\n");
			sql.append("						(                                                                                      \r\n");
			sql.append("							booking.no = NVL(?, booking.no)                                                    \r\n"); // 5
			sql.append("							OR                                                                                 \r\n");
			sql.append("							sonnim.name LIKE '%' || ? || '%'                                                   \r\n"); // 6
			sql.append("							OR                                                                                 \r\n");
			sql.append("							sonnim.phone LIKE '%' || ? || '%'                                                  \r\n"); // 7
			sql.append("						)                                                                                      \r\n");
			sql.append("					ORDER BY                                                                                   \r\n");
			sql.append("						booking.no DESC                                                                        \r\n");
			sql.append("				) b                                                                                            \r\n");
			sql.append("			WHERE                                                                                              \r\n");
			sql.append("				rownum < ?                                                                                     \r\n"); // 8
			sql.append("		)                                                                                                      \r\n");
			sql.append("	WHERE                                                                                                      \r\n");
			sql.append("		rnum >= ?                                                                                              \r\n"); // 9
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("StoreDao.do_book() sql: ");
			System.out.println(sql.toString());
			
			System.out.println("StoreDao.do_book() paramMap: " + paramMap);
			
			int store_id = -1;
			
			try {
				store_id = Integer.parseInt(paramMap.get("store_id"));
			} catch (Exception e) {
				System.out.println("StoreDao.do_book() paramMap.get(\"store_id\"): " + paramMap.get("store_id") + ", " + e.getMessage());
			}
			
			int bookstate = -1;
			
			try {
				bookstate = Integer.parseInt(paramMap.get("bookstate"));
			} catch (Exception e) {
				System.out.println("StoreDao.do_book() paramMap.get(\"bookstate\"): " + paramMap.get("bookstate") + ", " + e.getMessage());
			}
			
			Date from = null;
			
			try {
				from = Date.valueOf(paramMap.get("from"));
			} catch (Exception e) {
				System.out.println("StoreDao.do_book() paramMap.get(\"from\"): " + paramMap.get("from") + ", " + e.getMessage());
			}
			
			Date to = null;
			
			try {
				to = Date.valueOf(paramMap.get("to"));
			} catch (Exception e) {
				System.out.println("StoreDao.do_book() paramMap.get(\"to\"): " + paramMap.get("to") + ", " + e.getMessage());
			}
			
			int query = -1;
			
			try {
				query = Integer.parseInt(paramMap.get("query"));
			} catch (Exception e) {
				System.out.println("StoreDao.do_book() paramMap.get(\"query\"): " + paramMap.get("query") + ", " + e.getMessage());
			}
			
			int size = 10;
			
			try {
				size = Integer.parseInt(paramMap.get("size"));
			} catch (Exception e) {
				System.out.println("StoreDao.do_book() paramMap.get(\"size\"): " + paramMap.get("size") + ", " + e.getMessage());
			}
			
			int page = 1;
			
			try {
				page = Integer.parseInt(paramMap.get("page"));
			} catch (Exception e) {
				System.out.println("StoreDao.do_book() paramMap.get(\"page\"): " + paramMap.get("page") + ", " + e.getMessage());
			}
			
			pstmt.setInt(1, store_id);
			pstmt.setInt(2, bookstate);
			
			pstmt.setDate(3, from);
			pstmt.setDate(4, to);
			
			pstmt.setInt(5, query);
			
			pstmt.setString(6, paramMap.get("query"));
			pstmt.setString(7, paramMap.get("query"));
			
			pstmt.setInt(8, ((size * (page - 1) + 1) + size));
			pstmt.setInt(9, (size * (page - 1) + 1));
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				System.out.println("StoreDao.do_book() rs.getRow(): " + rs.getRow());
				
				data = new HashMap<String, String>();
				
				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					
					data.put(rs.getMetaData().getColumnName(i).toLowerCase(),
							
							rs.getString(rs.getMetaData().getColumnName(i)));
				}
				
				selected_list.add(data);
			}
			
			return selected_list;
			
		} catch (Exception e) {
			System.out.println("StoreDao.do_book(): " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return null;
	}
	
}
