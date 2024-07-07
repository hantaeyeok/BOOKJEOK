<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 등록 페이지</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container my-5">
    <h2>도서 등록 페이지</h2>
    <div class="mt-4 mb-4">
        
        <form class="form-inline mb-4">
            <input type="text" class="form-control mr-sm-2" id="keyword" placeholder="책제목 OR 저자">
            <button type="button" class="btn btn-primary" onclick="searchBooks()">검색</button>
        </form>
        
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>표지</th>
                    <th>제목</th>
                    <th>저자</th>
                    <th>출판사</th>
                    <th>출판일</th>
                    <th>ISBN</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody id="bookResults">
                <!-- 검색 결과가 여기에 표시됩니다 -->
            </tbody>
        </table>
    </div>
    <div class="row">
        <div class="col-md-4">
            <img id="coverPreview" src="http://via.placeholder.com/150" class="img-fluid" alt="책 표지" style="width: 400px; height: auto;">
        </div>
        <div class="col-md-8">
            <h3>도서 정보 추가</h3>
            <form id="bookForm" action="/submitBook" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title">책제목</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="author">저자</label>
                    <input type="text" class="form-control" id="author" name="author" required>
                </div>
                <div class="form-group">
                    <label for="publisher">출판사</label>
                    <input type="text" class="form-control" id="publisher" name="publisher" required>
                </div>
                <div class="form-group">
                    <label for="pubDate">출판일</label>
                    <input type="date" class="form-control" id="pubDate" name="pubDate" required>
                </div>
                <div class="form-group">
                    <label for="isbn">ISBN</label>
                    <input type="text" class="form-control" id="isbn" name="isbn" required>
                </div>
                <div class="form-group">
                    <label for="category">카테고리</label>
                    <input type="text" class="form-control" id="category" name="category">
                </div>
                <div class="form-group">
                    <label for="description">책설명</label>
                    <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                </div>
                <button type="button" class="btn btn-primary" onclick="validateAndSubmit()">등록</button>
            </form>
        </div>
    </div>
</div>
<script>
    function searchBooks() {
        var $keyword = $('#keyword').val();
        console.log($keyword);
        $.ajax({
			url : 'book',            
			type : 'get',
            data : { keyword : $keyword },
            success : result => {
                console.log(result);
            }
        });
    }

    function selectBook(button) {
        var $button = $(button);
        $('#coverPreview').attr('src', $button.data('cover'));
        $('#title').val($button.data('title'));
        $('#author').val($button.data('author'));
        $('#publisher').val($button.data('publisher'));
        $('#pubDate').val($button.data('pubdate'));
        $('#isbn').val($button.data('isbn'));
        $('#category').val($button.data('category'));
        $('#description').val($button.data('description'));
    }
</script>
</body>
</html>

