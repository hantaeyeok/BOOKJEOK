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
</head>
<body>
<jsp:include page="../common/menubar.jsp"></jsp:include>

<div style="width:100%; height:75px;"></div>
<div style="width:100%; height:800px; display:flex; justify-content:center;">
<div style="width:30%; padding:50px;">
<form action="/member/EditMemberPwCheck" method="POST">
	<p>현재 비밀번호를 입력해주세요</p>	
	<div class="form-group">
	    <input type="password" class="form-control" name="userPwd" id="userPwd">
	</div>
	<div style="width:100%; height:300px;"></div>
	<button type="submit" class="btn btn-primary btn-lg btn-block">확인</button>
</form>
</div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>