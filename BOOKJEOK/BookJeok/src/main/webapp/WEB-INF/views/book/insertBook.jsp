<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
    <form class="form-inline my-4">
        <input type="text" class="form-control w-50"  id="keyword" placeholder="책제목 OR 저자">
        <button type="button" class="btn btn-primary" onclick="searchBooks()">검색</button>
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
                <div></div>
                <div class="modal-footer">
                	<button type="button" class="btn btn-secondary" onclick="changePage(-1)">이전</button>
                	<button type="button" class="btn btn-secondary" onclick="changePage(+1)">다음</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    

    <div class="row">
        <div class="col-md-8">
            <h3>도서 정보 추가</h3>
            <form id="bookForm" action="book/saveBook" method="post" enctype="multipart/form-data">
				<div class="form-group">
				    <label for="bookCover">책 표지:</label>
				    <select id="coverType">
				        <option value="basic" selected>기본값 사용</option>
				        <option value="custom">직접 등록</option>
				    </select>
				    <br>
				    <input type="text" class="form-control-file" id="bookCoverText"  name="bookCoverText" style="display: none"/>
				    <input type="file" class="form-control-file" id="bookCoverFile"  name="bookCoverFile" style="display: none"/>
				    <img id="coverPreview" src="http://via.placeholder.com/150x150" class="img-fluid" alt="책 표지 미리보기">
				</div>
				
				<script>
				    document.getElementById('coverType').addEventListener('change', function() {
				        var coverType = document.getElementById('coverType').value;
				        var textInput = document.getElementById('bookCoverText');
				        var fileInput = document.getElementById('bookCoverFile');
				
				        if (coverType === 'basic') {
				            textInput.name = 'bookCoverText';
				            fileInput.style.display = 'none';
				            fileInput.name = '';
				        } else if (coverType === 'custom') {
				            fileInput.style.display = '';
				            fileInput.name = 'bookCoverFile';
				            textInput.name = '';
				        }
				    });
			    
				</script>
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
                        <button type="button" class="btn btn-secondary" onclick="checkIsbn()">유효성 검사</button>
                </div>
                <div class="form-group">
                    <label for="category">카테고리</label>
                    <input type="text" class="form-control" id="category" name="categoryString">
                </div>
                
                <div class="form-group">
                    <label for="price">가격:</label>
                    <input type="number" class="form-control" id="price" name="bookPrice" required>
                </div>
                 <div class="form-group">
                    <label for="stock">재고:</label>
                    <input type="number" class="form-control" id="price" name="bookAmount" required>
                </div>
                <div class="form-group">
                    <label for="description">책설명</label>
                    <textarea class="form-control" id="description" name=bookDescription rows="3"></textarea>
                </div>
           <button type="submit" class="btn btn-primary">저장</button> 
           </form>
        </div>
    </div>
</div>
<script>
var currentPage = 1;

function searchBooks() {
    var $keyword = $('#keyword').val(); 
    console.log($keyword);
    $.ajax({
        url: 'books',
        type: 'get', 
        data: { keyword: $keyword, start: currentPage},
        success: result => {
            console.log(result.object);
            const items = result.object.item; 
            console.log(items);
            let rows = '';

            for (let i = 0; i < items.length; i++) {
                rows += buildBookRow(items[i]);
            }
            $('#modalBookResults').html(rows);
            $('#bookModal').modal('show'); 
        }
    });
}

function buildBookRow(item) {
    var setData = 'data-cover="' + item.cover + '" ' +
                  'data-title="' + item.title + '" ' +
                  'data-author="' + item.author + '" ' +
                  'data-publisher="' + item.publisher + '" ' +
                  'data-pubdate="' + item.pubDate + '" ' +
                  'data-isbn="' + item.isbn + '" ' +
                  'data-category="' + item.categoryName + '" ' +
                  'data-description="' + item.description + '" ' +
                  'data-price="' + item.priceSales + '"';

    return '<tr onclick="selectBook(this)" ' + setData + '>' +
           '<td><img src="' + item.cover + '" style="width:100px;height:150px;"></td>' +
           '<td>' + item.title + '</td>' +
           '<td>' + item.author + '</td>' +
           '<td>' + item.publisher + '</td>' +
           '<td>' + item.isbn + '</td>' +
           '<td><button class="btn btn-primary" onclick="closeModal()">선택</button></td>' +
           '</tr>';
}

function closeModal() {
    $('#bookModal').modal('hide');
}

function setDataAttributes(item) {
    return 'data-cover="' + item.cover + '" ' +
           'data-title="' + item.title + '" ' +
           'data-author="' + item.author + '" ' +
           'data-publisher="' + item.publisher + '" ' +
           'data-pubdate="' + item.pubDate + '" ' +
           'data-isbn="' + item.isbn + '" ' +
           'data-category="' + item.categoryName + '" ' +
           'data-description="' + item.description + '" ' +
           'data-price="' + item.priceSales + '"';
}

function selectBook(tr) {
    var $tr = $(tr);
    $('#coverPreview').attr('src', $tr.data('cover'));
    $('#title').val($tr.data('title'));
    $('#author').val($tr.data('author'));
    $('#publisher').val($tr.data('publisher'));
    $('#pubDate').val($tr.data('pubdate'));
    $('#isbn').val($tr.data('isbn'));
    $('#category').val($tr.data('category'));
    $('#description').val($tr.data('description'));
    $('#price').val($tr.data('price'));
    $('#bookCoverText').val($tr.data('cover'))
}
		
var isIsbnValid = false;
function checkIsbn() {
	var isbn = $('#isbn').val();
    if (!isbn) {
        $('#isbnFeedback').text('ISBN을 입력해주세요.').css('color', 'red');
        isIsbnValid = false;
        return;
    }
	
    $.ajax({
        url: 'books/isbnCheck',
        type: 'GET',
        data: { isbn: isbn },
        success: response => {
        	if (response.message === "유효한 ISBN입니다.") {
                alert(response.message);
                isIsbnValid = true;
            } else if(response.message === "유효하지 않은 ISBN입니다."){
                alert(response.message);
                isIsbnValid = false;
            }
        },
        error: e=> {
            alert('ISBN 유효성 검사 중 오류가 발생했습니다.');
            isIsbnValid = false;
        }
    });
}

$('#bookForm').on('submit', function(event) {
    if (!isIsbnValid) {
        event.preventDefault();
        alert('ISBN 유효성 검사를 통과해야 합니다.');
    }
});


function changePage(delta) {
    currentPage += delta;
    if (currentPage < 1) {
        currentPage = 1;
    }
    searchBooks();
}

</script>
</body>
</html>