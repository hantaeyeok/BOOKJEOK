<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>공지사항 목록입니다. NoticeList </title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        #boardList {text-align:center;}
        #boardList>tbody>tr:hover {cursor:pointer;}

        #pagingArea {width:fit-content; margin:auto;}
        
        #searchForm {
            width:80%;
            margin:auto;
        }
        #searchForm>* {
            float:left;
            margin:5px;
        }
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
    </style>
</head>
<body>
    
    <jsp:include page="../common/menubar.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>공지사항</h2>
            <br>
            
            	<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
            	<a class="btn btn-secondary" style="float:right;" href="boardForm.do">글쓰기</a>
            <br>
            <br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th>첨부파일</th>
                    </tr>
                </thead>
                <tbody>
                
                   <c:choose>
                      <c:when test="${list.size() == 0 }">
                         <tr>
                            <td colspan="6">조회된 결과가 존재하지 않습니다.</td>
                         </tr>
                      </c:when>
                   </c:choose>
                    <c:forEach items="${ list }" var="board">
                       <tr class="board-detail" id="boardNo-${ board.boardNo }">
                          <td>${ board.boardNo }</td>
                          <td>${ board.boardTitle }</td>
                          <td>${ board.boardWriter }</td>
                          <td>${ board.count }</td>
                          <td>${ board.createDate }</td>
                          <td>
                             <c:if test="${ not empty board.originName }">
                                ♨   
                             </c:if>
                          </td>
                       </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br>
            <script>
            /*
//          $(() => {
            	// <js 고려요소>
            	// 1번. 어떤 친구들을		== evnetTarget
            	// 2번. 언제				== eventType
            	
          		// console.log($('.board-detail'));		// event 줄 대상
          		
          		// .addEventListener() --> 권장사항		// 쓰면 베스트이긴 한데 클라이언트 요구에 따라 못 쓸 경우도 존재
          		// on이벤트 속성
          		// 익명함수 대입~
          		// 인라인방식
          		
          		// $
          		// .on()	=> jQuery 중 권장
          		// 이벤트타입()
//         		$('.board-detail').click(e => {		// tr요소에 클릭 이벤트 달아 둠.
          			// alert('ㅎㅇㅎㅇ');
          			// URL변경
          			// console.log(window);		// js에서의 window = 자바에서의 Object클래스(최상위클래스)
          			
          			// window.console.log('adfads');
          			// console이고 alert이고 전부 window에서 빠져나온 것임

          		// $('.board-detail').on('click', handler())
          		// console.dir(pagingArea);
          		
          		/* <js 객체 쓰기>
          		const student = {
          			name : '홍길동',
          			grade : 1
          		};
          		*/
          		
          		//console.log(student);
          		
          		// student.grade = 2;
          		
          		//console.log(student);
          		//location.href = '리터럴값';
          		
          		/* ★ 이벤트가 발생한 타겟을 찾아가는 방법 ★ */
          		//console.log(e.target);	// 현재 이벤트가 발생했을 때 어떤 td를 선택했는지
          		//console.log(e.currentTarget.id.split('-')[1]);	// 실제로 이벤트가 달려서 이벤트를 동작시키는 요소(여기선 tr)
          		
          		// ★★★ jQuery메서드를 이용해 타겟의 자식 요소를 찾아가겠다?
          		// console.log(e.currentTarget); => 자바스크립트 방식 선택
          		// console.log($(e.currentTarget).children().eq(0).text());	// => jQuery 방식 선택
//          		location.href = 'board-detail?boardNo=' + e.currentTarget.id.split('-')[1];
          			// children() : 자식요소 선택 메서드
          			// eq('자식요소인덱스(0~)') 메서드 : 여기서는 <tr>아래 첫 번째 <td> 요소
          			// text() : 거기에 있는 text
          			
          			// find('선택자') <-- 활용도가 가장 높음
          			// children() (jQuery에 정의되어 있는 메서드)
          		
          		//location.href = 'board-detail';
//         		});
//            });
            $(() =>{
                  $('.board-detail').click(e => {
                	  location.href = 'board-detail?boardNo=' + e.currentTarget.id.split('-')[1];
                  });
               });
            </script>

            <div id="pagingArea">
			    <ul class="pagination">
			        <c:choose>
			            <c:when test="${ pageInfo.startPage eq pageInfo.currentPage }">
			                <li class="page-item disabled">
			                    <a class="page-link" href="#">이전</a>
			                </li>
			            </c:when>
			            <c:otherwise>
			                <c:choose>
			                    <c:when test="${ empty condition }">
			                        <li class="page-item">
			                            <a class="page-link" href="boardList?page=${ pageInfo.currentPage - 1 }">이전</a>
			                        </li>
			                    </c:when>
			                    <c:otherwise>
			                        <li class="page-item">
			                            <a class="page-link" href="search.do?page=${ pageInfo.currentPage - 1 }&condition=${condition}&keyword=${keyword}">이전</a>
			                        </li>
			                    </c:otherwise>
			                </c:choose>
			            </c:otherwise>
			        </c:choose>
			        <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="p">
			            <c:choose>
			                <c:when test="${ empty condition }">
			                    <li class="page-item ${ pageInfo.currentPage eq p ? 'active' : '' }">
			                        <a class="page-link" href="boardList?page=${ p }">${ p }</a>
			                    </li>
			                </c:when>
			                <c:otherwise>
			                    <li class="page-item ${ pageInfo.currentPage eq p ? 'active' : '' }">
			                        <a class="page-link" href="search.do?page=${ p }&condition=${condition}&keyword=${keyword}">${ p }</a>
			                    </li>
			                </c:otherwise>
			            </c:choose>
			        </c:forEach>
			        <c:choose>
			            <c:when test="${ pageInfo.maxPage eq pageInfo.currentPage }">
			                <li class="page-item disabled">
			                    <a class="page-link" href="boardList?page=${ pageInfo.currentPage + 1 }">다음</a>
			                </li>
			            </c:when>
			            <c:otherwise>
			                <c:choose>
			                    <c:when test="${ empty condition }">
			                        <li class="page-item">
			                            <a class="page-link" href="boardList?page=${ pageInfo.currentPage + 1 }">다음</a>
			                        </li>
			                    </c:when>
			                    <c:otherwise>
			                        <li class="page-item">
			                            <a class="page-link" href="search.do?page=${ pageInfo.currentPage + 1 }&condition=${condition}&keyword=${keyword}">다음</a>
			                        </li>
			                    </c:otherwise>
			                </c:choose>
			            </c:otherwise>
			        </c:choose>
			    </ul>
			</div>

            <br clear="both"><br>

            <form id="searchForm" action="search.do" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="condition">
                        <option value="writer">작성자</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword" value="${ keyword }">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
            
            <br><br>
            
            <script>
	            $(() => {
	            	$('#searchForm option[value="${condition }"]').attr('selected',true);
	            });
            </script>
            
        </div>
        <br><br>

    </div>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>