package intable.board.dao;

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
public class BoardDao implements WorkArea {

	private BoardDao() {
	}

	private static BoardDao bDao;

	public static BoardDao getBoardDao() {

		if (bDao == null) {
			bDao = new BoardDao();
		}

		return bDao;
	}

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private String jdbc_driver = "oracle.jdbc.OracleDriver";
	private String jdbc_url = "jdbc:oracle:thin:@magoon.co.kr:1521:orcl";

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
	
	public ArrayList<HashMap<String, String>> do_search_notice(String table) {
		
		ArrayList<HashMap<String, String>> selected_list = null;

		HashMap<String, String> data = null;

		try {

			connect();
			
			selected_list = new ArrayList<HashMap<String, String>>();

			StringBuilder sql = new StringBuilder();
			sql.append("SELECT seq_no, title, content, writedate, readcount, reply_yn   \n");
			sql.append("FROM " + table + "   \n");
			sql.append("WHERE notice=?    	 \n");
			sql.append("ORDER BY seq_no DESC \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			int notice = -1;
			pstmt.setInt(1, notice);
			
			System.out.println("sql=" + sql.toString());
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				data = new HashMap<String, String>();
				data.put("seq_no", rs.getString(1));
				data.put("title", rs.getString(2));
				data.put("content", rs.getString(3));
				data.put("writedate", rs.getString(4));
				data.put("readcount", rs.getString(5));
				data.put("reply_yn", rs.getString(6));
				selected_list.add(data);
			}
			
			return selected_list;

		} catch (Exception e) {
			System.out.println("do_search_notice() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}

		return null;
	}

	@Override
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, 
			String search_div, String search_word) {
				
		return null;
	}
	
	public ArrayList<HashMap<String, String>> do_search_mine(int pageNum, int pageSize, 
			String id, String col, String table) {
		
		int begin = pageSize * (pageNum - 1) + 1;
		int end = pageSize * (pageNum - 1) + pageSize;

		ArrayList<HashMap<String, String>> selected_list = null;

		HashMap<String, String> data = null;

		try {

			connect();			

			selected_list = new ArrayList<HashMap<String, String>>();

			StringBuilder sql = new StringBuilder();   
			sql.append("SELECT RST1.rnum, RST1.seq_no, RST1." + col + "_id, RST1.title, 		  \n");
			sql.append("RST1.content, RST1.writedate, RST1.readcount,						  	  \n");
			sql.append("RST1.parent, RST1.notice, RST1.reply_yn, RST2.name   					  \n");
			sql.append("FROM (                                                                    \n");
			sql.append("SELECT *                                                                  \n");                
			sql.append("FROM (                                                                    \n");                
			sql.append("  SELECT T1.rnum, T1.seq_no, T1." + col + "_id, T1.title, T1.content,     \n");
			sql.append("  T1.writedate, T1.readcount, T1.parent, T1.notice, T1.reply_yn       	  \n");                 
			sql.append("  FROM ( 		                                                	      \n");               
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,           \n");
			sql.append("  " + col + "_id, title, content, writedate, readcount, parent, notice, reply_yn  \n");                                    
			sql.append("  FROM " + table + "                                                      \n"); 
			sql.append("  WHERE parent IS NULL AND " + col + "_id=?) T1                           \n");			               
			sql.append("WHERE T1.rnum>=? AND T1.rnum<=? 		                                  \n");                 
			sql.append("UNION ALL                                                                 \n");                 
			sql.append("SELECT rownum as rnum, seq_no, " + col + "_id, title,                     \n");  
			sql.append("content, writedate, readcount, parent, notice, reply_yn                   \n");                  
			sql.append("FROM " + table + " s                                                      \n");          
			sql.append("WHERE EXISTS ( 		                                                      \n");
			sql.append("  SELECT T2.seq_no                                                        \n");                 
			sql.append("  FROM (                                                                  \n");                 
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,           \n");
			sql.append("  " + col + "_id, title, content, writedate, readcount, parent, notice, reply_yn  \n");                                   
			sql.append("  FROM " + table + "                                                      \n"); 
			sql.append("  WHERE parent IS NULL AND " + col + "_id=?) T2                      	  \n");                           
			sql.append("  WHERE T2.rnum>=? AND T2.rnum<=?                 	                      \n");                
			sql.append("  AND T2.seq_no=s.parent))                                                \n");                
			sql.append("START WITH parent IS NULL                                                 \n");              
			sql.append("CONNECT BY PRIOR seq_no=parent                                            \n");                 
			sql.append("ORDER SIBLINGS BY seq_no DESC ) RST1 JOIN (                               \n");
			sql.append("SELECT " + col + "_id, name 	                                          \n");
			sql.append("FROM " + col + " ) RST2 ON (RST1." + col + "_id=RST2." + col + "_id)      \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setString(1, id);
			pstmt.setInt(2, begin);
			pstmt.setInt(3, end);
			pstmt.setString(4, id);
			pstmt.setInt(5, begin);
			pstmt.setInt(6, end);					

			System.out.println("sql=" + sql.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				data = new HashMap<String, String>();				
				data.put("seq_no", rs.getString(2));
				data.put(col + "_id", rs.getString(3));
				data.put("title", rs.getString(4));
				data.put("content", rs.getString(5));
				data.put("writedate", rs.getString(6));
				data.put("readcount", rs.getString(7));
				data.put("parent", rs.getString(8));
				data.put("notice", rs.getString(9));
				data.put("reply_yn", rs.getString(10));
				data.put("name", rs.getString(11));
				selected_list.add(data);
			}

			return selected_list;

		} catch (Exception e) {
			System.out.println("do_search() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return null;
	}
	
	public int do_words_pagi(String table, String words) {
		
		try {

			connect();
			
			String col = "store_id";
			if(table.equals("son_help")) {
				col = "sonnim_id";
			}
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT COUNT(*) AS TOTAL_COUNT                      \n");
			sql.append("FROM(                                               \n");
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no) RNUM   \n");
			sql.append("  FROM " + table + "                                \n");
			sql.append("  WHERE parent IS NULL AND title like '%'||?||'%')  \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, words);
			
			System.out.println("sql=" + sql.toString());
			rs = pstmt.executeQuery();	
			
			while(rs.next()) {
				int total_cnt = rs.getInt(1);
				
				return total_cnt;
			}
			
		} catch (Exception e) {
			System.out.println("do_words_pagi() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}

		return 0;
	}
	
	public ArrayList<HashMap<String, String>> do_words_result(int pageNum, int pageSize, 
			String search_word, String col, String table) {
		
		int begin = pageSize * (pageNum - 1) + 1;
		int end = pageSize * (pageNum - 1) + pageSize;

		ArrayList<HashMap<String, String>> selected_list = null;

		HashMap<String, String> data = null;

		try {

			connect();			

			selected_list = new ArrayList<HashMap<String, String>>();

			StringBuilder sql = new StringBuilder();   
			sql.append("SELECT RST1.rnum, RST1.seq_no, RST1." + col + "_id, RST1.title, 		  \n");
			sql.append("RST1.content, RST1.writedate, RST1.readcount,						  	  \n");
			sql.append("RST1.parent, RST1.notice, RST1.reply_yn, RST2.name   					  \n");
			sql.append("FROM (                                                                    \n");
			sql.append("SELECT *                                                                  \n");                
			sql.append("FROM (                                                                    \n");                
			sql.append("  SELECT T1.rnum, T1.seq_no, T1." + col + "_id, T1.title, T1.content,     \n");
			sql.append("  T1.writedate, T1.readcount, T1.parent, T1.notice, T1.reply_yn       	  \n");                 
			sql.append("  FROM ( 		                                                	      \n");               
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,           \n");
			sql.append("  " + col + "_id, title, content, writedate, readcount, parent, notice, reply_yn  \n");                                    
			sql.append("  FROM " + table + "                                                      \n"); 
			sql.append("  WHERE parent IS NULL AND title like '%'||?||'%') T1             	      \n");			               
			sql.append("WHERE T1.rnum>=? AND T1.rnum<=? 		                                  \n");                 
			sql.append("UNION ALL                                                                 \n");                 
			sql.append("SELECT rownum as rnum, seq_no, " + col + "_id, title,                     \n");  
			sql.append("content, writedate, readcount, parent, notice, reply_yn                   \n");                  
			sql.append("FROM " + table + " s                                                      \n");          
			sql.append("WHERE EXISTS ( 		                                                      \n");
			sql.append("  SELECT T2.seq_no                                                        \n");                 
			sql.append("  FROM (                                                                  \n");                 
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,           \n");
			sql.append("  " + col + "_id, title, content, writedate, readcount, parent, notice, reply_yn  \n");                                   
			sql.append("  FROM " + table + "                                                      \n");            
			sql.append("  WHERE parent IS NULL AND title like '%'||?||'%') T2              	      \n");                         
			sql.append("  WHERE T2.rnum>=? AND T2.rnum<=?                 	                      \n");                
			sql.append("  AND T2.seq_no=s.parent))                                                \n");                
			sql.append("START WITH parent IS NULL                                                 \n");              
			sql.append("CONNECT BY PRIOR seq_no=parent                                            \n");                 
			sql.append("ORDER SIBLINGS BY seq_no DESC ) RST1 JOIN (                               \n");
			sql.append("SELECT " + col + "_id, name 	                                          \n");
			sql.append("FROM " + col + " ) RST2 ON (RST1." + col + "_id=RST2." + col + "_id)      \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setString(1, search_word);
			pstmt.setInt(2, begin);
			pstmt.setInt(3, end);
			pstmt.setString(4, search_word);
			pstmt.setInt(5, begin);
			pstmt.setInt(6, end);					

			System.out.println("sql=" + sql.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				data = new HashMap<String, String>();				
				data.put("seq_no", rs.getString(2));
				data.put(col + "_id", rs.getString(3));
				data.put("title", rs.getString(4));
				data.put("content", rs.getString(5));
				data.put("writedate", rs.getString(6));
				data.put("readcount", rs.getString(7));
				data.put("parent", rs.getString(8));
				data.put("notice", rs.getString(9));
				data.put("reply_yn", rs.getString(10));
				data.put("name", rs.getString(11));
				selected_list.add(data);
			}

			return selected_list;

		} catch (Exception e) {
			System.out.println("do_search() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}

		return null;
	}			

	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, 
			String search_div, String search_word, String col, String table) {
		
		int begin = pageSize * (pageNum - 1) + 1;
		int end = pageSize * (pageNum - 1) + pageSize;

		ArrayList<HashMap<String, String>> selected_list = null;

		HashMap<String, String> data = null;

		try {

			connect();			

			selected_list = new ArrayList<HashMap<String, String>>();

			StringBuilder sql = new StringBuilder();   
			sql.append("SELECT RST1.rnum, RST1.seq_no, RST1." + col + "_id, RST1.title, 		  \n");
			sql.append("RST1.content, RST1.writedate, RST1.readcount,						  	  \n");
			sql.append("RST1.parent, RST1.notice, RST1.reply_yn, RST2.name   					  \n");
			sql.append("FROM (                                                                    \n");
			sql.append("SELECT *                                                                  \n");                
			sql.append("FROM (                                                                    \n");                
			sql.append("  SELECT T1.rnum, T1.seq_no, T1." + col + "_id, T1.title, T1.content,     \n");
			sql.append("  T1.writedate, T1.readcount, T1.parent, T1.notice, T1.reply_yn       	  \n");                 
			sql.append("  FROM ( 		                                                	      \n");               
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,           \n");
			sql.append("  " + col + "_id, title, content, writedate, readcount, parent, notice, reply_yn  \n");                                    
			sql.append("  FROM " + table + "                                                      \n"); 
			sql.append("  WHERE parent IS NULL) T1                                           	  \n");			               
			sql.append("WHERE T1.rnum>=? AND T1.rnum<=? 		                                  \n");                 
			sql.append("UNION ALL                                                                 \n");                 
			sql.append("SELECT rownum as rnum, seq_no, " + col + "_id, title,                     \n");  
			sql.append("content, writedate, readcount, parent, notice, reply_yn                   \n");                  
			sql.append("FROM " + table + " s                                                      \n");          
			sql.append("WHERE EXISTS ( 		                                                      \n");
			sql.append("  SELECT T2.seq_no                                                        \n");                 
			sql.append("  FROM (                                                                  \n");                 
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,           \n");
			sql.append("  " + col + "_id, title, content, writedate, readcount, parent, notice, reply_yn  \n");                                   
			sql.append("  FROM " + table + "                                                      \n");            
			sql.append("  WHERE parent IS NULL) T2                                          	  \n");                         
			sql.append("  WHERE T2.rnum>=? AND T2.rnum<=?                 	                      \n");                
			sql.append("  AND T2.seq_no=s.parent))                                                \n");                
			sql.append("START WITH parent IS NULL                                                 \n");              
			sql.append("CONNECT BY PRIOR seq_no=parent                                            \n");                 
			sql.append("ORDER SIBLINGS BY seq_no DESC ) RST1 JOIN (                               \n");
			sql.append("SELECT " + col + "_id, name 	                                          \n");
			sql.append("FROM " + col + " ) RST2 ON (RST1." + col + "_id=RST2." + col + "_id)      \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setInt(1, begin);
			pstmt.setInt(2, end);
			pstmt.setInt(3, begin);
			pstmt.setInt(4, end);					

			System.out.println("sql=" + sql.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				data = new HashMap<String, String>();				
				data.put("seq_no", rs.getString(2));
				data.put(col + "_id", rs.getString(3));
				data.put("title", rs.getString(4));
				data.put("content", rs.getString(5));
				data.put("writedate", rs.getString(6));
				data.put("readcount", rs.getString(7));
				data.put("parent", rs.getString(8));
				data.put("notice", rs.getString(9));
				data.put("reply_yn", rs.getString(10));
				data.put("name", rs.getString(11));
				selected_list.add(data);
			}

			return selected_list;

		} catch (Exception e) {
			System.out.println("do_search() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}

		return null;
	}
	
	public int do_pag_mine(String table, String id) {
		
		try {

			connect();
			
			String col = "store_id";
			if(table.equals("son_help")) {
				col = "sonnim_id";
			}
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT COUNT(*) AS TOTAL_COUNT                      \n");
			sql.append("FROM(                                               \n");
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no) RNUM   \n");
			sql.append("  FROM " + table + "                                \n");
			sql.append("  WHERE parent IS NULL AND " + col + "=?)           \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			System.out.println("sql=" + sql.toString());
			rs = pstmt.executeQuery();	
			
			while(rs.next()) {
				int total_cnt = rs.getInt(1);
				
				return total_cnt;
			}
			
		} catch (Exception e) {
			System.out.println("do_detail() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}

		return 0;
	}
	
	public int do_pagination(String table) {
		
		try {

			connect();
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT COUNT(*) AS TOTAL_COUNT                      \n");
			sql.append("FROM(                                               \n");
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no) RNUM   \n");
			sql.append("  FROM " + table + "                                \n");
			sql.append("  WHERE parent IS NULL)								\n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			rs = pstmt.executeQuery();	
			
			while(rs.next()) {
				int total_cnt = rs.getInt(1);
				
				return total_cnt;
			}
			
		} catch (Exception e) {
			System.out.println("do_detail() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}

		return 0;
	}
	
	@Override
	public HashMap<String, String> do_detail(HashMap<String, String> map) {
		
		HashMap<String, String> data = null;

		try {

			connect();
			
			String table = "store_help";
			String col = "store";
			if(map.get("issonnim").equals("true")) {					
				
				if(map.get("tb").equals("store_help")) {
					
				} else {
					table = "son_help";
					col = "sonnim";
				}
			}
			
			StringBuilder count = new StringBuilder();
			count.append("UPDATE " + table + "		  \n");
			count.append("SET readcount=readcount+1   \n");
			count.append("WHERE seq_no=? 			  \n");			
			
			pstmt = conn.prepareStatement(count.toString());
			pstmt.setInt(1, Integer.parseInt(map.get("no")));
			pstmt.executeUpdate();			

			System.out.println("sql=" + count.toString());
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT RST1.seq_no, RST1." + col + "_id, RST1.title, RST1.content, 		 \n");
			sql.append("RST1.writedate, RST1.readcount, RST1. parent,    \n");
			sql.append("RST1.notice, RST1.reply_yn, RST2.name 			 \n");
			sql.append("FROM (											 \n");
			sql.append("SELECT seq_no, " + col + "_id, title, content,   \n");
            sql.append("writedate, readcount, parent, notice, reply_yn   \n");
			sql.append("FROM " + table + "                               \n");
			sql.append("WHERE seq_no=? ) RST1 JOIN (                     \n");
			sql.append("SELECT " + col + "_id, name 	                 \n");
			sql.append("FROM " + col + " ) RST2 ON (RST1." + col + "_id=RST2." + col + "_id)     \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, Integer.parseInt(map.get("no")));
			rs = pstmt.executeQuery();

			System.out.println("sql=" + sql.toString());			

			while (rs.next()) {
				data = new HashMap<String, String>();
				data.put("seq_no", rs.getString(1));
				data.put("id", rs.getString(2));
				data.put("title", rs.getString(3));
				data.put("content", rs.getString(4));
				data.put("writedate", rs.getString(5));
				data.put("readcount", rs.getString(6));
				data.put("parent", rs.getString(7));				
				data.put("notice", rs.getString(8));
				data.put("reply_yn", rs.getString(9));
				data.put("name", rs.getString(10));
				
				return data;
			}
		} catch (Exception e) {
			System.out.println("do_detail() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}

		return null;
	}

	@Override
	public boolean do_insert(HashMap<String, String> map) {

		try {
			
			connect();
			
			String col_id = "(store";
			if(map.get("issonnim").equals("true")) {
				col_id = "(sonnim";
			}
			String table = map.get("table");
			
			System.out.println(col_id);	
			System.out.println(table);	

			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO " + table + " " + col_id + "_id, title, content) \n");
			sql.append("VALUES(?, ?, ?) 											 \n");

			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, Integer.parseInt(map.get("id")));
			pstmt.setString(2, map.get("title"));			
			pstmt.setString(3, map.get("content"));

			System.out.println("sql=" + sql.toString());

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

		try {

			connect();
			
			String table = "store_help";
			String col_id = "store";
			if(map.get("issonnim").equals("true")) {					
				
				if(map.get("table").equals("store_help")) {
					
				} else {
					table = "son_help";
					col_id = "sonnim";
				}
			}

			StringBuilder sql = new StringBuilder();
			sql.append("update " + table + "   \n");
			sql.append("set title=?,        \n");
			sql.append("content=?,          \n");
			sql.append("readcount=readcount-1  \n");
			sql.append("where seq_no=?      \n");

			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, map.get("title"));
			pstmt.setString(2, map.get("content"));
			pstmt.setInt(3, Integer.parseInt(map.get("seq_no")));

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

		try {

			connect();
			
			String table = "store_help";
			String col_id = "store";
			if(map.get("issonnim").equals("true")) {					
				
				if(map.get("table").equals("store_help")) {
					
				} else {
					table = "son_help";
					col_id = "sonnim";
				}
			}

			StringBuilder sql = new StringBuilder();
			sql.append("DELETE            \n");
			sql.append("FROM " + table + "   \n");
			sql.append("WHERE seq_no=?    \n");

			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("seq"));

			System.out.println("sql=" + sql.toString());

			int result = pstmt.executeUpdate();

			return (result == 1);

		} catch (SQLException e) {
			System.out.println("do_delete() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}

	public boolean do_reply(HashMap<String, String> map) {
		
		connect();
		
		String table = "store_help";
		String col_id = "(store";
		if(map.get("issonnim").equals("true")) {					
			
			if(map.get("table").equals("store_help")) {
				
			} else {
				table = "son_help";
				col_id = "(sonnim";
			}
		}

		StringBuilder sql1 = new StringBuilder();
		sql1.append("MERGE INTO " + table + "   \n");
		sql1.append("USING dual             \n");
		sql1.append("ON (seq_no=?)      	   \n");
		sql1.append("WHEN MATCHED THEN      \n");
		sql1.append("UPDATE SET reply_yn=1  \n");
		
		StringBuilder sql2 = new StringBuilder();
		sql2.append("INSERT INTO " + table + " 						   \n");
		sql2.append(col_id + "_id, title, content, parent, reply_yn)   \n");
		sql2.append("VALUES(?, ?, ?, ?, ?) 							   \n");
		
		try {
			pstmt = conn.prepareStatement(sql1.toString());
			pstmt.setString(1, map.get("seq"));

			System.out.println("sql=" + sql1.toString());

			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				pstmt = conn.prepareStatement(sql2.toString());
				pstmt.setInt(1, Integer.parseInt(map.get("id")));
				pstmt.setString(2, map.get("title"));			
				pstmt.setString(3, map.get("content"));
				pstmt.setInt(4, Integer.parseInt(map.get("seq")));
				pstmt.setInt(5, 1);

				System.out.println("sql=" + sql2.toString());

				result = pstmt.executeUpdate();

				return (result == 1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnect();
		}		
		
		return false;
	}
	
public boolean do_notice(HashMap<String, String> map) {
		
		connect();
		
		String table = "store_help";
		String col_id = "(store";
		// 손님-관리자
		if(map.get("issonnim").equals("true")) {					
			
			// 스토어 게시판에서 공지 작성 시도
			if(map.get("table").equals("store_help")) {
				
			} else {
				table = "son_help";
				col_id = "(sonnim";
			}
		}

		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO " + table + " 		\n");
		sql.append(col_id + "_id, title, content, parent, notice, reply_yn)   \n");
		sql.append("VALUES(?, ?, ?, -1, -1, 1) 		\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println(Integer.parseInt(map.get("id")));
			System.out.println(map.get("title"));
			System.out.println(map.get("content"));
			
			pstmt.setInt(1, Integer.parseInt(map.get("id")));
			pstmt.setString(2, map.get("title"));			
			pstmt.setString(3, map.get("content"));

			System.out.println("sql=" + sql.toString());

			int result = pstmt.executeUpdate();
			return (result == 1);			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnect();
		}		
		
		return false;
	}

	public void do_blind(HashMap<String, String> map) {
		
		try {

			connect();
			
			String table = "store_help";
			String col_id = "store";
			if(map.get("issonnim").equals("true")) {					
				
				if(map.get("table").equals("store_help")) {
					
				} else {
					table = "son_help";
					col_id = "sonnim";
				}
			}

			StringBuilder sql = new StringBuilder();
			sql.append("update " + table + " \n");
//			sql.append("set title=?,         \n");
//			sql.append("content=?            \n");
			sql.append("set reply_yn=2		 \n");
			sql.append("where seq_no=?       \n");

			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
//			pstmt.setString(1, "관리자에 의해 블라인드 처리되었습니다");
//			pstmt.setString(2, "바르고 고운말을 사용합시다<br>감사합니다");
			pstmt.setInt(1, Integer.parseInt(map.get("no")));

			pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("do_update() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
	}

	// X
	@Override
	public boolean do_upsert(HashMap<String, String> map) {
		
		return false;
	}

}
