package intable.abstracts;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * DAO 템플릿
 * 
 * @author 박성우
 *
 */
public class WorkTemplate implements WorkArea {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String jdbc_driver = "oracle.jdbc.OracleDriver";
	private String jdbc_url = "jdbc:oracle:thin:@magoon.co.kr:1521:orcl";
	
	private void connect() {
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "sky", "sky");
			System.out.println("conn=" + conn.toString());
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
		
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		try {
			
			connect();
			
			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			// TODO parameter 입력
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				data = new HashMap<String, String>();
				
				// TODO 쿼리 결과 저장
				
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
			
			// TODO sql 작성
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			// TODO parameter 입력
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				data = new HashMap<String, String>();
				
				// TODO 쿼리 결과 저장
				
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
	public boolean do_insert(HashMap<String, String> map) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			// TODO parameter 입력
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (Exception e) {
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
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			// TODO parameter 입력
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (Exception e) {
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
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			// TODO parameter 입력
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (Exception e) {
			System.out.println("do_delete() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}
	
	@Override
	public boolean do_upsert(HashMap<String, String> map) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			
			pstmt = conn.prepareStatement(sql.toString());
			
			System.out.println("sql=" + sql.toString());
			
			// TODO parameter 입력
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (Exception e) {
			System.out.println("do_upsert() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}
	
}
