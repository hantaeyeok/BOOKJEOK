<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        .content {
            margin : 100px;
        }

        .nav-tabs {
            padding-top: 100px;
        }

        .card {
            width: 18rem;
        }

        .card-container {
            display: flex;
            gap: 40px; /* 카드 간격 조절 */
            margin: auto;
            flex-wrap: wrap;
            
        }
        
        .card:hover {
			transform: scale(1.05);
			transition: all 0.5s ease-in-out;
        }

        .card-title-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 10px;
        }

        .card-title {
            margin-right: 10px; /* 제목과 배지 사이의 간격 */
            margin-bottom: 0;
            font-weight: bold;
        }

        .card-img-top {
            height: 18rem;
        }

        #badge {
            display: inline-block;
            margin-top: -10px;
            font-size: 75%;
            font-weight: 700;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.7rem;
            width: 70px;
            height: 25px;
            line-height: 18px;
        }


        /* 상태에 따라 다른 스타일 적용 */
        .recruiting {
            background-color: #20c997; /* 모집중 배경색 */
        }

        .completed {
            background-color: red; /* 모집완료 배경색 */
        }

        .text-body-secondary, .card-text-title {
            font-weight: bold;
        }

        .card-text-title, .card-text {
            font-size: 13px;
        }

        #insert-btn {
            float: right;
        }
        
        #pagingArea {
        	width:fit-content; margin:auto;
        }

    </style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />
	
    <div class="content">
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="list.clubboard">전체</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="list.clubboard?clubStatus=모집중">모집중</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="list.clubboard?clubStatus=모집완료">모집완료</a>
            </li>
        </ul>

        <br><br>
        <div class="card-container">
        	<c:choose>
        		<c:when test="${not empty param.clubStatus}">
        			<c:choose>
		        		<c:when test="${statusClubboard.size() == 0 }">
		        			<span style="font-weight:bold; font-size:17px; margin-left:15px;">작성된 글이 없습니다.</span>
		        		</c:when>
		        	</c:choose>
		       		<c:forEach items="${statusClubboard }" var="clubboard">
		        		<div class="card">
		        			<c:choose>
		        			<c:when test="${ empty clubboard.clubboardChangename }">
		        				<img src="https://st.kakaocdn.net/shoppingstore/store/20240528180123_b9a6145839c346e3a34304f14163d941.png" class="card-img-top" alt="소개이미지">
		        			</c:when>
		        			<c:otherwise>
		        				<img src="${clubboard.clubboardChangename }" class="card-img-top" alt="소개이미지">
		        			</c:otherwise>
		        			</c:choose>
			                <hr>
			                <div class="card-body">
			                    <div class="card-title-container">
			                        <p class="card-title">${clubboard.bookclubName }</p>
			                        <span class="badge recruiting" id="badge">${clubboard.clubStatus }</span>
			                    </div>
			                    <p class="card-text">- 모집인원 : ${clubboard.clubNumber }명</p>
			                    <p class="card-text">- 작성자 : ${clubboard.userId }</p>
			                </div>
			                <div class="card-footer">
			                    <small class="text-body-secondary">모집기간 : ${clubboard.clubboardDate } ~ ${clubboard.clubPeriod }</small>
			                </div>
			            </div>
		            </c:forEach>
        		</c:when>
        		
        		<c:otherwise>
        			<c:choose>
		        		<c:when test="${totalClubboard.size() == 0 }">
		        			<span style="font-weight:bold; font-size:17px; margin-left:15px;">작성된 글이 없습니다.</span>
		        		</c:when>
		        	</c:choose>
		       		<c:forEach items="${totalClubboard }" var="clubboard">
		        		<div class="card" id="clubboardNo-${ clubboard.clubboardNo }">
		        			<%-- <input type="hidden" name="clubboardNo" value="${clubboard.clubboardNo }" >--%>
		        			<c:choose>
		        			<c:when test="${ empty clubboard.clubboardChangename }">
		        				<img src="https://st.kakaocdn.net/shoppingstore/store/20240528180123_b9a6145839c346e3a34304f14163d941.png" class="card-img-top" alt="소개이미지">
		        			</c:when>
		        			<c:otherwise>
		        				<img src="${clubboard.clubboardChangename }" class="card-img-top" alt="소개이미지">
		        			</c:otherwise>
		        			</c:choose>
			                <hr>
			                <div class="card-body">
			                    <div class="card-title-container">
			                        <p class="card-title">${clubboard.bookclubName }</p>
			                        <span class="badge recruiting" id="badge">${clubboard.clubStatus }</span>
			                    </div>
			                    <p class="card-text">- 모집인원 : ${clubboard.clubNumber }명</p>
			                    <p class="card-text">- 작성자 : ${clubboard.userId }</p>
			                </div>
			                <div class="card-footer">
			                    <small class="text-body-secondary">모집기간 : ${clubboard.clubboardDate } ~ ${clubboard.clubPeriod }</small>
			                </div>
			            </div>
		            </c:forEach>
        		</c:otherwise>
        	</c:choose>
        </div>
        <br><br>
        
        <script>
        
        	$(() => {
        		
        		$('.card').click(e => {
        			
        			//var clubboardNo = $('[name="clubboardNo"]').val();
        			
        			//location.href = 'detail.clubboard?clubboardNo=' + clubboardNo ;
        			location.href = 'detail.clubboard?clubboardNo=' + e.currentTarget.id.split('-')[1];
        		})
        	});
        	
        	//const badge = document.getElementId('badge');
        	
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
						<li class="page-item">
		                	<a class="page-link" href="list.clubboard?page=${ pageInfo.currentPage - 1 }">이전</a>
		                </li>
					</c:otherwise>
				</c:choose>
			
				<c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="p">
					<li class="page-item">
		                <a class="page-link" href="list.clubboard?page=${ p }">${ p }</a>
		            </li>
				</c:forEach>
				
				<c:choose>
					<c:when test="${ pageInfo.maxPage eq pageInfo.currentPage }">
						<li class="page-item disabled">
							<a class="page-link" href="#">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
	                    	<a class="page-link" href="list.clubboard?page=${ pageInfo.currentPage + 1 }">다음</a>
	                    </li>
					</c:otherwise>
				</c:choose>
			    </ul>
			</div>
        
        <br><br>
        <c:if test="${not empty sessionScope.loginUser.userId }">
        	<a class="btn btn-primary" id="insert-btn" href="insertForm.clubboard">글 작성</a>
        </c:if>
    </div>
</body>
</html>