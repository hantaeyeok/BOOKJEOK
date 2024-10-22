<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<title>B강의장 프로젝트 입니다</title>
<style>
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
  width: 360px;
  padding: 8% 0 0;
  margin: auto;
}
.form {
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 360px;
  margin: 0 auto 100px;
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #0090F0;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,.form button:active,.form button:focus {
  background: #0066F0;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #0090F0;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
.container {
  position: relative;
  z-index: 1;
  max-width: 300px;
  margin: 0 auto;
}
.container:before, .container:after {
  content: "";
  display: block;
  clear: both;
}
.container .info {
  margin: 50px auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 36px;
  font-weight: 300;
  color: #1a1a1a;
}
.container .info span {
  color: #4d4d4d;
  font-size: 12px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #EF3B3A;
}
body {
  background: #89E4F0; /* fallback for old browsers */
  background: #89E4F0;
  background: linear-gradient(90deg, rgba(137, 228, 240,1) 0%, rgba(137, 228, 240,1) 50%);
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;      
}
</style>
</head>
<body>
	<div id="content">
		<div class="login-page">
		  <div class="form">
		    <form action="/member/login" method="post" class="login-form" id="formdata">
		      <input type="text" placeholder="아이디" name="userId"/>
		      <input type="password" placeholder="패스워드" name="userPwd"/>
		      <button type="button" style="margin-bottom:10px;" onclick="loginfnc()">login</button>
		      <br>
		      <img alt="카카오 로그인" id="login_kakao" src="/resources/img/kakao_login_medium_narrow.png"/>
		      <p class="message">아이디가 없으신가요? <a href="/member/joinform">회원가입</a></p>
		      <p class="message"><a href="/member/findId">아이디찾기 </a> / <a href="/member/findPwd"> 비밀번호찾기</a></p>
		    </form>
		  </div>
		</div>
		<script>
			document.getElementById('login_kakao').onclick = () => {
				let text='https://kauth.kakao.com/oauth/authorize' +
						 '?client_id=7c415afe1c27d9e3c6d607c7ab634426' +
						 '&redirect_uri=http://localhost/member/oauth' +
						 '&response_type=code' +
						 '&scope=profile_nickname,profile_image';
				location.href=text;
			};
			function loginfnc() {
				$formdata = $("#formdata").serialize();
				$.ajax({
					url: "/member/login",
					type: "POST",
					data: $formdata,
					success: rst => {
						if (rst.message==="success") {
							location.href="/";
						} else {
							alert("아이디나 비밀번호가 틀립니다.");
						}
					}
					
				});
			}
		</script>
	</div>
</body>
</html>