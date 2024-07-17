<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menubar</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
            var bookKeyword = $('#searchInput').val(); // 검색어를 입력받는 요소의 값을 가져옴
            if (bookKeyword.length > 0) {
                searchBookDB(bookKeyword);
            } else {
                $('#searchResults').empty().removeClass('show');
            }
        });
        
        $('#searchButtonDB').on('click', function() {
            var bookKeyword = $('#searchInput').val();
            if (bookKeyword.length > 0) {
                window.location.href = '/bookjeok/book/search?bookKeyword=' + bookKeyword;
            }
        });
    });
    
    function searchBookDB(bookKeyword) {
        $.ajax({
            url : '/bookjeok/book/search',
            type : 'GET',
            data : { bookKeyword : bookKeyword },
            success : result => {
                displayResults(result);
            },
            error : e => {
                console.log("메뉴바 ajax 오류오류오류오류오류로유로");
            }
        });
    }
    /*
    function displayResults(books) {
        var $searchResults = $('#searchResults');
        $searchResults.empty();  // 이전 결과를 비웁니다.

        if (books.length > 0) {
            books.forEach(function(book) {
                // bookNo 값이 정의되어 있고, 숫자형인지 확인합니다.
                if (book.bookNo && typeof book.bookNo === "number") {
                    // 드롭다운 아이템을 생성합니다.
                    var item = $('<a class="dropdown-item" href="/bookjeok/book/' + book.bookNo + '">' +
                                 '<img src="' + book.bookCover + '" style="width:100px; height:150px;"> ' +
                                 book.bookTitle + ' - ' + book.bookAuthor + '</a>');
                    $searchResults.append(item);
                } else {
                    // bookNo가 유효하지 않을 경우 콘솔에 로그를 기록합니다.
                    console.log(' bookNo :', book.bookNo);
                }
            });
        } else {
            $searchResults.append('<a class="dropdown-item disabled" href="#">검색 결과가 없습니다.</a>');
        }

        // 드롭다운 메뉴를 활성화합니다.
        if (!$searchResults.hasClass('show')) {
            $searchResults.addClass('show');
        }
    }
*/
    function displayResults(books) {
        var $searchResults =  $('#searchResults');
        $searchResults.empty();
        if (books.length > 0) {
            books.forEach(function(book) {
                var item = $('<a class="dropdown-item" href="/bookjeok/book/' + book.bookNo + '"><img src="' + book.bookCover + '" style="width:100px;height:150px;">' + book.bookTitle + ' - ' + book.bookAuthor + '</a>');
                $searchResults.append(item);
            });
        } else {
            $searchResults.append('<a class="dropdown-item disabled" href="#">검색 결과가 없습니다.</a>');
        }
        if (!$searchResults.hasClass('show')) {
            $searchResults.addClass('show');
        }
    }

    </script>
</body>
</html>