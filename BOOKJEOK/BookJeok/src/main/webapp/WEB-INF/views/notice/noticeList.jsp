<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
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

        #noticeList {text-align:center;}
        #noticeList>tbody>tr:hover {cursor:pointer;}

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
            <h2>게시판</h2>
            <br>
            
            	<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
            	<a class="btn btn-secondary" style="float:right;" href="noticeForm.do">글쓰기</a>
            <br>
            <br>
            <table id="noticeList" class="table table-hover" align="center">
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
                    <c:forEach items="${ list }" var="notice">
                       <tr class="notice-detail" id="noticeNo-${ notice.noticeNo }">
                          <td>${ notice.noticeNo }</td>
                          <td>${ notice.noticeTitle }</td>
                          <td>${ notice.userID }</td>
                          <td>${ notice.count }</td>
                          <td>${ notice.noticeDate }</td>
                          <td>
                             <c:if test="${ not empty notice.originName }">
                                ♨   
                             </c:if>
                          </td>
                       </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br>
            <script>

            $(() =>{
                  $('.notice-detail').click(e => {
                	  location.href = 'notice-detail?noticeNo=' + e.currentTarget.id.split('-')[1];
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
			                            <a class="page-link" href="noticeList?page=${ pageInfo.currentPage - 1 }">이전</a>
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
			                        <a class="page-link" href="noticeList?page=${ p }">${ p }</a>
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
			                    <a class="page-link" href="noticeList?page=${ pageInfo.currentPage + 1 }">다음</a>
			                </li>
			            </c:when>
			            <c:otherwise>
			                <c:choose>
			                    <c:when test="${ empty condition }">
			                        <li class="page-item">
			                            <a class="page-link" href="noticeList?page=${ pageInfo.currentPage + 1 }">다음</a>
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


</body>
</html>