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
    <link rel="stylesheet" href="/resources/css/common.css">


<!--
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/css/common.css">
-->    
<style>
    	header {z-index:999; position:fixed; background-color:rgba(255,255,255,0.5);}
    	li {list-style-type: none; list-style:none;}
    	a {text-decoration-line:none; color:#333;}
    	a:hover {text-decoration-line:none; color:#333;}
    	.gnb_list {display:flex; justify-content:center; align-items:center;}
    	.gnb_list > ul {width:100%; height:100%; display:flex; justify-content:center; align-items:center; margin:0px; padding:0px 30px;}
    	.gnb_list > ul > li {width:100%; height:100%;display:flex; justify-content:center; align-items:center;}
    	.gnb_list > ul > li:hover {cursor:pointer; background-color:#CCC; transition:0.3s}
    	.user_menu_wrap {height:100%;}
    	.user_menu {height:100%;}
    	.login_div {padding:0 20px; height:100%; display:flex; justify-content:center; align-items:center;}
    	.login_div:hover {background-color:#CCC; transition:0.3s;}
    </style>

</head>
    <header>
        <div class="header_wrapper columns">

            <nav id="global-navigation">
                <div class="gnb_wrap">
    <!--
                     <c:choose>
		            	<c:when test="${ sessionScope.loginUser eq null }">
			                <a href="member/joinform">회원가입</a>
			                <a href="member/loginform">로그인</a>
		                </c:when>
		                <c:otherwise>
			                <label>${ sessionScope.loginUser.userName }님 환영합니다</label> &nbsp;&nbsp;
			                <a href="#">마이페이지</a>
			                <a href="#">로그아웃</a>
		                </c:otherwise>
	                </c:choose>
	                <div id="header_2">
			            <ul>
			                <li><a href="../list.qna">1대1문의</a></li>
			                <li><a href="../list.clubboard">독서모임게시판</a></li>
			            </ul>
			        </div>
      -->
                    <div class="column is-5 gnb_list">
                        <div class="anb_wrap"><img src="https://cdn-icons-png.flaticon.com/512/94/94225.png" alt=""></div>
                        <ul>
                            <li class="gnb_items">메뉴1</li>
                            <li class="gnb_items">메뉴2</li>
                            <li class="gnb_items">메뉴3</li>
                            <li class="gnb_items">메뉴4</li>
                            <li class="gnb_items">메뉴5</li>
                        </ul>
                    </div>
                    <div class="seacrh_wrap column is-6">
                        <div class="search_bar">
                            <form class="search-container">
                                <input type="text" id="search-bar" placeholder="검색">
                              </form>
                        </div>
                    </div>
                    <div class="user_menu_wrap column is-1">
                        <div class="user_menu">
	                        <i class="fas fa-home"></i><i class="fas fa-bars"></i>
	                        <c:choose>
	                        	<c:when test="${empty loginUser}">
			                        <a class="login_div" href="/member/loginform">로그인</a>
			                        <a class="login_div" href="/member/joinform">회원가입</a>
	                        	</c:when>
	                        	<c:when test="${loginUser.userId eq 'admin' }">
	                        		<a class="login_div" href="">관리자게시판</a>
	                        		<a class="login_div" href="/member/logout">로그아웃</a>
	                        	</c:when>
	                        	<c:otherwise>
	                        		<a class="login_div" href="/mypage/orderList">마이페이지</a>
	                        		<a class="login_div" href="/member/logout">로그아웃</a>
	                        	</c:otherwise>
	                        </c:choose>
                        </div>
                    </div>
                </div>
            </nav>

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