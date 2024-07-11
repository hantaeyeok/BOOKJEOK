<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <!-- api 도서 검색창 -->
    <form class="form-inline my-4">
        <input type="text" class="form-control w-50" id="keyword" placeholder="책제목 OR 저자">
        <button type="button" class="btn btn-primary" onclick="searchBooks()">검색</button>
    </form>
    <!-- 도서 기본 정보 폼 -->
    <form id="bookForm">
        <div class="row">
            <div class="col-md-6">
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
                    <button type="button" class="btn btn-info mt-2" onclick="checkIsbn()">유효성 검사</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="category">카테고리</label>
                    <input type="text" class="form-control" id="category" name="categoryString" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="price">가격</label>
                    <input type="number" class="form-control" id="price" name="bookPrice" required>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="stock">재고</label>
                    <input type="number" class="form-control" id="stock" name="bookAmount" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="description">책 설명</label>
                    <textarea class="form-control" id="description" name="bookDescription" rows="3"></textarea>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-primary" onclick="submitBookForm()" style="display: none">도서 정보 저장</button>
    </form>

    <!-- 도서 상세 정보 표시 -->
    <form id="bookDetailForm" >
        <input type="hidden" id="bookNo" name="bookNo">
        <div class="form-group">
            <label for="detailImage">상세설명 이미지 추가</label>
            <input type="file" class="form-control" id="detailImage" name="detailImage" onchange="previewImage(this, 'imagePreview')">
            <div class="image-preview" id="imagePreview">
                <img src="" alt="상세 설명 이미지" style="max-height: 300px;">
                <span>이미지 없음</span>
            </div>
            <div class="form-group">
                <label for="detailDescription">상세 설명</label>
                <textarea class="form-control" id="detailDescription" name="detailDescription" rows="3"></textarea>
            </div>
        </div>
   		<button type="submit" class="btn btn-primary" style="display: none">도서 등록 및 상세 정보 저장</button>
    </form>
   <button class="btn btn-primary" id="saveAllbtn">도서 등록 및 상세 정보 저장</button>
</div>

<script>
var currentPage = 1;

	function searchBooks() {
	    var $keyword = $('#keyword').val(); 
	    console.log($keyword);
	    $.ajax({
	        url: 'api',
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

	
	$(document).ready(function() {
	    $('#saveAllbtn').on('click', function(event) {
	        if (!isIsbnValid) {
	            event.preventDefault();
	            alert('ISBN 유효성 검사를 통과해야 합니다.');
	        } else {
	            saveAll();
	        }
	    });
	});


	function changePage(delta) {
	    currentPage += delta;
	    if (currentPage < 1) {
	        currentPage = 1;
	    }
	    searchBooks();
	}

</script>
    detailFormData.append('bookNo', responseData);

<script>
let responseData;

//도서 정보와 상세 정보를 순차적으로 저장
function saveAll() {
    var bookFormData = new FormData($('#bookForm').get(0));

    $.ajax({
        url: 'books/saveBook',
        type: 'POST',
        data: bookFormData,
        contentType: false,
        processData: false,
        success: response => {
        	if (response.message == '도서 저장 성공') {  // 성공 시 데이터 체크
                console.log(response.data);	//34
                responseData = response.data;
        		alert('도서 기본 정보 저장 성공: ' + response.message);
                $('#bookDetailForm').find('input[name="bookNo"]').val(response.data);
                saveBookDetail();
            } else {
                alert('도서 기본 정보 저장 실패: ' + response.message);
            }
        }
    });
}


function saveBookDetail() {
    var bookDetailForm = new FormData($('#bookDetailForm').get(0));
    bookDetailForm.append('bookNo', responseData);
    console.log(responseData);
    $.ajax({
        url: 'books/saveBookDetail',
        type: 'POST',
        data: bookDetailForm,
        contentType: false,
        processData: false,
        success: response => {
        	if (response.message == "도서 상세정보 저장 성공") {
                alert('도서 상세 정보 저장 성공!');
            } else {
                alert('도서 상세 정보 저장 실패');
            }
        },
        error : function() {
            alert('도서 상세 정보 저장 중 오류 발생');
        }
    });
}







</script>










</body>
</html>
