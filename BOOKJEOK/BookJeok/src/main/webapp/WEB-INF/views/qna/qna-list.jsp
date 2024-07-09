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
    <!--  
    <jsp:include page="" />
	-->
    <div class="content">
        <br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>1대1 문의</h2>
            <br>
            <form id="searchForm" action="search.qna" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="condition">
                        <option value="title">문의제목</option>
                        <option value="status">처리상태</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword" value="${ keyword }">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
            
            <script>
	            $(() => {
	     
	            	$('#searchForm option[value="${condition}"]').attr('selected', true);
	            	
	            })
            </script>
            
            <br clear="both">
            <br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>문의번호</th>
                        <th>문의제목</th>
                        <th>문의날짜</th>
                        <th>처리상태</th>
                    </tr>
                </thead>
                <tbody>
                	<c:choose>
                		<c:when test="${ question.size() == 0 }">
                			<tr>
                				<td colspan="4">조회된 문의가 없습니다.</td>
                			</tr>
                		</c:when>
                	</c:choose>
                	<c:forEach items="${ question }" var="question">
                		<tr class="qna-detail" id="qnaNo-${ question.qnaNo }">
                			<td>${ question.qnaNo }</td>
	                        <td>${ question.questionTitle }</td>
	                        <td>${ question.questionDate }</td>
	                        <td>${ question.questionStatus }</td>
                		</tr>
                	</c:forEach>
                </tbody>
            </table>
            <br>
            <script>
            	$(() => {
            		
            		$('.qna-detail').click(e => {
            			
            			location.href = 'detail.qna?qnaNo=' + e.currentTarget.id.split('-')[1];
            		})
            	});
            </script>

            <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ '1' eq pageInfo.currentPage }">
                    		<li class="page-item disabled">
                    			<a class="page-link" href="#">이전</a>
                    		</li>
                    	</c:when>
                    	<c:otherwise>
                    		<c:choose>
                    			<c:when test="${ empty condition }">
                    				<li class="page-item">
				                    	<a class="page-link" 
				                    	   href="list.qna?page=${ pageInfo.currentPage - 1 }">이전</a>
				                    </li>
                    			</c:when>
                    			<c:otherwise>
                    				<li class="page-item">
			                    		<a class="page-link" 
			                    		   href="search.qna?page=${ pageInfo.currentPage - 1 }
			                    		   &condition=${condition}&keyword=${keyword}">이전</a>
			                    	</li>
                    			</c:otherwise>
                    		</c:choose>
                    	</c:otherwise>
                	</c:choose>
                
                    <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="p">
                    	<c:choose>
                    		<c:when test="${ empty condition }">
                    			<li class="page-item">
		                    		<a class="page-link" href="list.qna?page=${ p }">${ p }</a>
		                    	</li>
                    		</c:when>
                    		<c:otherwise>
	                    		<li class="page-item">
		                    		<a class="page-link" 
		                    		   href="search.qna.do?page=${ p }&condition=${condition}&keyword=${keyword}"
		                    		   >${ p }</a>
		                    	</li>
                    		</c:otherwise>
                    	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                		<c:when test="${ pageInfo.maxPage eq pageInfo.currentPage }">
                    		<li class="page-item disabled">
                    			<a class="page-link" href="#">다음</a>
                    		</li>
                    	</c:when>
                    	<c:otherwise>
                    		<c:choose>
                    			<c:when test="${ empty condition }">
                    				<li class="page-item">
				                    	<a class="page-link" 
				                    	   href="list.qna?page=${ pageInfo.currentPage + 1 }">다음</a>
				                    </li>
                    			</c:when>
                    			<c:otherwise>
                    				<li class="page-item">
			                    		<a class="page-link" 
			                    		   href="search.qna?page=${ pageInfo.currentPage + 1 }
			                    		   &condition=${condition}&keyword=${keyword}">다음</a>
			                    	</li>
                    			</c:otherwise>
                    		</c:choose>
                    	</c:otherwise>
                	</c:choose>
                    
                </ul>
            </div>
            <br>
            <a class="btn btn-primary" style="float:right;" href="insertForm.question">문의하기</a>
            <br><br>
        </div>
        <br><br>

    </div>
	<!--  
    <jsp:include page="" />
	-->
</body>
</html>