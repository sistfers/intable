/*
 * 음식점 예약 목록 -- 시작
 */
SELECT
	*
FROM
	(
		SELECT
			ROWNUM AS rnum,
			b.*
		FROM
			(
				SELECT
					ROW_NUMBER() OVER(ORDER BY booking.no DESC) AS row_num,
					count(*) OVER() AS book_count,
					booking.no,
					booking.sonnim_id,
					booking.store_id,
					booking.bookdate,
					booking.bookstate,
					booking.booktime,
					booking.bookperson,
					booking.writedate,
					booking.note,
					sonnim.email,
					sonnim.password,
					sonnim.phone,
					sonnim.birthday,
					sonnim.name
				FROM
					booking
				INNER JOIN
					sonnim
				ON
					booking.sonnim_id = sonnim.sonnim_id
				WHERE
					booking.store_id = '1000000010'
					AND
--					booking.bookstate = NVL(NULL, 0)
					-1 = -1
					AND
					booking.bookdate >= NVL(NULL, TO_DATE('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
					AND
					booking.bookdate <= NVL(NULL, TO_DATE('2038-01-19 03:14:07', 'YYYY-MM-DD HH24:MI:SS'))
					AND
					(
						booking.no = '7'
						OR
						sonnim.name LIKE '마제오' ||  '%'
						OR
						sonnim.phone LIKE '010-9658-9116' || '%'
					)
				ORDER BY
					booking.no DESC
			) b
		WHERE
			rownum < 3
	)
WHERE
	rnum >= 1
;
/*
 * 음식점 예약 목록 -- 끝
 */

/*
 * 음식점 사용자 이메일 중복 확인 -- 시작
 */
SELECT
	*
FROM
	store
WHERE
	email = 'magoon85@me.com'
;
/*
 * 음식점 사용자 이메일 중복 확인 -- 끝
 */

/*
 * 음식점 사용자 로그인 -- 시작
 */
SELECT
	*
FROM
	store
WHERE
	email = 'magoon85@me.com'
	AND
	password = 'magoon85'
;
/*
 * 음식점 사용자 로그인 -- 끝
 */

/*
 * 음식점 사용자 정보 -- 시작
 */
SELECT
	*
FROM
	store
WHERE
	store_id = '1000000141'
	AND
	email = 'magoon85@me.com'
	AND
	password = 'magoon85'
;
/*
 * 음식점 사용자 정보 -- 끝
 */

/*
 * 음식점 사용자 가입/수정/탈퇴 -- 시작
 */
MERGE INTO
	store t
USING
	(
		SELECT
			new_store.*,
			old_store.email AS old_email,
			old_store.password AS old_password,
			old_store.phone AS old_phone,
			old_store.name AS old_name,
			old_store.zonecode AS old_zonecode,
			old_store.sido AS old_sido,
			old_store.sigungu AS old_sigungu,
			old_store.address1 AS old_address1,
			old_store.address2 AS old_address2,
			old_store.maxbooking AS old_maxbooking,
			old_store.imageuri1 AS old_imageuri1,
			old_store.imageuri2 AS old_imageuri2,
			old_store.imageuri3 AS old_imageuri3,
			old_store.imageuri4 AS old_imageuri4,
			old_store.imageuri5 AS old_imageuri5,
			old_store.open AS old_open,
			old_store.closed AS old_closed,
			old_store.category AS old_category,
			old_store.note AS old_note
		FROM
			(
				SELECT
					'magoon85@me.com' AS email,
					'magoon85' AS password,
					'010-9658-9116' AS phone,
					'마제오' AS name,
					'04100' AS zonecode,
					'서울' AS sido,
					'마포구' AS sigungu,
					'서울 마포구 백범로 18' AS address1,
					'미화빌딩 2, 3층' AS address2,
					'15' AS maxbooking,
					'/image/magoon85@me.com.1.png' AS imageuri1,
					'/image/magoon85@me.com.2.png' AS imageuri2,
					'/image/magoon85@me.com.3.png' AS imageuri3,
					'/image/magoon85@me.com.4.png' AS imageuri4,
					'/image/magoon85@me.com.5.png' AS imageuri5,
					'9' AS open,
					'20' AS closed,
					'빵식' AS category,
					'좋아요<br>좋습니다<br>좋다구요' AS note,
					'1000000130' AS signed_store_id,
					'magoon85@me.com' AS signed_store_email,
					'magoon85' AS signed_store_password,
					'dismiss_account' AS signed_store_account
				FROM
					DUAL
			) new_store
		LEFT OUTER JOIN
			store old_store
		ON
			new_store.signed_store_id = old_store.store_id
	) d
ON
	(
		t.store_id = d.signed_store_id
	)
WHEN MATCHED THEN
	UPDATE
	SET
		t.email = NVL(d.email, d.old_email),
		t.password = NVL(d.password, d.old_password),
		t.phone = NVL(d.phone, d.old_phone),
		t.name = NVL(d.name, d.old_name),
		t.zonecode = NVL(d.zonecode, d.old_zonecode),
		t.sido = NVL(d.sido, d.old_sido),
		t.sigungu = NVL(d.sigungu, d.old_sigungu),
		t.address1 = NVL(d.address1, d.old_address1),
		t.address2 = NVL(d.address2, d.old_address2),
		t.maxbooking = NVL(d.maxbooking, d.old_maxbooking),
		t.imageuri1 = NVL(d.imageuri1, d.old_imageuri1),
		t.imageuri2 = NVL(d.imageuri2, d.old_imageuri2),
		t.imageuri3 = NVL(d.imageuri3, d.old_imageuri3),
		t.imageuri4 = NVL(d.imageuri4, d.old_imageuri4),
		t.imageuri5 = NVL(d.imageuri5, d.old_imageuri5),
		t.open = NVL(d.open, d.old_open),
		t.closed = NVL(d.closed, d.old_closed),
		t.category = NVL(d.category, d.old_category),
		t.note = NVL(d.note, d.old_note)
	WHERE
		t.store_id = d.signed_store_id
		AND
		t.email = d.signed_store_email
		AND
		t.password = d.signed_store_password
	DELETE
	WHERE
		d.signed_store_account = 'dismiss_account'
WHEN NOT MATCHED THEN
	INSERT
		(
			t.store_id,
			t.email,
			t.password,
			t.phone,
			t.name,
			t.zonecode,
			t.sido,
			t.sigungu,
			t.address1,
			t.address2,
			t.maxbooking,
			t.imageuri1,
			t.imageuri2,
			t.imageuri3,
			t.imageuri4,
			t.imageuri5,
			t.open,
			t.closed,
			t.category,
			t.note
		)
	VALUES
		(
			seq_store.NEXTVAL,
			d.email,
			d.password,
			d.phone,
			d.NAME,
			d.zonecode,
			d.sido,
			d.sigungu,
			d.address1,
			d.address2,
			d.maxbooking,
			d.imageuri1,
			d.imageuri2,
			d.imageuri3,
			d.imageuri4,
			d.imageuri5,
			d.open,
			d.closed,
			d.category,
			d.note
		)
	WHERE
		NOT EXISTS
			(
				SELECT
					*
				FROM
					store
				WHERE
					store.email = d.email
			)
;
/*
 * 음식점 사용자 가입/수정/탈퇴 -- 끝
 */

/*
 * 음식점 사용자 예약 수정 -- 시작
 */
UPDATE
	booking
SET
	bookstate = 1
WHERE
	no = 221
	AND
	EXISTS
		(
			SELECT
				*
			FROM
				booking b
			INNER JOIN
				store s
			ON
				b.store_id = s.store_id
			WHERE
				s.store_id = 1000000009
				AND
				s.email = '2@2'
				AND
				s.password = '2'
		)
;
/*
 * 음식점 사용자 예약 수정 -- 끝
 */


/*
 * 음식점 사용자 이미지 데이터베이스 전체 행 수정 -- 시작
 */
UPDATE
	store t1
SET
	(
		imageuri1,
		imageuri2,
		imageuri3,
		imageuri4,
		imageuri5
	) = (
		SELECT
			'/upload/image/' || store_id || '/' || store_id || '.1.' || 'jpg' AS imageuri1,
			'/upload/image/' || store_id || '/' || store_id || '.2.' || 'jpg' AS imageuri2,
			'/upload/image/' || store_id || '/' || store_id || '.3.' || 'jpg' AS imageuri3,
			'/upload/image/' || store_id || '/' || store_id || '.4.' || 'jpg' AS imageuri4,
			'/upload/image/' || store_id || '/' || store_id || '.5.' || 'jpg' AS imageuri5
		FROM
			store t2
		WHERE
			t1.store_id = t2.store_id
	)
WHERE
	1 = 1
;
/*
 * 음식점 사용자 이미지 데이터베이스 전체 행 수정 -- 끝
 */

/*
 * 음식점 사용자 이미지 데이터베이스 전체 행 수정 -- 시작
 */
UPDATE
	store t1
SET
	(
		imageuri1,
		imageuri2,
		imageuri3,
		imageuri4,
		imageuri5
	) = (
		SELECT
			'/upload/image/' || 'default' || '/' || 'default' || '.1.' || 'jpg' AS imageuri1,
			'/upload/image/' || 'default' || '/' || 'default' || '.2.' || 'jpg' AS imageuri2,
			'/upload/image/' || 'default' || '/' || 'default' || '.3.' || 'jpg' AS imageuri3,
			'/upload/image/' || 'default' || '/' || 'default' || '.4.' || 'jpg' AS imageuri4,
			'/upload/image/' || 'default' || '/' || 'default' || '.5.' || 'jpg' AS imageuri5
		FROM
			store t2
		WHERE
			t1.store_id = t2.store_id
	)
WHERE
	t1.store_id < 2000000000
;
/*
 * 음식점 사용자 이미지 데이터베이스 전체 행 수정 -- 끝
 */

/*
 * 음식점 사용자 예약 추가 -- 시작
 */
INSERT INTO
	booking
		(
			sonnim_id,
			store_id,
			bookdate,
			bookstate,
			booktime,
			bookperson,
			writedate,
			note
		)
	SELECT
		sonnim.sonnim_id,
		store_id,
		bookdate,
		bookstate,
		booktime,
		bookperson,
		writedate,
		note
	FROM
		sonnim
	INNER JOIN
		booking
	ON
		sonnim.sonnim_id = booking.sonnim_id
;
	SELECT
		sonnim_id,
		store_id,
		bookdate,
		bookstate,
		booktime,
		bookperson,
		writedate,
		note
	FROM
		booking
;
/*
 * 음식점 사용자 예약 추가 -- 끝
 */

/*
 * 예약 상태 수정 -- 시작
 */
UPDATE
	booking   
SET
	bookstate
	=
	CASE
		WHEN
			MOD(no, 3) = 0
		THEN
			0
		WHEN
			MOD(no, 3) = 1
		THEN
			1
		WHEN
			MOD(no, 3) = 2
		THEN
			2
	ELSE
		0
	END
;
/*
 * 예약 상태 수정 -- 끝
 */


commit;
