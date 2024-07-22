<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 리뷰 페이지</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<style>
    .star-rating {
        font-size: 0; 
        direction: rtl; 
        display: inline-block;
    }
    .star-rating label {
        color: #bbb; 
        font-size: 30px;
        padding: 0 5px;
        cursor: pointer;
    }
    .star-rating label:hover,
    .star-rating label:hover ~ label,
    .star-rating input[type="radio"]:checked ~ label {
        color: #f90;
    }
    
    .sticky-top {
         top: 0;
         z-index: 1020;
     }
     .star-rating {
         color: #ffc107;
         font-size: 16px;
     }
     .fixed-bottom-bar {
         position: fixed;
         bottom: 0;
         width: 100%;
         background-color: white;
         border-top: 1px solid #ddd;
         padding: 10px;
         text-align: center;
         box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
     }
     .fixed-bottom-bar .quantity-selector {
         display: inline-block;
         margin: 0 10px;
     }
     .fixed-bottom-bar .quantity-selector input {
         width: 50px;
         text-align: center;
     }
     .fixed-bottom-bar .total-price {
         font-weight: bold;
         margin: 0 10px;
     }
</style>


<body>

<!-- 상단 메뉴바 포함 -->
<jsp:include page="../common/menubar.jsp" />

<div class="container-fluid">
    <div class="row">
        <!-- 좌측 메뉴바 포함 -->
        <jsp:include page="../common/adminMenuBar.jsp"></jsp:include>

        <div class="col-md-9">
            <h2>리뷰 관리 페이지</h2>


            <!-- 도서 검색 -->
            <form class="form-inline my-4">
                <input type="text" class="form-control mr-2" id="keyword" placeholder="도서 제목 또는 저자로 검색">
                <button type="button" class="btn btn-primary" id="searchButton">검색</button>
            </form>
			
			<!-- Modal -->
            <div class="modal fade" id="bookModal" tabindex="-1" role="dialog" aria-labelledby="bookModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="bookModalLabel">도서 선택</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>표지</th>
                                        <th>제목</th>
                                        <th>저자</th>
                                        <th>출판사</th>
                                        <th>ISBN</th>
                                        <th>선택</th>
                                    </tr>
                                </thead>
                                <tbody id="modalBookResults">
                                    <!-- 검색 결과 표시 -->
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="changePage(-1)">이전</button>
                            <button type="button" class="btn btn-secondary" onclick="changePage(+1)">다음</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
                
                
            <!-- 사용자 ID로 리뷰 검색 -->
            <form class="form-inline my-2">
                <input type="text" class="form-control mr-2" id="userIdSearch" placeholder="사용자 ID로 리뷰 검색">
                <button type="button" class="btn btn-secondary" id="searchReviewsByUserIdButton">검색</button>
            </form>

            <!-- 도서 기본 정보 폼 -->
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="bookCover">책 표지:</label>
                        <img id="coverPreview" src="http://via.placeholder.com/150x150" class="img-fluid" alt="책 표지 미리보기">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="title">책제목</label>
                        <input type="text" class="form-control" id="title" name="bookTitle" required>
                    </div>
                    <div class="form-group">
                        <label for="author">저자</label>
                        <input type="text" class="form-control" id="author" name="bookAuthor" required>
                    </div>
                    <div class="form-group">
                        <label for="publisher">출판사</label>
                        <input type="text" class="form-control" id="publisher" name="bookPublisher" required>
                    </div>
                    <div class="form-group">
                        <label for="pubDate">출판일</label>
                        <input type="date" class="form-control" id="pubDate" name="bookPubDate" required>
                    </div>
                    <div class="form-group">
                        <label for="isbn">ISBN</label>
                        <input type="text" class="form-control" id="isbn" name="bookIsbn" required>
                    </div>
                </div>
            </div> 
			
			<h4>리뷰 요약</h4>
        	<div id="review-summary-container">
            <!-- 리뷰 요약이 여기에 동적으로 추가됩니다. -->
        	</div>
			
			
            <!-- 리뷰 목록 -->
            <div id="reviewsContainer">
                <h4>리뷰 목록</h4>
                <select class="form-control mb-2" id="sortBy">
                    <option value="latest">최신순</option>
                    <option value="rating">별점순</option>
                </select>
            <div class="list-group" id="review-list-container">
            <!-- 리뷰 목록이 여기에 동적으로 추가됩니다. -->
        	</div>
        	
        	<nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center" id="pagination-container">
                <!-- 페이지 번호가 여기에 동적으로 추가됩니다. -->
            </ul>
        	</nav>
  
        	
        	
            </div>

            <!-- 리뷰 수정 모달 -->
            <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="reviewModalLabel">리뷰 수정</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="reviewForm">
                            	<input type="hidden" id="bookNo"/>
                                <input type="hidden" id="reviewId">
                                <div class="form-group">
                                    <label for="reviewRating">별점:</label>
                                    <div class="star-rating">
                                        <input type="radio" id="5-stars" name="rating" value="5"><label for="5-stars">&#9733;</label>
                                        <input type="radio" id="4-stars" name="rating" value="4"><label for="4-stars">&#9733;</label>
                                        <input type="radio" id="3-stars" name="rating" value="3"><label for="3-stars">&#9733;</label>
                                        <input type="radio" id="2-stars" name="rating" value="2"><label for="2-stars">&#9733;</label>
                                        <input type="radio" id="1-star" name="rating" value="1"><label for="1-star">&#9733;</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="reviewText">리뷰 내용:</label>
                                    <textarea class="form-control" id="reviewText" rows="3"></textarea>
                                </div>
                                <button type="button" class="btn btn-primary" id="updateReviewButton" onclick="updateReview()">저장</button>
                                <button type="button" class="btn btn-primary" id="deleteReviewButton" onclick="deleteReview()">삭제</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


<script>
$(document).ready(function() {
    $('#searchButton').on('click', function() {
        searchBooks();
    });

    $('#sortBy').change(function() {
        fetchReviews();
    });
});

let currentPage = 1;
let bookData = {};

function searchBooks() {
   const $keyword = $('#keyword').val(); 
    $.ajax({
        url: '/bookjeok/book/update',
        type: 'GET', 
        data: { keyword: $keyword, 
        		page : currentPage},
        success: result => {
            const books = result.data;
            bookData = {}; //검색 할때 bookData 초기화
            let rows = '';
			books.forEach((book) => {
				const bookId = "book" + book.bookNo; //문자열+숫자
				bookData[bookId] = book;
				rows += buildBookRow(book, bookId);
			});             
            $('#modalBookResults').html(rows);
            $('#bookModal').modal('show'); 
        }
    });
}

function buildBookRow(book, bookId) {
    return '<tr id="' + bookId + '" onclick="selectBook(\'' + bookId + '\')">' +
           '<td><img src="' + book.bookCover + '" style="width:100px; height:150px;"></td>' +
           '<td>' + book.bookTitle + '</td>' +
           '<td>' + book.bookAuthor + '</td>' +
           '<td>' + book.bookPublisher + '</td>' +
           '<td>' + book.bookIsbn + '</td>' +
           '<td><button class="btn btn-primary" onclick="selectBook(\'' + bookId + '\')"; closeModal();">선택</button></td>' +
           '</tr>';
}

function selectBook(bookId) {
    var book = bookData[bookId];
    let bookNo = book.bookNo;
    $('#coverPreview').attr('src', book.bookCover);
    $('#title').val(book.bookTitle);
    $('#author').val(book.bookAuthor);
    $('#publisher').val(book.bookPublisher);
    $('#isbn').val(book.bookIsbn);
    $('#pubDate').val(book.bookPubDate);
    $('#bookNo').val(bookNo);
    fetchReviews(bookNo);
    fetchReviewSummary(bookNo);
}

function closeModal() {
    $('#bookModal').modal('hide');
}

let page = 1;
function fetchReviews(bookNo,page =1) {
    const sortBy = $('#sortBy').val();
    $.ajax({
        url: '/bookjeok/book/reviews/' + bookNo,
        type: 'GET',
        data: {
            page: page,
            pageSize: 10,
            sortBy: sortBy
        },
        success: function(response) {
            $('#review-list-container').empty();
            var reviews = response.data.reviews;
            var pageInfo = response.data.pageInfo;

            if (reviews && reviews.length > 0) {
                for (var i = 0; i < reviews.length; i++) {
                    var review = reviews[i];
                    var stars = '';
                    for (var j = 1; j <= 5; j++) {
                        if (j <= review.reviewRating) {
                            stars += '&#9733;';
                        } else {
                            stars += '&#9734;';
                        }
                    }
                    $('#review-list-container').append(
                        '<div class="list-group-item">' +
                        '<strong>' + review.userId + '</strong>' +
                        '<span class="star-rating">' + stars + '</span>' +
                        '<p>' + review.reviewContext + '</p>' +
                        '<button class="btn btn-primary" onclick="reviewModel(\'' + review.userId + '\', \'' + review.reviewContext + '\', ' + review.reviewRating + ')" >수정</button>' + 
                        '</div>'
                    );
                }
            } else {
                $('#review-list-container').append('<div class="list-group-item">리뷰가 없습니다.</div>');
            }
            updatePagination(pageInfo);
        },
        error: function() {
            alert('리뷰를 가져오는 중 오류가 발생했습니다.');
        }
       
    });
}

//리뷰 수정 모달을 띄우고 데이터를 로드하는 함수
function reviewModel(reviewId, reviewContext, reviewRating) {
    // 리뷰 데이터를 모달의 입력 필드에 설정
    $('#reviewId').val(reviewId);
    $('input[name="rating"][value="' + reviewRating + '"]').prop('checked', true);
    $('#reviewText').val(reviewContext);
    $('#reviewModal').modal('show');
}



/*
function displayReviews(reviews) {
    var reviewsList = $('#reviewsList');
    reviewsList.empty();
    reviews.forEach(function(review) {
        reviewsList.append(
            '<div class="list-group-item">
                <p>${review.userId}: ${review.reviewRating} stars</p>
                <p>${review.reviewContext}</p>
                <button onclick="loadReviewForEdit(${review.reviewNo})">수정</button>
            </div>'
        );
    });
}
*/
function fetchReviewSummary(bookNo) {
	$.ajax({
        url: 'reviewAvg/' + bookNo,
        type: 'GET',
        success: function(response) {
            $('#review-summary-container').empty();
            var reviewSummary = response.data;

            // 1점부터 5점까지의 비율을 표시합니다.
            for (var i = 1; i <= 5; i++) {
                var percentage = reviewSummary[i] || 0; // 각 평점에 대한 비율을 가져옵니다.
                $('#review-summary-container').append(
                    '<div class="progress mb-2">' +
                    '<div class="progress-bar bg-primary" role="progressbar" style="width: ' + percentage + '%;">' + Math.floor(percentage) + '%</div>' +
                    '</div>'
                );
            }
        },
        error: function() {
            alert('리뷰 요약을 가져오는 중 오류가 발생했습니다.');
        }
    });
}

function updatePagination(pageInfo) {
    $('#pagination-container').empty();

    // 이전 버튼
    if (pageInfo.currentPage > 1) {
        $('#pagination-container').append(
            '<li class="page-item">' +
            '<a class="page-link" href="#" aria-label="Previous" onclick="fetchReviews(' + (pageInfo.currentPage - 1) + ')">' +
            '<span aria-hidden="true">&laquo;</span>' +
            '</a>' +
            '</li>'
        );
    }

    // 페이지 번호
    for (var i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
        $('#pagination-container').append(
            '<li class="page-item ' + (i === pageInfo.currentPage ? 'active' : '') + '">' +
            '<a class="page-link" href="#" onclick="fetchReviews(' + i + ')">' + i + '</a>' +
            '</li>'
        );
    }

    // 다음 버튼
    if (pageInfo.currentPage < pageInfo.maxPage) {
        $('#pagination-container').append(
            '<li class="page-item">' +
            '<a class="page-link" href="#" aria-label="Next" onclick="fetchReviews(' + (pageInfo.currentPage + 1) + ')">' +
            '<span aria-hidden="true">&raquo;</span>' +
            '</a>' +
            '</li>'
        );
    }
}


function updateReview() {
 	const bookNo = $('#bookNo').val(); // Form에서 적절한 입력 필드 ID를 사용해 값을 가져와야 합니다.
    const reviewId = $('#reviewId').val();
    const reviewRating = $('input[name="rating"]:checked').val();
    const reviewText = $('#reviewText').val();
	
    const data = JSON.stringify({
        bookNo: bookNo,
        userId: reviewId, 
        reviewRating: reviewRating,
        reviewContext: reviewText
    });
    
	$.ajax({
		url : '/bookjeok/book/updateAdminReview',
		type : 'PUT',
		contentType : 'application/json',
		data : data,	
        success: result => {
            if (result.message === "성공") {
                alert('리뷰가 성공적으로 수정되었습니다.');
                $('#reviewModal').modal('hide');
                fetchReviews(bookNo);
                fetchReviewSummary(bookNo);
            } else {
                alert('리뷰 수정 실패: ' + result.message);
            }
        }
	})
}

function deleteReview() {
    const bookNo = $('#bookNo').val(); 
    const userId = $('#reviewId').val(); 

    $.ajax({
        url: '/bookjeok/book/deleteAdminReview',
        type: 'DELETE',
        data: {
            bookNo: bookNo,
            userId: userId
       	},
        success: result => {
            if (result.message === "성공") {
                alert('리뷰가 성공적으로 삭제되었습니다.');
            } else {
                alert('리뷰 삭제 실패: ' + result.message);
            }
        }
    });
} 



</script>
</body>
</html>
