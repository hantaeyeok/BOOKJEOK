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
<div style="width:100%; height:1200px; display:flex; justify-content:center;">
	<div style="width:30%;" id="page1">
	<form>
	  <div class="row mb-3">
	  	<input type="hidden" value="${member.userId }" id="userId">
	    <label for="userPwd" class="col-sm-2 col-form-label">새 비밀번호</label>
	    <div class="col-sm-10">
	      <input type="password" class="form-control" id="userPwd">
	    </div>
	  </div>
	  <div class="row mb-3">
	    <label for="userPwdRetype" class="col-sm-2 col-form-label">새 비밀번호 확인</label>
	    <div class="col-sm-10">
	      <input type="password" class="form-control" id="userPwdRetype">
	    </div>
	  </div>
	  <div style="width:100%; height:300px;"></div>
	  <button type="button" class="btn btn-primary btn-lg btn-block" onclick="pwdReset();">비밀번호 재설정</button>
	  <script>
	  	function pwdReset() {
	  		const pw_pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	  		const $page1 = $('#page1');
	  		const $page2 = $('#page2');
	  		const $userPwd = $('#userPwd');
	  		const $userPwdRetype = $('#userPwdRetype');
	  		
	  		
	  		memberData = {
  				userId: $('#userId').val(),
  				userPwd: $('#userPwd').val(),
  				code: '${pwResetKey.code}'
	  		}
	    	if(pw_pattern.test($userPwd.val())) { //패스워드 정규식
	        	if($userPwd.val()===$userPwdRetype.val()) { //비밀번호와 비밀번호확인 일치여부
			  		$.ajax({
			  			url:'/member/pwdresetPro',
			  			type: 'post',
			  			data: memberData,
			  			success : response => {
							if (response.data == 'success') {
								$page1.hide();
								$page2.show();
							}
			  			}
			  		});
	        	} else {
	        		alert('비밀번호와 비밀번호확인란이 일치하지 않습니다.');
	        	}
	    	} else {
	    		alert('비밀번호는 영어 대문자, 영어 소문자, 숫자, 특수문자가 하나씩 포함된 문자열로 작성하여주세요.');
	    	}
	  	}
	  </script>
	</form>
	</div>
	<div style="width:30%; display:none;" id="page2">
		비밀번호 재설정이 완료되었습니다.
		<div style="width:100%; height:300px;"></div>
		<button type="submit" class="btn btn-primary btn-lg btn-block" onclick="location.href='/member/loginform';">로그인 창으로</button>
	</div>
</div>

</body>
</html>