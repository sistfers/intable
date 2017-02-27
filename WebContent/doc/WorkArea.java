/**
 * 
 */
package com.khy.mini;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * @author sist
 *
 */
public interface WorkArea {
	/**
     * 조회 
     * @param pageNum
     * @param pageSize
     * @param search_div
     * @param search_word
     * @return ArrayList<HashMap>
     */
	public ArrayList<HashMap> do_search(int pageNum,int pageSize
			,String search_div,String search_word);
	
    /**
     * 등록
     * @return boolean
     */
    public boolean do_insert(Object bean);
    
    /**
     * 수정
     * @return boolean
     */
    public boolean do_update(Object bean);    
    
    /**
     * 삭제
     * @return boolean
     */
    public boolean do_delete(Object bean);
    
    /**
     * 등록/수정
     * ex) merge into
     * @return boolean
     */
    public boolean do_upsert(Object bean);    
    
    /**
     * 상세
     * @return boolean
     */
    public boolean do_detail(Object bean);      
}
