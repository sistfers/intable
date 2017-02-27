package intable.board.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import intable.abstracts.WorkArea;

public class QnADao implements WorkArea {
	
	private QnADao() {
	}

	private static QnADao qDao;

	public static QnADao getQnADao() {

		if (qDao == null) {
			qDao = new QnADao();
		}

		return qDao;
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

	@Override
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, String search_div,
			String search_word) {
		
		int begin = pageSize * (pageNum - 1) + 1;
		int end = pageSize * (pageNum - 1) + pageSize;

		ArrayList<HashMap<String, String>> selected_list = null;

		HashMap<String, String> data = null;
		
		try {

			connect();

			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
//			sql.append("SELECT RST1.rnum, RST1.seq_no, RST1.sonnim_id, RST1.store_id, RST1.title,       \n");
//			sql.append("RST1.content, RST1.writedate, RST1.readcount, RST1. parent, RST1.reply_yn, RST2.name   \n");
//			sql.append("FROM (                                                                          \n");
//			sql.append("SELECT *                                                                        \n");          
//			sql.append("FROM (                                                                          \n");          
//			sql.append("  SELECT T1.rnum, T1.seq_no, T1.sonnim_id, T1.store_id, T1.title,               \n");    
//			sql.append("   T1.content, T1.writedate, T1.readcount, T1.parent, T1.reply_yn               \n");           
//			sql.append("  FROM ( 		                                                	            \n");         
//			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,                 \n");
//			sql.append("  sonnim_id, store_id, title, content, writedate, readcount, parent, reply_yn   \n");                                        
//			sql.append("  FROM store_son                                                                \n");   
//			sql.append("  WHERE parent IS NULL) T1                                                      \n");          
//			sql.append("WHERE T1.rnum>=? AND T1.rnum<=? 		                                        \n");           
//			sql.append("UNION ALL                                                                       \n");           
//			sql.append("SELECT rownum as rnum, seq_no, sonnim_id, store_id, title,                      \n");      
//			sql.append("content, writedate, readcount, parent, reply_yn                                 \n");            
//			sql.append("FROM store_son s                                                                \n");     
//			sql.append("WHERE EXISTS ( 		                                                            \n");
//			sql.append("  SELECT T2.seq_no                                                              \n");           
//			sql.append("  FROM (                                                                        \n");           
//			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no, sonnim_id,      \n");
//			sql.append("  store_id, title, content, writedate, readcount, parent, reply_yn              \n");                            
//			sql.append("  FROM store_son                                                                \n");       
//			sql.append("  WHERE parent IS NULL ) T2 	                                                \n");               
//			sql.append("  WHERE T2.rnum>=? AND T2.rnum<=?                 	                            \n");          
//			sql.append("  AND T2.seq_no=s.parent))                                                      \n");          
//			sql.append("START WITH parent IS NULL                                                       \n");        
//			sql.append("CONNECT BY PRIOR seq_no=parent                                                  \n");           
//			sql.append("ORDER SIBLINGS BY seq_no DESC ) RST1 JOIN (                                     \n");
//			sql.append("SELECT sonnim_id, name 	                                                        \n");
//			sql.append("FROM sonnim ) RST2 ON (RST1.sonnim_id=RST2.sonnim_id)                           \n");
			
			sql.append("SELECT RST1.rnum, RST1.seq_no, RST1.sonnim_id, RST1.title, RST1.content,  \n");
			sql.append("RST1.writedate, RST1.readcount, RST1. parent, RST1.reply_yn, RST2.name    \n");
			sql.append("FROM (                                                                    \n");
			sql.append("SELECT *                                                                  \n");                
			sql.append("FROM (                                                                    \n");                
			sql.append("  SELECT T1.rnum, T1.seq_no, T1.sonnim_id, T1.title,                      \n");
			sql.append("   T1.content, T1.writedate, T1.readcount, T1.parent, T1.reply_yn         \n");                 
			sql.append("  FROM ( 		                                                	      \n");               
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,           \n");
			sql.append("  sonnim_id, title, content, writedate, readcount, parent, reply_yn       \n");                                    
			sql.append("  FROM son_help                                                           \n");        
			sql.append("  WHERE parent IS NULL) T1                                                \n");                
			sql.append("WHERE T1.rnum>=1 AND T1.rnum<=10 		                                  \n");                 
			sql.append("UNION ALL                                                                 \n");                 
			sql.append("SELECT rownum as rnum, seq_no, sonnim_id, title,                          \n");  
			sql.append("content, writedate, readcount, parent, reply_yn                           \n");                  
			sql.append("FROM son_help s                                                           \n");          
			sql.append("WHERE EXISTS ( 		                                                      \n");
			sql.append("  SELECT T2.seq_no                                                        \n");                 
			sql.append("  FROM (                                                                  \n");                 
			sql.append("  SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,           \n");
			sql.append("  sonnim_id, title, content, writedate, readcount, parent, reply_yn       \n");                                   
			sql.append("  FROM son_help                                                           \n");            
			sql.append("  WHERE parent IS NULL ) T2 	                                          \n");                     
			sql.append("  WHERE T2.rnum>=1 AND T2.rnum<=10                 	                      \n");                
			sql.append("  AND T2.seq_no=s.parent))                                                \n");                
			sql.append("START WITH parent IS NULL                                                 \n");              
			sql.append("CONNECT BY PRIOR seq_no=parent                                            \n");                 
			sql.append("ORDER SIBLINGS BY seq_no DESC ) RST1 JOIN (                               \n");
			sql.append("SELECT sonnim_id, name 	                                                  \n");
			sql.append("FROM sonnim ) RST2 ON (RST1.sonnim_id=RST2.sonnim_id)                     \n");
			
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
				data.put("sonnim_id", rs.getString(3));
				data.put("store_id", rs.getString(4));
				data.put("title", rs.getString(5));
				data.put("content", rs.getString(6));
				data.put("writedate", rs.getString(7));
				data.put("readcount", rs.getString(8));
				data.put("parent", rs.getString(9));
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

	@Override
	public boolean do_insert(HashMap<String, String> map) {

		try {
			
			connect();			

			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO store_son(sonnim_id, store_id, title, content)   \n");
			sql.append("VALUES(?, ?, ?, ?) 											 \n");

			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, Integer.parseInt(map.get("sonnim_id")));
			pstmt.setInt(2, Integer.parseInt(map.get("store_id")));
			pstmt.setString(3, map.get("title"));			
			pstmt.setString(4, map.get("content"));

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

	@Override
	public HashMap<String, String> do_detail(HashMap<String, String> map) {
		
		return null;
	}
	
}
