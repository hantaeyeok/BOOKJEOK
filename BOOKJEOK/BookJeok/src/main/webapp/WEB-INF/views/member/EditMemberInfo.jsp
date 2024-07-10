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
    <form action="/member/join" method="post">
        <div class="row">
            <h4>회원 정보</h4>
            <div class="input-group input-group-icon"><input type="text" placeholder="아이디" id="userId" name="userId" />
                <div class="input-icon"><i class="fa fa-user">123</i></div>
                <div id="checkResult" style="display:none; font-size:1em; margin-top:10px; float:right;"></div><br>
                <script>
                	$(() => {
                		const $idInput = $('#userId');
                		const $checkResult = $('#checkResult');
                		const $joinSubmit = $('#join-btn');
                		$idInput.keyup(() => { 
                			console.log($idInput.val());
                		});
                		
                		/*
                		$idInput.keyup(() => { 
                			//console.log($idInput.val().length);
                			if($idInput.val().length >= 5) {
                				$.ajax({
                					url : 'idCheck.do',
                					type : 'get',
                					data : {
                						checkId : $idInput.val()
                					},
                					success : response => {
                						console.log(response);
                						if (response.substr(4)==="N") { // jung bok
                							$checkResult.show().css('color', 'crimson').text('id check failed');
                							$joinSubmit.attr('disabled', true);
                						} else { //not jung bok
                							$checkResult.show().css('color', 'lightgreen').text('id check success');
                							$joinSubmit.attr('disabled', false);
                						}
                						
                					},
                					error : () => {}
                				});
                			} else {
                				$checkResult.hide();
                				$joinSubmit.attr('disabled', true);
                			}
                		} ); */
                	})
                </script>
            </div>
            <div class="input-group input-group-icon"><input type="password" placeholder="비밀번호" id="userPwd" name="userPwd" />
                <div class="input-icon"><i class="fa fa-key"></i></div>
            </div>
            <div class="input-group input-group-icon"><input type="password" placeholder="비밀번호 재확인" id="userPwdRetype" />
                <div class="input-icon"><i class="fa fa-key"></i></div>
            </div>
            <div class="input-group" style="display:flex; justify-content:flex-end;">
            	<button class="btn btn-primary">비밀번호 변경</button>
            </div>
            <br>

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
            <h4>세부 정보</h4>

            <div class="input-group input-group-icon"><input type="text" placeholder="이름" id="userName" name="userName" />
                <div class="input-icon"><i class="fa fa-user"></i></div>
            </div>
            <div class="input-group input-group-icon"><input type="email" placeholder="이메일" id="email" name="email" />
                <div class="input-icon"><i class="fa fa-envelope"></i></div>
            </div>
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
        	<input type="submit" class="input-group" value="회원정보 수정" id="btn_submit"/>
        </div>
    </form>
    
    <!-- modal 띄우는 속성 : data-toggle="modal" data-target=".bd-example-modal-lg" -->
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
	      
	      내용내용
	      
	      
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