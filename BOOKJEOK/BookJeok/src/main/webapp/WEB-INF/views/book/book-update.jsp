<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
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
				    <input type="text" class="form-control-file" id="bookCoverText"  name="bookCoverText" style="display: none" value="${ }"/>
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
                    <input type="text" class="form-control" id="title" name="bookTitle" value="${book.bookTitle }" required>
                </div>
                <div class="form-group">
                    <label for="author">저자</label>
                    <input type="text" class="form-control" id="author" name="bookAuthor" value="${ }" required>
                </div>
                <div class="form-group">
                    <label for="publisher">출판사</label>
                    <input type="text" class="form-control" id="publisher" name="bookPublisher" value="${ }" required>
                </div>
                <div class="form-group">
                    <label for="pubDate">출판일</label>
                    <input type="date" class="form-control" id="pubDate" name="bookPubDate" value="${ }" required>
                </div>
                <div class="form-group">
                    <label for="isbn">ISBN</label>
                    <input type="text" class="form-control" id="isbn" name="bookIsbn" value="${ }" required>
                    <button type="button" class="btn btn-info mt-2" onclick="checkIsbn()">유효성 검사</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="category">카테고리</label>
                    <input type="text" class="form-control" id="category" name="categoryString"  value="${ }" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="price">가격</label>
                    <input type="number" class="form-control" id="price" name="bookPrice"  value="${ }" required>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="stock">재고</label>
                    <input type="number" class="form-control" id="stock" name="bookAmount" value="${ }" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="description">책 설명</label>
                    <textarea class="form-control" id="description" name="bookDescription" rows="3" value="${ }" ></textarea>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-primary" onclick="submitBookForm()" style="display: none" value="${ }" >도서 정보 저장</button>
    </form>
    <!-- 도서 상세 정보 표시 -->
    <form id="bookDetailForm" >
        <input type="hidden" id="bookNo" name="bookNo">
        <div class="form-group">
            <label for="detailImage">상세설명 이미지 추가</label>
            <input type="file" class="form-control" id="detailImage" name="detailImage" onchange="previewImage(this, 'imagePreview')" value="${ }">
            <div class="image-preview" id="imagePreview">
                <img src="" alt="상세 설명 이미지" style="max-height: 300px;">
                <span>이미지 없음</span>
            </div>
            <div class="form-group">
                <label for="detailDescription">상세 설명</label>
                <textarea class="form-control" id="detailDescription" name="detailDescription" rows="3" value="${ }"></textarea>
            </div>
        </div>
   		<button type="submit" class="btn btn-primary" style="display: none">도서 등록 및 상세 정보 저장</button>
    </form>
   <button class="btn btn-primary" id="saveAllbtn">도서 등록 및 상세 정보 저장</button>
</div>

<script>
	$(()=>{
		$('#saveAllbtn').click(()=>
			saveAll();
		)
	})
		
/*
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
*/

let responseData;

//도서 정보와 상세 정보를 순차적으로 저장
function saveAll() {
    var bookFormData = new FormData($('#bookForm').get(0));

    $.ajax({
        url: 'books/saveBook',
        type: 'PUT',
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
        type: 'PUT',
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
