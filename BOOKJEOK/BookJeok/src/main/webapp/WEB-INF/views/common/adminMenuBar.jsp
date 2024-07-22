<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>도서 관리 시스템</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
        <style>



        </style>
    </head>
    <body>
        <div class="col-md-3 bg-light" style="height: 100vh;">
            <div class="d-flex flex-column flex-shrink-0 p-3">
                <span class="fs-4">관리자 페이지</span>
                <hr>
                <ul class="nav nav-pills flex-column">
                    <li class="nav-item">
                     	<span>도서관리</span>
                         <ul class="nav flex-column"> 
                             <li class="nav-item"><a href="/bookjeok/book/1" class="nav-link link-dark">도서 등록하기</a></li>
                             <li class="nav-item"><a href="/bookjeok/book/upup" class="nav-link link-dark">도서 수정하기</a></li>
                             <li class="nav-item"><a href="/bookjeok/book/adminReview" class="nav-link link-dark">도서 리뷰관리</a></li>                                
                         	 <li class="nav-item"><a href="/bookjeok/book/30" class="nav-link link-dark">도서상세보기예시(30)</a></li>                                
                         
                         </ul>
                     </li>
                </ul>
            </div>
        </div>
      
</body>
</html>

