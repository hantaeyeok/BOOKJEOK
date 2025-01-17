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
<br>
<jsp:include page="../common/menubar.jsp"></jsp:include>
<div style="width:100%; height:1200px; display:flex; justify-content:center;">
	<div style="width:600px;" id="page1">
	<form>
	  <div class="row mb-3">
	    <label for="userName" class="col-sm-2 col-form-label">이름</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="userName">
	    </div>
	  </div>
	  <div class="row mb-3">
	    <label for="email" class="col-sm-2 col-form-label">이메일</label>
	    <div class="col-sm-10">
	      <input type="email" class="form-control" id="email">
	    </div>
	  </div>
	  <div style="width:600px; height:500px;"></div>
	  <button type="button" class="btn btn-primary btn-lg btn-block" onclick="idFind();">아이디 찾기</button>
	  <script>
	  	function idFind() {
	  		const $page1 = $('#page1');
	  		const $page2 = $('#page2');
	  		const $page3 = $('#page3');
	  		
	  		requestData = {
  				userName: $('#userName').val(),
  				email: $('#email').val()
	  		}
	  		$.ajax({
	  			url:'/member/findId',
	  			type: 'post',
	  			data: requestData,
	  			success : response => {
	  				//console.log(response.data);
					if (response.data == 'success') {
						$page1.hide();
						$page2.show();
						$page3.hide();
					}
					if (response.data == 'fail') {
						$page1.hide();
						$page2.hide();
						$page3.show();
					}
	  			}
	  		});
	  	}
	  </script>
	</form>
	</div>
	<div style="width:30%; display:none;" id="page2">
		입력하신 이메일로 아이디가 전송되었습니다.<br>
		이메일을 확인하여주세요.
		<div style="width:100%; height:300px;"></div>
		<button type="submit" class="btn btn-primary btn-lg btn-block" onclick="location.href='/member/loginform';">돌아가기</button>
	</div>
	<div style="width:30%; display:none;" id="page3">
		이메일과 이름이 회원 정보와 일치하지 않습니다.<br>
		다시 확인해주세요.
		<div style="width:100%; height:300px;"></div>
		<button type="submit" class="btn btn-primary btn-lg btn-block" onclick="location.href='/member/loginform';">돌아가기</button>
	</div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>