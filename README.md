# JSP Project 2조

쌍용강북교육센터

git_hub 기반의 스프링을 활용한 실전 프레임워크 설계와 구축 개발자

웹 프로그래밍 실습 프로젝트 2조 삼시n끼 (n > 3) 팀의

inTable 서비스 개발 프로젝트.





## Team

삼시n끼 (n > 3)

- 김미현

- 마제오

- 박성우

- 박하늘: 팀장

- 조영숙

![team](http://sistfers.github.io/intable/docs/team.png)





## 프로젝트 진행 동기 및 목적

> 실제 서비스 기획과 프로젝트를 수행함으로써
>
> Java, Oracle, Web(HTML, CSS, JavaScript), Web Programming(Servlet, JSP) 등
>
> 자바 웹 개발 전반에 걸친 주요 기술에 대한 숙달.





## Service

음식점 추천 및 예약 서비스.

[inTable](http://magoon.co.kr)

> "언제나 열린 식탁"




### 소개

> 오프라인(음식점)과 온라인(손님) 간의 예약(열린식탁) 연동 서비스: O2O(Online to Offline).
>
> 손님에게는 지역/테마 기반 음식점 검색과 간편한 예약 서비스의 이용을,
>
> 음식점 사업자에게는 예약 채널의 다양화를 통한 홍보와 예약 관리 플랫폼을 제공.




### 참고

- [네이버 예약](http://easybooking.naver.com)

> "네이버 예약은 사업주의 홈페이지, 네이버 검색광고, 지도, 블로그, SNS 등 고객을 만날 수 있는 다양한 곳에서 네이버 ID 하나로 편리하게 예약할 수 있는 무료 예약 서비스입니다."

- [OpenTable](http://opentable.com)

> "OpenTable is an online restaurant-reservation service."




### 기능



#### 손님

- 가입

- 로그인

- 정보 수정

- 탈퇴

- 지역/테마 별 음식점 검색

- 지역/테마 기반 음식점 추천

- 손님-음식점 Q&A

	- 질문

	- 조회

	- 수정

	- 삭제

- SNS 공유



#### 음식점

- 가입

- 로그인

- 정보 수정

- 탈퇴

- 손님-음식점 Q&A

	- 답변

	- 조회

	- 수정

	- 삭제

- 예약 통계



#### 예약


##### 손님

- 예약

- 예약 상태

- 예약 조회

- 예약 수정

- 예약 평가

- 예약 취소


##### 음식점

- 예약

- 예약 상태

- 예약 조회

- 예약 수정

- 예약 평가

- 예약 취소



#### 관리자


##### 손님

- 등록

- 조회

- 수정

- 삭제


##### 음식점

- 등록

- 조회

- 수정

- 삭제


##### 예약

- 등록

- 조회

- 수정

- 삭제


##### 고객센터 Q&A

- 등록

- 조회

- 수정

- 삭제


##### 서비스 소개

- 등록

- 조회

- 수정

- 삭제


##### 예약 통계

- 예약순

- 평가순





## Plan

01. [2017-02-02 기획](http://sistfers.github.io/intable/2017/02/02/planning.html)

02. [2017-02-03 분석](http://sistfers.github.io/intable/2017/02/03/analysis.html)

03. [2017-02-06 설계](http://sistfers.github.io/intable/2017/02/06/design.html)

04. [2017-02-07 설계](http://sistfers.github.io/intable/2017/02/07/design.html)

05. [2017-02-08 설계](http://sistfers.github.io/intable/2017/02/08/design.html)

06. [2017-02-09 설계](http://sistfers.github.io/intable/2017/02/09/design.html)

07. [2017-02-10 구현](http://sistfers.github.io/intable/2017/02/10/implementation.html)

08. [2017-02-13 구현](http://sistfers.github.io/intable/2017/02/13/implementation.html)

09. [2017-02-14 구현](http://sistfers.github.io/intable/2017/02/14/implementation.html)

10. [2017-02-15 구현](http://sistfers.github.io/intable/2017/02/15/implementation.html)

11. [2017-02-16 구현](http://sistfers.github.io/intable/2017/02/16/implementation.html)

12. [2017-02-17 시험](http://sistfers.github.io/intable/2017/02/17/test.html)

13. [2017-02-20 시험](http://sistfers.github.io/intable/2017/02/20/test.html)

14. [2017-02-21 발표](http://sistfers.github.io/intable/2017/02/21/presentation.html)

![Plan](http://sistfers.github.io/intable/docs/plan.png)



## Site

[GitHub Pages](http://sistfers.github.io/intable)





## Repository

[GitHub](http://github.com/sistfers/intable)





## Conventions

[Conventions](http://github.com/sistfers/intable/tree/master/conventions)





## Documents

[Documents](http://github.com/sistfers/intable/tree/master/docs)

[열린식탁 Javadocs](http://sistfers.github.io/intable/docs/api)

[Java SE Javadocs](http://docs.oracle.com/javase/8/docs/api)

[Java EE Javadocs](http://docs.oracle.com/javaee/7/api)

[Tomcat Javadocs](http://tomcat.apache.org/tomcat-8.5-doc/api)





## Modeling

[Modeling](http://github.com/sistfers/intable/tree/master/modeling)




### Database UML

![Database](http://sistfers.github.io/intable/modeling/intable.png)




### Class UML

![Class](http://sistfers.github.io/intable/modeling/class.png)




### Sequence UML

![Sequence](http://sistfers.github.io/intable/modeling/sequence.png)





## 개발 환경 및 개발 툴

- [Java SE 8 (Oracle JDK 1.8.x)](http://jcp.org)

- [Oracle Database 12c Release 1 (12.1.x Enterprise Edition)](http://oracle.com)

- [Eclipse Neon (4.6.x)](http://eclipse.org)

- [Apache Tomcat (8.5.x)](http://tomcat.apache.org)

- [Apache Maven (3.3.9)](http://maven.apache.org)

- [Git](http://git-scm.com)

- [GitHub](http://github.com)





## 적용 기술 및 라이브러리 의존성

- [Servlet 3.1.x](http://jcp.org/en/jsr/detail?id=340)

- [JSP 2.3.x](http://jcp.org/en/jsr/detail?id=245)

- [EL 3.0.x](http://jcp.org/en/jsr/detail?id=341)

- [JSTL 1.2.x](http://jcp.org/en/jsr/detail?id=52)

- [Oracle JDBC Thin Driver 12.1.0.2](http://www.oracle.com/technetwork/database/features/jdbc/default-2280470.html)

- [Oracle 11g Release 2 (11.2) Standard SQL](http://docs.oracle.com/cd/E11882_01/server.112/e41084/ap_standard_sql.htm)

- [Oracle 12c Release 1 (12.1) Standard SQL](http://docs.oracle.com/database/121/SQLRF/ap_standard_sql.htm)

- [HTML5](http://w3.org/TR/html5)

- [CSS3](http://w3.org/TR/CSS)

- [JavaScript (ECMA-262 ECMAScript)](http://ecma-international.org/publications/standards/Ecma-262.htm)

- [jQuery 3.1.x](http://jquery.com)

- [jQuery UI 1.12.x](http://jqueryui.com)

- [Bootstrap 3.3.x](http://bootstrapk.com)

- [NAVER Maps](http://github.com/navermaps/maps.js)

- [NAVER SmartEditor](http://github.com/naver/smarteditor2)

- [Daum Maps](http://apis.map.daum.net)

- [Daum Postcode](https://github.com/daumPostcode)

- [Google Maps](http://enterprise.google.com/intl/ko/maps)





## 배포 타겟 서버 런타임 환경 및 브라우저 호환성

- Microsoft Windows 10 Insider Preview

- Oracle Java SE HotSpot Virtual Machine JRE 8u121

- Oracle Database 12c Release 1 Enterprise Edition 12.1.0.2.0

- Apache Tomcat 8.5.11

- Chrome Stable Version



