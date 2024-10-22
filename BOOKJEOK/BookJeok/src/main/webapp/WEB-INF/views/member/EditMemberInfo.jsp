<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EditMemberInfo</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
/* 64ac15 */
*,
*:before,
*:after {
  box-sizing: border-box;
}
body {
  font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 15px;
  color: #b9b9b9;
  background-color: #e3e3e3;
}
h4 {
  color: #0090F0;
}
input,
input[type="radio"] + label,
input[type="checkbox"] + label:before,
select option,
select {
  width: 100%;
  padding: 1em;
  line-height: 1.4;
  background-color: #f9f9f9;
  border: 1px solid #e5e5e5;
  border-radius: 3px;
  -webkit-transition: 0.35s ease-in-out;
  -moz-transition: 0.35s ease-in-out;
  -o-transition: 0.35s ease-in-out;
  transition: 0.35s ease-in-out;
  transition: all 0.35s ease-in-out;
}
input:focus {
  outline: 0;
  border-color: #0090F0;
}
input:focus + .input-icon i {
  color: #0090F0;
}
input:focus + .input-icon:after {
  border-right-color: #0090F0;
}
input[type="radio"] {
  display: none;
}
input[type="radio"] + label,
select {
  display: inline-block;
  width: 50%;
  text-align: center;
  float: left;
  border-radius: 0;
}
input[type="radio"] + label:first-of-type {
  border-top-left-radius: 3px;
  border-bottom-left-radius: 3px;
}
input[type="radio"] + label:last-of-type {
  border-top-right-radius: 3px;
  border-bottom-right-radius: 3px;
}
input[type="radio"] + label i {
  padding-right: 0.4em;
}
input[type="radio"]:checked + label,
input:checked + label:before,
select:focus,
select:active {
  background-color: #0090F0;
  color: #fff;
  border-color: #0066F0;
}
input[type="checkbox"] {
  display: none;
}
input[type="checkbox"] + label {
  position: relative;
  display: block;
  padding-left: 1.6em;
}
input[type="checkbox"] + label:before {
  position: absolute;
  top: 0.2em;
  left: 0;
  display: block;
  width: 1em;
  height: 1em;
  padding: 0;
  content: "";
}
input[type="checkbox"] + label:after {
  position: absolute;
  top: 0.45em;
  left: 0.2em;
  font-size: 0.8em;
  color: #fff;
  opacity: 0;
  font-family: FontAwesome;
  content: "\f00c";
}
input:checked + label:after {
  opacity: 1;
}
select {
  height: 3.4em;
  line-height: 2;
}
select:first-of-type {
  border-top-left-radius: 3px;
  border-bottom-left-radius: 3px;
}
select:last-of-type {
  border-top-right-radius: 3px;
  border-bottom-right-radius: 3px;
}
select:focus,
select:active {
  outline: 0;
}
select option {
  background-color: #0090F0;
  color: #fff;
}
.input-group {
  margin-bottom: 1em;
  zoom: 1;
}
.input-group:before,
.input-group:after {
  content: "";
  display: table;
}
.input-group:after {
  clear: both;
}
.input-group-icon {
  position: relative;
}
.input-group-icon input {
  padding-left: 4.4em;
}
.input-group-icon .input-icon {
  position: absolute;
  top: 0;
  left: 0;
  width: 3.4em;
  height: 3.4em;
  line-height: 3.4em;
  text-align: center;
  pointer-events: none;
}
.input-group-icon .input-icon:after {
  position: absolute;
  top: 0.6em;
  bottom: 0.6em;
  left: 3.4em;
  display: block;
  border-right: 1px solid #e5e5e5;
  content: "";
  -webkit-transition: 0.35s ease-in-out;
  -moz-transition: 0.35s ease-in-out;
  -o-transition: 0.35s ease-in-out;
  transition: 0.35s ease-in-out;
  transition: all 0.35s ease-in-out;
}
.input-group-icon .input-icon i {
  -webkit-transition: 0.35s ease-in-out;
  -moz-transition: 0.35s ease-in-out;
  -o-transition: 0.35s ease-in-out;
  transition: 0.35s ease-in-out;
  transition: all 0.35s ease-in-out;
}
.container {
  max-width: 38em;
  padding: 1em 3em 2em 3em;
  margin: 0em auto;
  border-radius: 4.2px;

}
.row {
  zoom: 1;
}
.row:before,
.row:after {
  content: "";
  display: table;
}
.row:after {
  clear: both;
}
.col-half {
  padding-right: 10px;
  float: left;
  width: 50%;
}
.col-half:last-of-type {
  padding-right: 0;
}
.col-third {
  padding-right: 10px;
  float: left;
  width: 33.33333333%;
}
.col-third:last-of-type {
  padding-right: 0;
}
#btn_submit {
	background:#0090F0;
	color:#FFF;
	font-size:1.1em;
}
#btn_submit:hover {
	background:#0070D0;
	color:#FFF;
	font-size:1.1em;
}
@media only screen and (max-width: 540px) {
  .col-half {
    width: 100%;
    padding-right: 0;
  }
}

</style>
</head>
<body>
<jsp:include page="../common/menubar.jsp"></jsp:include>
<div style="width:100%; height:75px;"></div>
<div style="width:100%; height:1000px;">
<c:if test="${PassEncryptPasscheck eq'OK'}">
	<div class="container">
	    <form action="/member/EditMemberInfoPwd" method="post" id="pwdForm">
	        <div class="row">
	            <h4>회원 정보</h4>
	            <div class="input-group input-group-icon"><input type="text" id="userId" placeholder="아이디" name="userId" value="${loginUser.userId }" readonly/>
	                <div class="input-icon"><i class="fa fa-user"></i></div>
	            </div>
	            
	            <div class="input-group input-group-icon">
	            	<input type="password" placeholder="비밀번호" id="userPwd" name="userPwd"/>
	                <div class="input-icon"><i class="fa fa-key"></i></div>
	                <div style="font-size:0.7em; margin-top:10px; float:right; color:gray;">비밀번호는 영어 대문자, 영어 소문자, 숫자, 특수문자가 하나씩 포함된 문자열로 작성하여주세요</div><br>
	            </div>
	            <div class="input-group input-group-icon"><input type="password" placeholder="비밀번호 재확인" id="userPwdRetype" />
	                <div class="input-icon"><i class="fa fa-key"></i></div>
	            </div>
	            <div class="input-group" style="display:flex; justify-content:flex-end;">
	            	<button type="button" class="btn btn-primary" id="pwd_submit" onclick="pwd_submitfc()">비밀번호 변경</button>
	            </div>
	            <br>
	            <script>
	            	function pwd_submitfc() {
	                	const pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	                	const $userId = $('#userId');
	                	const $userPwd = $('#userPwd');
	                	const $userPwdRetype = $('#userPwdRetype');
	                	const $pwdForm = $('#pwdForm');
	                	if(pattern.test($userPwd.val())) { //패스워드 정규식
	                    	if($userPwd.val()===$userPwdRetype.val()) { //비밀번호와 비밀번호확인 일치여부
        			    		$.ajax({
        			    			url:'EditMemberInfoPwd',
        			    			type:'post',
        			    			data: {
        			    				"userId":$userId.val(),
        			    				"userPwd":$userPwd.val()
        			    			},
        			    			success: result => {
        			    				const member = result.data;
        			    				$userPwd.val('');
        			    				$userPwdRetype.val('');
        			    				alert('비밀번호 수정이 완료되었습니다.');
        			    			}
        			    		});
                    			//$pwdForm.submit();
	                    	} else {
	                    		alert('비밀번호와 비밀번호확인란이 일치하지 않습니다.');
	                    	}
	                	} else {
	                		alert('비밀번호는 영어 대문자, 영어 소문자, 숫자, 특수문자가 하나씩 포함된 문자열로 작성하여주세요.');
	                	}
	            	};
	            </script>
	        </div>
	     </form>
	     <form action="/member/EditMemberInfoEtc" method="post" id="etcForm">
	        <div class="row">
	            <h4>세부 정보</h4>
	            <div class="input-group input-group-icon"><input type="text" placeholder="이름" id="userName" name="userName" value="${loginUser.userName }" readonly />
	                <div class="input-icon"><i class="fa fa-user"></i></div>
	            </div>
	            <div class="input-group input-group-icon"><input type="email" placeholder="이메일" id="email" name="email" value="${loginUser.email }" />
	                <div class="input-icon"><i class="fa fa-envelope"></i></div>
	                <div id="emailCheckResult" style="display:none; font-size:1em; margin-top:10px; float:right;"></div><br>
	            </div>
                <script>
                	$(() => {
                		const $emailInput = $('#email');
                		const $checkEmailResult = $('#emailCheckResult');
                		const $info_submit = $('#info_submit');

                		$emailInput.keyup(() => { 
               				$.ajax({
               					url : '/member/emailCheck',
               					type : 'get',
               					data : {
               						checkEmail : $emailInput.val()
               					},
               					success : response => {
               						if (response.substr(4)==="N") { // jung bok
               							if ($emailInput.val() != '${sessionScope.loginUser.email}') {
	               							$checkEmailResult.show().css('color', 'crimson').text('이미 사용중인 이메일입니다.');
	               							$info_submit.attr('disabled', true);
               							} else {
               								$checkEmailResult.show().css('color', 'lightgreen').text('사용 가능한 이메일입니다.');
               								$info_submit.attr('disabled', false);
               							}
               						} else { //not jung bok
               							$checkEmailResult.show().css('color', 'lightgreen').text('사용 가능한 이메일입니다.');
               							$info_submit.attr('disabled', false);
               						}
               					},
               					error : () => {}
               				});
                		} );
                	})
                </script>
	            <div class="input-group">
		            <input id="payment-method-card" type="radio" name="gender" value="M" readonly/>
		            <label for="payment-method-card">
		            	<span><i class="fa fa-cc-visa"></i>남성</span>
		            </label>
		            <input id="payment-method-paypal" type="radio" name="gender" value="F" readonly/>
		            <label for="payment-method-paypal">
		            	<span><i class="fa fa-cc-paypal"></i>여성</span>
		            </label>
	            </div>
	            <div class="input-group input-group-icon">
	            	<input type="text" placeholder="주소" id="address" name="address" value="${loginUser.address }"/>
	                <div class="input-icon"><i class="fa fa-credit-card"></i></div>
	            </div>
	            <div class="col-half">
		            <div class="input-group input-group-icon">
		            	<input type="text" placeholder="상세주소" id="addressDetail" name="addressDetail" value="${loginUser.addressDetail }" />
		                <div class="input-icon"><i class="fa fa-credit-card"></i></div>
		            </div>
	            </div>
	            <div class="col-half">
		            <div class="input-group input-group-icon">
		            	<input type="text" placeholder="우편번호" id="postnum" name="postnum" value="${loginUser.postnum }" />
		                <div class="input-icon"><i class="fa fa-credit-card"></i></div>
		            </div>
	            </div>
	       	</div>
	       	<div class="row">
	            <div class="input-group input-group-icon"><input type="text" id="phone" placeholder="전화번호" name="phone" value="${loginUser.phone }" />
	                <div class="input-icon"><i class="fa fa-envelope"></i></div>
	            </div>
	        </div>
	        <div class="row">
	        	<input type="button" class="input-group" value="회원정보 수정" id="info_submit" onclick="info_submitfc()"/>
	        </div>
	        <script>
	        	window.onload = () => {
	        		$("input:radio[name='gender'][value=${loginUser.gender }]").prop('checked',true);
	        	};
	        	function info_submitfc() {
	           		const phone_pattern = /^(?:(010)|(01[1|6|7|8|9]))-\d{3,4}-(\d{4})$/;
	           		const email_pattern = /[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]$/i;
	           		const postnum_pattern = /^[a-z|A-Z|0-9]{5}$/;
	           		
	           		const $userId = $('#userId');
	            	const $email = $('#email');
	            	const $phone = $('#phone');
	            	const $address = $('#address');
	            	const $addressDetail = $('#addressDetail');
	            	const $postnum = $('#postnum');
	            	const $gender = $('input:radio[name="gender"]:checked');
	            	
	            	if(postnum_pattern.test($postnum.val())) { //우편번호 정규식
        		    	if($phone.val()=='' || phone_pattern.test($phone.val())) { //폰 정규식
        			    	if(email_pattern.test($email.val())) { //이메일 정규식
        			    		$.ajax({
        			    			url:'EditMemberInfoEtc',
        			    			type:'post',
        			    			data: {
        			    				"userId":$userId.val(),
        			    				"email":$email.val(),
        			    				"phone":$phone.val(),
        			    				"postnum":$postnum.val(),
        			    				"address":$address.val(),
        			    				"addressDetail":$addressDetail.val(),
        			    				"gender":$gender.val()
        			    			},
        			    			success: result => {
        			    				const member = result.data;
        			    				$email.val(member.email);
        			    				$phone.val(member.phone);
        			    				$postnum.val(member.postnum);
        			    				$address.val(member.address);
        			    				$addressDetail.val(member.addressDetail);
        			    				$gender.val(member.gender);
        			    				alert('세부 정보 수정이 완료되었습니다.');
        			    			}
        			    		});
        			    	} else {
        			    		alert('올바른 이메일 형식을 입력해주세요.');
        			    	}
        		    	} else {
        		    		alert('하이픈(-)을 포함하여 올바른 형식으로 휴대폰 번호를 작성해주세요.');
        		    	}
	            	} else {
	            		alert('우편번호는 숫자5자리로 이루어져 있어야 합니다.');
	            	}
	        		
	        	}
	        </script>
	    </form>
	</div>
</c:if>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>