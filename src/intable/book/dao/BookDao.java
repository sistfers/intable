package intable.book.dao;

import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import intable.abstracts.WorkArea;

/**
 * DAO 템플릿
 * 
 * @author 박성우
 *
 */
public class BookDao implements WorkArea {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String jdbc_driver = "oracle.jdbc.OracleDriver";
	private String jdbc_url = "jdbc:oracle:thin:@magoon.co.kr:1521:sist";
	
	public void connect() {
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "sky", "sky");
			System.out.println("conn=" + conn.toString());
		} catch (Exception e) {
			System.out.println("connect(): " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public void disConnect() {
		
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			System.out.println("disConnect():rs.close() " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				System.out.println("disConnect():pstmt.close() " + e.getMessage());
				e.printStackTrace();
			} finally {
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (Exception e) {
					System.out.println("disConnect():conn.close() " + e.getMessage());
					e.printStackTrace();
				}
			}
		}
	}
	
	@Override
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		return null;
	}
	
	public ArrayList<HashMap<String, String>> do_search(
			int pageNum, int pageSize, String search_div, String search_word, String sonnimId) 
	{
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		StringBuilder sqlParam = new StringBuilder();
		
		if(search_div.equals("NAME")){
			sqlParam.append("WHERE store.name like '" + search_word +"%' \n");
		}else if(search_div.equals("CATEGORY")){
			sqlParam.append("WHERE store.category like '" + search_word +"%' \n");
		}
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("SELECT b.rnum, b.TOT_CNT, b.no, b.bookstate, b.bdate, b.booktime, b.bookperson, b.note, b.name, b.store_id, b.imageuri1 FROM (																	   \n");
			sql.append("SELECT ROWNUM AS rnum, TT1.TOT_CNT, TT1.no, TT1.bookstate, to_char(TT1.bookdate,'yyyy-mm-dd') AS bdate, TT1.booktime, TT1.bookperson, TT1.note, store.name ,store.store_id , store.imageuri1       \n");
			sql.append("FROM                                                                                                                                                                              \n");
			sql.append("  (SELECT                                                                                                                  	                                                      \n");
			sql.append("    T1.*,                                                                                                                                                                         \n");
			sql.append("    T2.*                                                                                                                                                                          \n");
			sql.append("  FROM                                                                                                                                                                            \n");
			sql.append("    ( SELECT * FROM booking WHERE sonnim_id=? order by no DESC                                                                                                                                    \n");
			sql.append("    )T1 natural JOIN                                                                                                                                                              \n");
			sql.append("    (SELECT COUNT(*) AS TOT_CNT FROM booking WHERE sonnim_id=?                                                                                                                    \n");
			sql.append("    )T2                                                                                                                                                                           \n");
			sql.append("  )TT1 inner join store                                                                                                                                                           \n");
			sql.append("  on TT1.store_id = store.store_id                                                                                                                                                \n");
			//검색
			sql.append(sqlParam.toString());
			sql.append(")b \n WHERE rnum BETWEEN ? AND ?										                               						                                                          \n");
			
//			sql.append("WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE)                                \n");
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			int first = (pageSize*(pageNum-1))+1;
			int last = (pageSize*(pageNum-1))+pageSize;
			System.out.println("first: " + first + " last : " + last);
			pstmt.setString(1, sonnimId);
			pstmt.setString(2, sonnimId);
			pstmt.setInt(3, first);
			pstmt.setInt(4, last);
			
			System.out.println(pstmt.toString());
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				System.out.println("");
				if(selected_list==null)selected_list = new ArrayList<>();
				data = new HashMap<String, String>();
				
				data.put("bookstate", rs.getString("bookstate"));
				data.put("bookdate", rs.getString("bdate"));
				data.put("booktime", rs.getString("booktime"));
				data.put("bookperson", rs.getString("bookperson"));
				data.put("no", rs.getString("no"));
				data.put("note", rs.getString("note"));
				data.put("name", rs.getString("name"));
				data.put("count", rs.getString("TOT_CNT"));
				data.put("store_id", rs.getString("store_id"));
				data.put("image", rs.getString("imageuri1"));
				
				selected_list.add(data);
			}
			
			return selected_list;
			
		} catch (Exception e) {
			System.out.println("do_search() in whole list : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return null;
	}
	
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, 
			String search_div, String search_word, String sonnimId, String state) {
	ArrayList<HashMap<String, String>> selected_list = null;
	
	HashMap<String, String> data = null;
	
	StringBuilder sqlParam = new StringBuilder();
	
	if(search_div.equals("NAME")){
		sqlParam.append("WHERE store.name like '" + search_word +"%' \n");
	}else if(search_div.equals("CATEGORY")){
		sqlParam.append("WHERE store.category like '" + search_word +"%' \n");
	}
	try {
	
		connect();
		
		StringBuilder sql = new StringBuilder();
		
		sql.append("select b.rnum, b.TOT_CNT, b.no, b.bookstate, b.bdate, b.booktime, b.bookperson, b.note, b.name, b.store_id, b.imageuri1 from ( \n");
		sql.append("SELECT ROWNUM AS rnum, TT1.TOT_CNT, TT1.no, TT1.bookstate, to_char(TT1.bookdate,'yyyy-mm-dd') AS bdate, TT1.booktime, TT1.bookperson, TT1.note, store.name ,store.store_id , store.imageuri1                                                                       \n");
		sql.append("FROM                                                                                                                            \n");
		sql.append("  (SELECT                                			                                                                            \n");
		sql.append("    T1.*,                                                                                                                       \n");
		sql.append("    T2.*                                                                                                                        \n");
		sql.append("  FROM                                                                                                                          \n");
		sql.append("    ( SELECT * FROM booking WHERE sonnim_id=? AND bookstate=? order by no DESC                                           \n");
		sql.append("    )T1 natural JOIN                                                                                                            \n");
		sql.append("    (SELECT COUNT(*) AS TOT_CNT FROM booking WHERE sonnim_id=? AND bookstate=?                                                     \n");
		sql.append("    )T2                                                                                                                         \n");
		sql.append("  )TT1 inner join store                                                                                                         \n");
		sql.append("  on TT1.store_id = store.store_id                                                                                              \n");
		//검색
		sql.append(sqlParam.toString());
		sql.append(")b \n where rnum BETWEEN ? AND ?										                                                           \n");
		//sql.append("WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE)                              \n");
		
		pstmt = conn.prepareStatement(sql.toString());
		
		System.out.println("sql=" + sql.toString());
		
		int first = (pageSize*(pageNum-1))+1;
		int last = (pageSize*(pageNum-1))+pageSize;
		pstmt.setString(1, sonnimId);
		pstmt.setString(2, state);
		pstmt.setString(3, sonnimId);
		pstmt.setString(4, state);
		pstmt.setInt(5, first);
		pstmt.setInt(6, last);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			if(selected_list==null)selected_list = new ArrayList<>();
		
			data = new HashMap<String, String>();
			
			data.put("bookstate", rs.getString("bookstate"));
			data.put("bookdate", rs.getString("bdate"));
			data.put("booktime", rs.getString("booktime"));
			data.put("bookperson", rs.getString("bookperson"));
			data.put("no", rs.getString("no"));
			data.put("note", rs.getString("note"));
			data.put("name", rs.getString("name"));
			data.put("count", rs.getString("TOT_CNT"));
			data.put("store_id", rs.getString("store_id"));
			data.put("image", rs.getString("imageuri1"));
			
			selected_list.add(data);
		}
		
		return selected_list;
	
	} catch (Exception e) {
		System.out.println("do_search() in each state list : " + e);
		e.printStackTrace();
	} finally {
		disConnect();
	}
	
	return null;
}
	
	@Override
	public HashMap<String, String> do_detail(HashMap<String, String> map) {
		return null;
	}
	
	@Override
	public boolean do_insert(HashMap<String, String> map) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			sql.append("insert into booking(sonnim_id, store_id, bookdate, booktime, bookperson, note) \n");
			sql.append("values(?, ?, ?, ?, ?, ?)                                                       \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, map.get("sonnim_id"));
			pstmt.setString(2, map.get("store_id"));
			pstmt.setString(3, map.get("bookdate"));
			pstmt.setString(4, map.get("booktime"));
			pstmt.setString(5, map.get("bookperson"));
			
			if(!map.get("note").equals("")){
	    		
    			Clob clobCon = conn.createClob();
	    		clobCon.setString(1, map.get("note"));
	    		
	    		pstmt.setClob(6, clobCon);
			}else{
				pstmt.setString(6, null);
			}
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (SQLException e) {
			System.out.println("do_insert() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}
	
	@Override
	public boolean do_update(HashMap<String, String> map) {
		
		// 스토어 예약 수정 @author magoon // 시작
		
		if (map != null
				
				&& map.get("signed_store_account") != null
				
				&& map.get("signed_store_id") != null
				
				&& map.get("signed_store_email") != null
				
				&& map.get("signed_store_password") != null
				
				&& map.get("no") != null
				
				&& map.get("bookstate") != null) {
			
			HashMap<String, String> paramMap = map;
			
			try {
				
				connect();
				
				StringBuilder sql = new StringBuilder();
				
				sql.append("	UPDATE                                     \r\n");
				sql.append("		booking                                \r\n");
				sql.append("	SET                                        \r\n");
				sql.append("		bookstate = ?                          \r\n"); // 1
				sql.append("	WHERE                                      \r\n");
				sql.append("		no = ?                                 \r\n"); // 2
				sql.append("		AND                                    \r\n");
				sql.append("		EXISTS                                 \r\n");
				sql.append("			(                                  \r\n");
				sql.append("				SELECT                         \r\n");
				sql.append("					*                          \r\n");
				sql.append("				FROM                           \r\n");
				sql.append("					booking b                  \r\n");
				sql.append("				INNER JOIN                     \r\n");
				sql.append("					store s                    \r\n");
				sql.append("				ON                             \r\n");
				sql.append("					b.store_id = s.store_id    \r\n");
				sql.append("				WHERE                          \r\n");
				sql.append("					s.store_id = ?             \r\n"); // 3
				sql.append("					AND                        \r\n");
				sql.append("					s.email = ?                \r\n"); // 4
				sql.append("					AND                        \r\n");
				sql.append("					s.password = ?             \r\n"); // 5
				sql.append("			)                                  \r\n");
				
				pstmt = conn.prepareStatement(sql.toString());
				
				System.out.println("BookDao.do_update() sql: ");
				System.out.println(sql.toString());
				
				System.out.println("BookDao.do_update() paramMap: " + paramMap);
				
				int bookstate = -1;
				
				try {
					bookstate = Integer.parseInt(paramMap.get("bookstate"));
				} catch (Exception e) {
					System.out.println("BookDao.do_update() paramMap.get(\"bookstate\"): " + paramMap.get("bookstate") + ", " + e.getMessage());
					e.printStackTrace();
				}
				
				int no = -1;
				
				try {
					no = Integer.parseInt(paramMap.get("no"));
				} catch (Exception e) {
					System.out.println("BookDao.do_update() paramMap.get(\"no\"): " + paramMap.get("no") + ", " + e.getMessage());
					e.printStackTrace();
				}
				
				int store_id = -1;
				
				try {
					store_id = Integer.parseInt(paramMap.get("signed_store_id"));
				} catch (Exception e) {
					System.out.println("BookDao.do_update() paramMap.get(\"signed_store_id\"): " + paramMap.get("signed_store_id") + ", " + e.getMessage());
					e.printStackTrace();
				}
				
				pstmt.setInt(1, bookstate);
				pstmt.setInt(2, no);
				pstmt.setInt(3, store_id);
				
				pstmt.setString(4, paramMap.get("signed_store_email"));
				pstmt.setString(5, paramMap.get("signed_store_password"));
				
				int result = pstmt.executeUpdate();
				
				return (result == 1);
				
			} catch (Exception e) {
				System.out.println("BookDao.do_update() : " + e.getMessage());
				e.printStackTrace();
			} finally {
				disConnect();
			}
			
			return false;
		}
		
		// 스토어 예약 수정 @author magoon // 끝
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			sql.append("update booking  \n");
			sql.append("set bookstate=2 \n"); 
			sql.append("where no=?      \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, map.get("no"));
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (SQLException e) {
			System.out.println("do_update() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}
	
	@Override
	public boolean do_delete(HashMap<String, String> map) {
		return false;
	}
	
	@Override
	public boolean do_upsert(HashMap<String, String> map) {
		return false;
	}
	
	public ArrayList<Integer> do_getStateCount(HashMap map){
		ArrayList<Integer> list = new ArrayList<>();
		
		try{
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			sql.append("SELECT COUNT(*) AS every,      \n");
    		sql.append("  SUM(                         \n");
    		sql.append("  CASE                         \n");
    		sql.append("    WHEN booking.bookstate = 0 \n");
    		sql.append("    THEN 1                     \n");
    		sql.append("  END) AS state0,              \n");
    		sql.append("  SUM(                         \n");
    		sql.append("  CASE                         \n");
    		sql.append("    WHEN booking.bookstate = 1 \n");
    		sql.append("    THEN 1                     \n");
    		sql.append("  END) AS state1,              \n");
    		sql.append("  SUM(                         \n");
    		sql.append("  CASE                         \n");
    		sql.append("    WHEN booking.bookstate = 2 \n");
    		sql.append("    THEN 1                     \n");
    		sql.append("  END) AS state2               \n");
    		sql.append("FROM booking                   \n");
    		sql.append("WHERE SONNIM_ID=?              \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			System.out.println("map=" + map.toString());
			pstmt.setString(1, map.get("sonnim_id").toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				list.add(rs.getInt("every"));
    			list.add(rs.getInt("state0"));
    			list.add(rs.getInt("state1"));
    			list.add(rs.getInt("state2"));
			}
		}catch (SQLException e) {
			System.out.println("do_getStateCount() : " + e.getMessage());
			e.printStackTrace();
		}finally {
			disConnect();
		}
		
		return list;
	}
	
	//전체 예약 목록 가져오기
	public ArrayList<HashMap<String, String>> do_getList(int pageNum,int pageSize, String sonnimId){
		HashMap<String, String> data = null;
    	ArrayList<HashMap<String, String>> list = null;
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("SELECT TT1.TOT_CNT, TT1.bookstate, to_char(TT1.bookdate,'YYYY-MM-DD'), TT1.booktime, TT1.bookperson, TT1.no, TT1.note, store.name ,store.store_id ,store.imageuri1           \n");
			sql.append("FROM                                                                                                                                          \n");
			sql.append("  (SELECT ROWNUM AS rnum,     			                                                                                                                  \n");
			sql.append("    T1.*,                                                                                                                                     \n");
			sql.append("    T2.*                                                                                                                                      \n");
			sql.append("    FROM                                                                                                                                      \n");
			sql.append("	( SELECT * FROM booking WHERE sonnim_id=? order by no DESC                                                                                              \n");
			sql.append("	)T1 natural JOIN                                                                                                                          \n");
			sql.append("	(SELECT COUNT(*) AS TOT_CNT FROM booking WHERE sonnim_id=?                                                                                   \n");
			sql.append("	)T2                                                                                                                                       \n");
			sql.append("  )TT1 join store                                                                                                                             \n");
			sql.append("  on TT1.store_id = store.store_id                                                                                                            \n");
//			sql.append("WHERE ROWNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE)                                            \n");
			sql.append("WHERE rnum BETWEEN ? AND ? 																											\n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			int first = (pageSize*(pageNum-1))+1;
			int last = (pageSize*(pageNum-1))+pageSize;
			pstmt.setString(1, sonnimId);
			pstmt.setString(2, sonnimId);
			pstmt.setInt(3, first);
			pstmt.setInt(4, last);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				if(list==null)list = new ArrayList<>();
				data = new HashMap<>();
				data.put("bookstate", rs.getString("bookstate"));
				data.put("bookdate", rs.getString("to_char(TT1.bookdate,'YYYY-MM-DD')"));
				data.put("booktime", rs.getString("booktime"));
				data.put("bookperson", rs.getString("bookperson"));
				data.put("no", rs.getString("no"));
				data.put("note", rs.getString("note"));
				data.put("name", rs.getString("name"));
				data.put("count", rs.getString("TOT_CNT"));
				data.put("store_id", rs.getString("store_id"));
				data.put("image", rs.getString("imageuri1"));
				
				list.add(data);
			}
			
			return list;
			
		} catch (SQLException e) {
			System.out.println("do_getList() : " + e.getMessage());
			e.printStackTrace();
		}finally {
			disConnect();
		}
		
		return null;
	}
	
	//상태 예약 목록 가져오기
	public ArrayList<HashMap<String, String>> do_getList(int pageNum,int pageSize, String sonnimId, String state){
		HashMap<String, String> data = null;
    	ArrayList<HashMap<String, String>> list = null;
    	
    	try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("SELECT TT1.TOT_CNT, TT1.bookstate, to_char(TT1.bookdate,'YYYY-MM-DD'), TT1.booktime, TT1.bookperson, TT1.no, TT1.note, store.name ,store.store_id ,store.imageuri1           \n");
			sql.append("FROM                                                                                             \n");
			sql.append("  (SELECT ROWNUM AS rnum,    			                                                                     \n");
			sql.append("    T1.*,                                                                                        \n");
			sql.append("    T2.*                                                                                         \n");
			sql.append("    FROM                                                                                         \n");
			sql.append("	( SELECT * FROM booking WHERE sonnim_id=? AND bookstate=? order by no DESC                                  \n");
			sql.append("	)T1 natural JOIN                                                                             \n");
			sql.append("	(SELECT COUNT(*) AS TOT_CNT FROM booking WHERE sonnim_id=? AND bookstate=?                      \n");
			sql.append("	)T2                                                                                          \n");
			sql.append("  )TT1 join store                                                                                \n");
			sql.append("  on TT1.store_id = store.store_id                                                               \n");
//			sql.append("WHERE ROWNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE) \n");
			sql.append("WHERE rnum BETWEEN ? AND ? 											 \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			int first = (pageSize*(pageNum-1))+1;
			int last = (pageSize*(pageNum-1))+pageSize;
			pstmt.setString(1, sonnimId);
			pstmt.setString(2, state);
			pstmt.setString(3, sonnimId);
			pstmt.setString(4, state);
			pstmt.setInt(5, first);
			pstmt.setInt(6, last);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				if(list==null)list = new ArrayList<>();
				data = new HashMap<>();
				data.put("bookstate", rs.getString("bookstate"));
				data.put("bookdate", rs.getString("to_char(TT1.bookdate,'YYYY-MM-DD')"));
				data.put("booktime", rs.getString("booktime"));
				data.put("bookperson", rs.getString("bookperson"));
				data.put("no", rs.getString("no"));
				data.put("name", rs.getString("name"));
				data.put("note", rs.getString("note"));
				data.put("count", rs.getString("TOT_CNT"));
				data.put("store_id", rs.getString("store_id"));
				data.put("image", rs.getString("imageuri1"));
				
				list.add(data);
			}
			
			return list;
			
    	}catch (SQLException e) {
    		e.printStackTrace();
		}finally {
			disConnect();
		}
    	
    	return null;
	}
	
	public String do_gettoday(){
		String todayStr = "";
		
		try{
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("select to_char(sysdate,'YYYY-MM-DD') \n");
			sql.append("from dual      \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			todayStr = rs.getString("to_char(sysdate,'YYYY-MM-DD')");
			
			return todayStr;
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			disConnect();
		}
		
		return "";
	}
}
