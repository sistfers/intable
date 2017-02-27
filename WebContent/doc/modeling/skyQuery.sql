-- 리뷰작성할수있는 권한이 있는지.
		
	SELECT BOOKSTATE			
	FROM BOOKING			
	WHERE SONNIM_ID=3 AND STORE_ID=2;			

return count != 1 ? False:true;				


-- 리뷰삽입하는경우
INSERT INTO review						
VALUES((SELECT no						
        FROM BOOKING						
        WHERE sonnim_id=100 AND bookstate=1 AND store_id=901),						
        100,						
        901,						
        'review',						
        5);  						


-- 베스트 추천업체(별점순)
SELECT B.RNUM,
  B.STORE_ID,
  B.NAME
FROM
  (SELECT ROWNUM AS RNUM,
    STORE_ID,
    NAME
  FROM STORE
  ORDER BY
    (SELECT SUM(STARPOINT) FROM REVIEW
    ) DESC
  ) B
WHERE RNUM < 5;


-- 지역 검색
SELECT *
FROM store
WHERE SIDO LIKE '수원시%' OR SIGUNGU LIKE '수원시%';

-- 카테고리검색
SELECT *
FROM store
WHERE CATEGORY LIKE '한식%';

-- 이름검색
SELECT *
FROM store
WHERE name LIKE '맛점%';
}


SELECT store_id, name, IMAGEURI1
FROM store;

   
-- 하트인설트 (true로 반환되면 +1이 되어 현재 heart카운트에 반환한 +1값을 대입해준다)
-- +1 인 경우 하트를 채우게
INSERT INTO heart
VALUES(6, 6);

-- 처음들어갔을때 보이는 좋아요 수
SELECT COUNT(*) heartCnt
FROM HEART
WHERE STORE_ID = ?

-- 하트가 칠해져있는지 아닌지 (페이지 킬때 동시구동)
-- 해서 결과가 NULL이 아니라면(true) 하트가 칠해져있는 상태로.
-- 결과가 NULL이면 (false) 하트가 비워져있게.
SELECT *
FROM HEART
WHERE SONNIM_ID = ? AND STROE_ID = ?;



-- 하트 딜리트 -1반환
delete from heart
where sonnim_id=? AND store_id=?;





-- 전체목록에 대한 페이징(카테고리/그것별 페이징도 셀렉트문만 바꾸면됩니다)
SELECT TT1.*
  FROM(
SELECT ROWNUM RNUM,T1.*,T2.*
  FROM(
		SELECT store_id, name, IMAGEURI1
		FROM store
      )T1
      NATURAL JOIN
      (
        SELECT COUNT(*) TOT_CNT 
        FROM store
      )T2
)TT1
WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE );
