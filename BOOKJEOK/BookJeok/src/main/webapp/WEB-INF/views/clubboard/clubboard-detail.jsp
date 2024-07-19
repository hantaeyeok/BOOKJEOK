<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독서 모임 모집 게시판</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
    	
        .container-box {
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
           	width: 80%;
            margin:auto;
        }
        
        .container {
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin : 100px;
        }
        
        #container {
        	width: 55%;
        	padding: 20px 30px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px;
        }
        
        .header .badge {
            background-color: #00b894;
            color: white;
            padding: 7px 10px;
            border-radius: 5px;
            font-size: 14px;
        }
        
        /* 상태에 따라 다른 스타일 적용 */
        .header .recruiting {
            background-color: #20c997; /* 모집중 배경색 */
        }

        .header .completed {
            background-color: red; /* 모집완료 배경색 */
        }
        
        .header .writer {
        	padding: 5px 10px;
        	border: 1px solid #fff;
        	border-radius: 5px;
        	background-color: gray;
            font-size: 14px;
            color: white;
            text-align: center;
            font-weight: bold;
        }
        
        .image-container {
            width: 200px;
            height: 200px;
            background-color: white;
            margin-bottom: 20px;
            display: inline-block;
            justify-content: center;
            align-items: center;
            border : 1px solid #ddd;
            margin-left: 20px;
        }
        
        .image-container img {
            max-width: 200px;
            max-height: 200px;
        }
        
        .content {
        	display: inline-block;
        	margin-right: 40px;
        	margin-top: 10px;
        	float: right;
        }
        
        .content div {
            margin-bottom: 10px;
        }
        
        .content label {
            font-weight: bold;
            display: inline-block;
            width: 120px;
            height: 30px;
            text-align: center;
            vertical-align : center;
            border : 1px solid #fff;
            background-color : #d5d5d5;
            border-radius: 10px;
            padding: 2px;
        }
        
        .content .value {
            margin-left: 10px;
        }
        
        .title-container {
        	text-align: center;
        	font-weight: bold;
        	margin-left: 10px;
        }
        
        }
        .title-container .title {
        	font-weight: bold;
        	margin-left: 10px;
        	text-align: center;
        }
        
        .textarea-container {
            background-color: #f9f9f9;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-top: 20px;
            font-size: 14px;
            color: #333;
            line-height: 1.5;
            height: 200px;
            overflow-y: scroll;
        }
        
        .buttons {
            display: flex;
            justify-content : center;
            margin: 20px;
        }
        
        .buttons .btn {
            cursor: pointer;
            width: 100px;
            height: auto;
            margin: 10px;
        }
        
    </style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<div class="container-box">
	    <div class="container" id="container">
	        <div class="header">
	        	<span class="writer">작성자 : ${clubboard.userId }</span>
	            <span class="badge ${clubboard.clubStatus == '모집중' ? 'recruiting' : 'completed'}">${clubboard.clubStatus }</span>
	        </div>
	        <hr>
	        <div class="image-container">
	            <c:choose>
	      			<c:when test="${ empty clubboard.clubboardChangename }">
	      				<img src="https://st.kakaocdn.net/shoppingstore/store/20240528180123_b9a6145839c346e3a34304f14163d941.png" class="card-img-top" alt="소개이미지">
	      			</c:when>
	      			<c:otherwise>
	      				<img src="${clubboard.clubboardChangename }" class="card-img-top" alt="소개이미지">
	      			</c:otherwise>
	    		</c:choose>
	        </div>
	        <div class="content">
	            <div>
	                <label>모임 명</label>
	                <span class="value">${clubboard.bookclubName }</span>
	            </div>
	            <div>
	                <label>모집 인원</label>
	                <span class="value">${clubboard.clubNumber }명</span>
	            </div>
	            <div>
	                <label>신청 인원</label>
	                <span class="value">#명</span>
	            </div>
	            <div>
	                <label>모집 기간</label>
	                <span class="value">${clubboard.clubboardDate } ~ ${clubboard.clubPeriod }</span>
	            </div>
	        </div>
	        <hr>
	        <div class="title-container">
	            <span class="title" id="title">${clubboard.clubboardTitle }</span>
	        </div>
	        <div class="textarea-container">
	            ${clubboard.clubboardContent }
	        </div>
	        <c:if test="${not empty sessionScope.loginUser.userId }">
		        <c:choose>
			        <c:when test="${sessionScope.loginUser.userId eq clubboard.userId }">
				        <div class="buttons">
				            <a class="btn btn-success" href="updateForm.clubboard?clubboardNo=${clubboard.clubboardNo }">수정</a>
				            <a class="btn btn-danger" href="delete.clubboard?clubboardNo=${clubboard.clubboardNo }">삭제</a>
				            <a class="btn btn-info" href="list.clubboard">목록으로</a>
				        </div>
			        </c:when>
			        <c:otherwise>
			        	<c:choose>
			        		<c:when test="${sessionScope.loginUser.userId eq 'admin'}">
					        	<div class="buttons">
						            <a class="btn btn-primary" href="#">신청하기</a>
						            <a class="btn btn-danger" href="delete.clubboard?clubboardNo=${clubboard.clubboardNo }">삭제</a>
						            <a class="btn btn-info" href="list.clubboard">목록으로</a>
						        </div>
					        </c:when>
					        <c:otherwise>
					        	<div class="buttons">
						            <a class="btn btn-primary" href="#">신청하기</a>
						            <a class="btn btn-info" href="list.clubboard">목록으로</a>
						        </div>
					        </c:otherwise>
			        	</c:choose>
			        </c:otherwise>
		        </c:choose>
	        </c:if>
	        <c:if test="${empty sessionScope.loginUser.userId }">
	        	<div class="buttons">
		            <a class="btn btn-info" href="list.clubboard">목록으로</a>
		        </div>
	        </c:if>
	    </div>
    </div>
</body>
</html>