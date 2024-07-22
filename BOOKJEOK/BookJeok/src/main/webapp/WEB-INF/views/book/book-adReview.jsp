<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 리뷰 페이지</title>

</head>
<body>

<jsp:include page="../common/menubar.jsp" />


<div class="container-fluid">
    <div class="row">
        <!-- 좌측 메뉴바 -->
        <jsp:include page="../common/adminMenuBar.jsp"></jsp:include>

        <!-- 메인 콘텐츠 영역 -->
        <div class="col-md-9">
                <h2>리뷰 관리자 페이지</h2>
                
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
                
                <!-- 도서 검색창 -->
                <form class="form-inline my-4">
                    <input type="text" class="form-control w-50" id="keyword" placeholder="책제목 OR 저자">
                    <button type="button" class="btn btn-primary" onclick="searchBooks()">검색</button>
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
           </div>
           
           
          <!-- 리뷰 모달 -->
    <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="reviewModalLabel">리뷰 작성</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="reviewForm">
                        <input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId}">
                        <input type="hidden" id="bookNo" name="bookNo" value="${book.bookNo}">
                        <div class="form-group">
                            <label for="rating">별점:</label>
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
                        <button type="button" class="btn btn-primary" onclick="submitReview()">저장</button>
                    </form>
                </div>
            </div>
        </div>
    </div> 
     <h4>리뷰 요약</h4>     
     
          
     <h4>리뷰 목록</h4>
        <div class="form-group">
            <label for="sortBy">정렬:</label>
            <select class="form-control" id="sortBy">
                <option value="latest">최신순</option>
                <option value="rating">별점순</option>
            </select>
        </div>
        <div class="list-group" id="review-list-container">
            <!-- 리뷰 목록이 여기에 동적으로 추가됩니다. -->
        </div>
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center" id="pagination-container">
                <!-- 페이지 번호가 여기에 동적으로 추가됩니다. -->
            </ul>
        </nav>
        <button type="button" class="btn btn-primary mt-3" data-toggle="modal" data-target="#reviewModal">리뷰 작성</button>
    </div> 
         
   <!-- 사용자 ID로 리뷰 검색 -->
    <form class="form-inline my-2">
       <input type="text" class="form-control" id="userIdSearch" placeholder="사용자 ID로 검색">
       <button type="button" class="btn btn-secondary" onclick="searchReviewsByUserId()">검색</button>
   </form>   
           
	</div>
                   
<script>
var currentPage = 1;
var bookData = {};

function searchBooks() {
   var $keyword = $('#keyword').val(); 
   console.log(typeof currentPage);
    $.ajax({
        url: '/bookjeok/book/adminReview',
        type: 'GET', 
        data: { keyword: $keyword, 
        		page : currentPage},
        success: result => {
            const books = result.data;
            console.log(books);
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
    $('#coverPreview').attr('src', book.bookCover);
    $('#title').val(book.bookTitle);
    $('#author').val(book.bookAuthor);
    $('#publisher').val(book.bookPublisher);
    $('#isbn').val(book.bookIsbn);
    $('#pubDate').val(book.bookPubDate);
}

function closeModal() {
    $('#bookModal').modal('hide');
}

function fetchReviews(page = 1) {
    var bookNo = ${book.bookNo};
    var sortBy = $('#sortBy').val();
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

function fetchReviewSummary() {
    var bookNo = ${book.bookNo};
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

//userId로 검색하면 해당 userid가 나오돍

$(document).ready(function() {
 
});


let responseData;


</script>
</body>
</html>
