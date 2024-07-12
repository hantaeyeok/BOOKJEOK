<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <header>
        <div class="header_wrapper columns">
        <form class="form-inline my-4">
            <div class="dropdown w-100">
                <input type="text" class="form-control w-75" id="searchInput" name="searchInput" placeholder="검색어를 입력하세요" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <button type="button" class="btn btn-primary ml-2" id="searchButtonDB">검색</button>
                <div id="searchResults" class="dropdown-menu" aria-labelledby="searchInput"></div>
            </div>
        </form>
        </div>
    </header>
    
<script>

    $(document).ready(function() {
    	$('#searchInput').on('input', function() {
            var $bookKeyword = $('#bookKeyword').val();
            if (bookKeyword.length > 0) {
                searchBookDB(bookKeyword);
            } else {
                $('#searchResults').empty().removeClass('show');
        	}
    	})
    }
    	
  	 $('#searchButtonDB').on('click', function() {
 	     var bookKeyword = $('#searchInput').val();
 	     if (bookKeyword.length > 0) {
 	          window.location.href = '/bookjeok/book/search?bookKeyword=' + bookKeyword;
 	     }
	 });	
   	 
  	function searchBookDB($bookKeyword) {
  		$.ajax({
			url : '/bookjeok/book/search',
			type : 'GET',
			data : { bookKeyword : $bookKeyword},
			success : result => {
				console.log(result);
				displayResults(result);
			},
			error : e => {
				console.log("메뉴바 ajax 오류오류오류오류오류로유로")
			}
		});
	}
  		 
	function displayResults(books) {
		var $searchResults =  $('#searchResults');
		$searchResults.empty();
		if(books.length > 0){
			books.forEach(function (book) {
                var item = $('<a class="dropdown-item" href="/books/' + book.bookNo + '"><img src="' + book.cover + '" style="width:100px;height:150px;">' + book.bookTitle + ' - ' + book.bookAuthor + '</a>');
                $searchResults.append(item);
			});
		} else{
            $searchResults.append('<a class="dropdown-item disabled" href="#">검색 결과가 없습니다.</a>');
		}
		if (!$searchResults.hasClass('show')) {
            $searchResults.addClass('show');
        }
	}

    </script>

</body>
</html>