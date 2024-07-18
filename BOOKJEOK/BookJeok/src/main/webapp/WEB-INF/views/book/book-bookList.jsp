<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 검색 결과</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .book-cover {
            width: 100px;
            height: 150px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <h2>도서 검색 결과</h2>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>표지</th>
                        <th>제목</th>
                        <th>저자</th>
                        <th>출판사</th>
                        <th>출판일</th>
                        <th>ISBN</th>
                        <th>가격</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${books}">
                        <tr>
                            <td><img src="${book.bookCover}" class="book-cover"></td>
                            <td>${book.bookTitle}</td>
                            <td>${book.bookAuthor}</td>
                            <td>${book.bookPublisher}</td>
                            <td>${book.bookPubDate}</td>
                            <td>${book.bookIsbn}</td>
                            <td>${book.bookPrice}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
