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
public class SonnimDao implements WorkArea {
	
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
//==============================================================================
    // 로그인
    public HashMap<String, String> do_login(HashMap<String, String> map) {
    	this.connect();
		
    	HashMap<String, String> sonnim = null;
		
		try{
			StringBuilder sql = new StringBuilder();
			
			sql.append("SELECT SONNIM_ID               \n");
			sql.append("		,EMAIL                 \n");              
			sql.append("		,PASSWORD              \n");
			sql.append("		,PHONE                 \n");
			sql.append("		,BIRTHDAY              \n");
			sql.append("		,NAME                  \n");
			sql.append("FROM  SONNIM                   \n");
			sql.append("WHERE EMAIL=? AND PASSWORD=?   \n");

			pstmt = conn.prepareStatement(sql.toString());
    		
//    		// 확인용
//    		System.out.println("1 pstmt"+pstmt.toString());  
//    		System.out.println("2 sql="+sql.toString()); 
    		
    		pstmt.setString(1, map.get("email"));
    		pstmt.setString(2, map.get("password"));
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				sonnim = new HashMap();
				
				sonnim.put("sonnim_id",	rs.getString(1));
				sonnim.put("email",		rs.getString(2));
				sonnim.put("password",	rs.getString(3));
				sonnim.put("phone",		rs.getString(4));
				sonnim.put("birthday",	rs.getString(5));
				sonnim.put("name",		rs.getString(6));

				return sonnim;
			}
			
		}catch(SQLException e){
		}finally{
			this.disConnect();		//접속종료
		}	
		
		return null;		
	}
    
	// 회원가입시 email중복체크
    public boolean do_checkEmail(HashMap<String, String> map) {
    	this.connect();				// db접속
    	String email =null;
    
    	try{
    		StringBuilder sql = new StringBuilder();
    		
    		sql.append("SELECT email     \n");
    		sql.append("FROM SONNIM      \n");
    		sql.append("WHERE email = ?  \n");
    		
    		pstmt = conn.prepareStatement(sql.toString());
    		
    		pstmt.setString(1, map.get("email"));
    		
//    		// 확인용
//    		System.out.println("1 pstmt"+pstmt.toString());  
//    		System.out.println("2 sql="+sql.toString()); 
    		
    		//executeUpdate 리턴되는것은 <적용된 행의 갯수>
    		//executeUpdate 리턴되는것은 <레코드셋 결과>
    		int result = pstmt.executeUpdate();

    		return (result == 1);
    	}catch(Exception e){
    	}finally{
    		this.disConnect();		//접속종료
    	}
    	
    	return false; 		
	}
	
	@Override
	public boolean do_delete(HashMap<String, String> map) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
    		sql.append("DELETE FROM SONNIM    \n");
    		sql.append("WHERE SONNIM_ID=?     \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
    		pstmt.setString(1, map.get("sonnim_id"));
			
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
	
	@Override
	public boolean do_upsert(HashMap<String, String> map) {
		
		try {
			
			connect();
			
			StringBuilder sql = new StringBuilder();
			
    		sql.append("MERGE INTO SONNIM T1                                                           \n");
    		sql.append("USING ( SELECT  ?       as SONNIM_ID                                           \n");
    		sql.append("               ,?       as EMAIL                                        	   \n");
    		sql.append("               ,?       as PASSWORD                                            \n");
    		sql.append("               ,?       as PHONE                                               \n");
    		sql.append("               ,?       as BIRTHDAY                                      	   \n");
    		sql.append("               ,?       as NAME                                         	   \n");
    		sql.append("        FROM dual                                                              \n");
    		sql.append("       ) T2                                                                    \n");
    		sql.append("ON ( T1.SONNIM_ID = T2.SONNIM_ID)                                              \n");
    		sql.append("WHEN MATCHED THEN                                                              \n");
    		sql.append("  UPDATE SET                                                                   \n");
    		sql.append("             T1.EMAIL   = T2.EMAIL,                                            \n");
    		sql.append("             T1.PASSWORD= T2.PASSWORD,                                         \n");
    		sql.append("             T1.PHONE   = T2.PHONE,                                            \n");
    		sql.append("             T1.BIRTHDAY= T2.BIRTHDAY,                                         \n");
    		sql.append("             T1.NAME = T2.NAME                                                 \n");
    		sql.append("WHEN NOT MATCHED THEN                                                          \n");
    		sql.append("INSERT (SONNIM_ID,EMAIL,PASSWORD,PHONE,BIRTHDAY,NAME)                          \n");
    		sql.append("VALUES (seq_sonnim.nextval,T2.EMAIL, T2.PASSWORD,T2.PHONE,T2.BIRTHDAY,T2.NAME) \n");
			
			pstmt = conn.prepareStatement(sql.toString());
			
    		pstmt.setString(1, map.get("sonnim_id"));
    		pstmt.setString(2, map.get("email"));
    		pstmt.setString(3, map.get("password"));
    		pstmt.setString(4, map.get("phone"));
    		pstmt.setString(5, map.get("birthday"));
    		pstmt.setString(6, map.get("name"));
			
			System.out.println("sql=" + sql.toString());
			
			int result = pstmt.executeUpdate();
			
			return (result == 1);
			
		} catch (SQLException e) {
			System.out.println("do_upsert() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			disConnect();
		}
		
		return false;
	}
 	// 하트상점 목록 보여주기 페이징
 	public ArrayList<HashMap> do_selectHeartList(HashMap<String, String> map) {
 		// 한페이지 보여줄 목록수 고정하면 pageSize는 안받아도 됨
 	 	//public ArrayList<HashMap> selectHeartList(String sonnim_id, int pageNum,int pageSize) {
 		connect();
 		HashMap<String, String> data = null;
 		ArrayList data_list = new ArrayList();

 		try{
 			StringBuilder sql = new StringBuilder();
 			
 			sql.append("SELECT TT1.*                                           \n");
 			sql.append("FROM                                                   \n");
 			sql.append("  (SELECT ROWNUM RNUM,                                 \n");		// rnum
			sql.append(" 			     T1.*,                                 \n");
			sql.append(" 			     T2.*                                  \n");
 			sql.append("  FROM                                                 \n");
 			sql.append("    ( SELECT                                           \n");
 			sql.append("          NVL((SELECT ROUND(AVG(starpoint))            \n");
 			sql.append("          FROM review                                  \n");
 			sql.append("          WHERE store_id = s.store_id),0) AS 별점평균, \n");		// 별점 평균
 			//sql.append("          h.sonnim_id,                                 \n");		// 손님 id
 			sql.append("          s.name,                                      \n");		// 상점명
 			sql.append("          s.IMAGEURI1                                  \n");		// 이미지1개
 			//sql.append("          s.store_id                                   \n");		// 상점 id
 			sql.append("        FROM store s INNER JOIN heart h                \n");
 			sql.append("        ON s.STORE_ID   = h.STORE_ID                   \n");
 			sql.append("        WHERE sonnim_id = ?                            \n");
 			sql.append("        order by s.name                                \n");
 			sql.append("    )T1 NATURAL JOIN                                   \n");
 			sql.append("    (                                                  \n");
 			sql.append("      SELECT COUNT(*)                                  \n");		// 총 글의 갯수	
 			sql.append("      FROM store s JOIN heart h                        \n");
 			sql.append("      ON s.STORE_ID   = h.STORE_ID                     \n");
 			sql.append("      WHERE sonnim_id = ?                              \n");
 			sql.append("    )T2                                                \n");
 			sql.append("  )TT1                                                 \n");
 			sql.append("WHERE RNUM BETWEEN (4 * (?-1)+1) AND (( 4 * (?-1))+4 ) \n");
 			//sql.append("WHERE RNUM BETWEEN (? * (?-1)+1) AND (( ? * (?-1))+? ) \n"); 
 			//sql.append("WHERE RNUM BETWEEN (4 * (1-1)+1) AND ((4 * (1-1))+4)   \n");	= 쿼리 이렇게 나와야 답
 			//음식점명 순으로 소트, 한 화면에 4개씩 보여주기
 			//sql.append("WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE ) \n");

 			pstmt = conn.prepareStatement(sql.toString());
     		//System.out.println("1 pstmt"+pstmt.toString());  
     		
 			pstmt.setString(1, map.get("sonnim_id"));
 			pstmt.setString(2, map.get("sonnim_id"));
 			pstmt.setString(3, map.get("pageNum"));
 			pstmt.setString(4, map.get("pageNum"));
     		
     		ResultSet rs = pstmt.executeQuery();

 			while(rs.next()) {
 				data = new HashMap();
 				
 				data.put("RNUM",rs.getString("RNUM"));
 				data.put("starpoint",rs.getString(2));
 				data.put("storeName",rs.getString(3));
 				data.put("storeImage",rs.getString(4));
 				data.put("totCnt",rs.getString(5));
 				
 				data_list.add(data);
 			}
 			
 	}
 	catch(Exception e) {
 		System.out.println("selectDBList() : "+e);
 	}
 	finally {
 		this.disConnect();
 	}
 	return data_list;
     }
//==================================================================================
	@Override
	public HashMap<String, String> do_detail(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean do_insert(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean do_update(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, String search_div,
			String search_word) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
