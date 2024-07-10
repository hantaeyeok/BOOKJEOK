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
    </style>
</head>
<body>
    <header>
        <div class="header_wrapper columns">
            <nav id="global-navigation">
                <div class="gnb_wrap">
                    <div class="column is-5">
                        <div class="anb_wrap"><img src="https://cdn-icons-png.flaticon.com/512/94/94225.png" alt=""></div>
                        <ul class="gnb_list">
                            <li class="gnb_items">노트북</li>
                            <li class="gnb_items">스마트폰</li>
                            <li class="gnb_items">태블릿</li>
                            <li class="gnb_items">스마트워치</li>
                            <li class="gnb_items">이어폰</li>
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
                        <div class="user_menu"><i class="fas fa-home"></i><i class="fas fa-bars"></i></div>
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