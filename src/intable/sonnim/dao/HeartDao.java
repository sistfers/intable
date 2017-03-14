package intable.sonnim.dao;

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
public class HeartDao implements WorkArea {
	
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
	
	/**
	 * 처음 들어갔을 때 보이는 좋아요 수
	 * @param store_id
	 * @return count
	 */
	public int do_heartCount(String store_id){
		
		int count = 0;
		
		try{

			connect();
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			sql.append("SELECT COUNT(*) AS heartCnt ");
			sql.append("FROM HEART               ");
			sql.append("WHERE STORE_ID = ?       ");
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, store_id);
			
			rs = pstmt.executeQuery();
			while(rs.next()){		
				count = rs.getInt("heartCnt");
			}
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			disConnect();
		}
		
		return count;
	}
	
	/**
	 * 현재 스토어에 대해 하트를 추가했는지 아닌지를 확인한다.
	 * @param sonnim_id
	 * @param store_id
	 * @return
	 */
	public boolean do_heartCheck(String sonnim_id, String store_id){
		
		int count = 0;

		try{
			
			connect();
			
			StringBuilder sql = new StringBuilder();
		
			// TODO sql 작성 
			sql.append("SELECT count(sonnim_id) cnt			  \n");
			sql.append("FROM HEART         					  \n");
			sql.append("WHERE SONNIM_ID = ? AND STORE_ID = ?  \n");
				
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, sonnim_id);
			pstmt.setString(2, store_id);
			System.out.println("확인 : " + sonnim_id + " " + store_id);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			count = rs.getInt("cnt");
			System.out.println("count : " + count);
						
			return (count>0);
			
		} catch (SQLException e) {
			System.out.println("do_heartCheck() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}
	
	/**
	 * 하트insrt.
	 * 눌렀을 경우 하트 추가
	 * true로 반환되면 
	 * 동시에 페이지 새로고침 또는 heartCheck다시하여 하트를 채우게.
	 */
	
	@Override
	public boolean do_insert(HashMap<String, String> map) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			sql.append("INSERT INTO heart ");
			sql.append("VALUES(?, ?)      ");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, map.get("sonnim_id"));
			pstmt.setString(2, map.get("store_id"));
			
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
	
	/**
	 * 내가 추가했던 하트를 삭제한다.
	 */
	@Override
	public boolean do_delete(HashMap<String, String> map) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			
			sql.append("delete from heart                 ");
			sql.append("where sonnim_id=? AND store_id=?  ");
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			System.out.println("map=" + map.toString());
			
			pstmt.setString(1, map.get("sonnim_id").toString());
			pstmt.setString(2, map.get("store_id").toString());
			
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
	
	@Override
	public boolean do_update(HashMap<String, String> map) {
		return false;
	}
	
	
	@Override
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		return null;
	}

	@Override
	public HashMap<String, String> do_detail(HashMap<String, String> map) {
		return null;
	}
		
	@Override
	public boolean do_upsert(HashMap<String, String> map) {
		return false;
	}
	
}
