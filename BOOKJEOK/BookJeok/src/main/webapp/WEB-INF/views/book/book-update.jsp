<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>도서 수정 페이지</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container my-5">
    <h2>도서 수정 페이지</h2>
    <form id="editBookForm" action="book/updateBook" method="post" enctype="multipart/form-data">
        <div class="row">
            <!-- 좌측 컬럼: 책 표지 선택 및 이미지 표시 -->
            <div class="col-md-6">
                <div class="form-group">
                    <label for="coverType">책 표지:</label>
                    <select id="coverType" class="form-control">
                        <option value="basic">기존 표지 사용</option>
                        <option value="custom">직접 등록</option>
                    </select>
                    <br>
                    <img id="coverPreview" src="http://via.placeholder.com/150x150" class="img-fluid" alt="책 표지 미리보기">
                    <input type="text" class="form-control" id="bookCoverText" name="bookCoverText" style="display: none"/>
                    <input type="file" class="form-control-file" id="bookCoverFile" name="bookCoverFile" style="display: none"/>
                </div>
            </div>
            
            <!-- 우측 컬럼: 책 제목, 저자, 출판사 정보 입력 -->
            <div class="col-md-6">
                <div class="form-group">
                    <label for="title">책제목</label>
                    <input type="text" class="form-control" id="title" name="bookTitle" value="기존 제목" required>
                </div>
                
                <div class="form-group">
                    <label for="author">저자</label>
                    <input type="text" class="form-control" id="author" name="bookAuthor" value="기존 저자" required>
                </div>

                <div class="form-group">
                    <label for="publisher">출판사</label>
                    <input type="text" class="form-control" id="publisher" name="bookPublisher" value="기존 출판사" required>
                </div>
            </div>
        </div>

        <!-- 추가 정보 및 폼 제출 버튼 -->
        <div class="form-group">
            <label for="pubDate">출판일</label>
            <input type="date" class="form-control" id="pubDate" name="bookPubDate" value="기존 출판일" required>
        </div>

        <div class="form-group">
            <label for="isbn">ISBN</label>
            <input type="text" class="form-control" id="isbn" name="bookIsbn" value="기존 ISBN" required>
        </div>

        <div class="form-group">
            <label for="category">카테고리</label>
            <input type="text" class="form-control" id="category" name="categoryString" value="기존 카테고리">
        </div>

        <div class="form-group">
            <label for="price">가격</label>
            <input type="number" class="form-control" id="price" name="bookPrice" value="기존 가격" required>
        </div>

        <div class="form-group">
            <label for="stock">재고</label>
            <input type="number" class="form-control" id="stock" name="bookAmount" value="기존 재고" required>
        </div>

        <div class="form-group">
            <label for="description">책설명</label>
            <textarea class="form-control" id="description" name="bookDescription" rows="3">기존 설명</textarea>
        </div>

        <button type="submit" class="btn btn-primary">저장</button>
    </form>
</div>
<script>
document.getElementById('coverType').addEventListener('change', function() {
    var coverType = document.getElementById('coverType').value;
    var textInput = document.getElementById('bookCoverText');
    var fileInput = document.getElementById('bookCoverFile');

    if (coverType === 'basic') {
        textInput.style.display = '';
        fileInput.style.display = 'none';
        textInput.name = 'bookCoverText';
        fileInput.name = '';
    } else if (coverType === 'custom') {
        fileInput.style.display = '';
        textInput.style.display = 'none';
        fileInput.name = 'bookCoverFile';
        textInput.name = '';
    }
});
</script>
</body>
</html>

