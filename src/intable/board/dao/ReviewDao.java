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
public class ReviewDao implements WorkArea {
	
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
	 * 리뷰 작성권한을 체크합니다(작성버튼을 누르는 순간 발동)
	 */
	
	public boolean reviewStateCheck(String sonnim_id, String store_id){
		
		int result = 0;
		
		try{
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			
			sql.append("SELECT BOOKSTATE			      \n");
			sql.append("FROM BOOKING			          \n");
			sql.append("WHERE SONNIM_ID=? AND STORE_ID=?  \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, sonnim_id);
			pstmt.setString(2, store_id);
			rs = pstmt.executeQuery();
			
			// rs값이 있을때만 돌린다. (값을 넣는다.) 값이 없을경우엔 0 그대로 반환, false.
			while(rs.next()){
				result = rs.getInt(1);
				if(result==1) return true;
			}
			
			System.out.println("체크 result : " + result); 
					
			return (result == 1); // 이용완료 상태
		
		}catch(SQLException e){
			System.out.println("reivewCheck : " + e.getMessage());
			e.printStackTrace();
			
		}finally{
			disConnect();
		}
		
		return false; // 해당업체를 이용하신적이 없습니다.
	}
	
	/**
	 * 리뷰 출력
	 */
	public ArrayList<HashMap<String, String>> do_starList(int pageNum, int pageSize, String store_id) {
		
		ArrayList<HashMap<String, String>> selected_list = null;
		
		HashMap<String, String> data = null;
		
		try {
			
			connect();
			
			selected_list = new ArrayList<HashMap<String, String>>();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			sql.append("SELECT TT1.email,                                              ");
			sql.append("	   TT1.sonnim_id,                                          ");
			sql.append("	   TT1.sonnim_name,                                        ");
			sql.append("  TT1.store_id,                                                ");
			sql.append("  TT1.starpoint,                                      		   ");
			sql.append("  TT1.memo,                                                    ");
			sql.append("  TO_CHAR(TT1.writedate,'yyyy-mm-dd') AS writedate,            ");
			sql.append("  TOT_CNT,                                                     ");
			sql.append("  RNUM                                                   	   ");
			sql.append("FROM                                                           ");
			sql.append("  (SELECT ROWNUM AS RNUM,                                      ");
			sql.append("    T1.*,                                                      ");
			sql.append("    T2.*                                                       ");
			sql.append("  FROM                                                         ");
			sql.append("    (SELECT                                                    ");
			sql.append("      (SELECT email FROM sonnim WHERE sonnim_id = r.sonnim_id  ");
			sql.append("      ) AS email,                                              ");
			sql.append("      (SELECT sonnim_id FROM sonnim WHERE sonnim_id = r.sonnim_id  ");
			sql.append("      ) AS sonnim_id,                                          ");
			sql.append("      (SELECT name FROM sonnim WHERE sonnim_id = r.sonnim_id  ");
			sql.append("      ) AS sonnim_name,										    ");
			sql.append("      store_id,                                                ");
			sql.append("      starpoint,                                               ");
			sql.append("      memo,                                                    ");;
			sql.append("      writedate                                                ");
			sql.append("    FROM review r                                              ");
			sql.append("    WHERE store_id = ?                                         ");
			sql.append("    ORDER BY writedate DESC                                    ");
			sql.append("    )T1 NATURAL                                                ");
			sql.append("  JOIN                                                         ");
			sql.append("    ( SELECT COUNT(*) AS TOT_CNT FROM review                   ");
			sql.append("    WHERE store_id = ?                                         ");
			sql.append("    )T2                                                        ");
			sql.append("  )TT1                                                         ");
			sql.append("WHERE RNUM BETWEEN (? * (?-1)+1) AND ((? * (:pageNum-1))+?)	   ");
					
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			//TODO pstmt 인자값 채우기
			pstmt.setString(1, store_id);
			pstmt.setString(2, store_id);
			pstmt.setInt(3, pageSize);
			pstmt.setInt(4, pageNum);
			pstmt.setInt(5, pageSize);
			pstmt.setInt(6, pageNum);
			pstmt.setInt(7, pageSize);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				data = new HashMap<String, String>();
				
				// TODO 쿼리 결과 저장
				data.put("sonnim_id", rs.getString("sonnim_id"));
				data.put("email", rs.getString("email"));
				data.put("store_id", rs.getString("store_id"));
				data.put("starPoint", rs.getString("starPoint"));
				data.put("memo", rs.getString("memo"));
				data.put("wirtedate", rs.getString("writedate"));
				data.put("TOT_CNT", rs.getString("TOT_CNT"));
				data.put("RNUM", rs.getString("RNUM"));
				data.put("name", rs.getString("sonnim_name"));
				
				selected_list.add(data);
			}
			
			return selected_list;
			
		} catch (Exception e) {
			System.out.println("do_starList() : " + e);
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return null;
	}
	
	/**
	 * @param pageNum
	 * @param pageSize
	 * @param search_div
	 * @param search_word
	 * return ArrayList<HashMap>
	 */
	@Override
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		
		return null;
	}
	
	/**
	 * 리뷰 작성. (작성권한이 있는사람에 한해) true시 호출.
	 * @param map
	 * @return boolean
	 */
	@Override
	public boolean do_insert(HashMap<String, String> map) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			
			sql.append("	INSERT                      \n");
			sql.append("	INTO review                 \n");
			sql.append("	  (                         \n");
			sql.append("	    sonnim_id,              \n");
			sql.append("	    store_id,               \n");
			sql.append("	    memo,                   \n");
			sql.append("	    starpoint,              \n");
			sql.append("	    writedate               \n");
			sql.append("	  )                         \n");
			sql.append("	  VALUES                    \n");
			sql.append("	  (                         \n");
			sql.append("	    ?,                      \n");
			sql.append("	    ?,                      \n");
			sql.append("	    ?,		                \n");
			sql.append("	    ?,                      \n");
			sql.append("	    SYSDATE                 \n");
			sql.append("	   )                          ");
			
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, map.get("sonnim_id"));
			pstmt.setString(2, map.get("store_id"));
			pstmt.setString(3, map.get("memo"));
			pstmt.setString(4, map.get("starpoint"));
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (SQLException e) {
			System.out.println("do_insert() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		// 이미 리뷰를 작성하셨습니다.
		return false;
	}
	

	/**
	 * 본인이 삭제버튼을 누를경우 진행. 
	 * @param map
	 * @return
	 */
		@Override
		public boolean do_delete(HashMap<String, String> map) {
			
			try {
				
				connect();
				
				StringBuilder sql = new StringBuilder();
				
				// TODO sql 작성
				
				sql.append(" DELETE FROM review                       ");
				sql.append(" WHERE sonnim_id = ? AND store_id = ?     ");
				
				pstmt = conn.prepareStatement(sql.toString());
				System.out.println("sql=" + sql.toString());
				
				pstmt.setString(1, map.get("sonnim_id"));
				pstmt.setString(2, map.get("store_id"));
				
				int result = pstmt.executeUpdate();
				System.out.println("result 상태" + result);
				
				return (result == 1);
				
			} catch (SQLException e) {
				System.out.println("do_delete() : " + e.getMessage());
				e.printStackTrace();
			} finally {
				disConnect();
			}
			
			return false;
		}
	
	/**
	 * 
	 *  해당업체의 별점 평균
	 */
		
	public String do_starAvg(String store_id){
		
		String starAvg = "";

		try{
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
			// TODO sql 작성
			sql.append("SELECT ROUND(avg(starpoint),1) as starpoint	 \n");
			sql.append("FROM REVIEW			    \n");
			sql.append("WHERE STORE_ID = ?  	\n");
			sql.append("GROUP BY STORE_ID  		\n");
			
			pstmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());
			
			pstmt.setString(1, store_id);
			rs = pstmt.executeQuery();
			
			// rs값이 있을때만 돌린다. (값을 넣는다.) 값이 없을경우엔 0 그대로 반환, false.
			while(rs.next()){
				starAvg = rs.getString(1);
			}
			
			System.out.println("do_starAvg : " + starAvg); 
			
			return starAvg;
		
		}catch(SQLException e){
			System.out.println("delCheck : " + e.getMessage());
			e.printStackTrace();
			
		}finally{
			disConnect();
		}
		
		return starAvg;
	}
	@Override
	public HashMap<String, String> do_detail(HashMap<String, String> map) {
		return null;
	}
	
	@Override
	public boolean do_update(HashMap<String, String> map) {
		return false;
	}
	
	@Override
	public boolean do_upsert(HashMap<String, String> map) {
		
		return false;
	}
	
}
