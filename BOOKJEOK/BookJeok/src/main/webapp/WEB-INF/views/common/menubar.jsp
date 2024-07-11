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
                     <c:choose>
		            	<c:when test="${ sessionScope.loginUser eq null }">
		            		<%-- ${ empty sessionScope.loginUser } --%>
			                <!-- 로그인 전 -->
			                <a href="member/joinform">회원가입</a>
			                <a href="member/loginform">로그인</a>
		                </c:when>
		                <c:otherwise>
			                <!-- 로그인 후 -->
			                <label>${ sessionScope.loginUser.userName }님 환영합니다</label> &nbsp;&nbsp;
			                <a href="#">마이페이지</a>
			                <a href="#">로그아웃</a>
		                </c:otherwise>
	                </c:choose>
	                <div id="header_2">
			            <ul>
			                <li><a href="../list.qna">1대1문의</a></li>
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