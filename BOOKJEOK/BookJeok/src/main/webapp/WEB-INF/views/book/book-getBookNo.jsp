<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 상세 페이지</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <style>
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
</head>
<body>
<div class="container my-5">
    <h2 class="mb-4">도서 상세 페이지</h2>
    <div class="row mb-4">
        <div class="col-md-4">
            <img src="${book.bookCover}" alt="책 표지" class="img-fluid">
        </div>
        <div class="col-md-8">
            <h3>${book.bookTitle}</h3>
            <p>저자: ${book.bookAuthor}</p>
            <p>출판사: ${book.bookPublisher}</p>
            <p>가격: ${book.bookPrice}</p>
            <p>ISBN: ${book.bookIsbn}</p>
        </div>
    </div>

    <ul class="nav nav-pills sticky-top bg-white">
        <li class="nav-item">
            <a class="nav-link active" href="#book-info">상품정보</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#review-section">리뷰</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#exchange-policy-section">교환/반품/규정</a>
        </li>
    </ul>

    <div id="book-info" class="mt-4">
        <h4>상품 상세 설명</h4>
        <img src="${bookDetail.detailImage}" alt="상세 설명 이미지" class="img-fluid mb-3">
        <p>${bookDetail.detailDescription}</p>
    </div>

    <div id="review-section" class="mt-4">
        <h4>리뷰 요약</h4>
        <div class="progress mb-2" id="review-summary-container">
            <!-- 리뷰 요약이 여기에 동적으로 추가됩니다. -->
        </div>

        <h4>리뷰 목록</h4>
        <div class="list-group" id="review-list-container">
            <!-- 리뷰 목록이 여기에 동적으로 추가됩니다. -->
        </div>
        <button type="button" class="btn btn-primary mt-3" data-toggle="modal" data-target="#reviewModal">리뷰 작성</button>
    </div>

    <div id="exchange-policy-section" class="mt-4">
        <h4>교환/반품/규정</h4>
        <p>교환 및 반품에 대한 정책...</p>
    </div>

    <div class="fixed-bottom-bar">
        <span class="total-price">총 상품 금액: ${book.bookPrice}</span>
        <span class="quantity-selector">
            <button class="btn btn-secondary" onclick="decreaseQuantity()">-</button>
            <input type="text" id="quantity" value="1">
            <button class="btn btn-secondary" onclick="increaseQuantity()">+</button>
        </span>
        <button class="btn btn-primary">장바구니</button>
        <button class="btn btn-success">구매하기</button>
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
</div>

<script>
    function decreaseQuantity() {
        var quantity = parseInt($('#quantity').val());
        if (quantity > 1) {
            $('#quantity').val(quantity - 1);
            updateTotalPrice();
        }
    }

    function increaseQuantity() {
        var quantity = parseInt($('#quantity').val());
        $('#quantity').val(quantity + 1);
        updateTotalPrice();
    }

    function updateTotalPrice() {
        var quantity = parseInt($('#quantity').val());
        var price = parseInt('${book.bookPrice}');
        var totalPrice = price * quantity;
        $('.total-price').text('총 상품 금액: ' + totalPrice.toLocaleString() + '원');
    }

    function submitReview() {
        var bookNo = ${book.bookNo};
        var userId = $("#userId").val();
        var reviewContext = $('#reviewText').val();
        var reviewRating = $('input[name="rating"]:checked').val();
        
        $.ajax({
            url: 'review',
            type: 'POST',
            data: {
                bookNo: bookNo,
                userId: userId,
                reviewContext: reviewContext,
                reviewRating: reviewRating
            },
            success: function(response) {
                if (response.message === '리뷰 등록 성공') {
                    alert('리뷰가 성공적으로 등록되었습니다.');
                    $('#reviewModal').modal('hide');
                    fetchReviews();
                    fetchReviewSummary();
                } else {
                    alert('리뷰 등록에 실패했습니다.');
                }
            },
            error: function() {
                alert('리뷰 등록 중 오류가 발생했습니다.');
            }
        });
    }

    function fetchReviews() {
        var bookNo = ${book.bookNo};
        $.ajax({
            url: 'reviews/' + bookNo,
            type: 'GET',
            success: function(response) {
                $('#review-list-container').empty();
                var reviews = response;
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
                if (reviewSummary && reviewSummary.length > 0) {
                    for (var i = 0; i < reviewSummary.length; i++) {
                        var summary = reviewSummary[i];
                        $('#review-summary-container').append(
                            '<div class="progress mb-2">' +
                            '<div class="progress-bar bg-primary" role="progressbar" style="width: ' + summary.percentage + '%;">' + summary.percentage.toFixed(2) + '%</div>' +
                            '</div>'
                        );
                    }
                } else {
                    $('#review-summary-container').append('<div class="progress mb-2">리뷰 요약이 없습니다.</div>');
                }
            },
            error: function() {
                alert('리뷰 요약을 가져오는 중 오류가 발생했습니다.');
            }
        });
    }

    $(document).ready(function() {
        $('a.nav-link').click(function(e) {
            e.preventDefault();
            var target = $(this).attr('href');
            $('html, body').animate({
                scrollTop: $(target).offset().top - 70
            }, 1000, 'easeInOutExpo');
            $('a.nav-link').removeClass('active');
            $(this).addClass('active');
        });

        updateTotalPrice();
        fetchReviews();
        fetchReviewSummary();
    });
</script>
</body>
</html>
