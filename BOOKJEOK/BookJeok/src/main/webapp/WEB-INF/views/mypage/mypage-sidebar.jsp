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
    <style>
    	.sidebar {width:100%; background-color:#FFF; padding:20px; transition:0.3s;}
    	.sidebar:hover {width:100%; background-color:#CCC; padding:20px;}
    </style>
</head>
<body>
<div style="width:100%; height:800px; background-color:#FFF; padding:20px;">
	<h1 style="padding:20px;background-color:#DDD">마이페이지</h1>
	<div class="sidebar" onclick="toEditMemberInfo();">
		회원정보 변경
	</div>
	<div class="sidebar" >
		장바구니
	</div>
	<div class="sidebar" >
		주문 목록
	</div>
</div>
<script>
function toEditMemberInfo() {
	location.href="/member/editMemberInfoBfr";
};

</script>
</body>
</html>