<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .bestseller-card {
            display: flex;
            margin: 10px;
            align-items: center;
            border: 1px solid #ddd;
            padding: 10px;
            background-color: #f9f9f9;
        }
        .bestseller-card img {
            width: 120px;
            height: auto;
            margin-right: 20px;
        }
        .bestseller-card div {
            flex-grow: 1;
        }
        .paging-buttons {
            text-align: center;
            margin-top: 20px;
        }
        .paging-buttons a {
            margin: 0 10px;
            color: #007bff;
        }
        .card-img-top {
            height: 200px; 
            object-fit: cover;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>베스트 셀러</h2>
            <br>
            <c:forEach var="book" items="${bestSellerBooks}" varStatus="status">
                <c:if test="${status.index < 10}">
                    <div class="bestseller-card">
                        <a href="productDetail.jsp?bookId=${book.id}">
                            <img src="${book.coverImage}" alt="책 이미지">
                        </a>
                        <div>
                            <a href="productDetail.jsp?bookId=${book.id}">
                                <h5 class="card-title">${book.title}</h5>
                            </a>
                            <p class="card-text">${book.author}</p>
                            <p class="card-text">${book.price}원</p>
                            <p class="card-text">${book.text}</p>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            <div class="paging-buttons">
                <a href="productList.jsp?page=${currentPage - 1}">이전</a>
                <a href="productList.jsp?page=${currentPage + 1}">다음</a>
            </div>
            <br><br>
            <h2>카테고리별 상품 목록</h2>
            <br>
            <h3>경제</h3>
            <div class="card-deck">
                <c:forEach var="book" items="${economyBooks}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <div class="card">
                            <a href="productDetail.jsp?bookId=${book.id}">
                                <img class="card-img-top" src="${book.coverImage}" alt="책 이미지" >
                            </a>
                            <div class="card-body">
                                <a href="productDetail.jsp?bookId=${book.id}">
                                    <h5 class="card-title">${book.title}</h5>
                                </a>
                                <p class="card-text">${book.author}</p>
                                <p class="card-text">${book.price}원</p>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <h3>과학</h3>
            <div class="card-deck">
                <c:forEach var="book" items="${scienceBooks}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <div class="card">
                            <a href="productDetail.jsp?bookId=${book.id}">
                                <img class="card-img-top" src="${book.coverImage}" alt="책 이미지" >
                            </a>
                            <div class="card-body">
                                <a href="productDetail.jsp?bookId=${book.id}">
                                    <h5 class="card-title">${book.title}</h5>
                                </a>
                                <p class="card-text">${book.author}</p>
                                <p class="card-text">${book.price}원</p>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <h3>외국어</h3>
            <div class="card-deck">
                <c:forEach var="book" items="${foreignBooks}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <div class="card">
                            <a href="productDetail.jsp?bookId=${book.id}">
                                <img class="card-img-top" src="${book.coverImage}" alt="책 이미지" >
                            </a>
                            <div class="card-body">
                                <a href="productDetail.jsp?bookId=${book.id}">
                                    <h5 class="card-title">${book.title}</h5>
                                </a>
                                <p class="card-text">${book.author}</p>
                                <p class="card-text">${book.price}원</p>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <h3>문학</h3>
            <div class="card-deck">
                <c:forEach var="book" items="${literatureBooks}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <div class="card">
                            <a href="productDetail.jsp?bookId=${book.id}">
                                <img class="card-img-top" src="${book.coverImage}" alt="책 이미지" >
                            </a>
                            <div class="card-body">
                                <a href="productDetail.jsp?bookId=${book.id}">
                                    <h5 class="card-title">${book.title}</h5>
                                </a>
                                <p class="card-text">${book.author}</p>
                                <p class="card-text">${book.price}원</p>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <br><br>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>

<script>
    var pageNumber = 
    function bestBook(pageNumber) {

        $.ajax({
            url: 'getBooks.jsp',  
            type: 'GET',
            data: { page: pageNumber },
            dataType: 'json',
            success: result => {

                console.log(result);

                    var bookHTML += '<div class="bestseller-card">' 
                        + '<a href="productDetail.jsp?bookId=' + book.id + '">' 
                        + '<img src="' + book.coverImage + '" alt="책 이미지">' 
                        + '</a><div><a href="productDetail.jsp?bookId=' + book.id + '">' 
                        + '<h5 class="card-title">' + book.title + '</h5></a>' 
                        + '<p class="card-text">' + book.author + '</p>' 
                        + '<p class="card-text">' + book.price + '원</p>' 
                        + '<p class="card-text">' + book.text + '</p></div>'
                        + '</div>';

                });
                
                $('#booksContainer').append(bookHTML);
            }
        });
    }
</script>
