package intable.abstracts;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * @author 박성우
 *
 */
public interface WorkArea {

	/**
	 * 조회
	 * 
	 * @param pageNum
	 * @param pageSize
	 * @param search_div
	 * @param search_word
	 * @return ArrayList<HashMap>
	 */
	public ArrayList<HashMap<String, String>> do_search(int pageNum, int pageSize, String search_div,
			String search_word);

	/**
	 * 등록
	 * 
	 * @return boolean
	 */
	public boolean do_insert(HashMap<String, String> map);

	/**
	 * 수정
	 * 
	 * @return boolean
	 */
	public boolean do_update(HashMap<String, String> map);

	/**
	 * 삭제
	 * 
	 * @return boolean
	 */
	public boolean do_delete(HashMap<String, String> map);

	/**
	 * 등록/수정 ex) merge into
	 * 
	 * @return boolean
	 */
	public boolean do_upsert(HashMap<String, String> map);

	/**
	 * 상세
	 * 
	 * @return HashMap
	 */
	public HashMap<String, String> do_detail(HashMap<String, String> map);
}
