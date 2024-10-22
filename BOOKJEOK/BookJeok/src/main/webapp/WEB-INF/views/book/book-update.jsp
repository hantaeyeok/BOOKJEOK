<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 수정 페이지</title>

</head>
<body>

<jsp:include page="../common/menubar.jsp" />


<div class="container-fluid">
    <div class="row">
        <!-- 좌측 메뉴바 -->
        <jsp:include page="../common/adminMenuBar.jsp"></jsp:include>

        <!-- 메인 콘텐츠 영역 -->
        <div class="col-md-9">

                <h2>도서 수정 페이지</h2>
                
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
					            <input type="file" class="form-control-file" id="bookCoverFile"  name="bookCoverFile" style="display: none" onchange="previewCoverImage(this)"/>
					            <img id="coverPreview" src="http://via.placeholder.com/150x150" class="img-fluid" alt="책 표지 미리보기">
                            </div>
                        </div>
<script>
document.getElementById('coverType').addEventListener('change', function() {
    const coverType = document.getElementById('coverType').value;
    const textInput = document.getElementById('bookCoverText');
    const fileInput = document.getElementById('bookCoverFile');

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

function previewCoverImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
        	document.getElementById('coverPreview').src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}
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
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="topCategory">상위 카테고리</label>
                                <select class="form-control" id="topCategory" onchange="fetchUpperCategories(); toggleCustomInput('topCategory');">
                                    <option value="">선택</option>
                                    <option value="custom">직접 입력</option>
                                </select>
                                <input type="text" class="form-control mt-2" id="topCategoryInput" name="topCategory" style="display:none;" placeholder="직접 입력">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="upperCategory">중위 카테고리</label>
                                <select class="form-control" id="upperCategory" onchange="fetchMidCategories(); toggleCustomInput('upperCategory');"></select>
                                <input type="text" class="form-control mt-2" id="upperCategoryInput" name="upperCategory" style="display:none;" placeholder="직접 입력">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="midCategory">하위 카테고리</label>
                                <select class="form-control" id="midCategory" onchange="fetchLowerCategories(); toggleCustomInput('midCategory');"></select>
                                <input type="text" class="form-control mt-2" id="midCategoryInput" name="midCategory" style="display:none;" placeholder="직접 입력">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="lowerCategory">최하위 카테고리</label>
                                <select class="form-control" id="lowerCategory" onchange="toggleCustomInput('lowerCategory');"></select>
                                <input type="text" class="form-control mt-2" id="lowerCategoryInput" name="lowerCategory" style="display:none;" placeholder="직접 입력">
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
                                <input type="number" class="form-control" id="bookAmount" name="bookAmount" required>
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
                <form id="bookDetailForm">
					 <input type="hidden" id="bookNo" name="bookNo">
					    <div class="form-group">
					        <label for="detailImage">상세설명 이미지 추가</label>
					        <select id="detailImageType">
					            <option value="basic" selected>기존 이미지 사용</option>
					            <option value="custom">이미지 변경</option>
					        </select>
					        <br>
					        <input type="file" class="form-control" id="detailImageFile" name="detailImageFile" style="display: none" onchange="previewImage(this, 'imagePreview')">
					        <input type="file" class="form-control" id="detailImageString" name="detailImageString" style="display: none" onchange="previewImage(this, 'imagePreview')">
					        
					        <div class="image-preview" id="imagePreview">
					            <img src="" alt="상세 설명 이미지" style="max-height: 300px;" id="detailImage">
					        </div>
					        
					    </div>
					    <div class="form-group">
					        <label for="detailDescription">상세 설명</label>
					        <textarea class="form-control" id="detailDescription" name="detailDescription" rows="3"></textarea>
					    </div>
					    <button type="submit" class="btn btn-primary" style="display: none">도서 등록 및 상세 정보 저장</button>
					</form>
                <button class="btn btn-primary" id="saveAllbtn">도서 등록 및 상세 수정</button>
                
            </div>
        </div>
    </div>

<script>
	document.getElementById('detailImageType').addEventListener('change', function() {
	    const detailImageSelect = document.getElementById('detailImageType').value;
	    const detailImageFile = document.getElementById('detailImageFile');
	    const detailImageString = document.getElementById('detailImageString');
	
	    if (detailImageSelect === 'basic') {
	    	detailImageFile.style.display = 'none';
	        detailImageFile.name = '';
	        detailImageString.style.display = 'none';
	        detailImageString.name = 'detailImageString';
	    } else if (detailImageSelect === 'custom') {
	    	detailImageFile.style.display = '';
	    	detailImageFile.name = 'detailImageFile';
	        detailImageString.style.display = 'none';
	        detailImageString.name = '';
	    }
	});

function previewImage(input, previewId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById(previewId).querySelector('img').src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}



</script>

<script>
var currentPage = 1;
var bookData = {};

function searchBooks() {
   var $keyword = $('#keyword').val(); 
   console.log(typeof currentPage);
    $.ajax({
        url: '/bookjeok/book/update',
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
    $('#description').val(book.bookDescription);
    $('#price').val(book.bookPrice);
    $('#bookAmount').val(book.bookAmount);
    $('#detailImage').attr('src', book.detailImage);
    $('#detailDescription').val(book.detailDescription);
    $('#bookNo').val(book.bookNo);
    $('#pubDate').val(book.bookPubDate);
    setCategory('topCategory', book.topCategoryName);
    setCategory('upperCategory', book.upperCategoryName);
    setCategory('midCategory', book.midCategoryName);
    setCategory('lowerCategory', book.lowerCategoryName);
}

function closeModal() {
    $('#bookModal').modal('hide');
}


function setCategory(categoryId, categoryValue) {
    const categorySelect = $('#' + categoryId);
    const categoryInput = $('#' + categoryId + 'Input');
    if (categorySelect.find('option[value="' + categoryValue + '"]').length > 0) {
        categorySelect.val(categoryValue).change();
    } else {
        categorySelect.val('custom').change();
        categoryInput.val(categoryValue).show();
    }
}

$(document).ready(function() {
    $('#saveAllbtn').on('click', function(event) {  
            saveAll();
    });
    fetchTopCategories();
});

function fetchTopCategories() {
    $.ajax({
        url: 'top',
        type: 'GET',
        success: response => {
            $('#topCategory').html('<option value="">선택</option><option value="custom">직접 입력</option>');
            response.forEach( category => {
                $('#topCategory').append('<option value="' + category.topCategoryNo + '">' + category.topCategoryName + '</option>');
            });
        }
    });
    toggleCustomInput('topCategory');
}

function fetchUpperCategories(selectedValue) {
    var topCategoryNo = $('#topCategory').val();
    if (topCategoryNo && topCategoryNo !== 'custom') {
        $.ajax({
            url: 'upper/' + topCategoryNo,
            type: 'GET',
            success: response => {
                $('#upperCategory').html('<option value="">선택</option><option value="custom">직접 입력</option>');
                response.forEach(category => {
                    $('#upperCategory').append('<option value="' + category.upperCategoryNo + '">' + category.upperCategoryName + '</option>');
                });
                if (selectedValue) {
                    $('#upperCategory').val(selectedValue);
                }
            }
        });
    } else {
        $('#upperCategory').html('<option value="">선택</option><option value="custom">직접 입력</option>');
    }
    toggleCustomInput('upperCategory');
}

function fetchMidCategories(selectedValue) {
    var upperCategoryNo = $('#upperCategory').val();
    if (upperCategoryNo && upperCategoryNo !== 'custom') {
        $.ajax({
            url: 'mid/' + upperCategoryNo,
            type: 'GET',
            success: response => {
                $('#midCategory').html('<option value="">선택</option><option value="custom">직접 입력</option>');
                response.forEach(category => {
                    $('#midCategory').append('<option value="' + category.midCategoryNo + '">' + category.midCategoryName + '</option>');
                });
                if (selectedValue) {
                    $('#midCategory').val(selectedValue);
                }
            }
        });
    } else {
        $('#midCategory').html('<option value="">선택</option><option value="custom">직접 입력</option>');
    }
    toggleCustomInput('midCategory');
}

function fetchLowerCategories(selectedValue) {
    var midCategoryNo = $('#midCategory').val();
    if (midCategoryNo && midCategoryNo !== 'custom') {
        $.ajax({
            url: 'lower/' + midCategoryNo,
            type: 'GET',
            success: response => {
                $('#lowerCategory').html('<option value="">선택</option><option value="custom">직접 입력</option>');
                response.forEach(category => {
                    $('#lowerCategory').append('<option value="' + category.lowerCategoryNo + '">' + category.lowerCategoryName + '</option>');
                });
                if (selectedValue) {
                    $('#lowerCategory').val(selectedValue);
                }
            }
        });
    } else {
        $('#lowerCategory').html('<option value="">선택</option><option value="custom">직접 입력</option>');
    }
    toggleCustomInput('lowerCategory');
}

function toggleCustomInput(categoryLevel) {
    const selectElement = $('#' + categoryLevel);
    const inputElement = $('#' + categoryLevel + 'Input');
    if (selectElement.val() === 'custom') {
        inputElement.show();
        inputElement.attr('name', categoryLevel);
        selectElement.attr('name', '');
    } else {
        inputElement.hide();
        inputElement.attr('name', '');
        selectElement.attr('name', categoryLevel);
    }
}

let responseData;

//도서 정보와 상세 정보를 순차적으로 저장
function saveAll() {
	let topCategory, upperCategory, midCategory, lowerCategory, categoryString;
	
	$('#topCategory').val() === 'custom' ? topCategory = $('#topCategoryInput').val(): topCategory = $('#topCategory option:selected').text();
	$('#upperCategory').val() === 'custom' ? upperCategory = $('#upperCategoryInput').val(): upperCategory = $('#upperCategory option:selected').text();
	$('#midCategory').val() === 'custom' ?  midCategory = $('#midCategoryInput').val(): midCategory = $('#midCategory option:selected').text();
	$('#lowerCategory').val() === 'custom' ? lowerCategory = $('#lowerCategoryInput').val() : lowerCategory = $('#lowerCategory option:selected').text() ;

	categoryString = topCategory; 
	if (upperCategory) {
	    categoryString += '>' + upperCategory;
	}
	if (midCategory) {
	    categoryString += '>' + midCategory;
	}
	if (lowerCategory) { 
	    categoryString += '>' + lowerCategory;
	}
    
    const $bookNo = $('#bookNo').val();
    const coverTypeBook = document.getElementById('coverType').value;
    const textInputBook = document.getElementById('bookCoverText');
    const fileInputBook = document.getElementById('bookCoverFile');
    const bookFormDatal = new FormData($('#bookForm').get(0));
    bookFormDatal.append('bookNo', $bookNo);
    bookFormDatal.append('categoryString',categoryString);
    coverTypeBook === 'basic' ? bookFormDatal.delete('bookCoverFile') : bookFormDatal.append('bookCoverText',textInputBook.value) ;
    coverTypeBook === 'custom' ? bookFormDatal.append('bookCoverFile', fileInputBook.value) : bookFormDatal.delete('bookCoverText');
     
    $.ajax({
        url: '/bookjeok/book/updateBook',
        type: 'POST',
        data: bookFormDatal,
        contentType: false,
        processData: false,
        success: response => {
            if (response.message == '도서 수정 성공') {
                console.log(response.data);
                responseData = response.data;
                alert('도서 기본 정보 저장 성공: ' + response.message);
                $('#bookDetailForm').find('input[name="bookNo"]').val(response.data);
                saveBookDetail();
            } else {
                alert('도서 기본 정보 수정 실패: ' + response.message);
            }
        }
    });
}

function saveBookDetail() {
 	const detailImageSelect = document.getElementById('detailImageType').value; 
	const fileInput = document.getElementById('detailImageFile');
    const stringInput = document.getElementById('detailImageString');
	const bookDetailForm = new FormData($('#bookDetailForm').get(0));
		  bookDetailForm.append('bookNo', responseData);
   
	detailImageSelect === 'basic' ? bookDetailForm.delete('detailImageString'): bookDetailForm.append('detailImageString', stringInput.value) ;
	detailImageSelect === 'custom' ? bookDetailForm.append('detailImageFile',fileInput): bookDetailForm.delete('detailImageString');
				
    $.ajax({
        url: '/bookjeok/book/updateBookDetail',
        type: 'POST',
        data: bookDetailForm,
        contentType: false,
        processData: false,
        success: response => {
            if (response.message == "도서 상세정보 수정 성공") {
                alert('도서 상세 정보 수정 성공!');
            } else {
                alert('도서 상세 정보 수정 실패');
            }
        },
        error : function() {
            alert('도서 상세 정보 수정 중 오류 발생');
        }
    });
}

</script>
</body>
</html>
