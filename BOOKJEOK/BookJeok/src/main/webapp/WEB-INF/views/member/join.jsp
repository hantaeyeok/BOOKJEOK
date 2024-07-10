<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>B강의장 프로젝트 입니다</title>
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
  padding: 1em;
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
  background-color: #fff;
  border-radius: 4.2px;
  box-shadow: 0px 3px 10px -2px rgba(0, 0, 0, 0.2);
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

<div class="container">
    <form action="/member/join" method="post" id="join_form">
        <div class="row">
            <h4>회원 정보</h4>
            <div class="input-group input-group-icon"><input type="text" placeholder="아이디" id="userId" name="userId" />
                <div class="input-icon"><i class="fa fa-user">123</i></div>
                <div id="checkResult" style="display:none; font-size:1em; margin-top:10px; float:right;"></div><br>
                <script>
                	$(() => {
                		const $idInput = $('#userId');
                		const $checkResult = $('#checkResult');
                		const $joinSubmit = $('#btn_submit');
						
                		$idInput.keyup(() => { 
                			if($idInput.val().length >= 5) {
                				$.ajax({
                					url : '/member/idCheck',
                					type : 'get',
                					data : {
                						checkId : $idInput.val()
                					},
                					success : response => {
                						console.log(response);
                						if (response.substr(4)==="N") { // jung bok
                							$checkResult.show().css('color', 'crimson').text('이미 존재하는 아이디입니다.');
                							$joinSubmit.attr('disabled', true);
                						} else { //not jung bok
                							$checkResult.show().css('color', 'lightgreen').text('사용 가능한 아이디입니다.');
                							$joinSubmit.attr('disabled', false);
                						}
                					},
                					error : () => {}
                				});
                			} else {
                				$checkResult.show().css('color', 'crimson').text('아이디는 5글자 이상이어야 합니다.');
                				$joinSubmit.attr('disabled', true);
                			}
                		} );
                	})
                </script>
            </div>
            
            <div class="input-group input-group-icon">
            	<input type="password" placeholder="비밀번호" id="userPwd" name="userPwd" required/>
                <div class="input-icon"><i class="fa fa-key"></i></div>
                <div style="font-size:0.7em; margin-top:10px; float:right; color:gray;">비밀번호는 영어 대문자, 영어 소문자, 숫자, 특수문자가 하나씩 포함된 문자열로 작성하여주세요</div><br>
            </div>
            <div class="input-group input-group-icon"><input type="password" placeholder="비밀번호 재확인" id="userPwdRetype" required/>
                <div class="input-icon"><i class="fa fa-key"></i></div>
            </div>
            <div class="input-group input-group-icon"><input type="text" placeholder="이름" id="userName" name="userName" required/>
                <div class="input-icon"><i class="fa fa-user"></i></div>
            </div>
            <div class="input-group input-group-icon"><input type="email" placeholder="이메일" id="email" name="email" required/>
                <div class="input-icon"><i class="fa fa-envelope"></i></div>
                <div id="emailCheckResult" style="display:none; font-size:1em; margin-top:10px; float:right;"></div><br>
            </div>
                <script>
                	$(() => {
                		const $emailInput = $('#email');
                		const $checkEmailResult = $('#emailCheckResult');
                		const $joinSubmit = $('#btn_submit');

                		$emailInput.keyup(() => { 
               				$.ajax({
               					url : '/member/emailCheck',
               					type : 'get',
               					data : {
               						checkEmail : $emailInput.val()
               					},
               					success : response => {
               						console.log(response);
               						if (response.substr(4)==="N") { // jung bok
               							$checkEmailResult.show().css('color', 'crimson').text('이미 사용중인 이메일입니다.');
               							$joinSubmit.attr('disabled', true);
               						} else { //not jung bok
               							$checkEmailResult.show().css('color', 'lightgreen').text('사용 가능한 이메일입니다.');
               							$joinSubmit.attr('disabled', false);
               						}
               					},
               					error : () => {}
               				});
                		} );
                	})
                </script>
        </div>
        <div class="row" style="display:none;">
            <div class="col-half">
                <h4>Date of Birth</h4>
                <div class="input-group">
                    <div class="col-third"><input type="text" placeholder="DD" /></div>
                    <div class="col-third"><input type="text" placeholder="MM" /></div>
                    <div class="col-third"><input type="text" placeholder="YYYY" /></div>
                </div>
            </div>
        </div>
        <div class="row">
            <h4>선택 기입 정보</h4>
            <div class="input-group">
	            <input id="payment-method-card" type="radio" name="gender" value="M" checked />
	            <label for="payment-method-card">
	            	<span><i class="fa fa-cc-visa"></i>남성</span>
	            </label>
	            <input id="payment-method-paypal" type="radio" name="gender" value="F" />
	            <label for="payment-method-paypal">
	            	<span><i class="fa fa-cc-paypal"></i>여성</span>
	            </label>
            </div>
            <div class="input-group input-group-icon">
            	<input type="text" placeholder="주소" id="address" name="address"/>
                <div class="input-icon"><i class="fa fa-credit-card"></i></div>
            </div>
            <div class="col-half">
	            <div class="input-group input-group-icon">
	            	<input type="text" placeholder="상세주소" id="addressDetail" name="addressDetail" />
	                <div class="input-icon"><i class="fa fa-credit-card"></i></div>
	            </div>
            </div>
            <div class="col-half">
	            <div class="input-group input-group-icon">
	            	<input type="text" placeholder="우편번호" id="postnum" name="postnum" />
	                <div class="input-icon"><i class="fa fa-credit-card"></i></div>
	            </div>
            </div>
       	</div>
       	<div class="row">
            <div class="input-group input-group-icon"><input type="text" id="phone" placeholder="전화번호" name="phone" />
                <div class="input-icon"><i class="fa fa-envelope"></i></div>
            </div>
        </div>
        <div class="row">
            <h4>약관 동의</h4>
            <div class="input-group"><input id="terms" type="checkbox" /><label data-toggle="modal" data-target=".bd-example-modal-lg">개인정보 이용 약관에 동의합니다.</label></div>
        </div>
        <div class="row">
        	<input type="button" class="input-group" value="회원가입" id="btn_submit" onclick="fc_submit()"/>
        </div>
    </form>
    
    <script>
    function fc_submit() {
    	const pw_pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
    	const id_pattern = /^[a-z|A-Z|0-9]{4,}$/;
   		const phone_pattern = /^(?:(010)|(01[1|6|7|8|9]))-\d{3,4}-(\d{4})$/;
   		const email_pattern = /[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]$/i;
   		const postnum_pattern = /^[a-z|A-Z|0-9]{5}$/;
   		
   		const $userId = $('#userId');
    	const $userPwd = $('#userPwd');
    	const $userPwdRetype = $('#userPwdRetype');
    	const $email = $('#email');
    	const $phone = $('#phone');
    	const $terms = $('#terms');
    	const $postnum = $('#postnum');
    	const $join_form = $('#join_form');
    	
    	if(postnum_pattern.test($postnum.val())) { //우편번호 정규식
			if(id_pattern.test($userId.val())) { //아이디 정규식
		    	if($phone.val()=='' || phone_pattern.test($phone.val())) { //폰 정규식
			    	if(email_pattern.test($email.val())) { //이메일 정규식
				    	if(pw_pattern.test($userPwd.val())) { //패스워드 정규식
				        	if($userPwd.val()===$userPwdRetype.val()) { //비밀번호와 비밀번호확인 일치여부
				        		if($terms.is(':checked')) { //개인정보 동의 약관 체크여부
				        			$join_form.submit();
				        		} else {
				        			alert('개인정보 이용 약관에 동의하여주세요.');
				        		}
				        	} else {
				        		alert('비밀번호와 비밀번호확인란이 일치하지 않습니다.');
				        	}
				    	} else {
				    		alert('비밀번호는 영어 대문자, 영어 소문자, 숫자, 특수문자가 하나씩 포함된 문자열로 작성하여주세요.');
				    	}
			    	} else {
			    		alert('올바른 이메일 형식을 입력해주세요.');
			    	}
		    	} else {
		    		alert('하이픈(-)을 포함하여 올바른 형식으로 휴대폰 번호를 작성해주세요.');
		    	}
		   	} else {
		   		alert('id에는 영문자와 숫자만, 최소 4자리 이상 들어가야 사용할 수 있습니다.');
		   	}
    	} else {
    		alert('우편번호는 숫자5자리로 이루어져 있어야 합니다.');
    	}
    };
    </script>
    
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		  <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body" style="white-space:pre-line">
개인정보의 수집항목, 처리목적, 보유 및 이용기간
알라딘이 처리하는 개인정보의 항목, 목적, 보유 및 이용기간은 다음과 같습니다. 선택항목은 입력하지 않더라도 회원가입이나 서비스 이용에 제한은 없습니다.

수집방법	대상	수집항목	처리목적	보유 및 이용기간
통합
회원가입	개인
(만 14세 이상)	[필수]
이름, 아이디, 이메일, 비밀번호, 휴대폰번호	본인확인, 회원관리, 서비스 이용에 따른 정보 제공 및 상담	회원 탈퇴 시까지
(단, 관계 법령에 따름)
개인
(만 14세 미만)	[필수]
이름, 아이디, 이메일, 비밀번호, 휴대폰번호, 생년월일, 법정대리인 정보(통신사, 이름, 생년월일, 성별, 휴대폰번호), 가입자와의 관계
법인/단체
(학교, 기업, 기관)	[필수]
법인/단체명, 법인/단체 유형(기업, 학교, 기타), 담당자명, 아이디, 이메일, 비밀번호, 휴대폰번호
[선택]
도서관 사서, 사업자 등록번호
해외 거주자	[필수]
이름, 아이디, 이메일, 비밀번호, 휴대폰번호
SNS 회원가입
(구글, 애플, 카카오, 트위터)	[필수]
이름, 이메일, 암호화된 동일인 식별정보(CI)	SNS 회원가입을 위한 본인확인
SNS 회원가입
(네이버, 삼성 패스)	[필수]
성명, 이메일, 휴대폰번호, 생년월일, 성별, 암호화된 동일인 식별 정보(CI)
자동수집	회원, 비회원	[필수]
IP주소	전자책 부정 이용 방지	회원 탈퇴 시까지
(단, 관계 법령에 따름)
[필수]
IP주소, 쿠키, 방문 일시, OS 종류, 브라우저 종류, 단말기 모델, 단말기 OS 종류, PC 및 모바일 여부, 검색키워드	이용자의 관심, 성향에 기반한 개인 맞춤형 추천서비스를 제공	동의 철회 시, 회원 탈퇴 시까지
(단, 관계 법령에 따름)

개인정보의 수집항목, 처리목적, 보유 및 이용기간(선택)
알라딘이 처리하는 개인정보의 항목, 목적, 보유 및 이용기간은 다음과 같습니다. 선택항목은 입력하지 않더라도 회원가입이나 서비스 이용에 제한은 없습니다.

수집방법	대상	수집항목	처리목적	보유 및 이용기간
뉴스레터 구독,마케팅	회원,비회원	[선택]
이메일,휴대전화번호	신간, 이벤트 안내, 맞춤 서비스 제공	구독 취소시까지
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="terms_reject();">미동의</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="terms_agree();">동의</button>
	      </div>
	      <script>
	      	const $terms=$('#terms');
	      	function terms_reject() {
	      		$terms.prop('checked', false);
	      	};
	      	function terms_agree() {
	      		$terms.prop('checked', true);
	      	};
	      </script>
	    </div>
	  </div>
	</div>
</div>

</body>
</html>