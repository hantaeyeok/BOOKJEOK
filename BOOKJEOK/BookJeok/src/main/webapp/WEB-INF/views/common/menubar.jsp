<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/css/common.css">
    <style>
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
<body>
    <header>
        <div class="header_wrapper columns">
            <nav id="global-navigation">
                <div class="gnb_wrap">
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
	                        		<a class="login_div" href="/member/logout">로그아웃</a>
	                        	</c:otherwise>
	                        </c:choose>
                        </div>
                    </div>
                </div>
            </nav>
        </div>

        <!--
        <aside id="review-banner">
            <h3>리뷰 배너</h3>
        </aside>
        -->
    </header>
</body>
</html>