# 북적북적 (BiteNest) 프로젝트

## 프로젝트 개요
**도서 판매 및 독서 모임 동호회 전문 웹사이트**  
- **프로젝트 기간**: 2024-06-11 ~ 2024-07-20  
- **팀 명**: 북적북적  
- **GitHub**: [https://github.com/hantaeyeok/BOOKJEOK](https://github.com/hantaeyeok/BOOKJEOK)  
- **Notion**: [프로젝트 정보 및 진행 일지 (제출안)](https://www.notion.so/337cd286bac1485e8bd72c80d81701e7?pvs=21)

## 개발 환경
- **운영체제**: Windows 10(개발 환경), AWS EC2_Windows(운영 환경)
- **IDE**: STS3(Spring Tool Suite) 3.8.2242425, Visual Studio Code 19.2
- **DBMS**: Oracle 21.324234
- **WAS**: Apache Tomcat 10
- **언어**: Java (JDK 11), JavaScript
- **프론트엔드**: HTML5, CSS3
- **라이브러리**: JSTL, jQuery 3.7.1
- **협업 툴**: Notion, Slack, GitHub, Google Spreadsheet

## 주요 기능
- **도서 등록**: 도서 정보를 API와 외부 데이터를 통해 등록하며, 도서의 기본 정보 및 상세 정보 관리
- **도서 수정 및 삭제**: 관리자가 도서 정보를 수정 및 삭제할 수 있는 기능
- **도서 리뷰 및 평점 시스템**: 사용자 리뷰 및 평점 등록/수정, 리뷰 정렬 및 필터링
- **카테고리 관리**: 도서 카테고리 구조화 및 카테고리별 도서 검색
- **도서 검색**: 제목 및 저자 등을 기반으로 도서 검색 기능 제공
- **파일 업로드 및 처리**: 도서 이미지 파일 업로드 및 관리
- **API 연동**: Open API를 활용하여 도서 정보를 외부에서 가져오는 기능

## 기술 스택
- **백엔드**: Java (JDK 11), Spring Boot, MyBatis
- **프론트엔드**: HTML5, CSS3, jQuery
- **데이터베이스**: Oracle 21
- **배포**: AWS EC2

## 시스템 설계
### 1. **API 연동**
- 알라딘 Open API를 활용하여 도서 데이터를 JSON 형식으로 가져옵니다.
- API 호출 시, XML 형식의 응답 데이터를 JSON으로 변환하여 처리합니다.

## 담당 기능
- **도서 등록**: 관리자 페이지에서 도서 등록 및 상세 정보 입력
- **도서 수정 및 삭제**: 관리자 페이지에서 도서 정보 수정 및 삭제
- **도서 검색**: 사용자 검색 페이지에서 도서 제목, 저자 등을 기반으로 검색
- **도서 리뷰 및 평점**: 사용자 리뷰 및 평점 시스템 구현
- **카테고리 관리**: 도서 카테고리 선택 및 검색 기능
- **파일 업로드**: 도서 이미지 파일 업로드 및 관리

## 문제 해결 및 성과
1. **카테고리 DB 저장**: 초기에는 중복된 데이터 입력 및 불필요한 SELECT/INSERT 쿼리가 발생했으나, 전체 카테고리 데이터를 한 번에 조회하여 중복을 방지하고, 성능을 최적화하였습니다.
2. **파일 업로드 및 데이터 전송**: `FormData` 객체를 사용하여 파일과 텍스트 데이터를 동시에 처리하고, 서버로 안전하게 전송할 수 있도록 구현했습니다.
3. **API 호출 최적화**: 알라딘 Open API를 호출하는 로직을 리팩토링하여 재사용성과 유지보수성을 향상시켰습니다.

## 프로젝트의 교훈
- **초기 설계 중요성**: 데이터 입출력 방식에 대한 명확한 설계를 통해 프로젝트를 효율적으로 관리할 수 있었습니다.
- **협업과 소통**: 팀원들과의 긴밀한 협업을 통해 문제 해결에 적극적으로 참여할 수 있었으며, 프로젝트 성공적인 완수를 이끌었습니다.
- **문제 해결 능력 향상**: 성능 최적화 및 API 연동과 같은 다양한 기술적인 문제를 해결하며 많은 경험을 쌓을 수 있었습니다.

## 향후 계획
- 이번 프로젝트에서 얻은 경험을 바탕으로 더 나은 성능 최적화 및 확장성 있는 시스템을 설계하여 향후 프로젝트에 적용할 것입니다.
- 계속해서 문제 해결 능력을 향상시키고, 데이터 관리 및 API 통합 처리에서 발생할 수 있는 문제를 미리 예측하고 대비할 수 있도록 노력하겠습니다.
