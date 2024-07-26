<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
    <!--  iamport JavaScript SDK -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!--  주소찾기 -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>

    * { margin: 0; padding: 0; }
    
    a { text-decoration: none; color: #333; }
    ul { list-style: none; }
    body, html { width: 100%; overflow-x: hidden; }


    .thanks-greeting {
    text-align:center ;    
    }

    /*주문페이지 전체 div*/
    .order-page {
        
    width:80%;
    margin:auto;
    padding:5% 10%;
    background-color:white;
    }

    .order-title { font-weight: 800; font-size: 20px;}
    </style>

</head>
<body>
<div class="order-page"> 


        <br><br><br>
        <div class="order-title">
        <p>주 문 상 품</p>
        </div>
        <hr>
        <table class="table table-borderless">
        <thead>
            <tr class="order-detail" id="cartNo-${ cart.cartNo }">
	            <th scope="col">구분</th>
	            <th scope="col">이미지</th>            
	            <th scope="col">상품명</th>
	            <th scope="col">정가</th>
	            <th scope="col">수량</th>
	            <th scope="col">마일리지</th>
	            <th scope="col">합계</th>
	            <th scope="col">배송일</th>
            </tr>
        </thead>
        <tbody>
            <tr>
            <th scope="row">${cart.bookNo}</th>
	            <td><img src="${book.bookImg}" width=50 height=50></td>
	            <td>${cart.bookTitle}</td>
	            <td>${book.bookPrice}</td>
	            <td>${cart.cartAmount}</td>
	            <td>${memeber.mileage}</td>
	            <td>${cart.cartTotal}</td>
	            <td>${cart.departureDate}</td>
            </tr>  
        </tbody>
        </table>
        <hr>


        <br><br><br>
        <div class="order-title">
            <p>배 송 주 소</p>
        </div>
        <hr>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" checked>
                <label class="form-check-label" for="inlineRadio1">주소록</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                <label class="form-check-label" for="inlineRadio2">새로 추가</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3" >
                <label class="form-check-label" for="inlineRadio3">회원정보동일</label>
            </div>
  
          <br><br>
          <tr>
                <th>이름&nbsp;&nbsp;</th>
                <td><input class="form-control-sm" type="text" placeholder=".form-control-sm" aria-label=".form-control-sm example"></td>
          </tr>
          <br><br>
          <tr>
                <th><label for="addr">주소&nbsp;&nbsp;</label></th>
                <td>
                    <input class="form-control-sm" type="text" name="postcode" id="postcode" placeholder="우편번호 입력" value="${member.postcode }" onclick="findAddr()" style="width:160px" required>
                        &nbsp;&nbsp;&nbsp;<button type="button" id="post_btn" class="btn btn-secondary btn-sm" onclick="findAddr()">우편번호 검색</button>
                </td>
                    <br> <br>
                <th>기본주소 입력 &nbsp;&nbsp;</th>
                <td>
                    <input class="form-control form-control-sm" type="text" name="address1" id="address1" placeholder="기본 주소 입력" value="${ member.address[0] }" onclick="findAddr()" required>
                </td>
                    <br>
                <th>상세주소 입력 &nbsp;&nbsp;</th>
                &nbsp;&nbsp;<button type="button" id="post_btn" class="btn btn-secondary btn-sm" onclick="insertAddr()">주소록에 추가</button>
                <td>
                    <input class="form-control form-control-sm"type="text" name="address2" id="address2" placeholder="상세 주소 입력" value="${member.address[1] }" required>
                    <br>
                <th>전화번호 &nbsp;&nbsp;</th>
                    <input class="form-control form-control-sm"type="text" name="phone" id="phone" placeholder="전화번호 입력" value="${ member.phone }" required>
                </td>
          </tr>
        <br>
        <hr>

        <br><br><br>
        <div class="order-title">
            <p>결 제 정 보</p>
        </div>
        <hr>
        <tr>
            <th>총 상품금액&nbsp;&nbsp;</th>
            <td>${payment.totalPrice}</td>
        </tr>
        <br><br>
        <tr>
            <th>마일리지 사용금액&nbsp;&nbsp;</th>
            <td>${payment.mileageUsed}</td>
        </tr>
        <br><br>
        <tr>
            <th>총 결제금액&nbsp;&nbsp;</th>
            <td>${payment.totalPaymentPrice}</td>
        </tr>
        <br><br>
        <tr>
            <th>마일리지 적립금액&nbsp;&nbsp;</th>
            <td>${payment.mileageGet}</td>
        </tr>
        <br><br>
        <hr>


        <br><br><br>
        <div class="order-title">
            <p>결 제 방 법</p>
        </div>
        <hr>
        <div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio4" value="option1" checked>
                <label class="form-check-label" for="inlineRadio4">신용카드</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio5" value="option2">
                <label class="form-check-label" for="inlineRadio5">계좌이체</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio6" value="option3" >
                <label class="form-check-label" for="inlineRadio6">카카오페이</label>
            </div>
        </div>
        <br><br>

        <tr>
            <th>카드회사&nbsp;&nbsp;</th>
            <td>
                <select class="form-select form-select-sm" aria-label="Small select example">
                <option selected>카드결제할 회사를 선택하세요</option>
                <option value="1">신한</option>
                <option value="2">삼성</option>
                <option value="3">현대</option>
                </select>
            </td>
        </tr>
        <br><br>
        <tr>
            <th>은행계좌&nbsp;&nbsp;</th>
            <td>
                <select class="form-select form-select-sm" aria-label="Small select example">
                <option selected>계좌이체할 은행을 선택하세요</option>
                <option value="1">신한</option>
                <option value="2">기업</option>
                <option value="3">농협</option>
                </select>
            </td>
            <br><br>
            <th>계좌번호 &nbsp;&nbsp;</th>
            <td>
                <input class="form-control-sm" type="text" placeholder="계좌변호를 입력하세요" aria-label=".form-control-sm example">
            </td>

        </tr>
        <br> 
        <hr>
        <br><br>
        <button type="button" class="btn btn-primary btn-lg">결제하기</button>
</div>

	<!--yes24 DB 주소록불러오기 자바스크립트-->
	<script>
	        function getHeightestElement() {
	            const isScrollable = function (node) {
	                let overflowY = window.getComputedStyle(node)['overflow-y'];
	                return (overflowY === 'scroll' || overflowY === 'auto') && node.scrollHeight > node.clientHeight && node.clientHeight !== 0 && node.scrollTop == 0
	            }
	        
	            const isBodyScrollable = function (node) {
	                return document.body.scrollHeight > window.innerHeight
	            }
	        
	            let allElems = document.body.getElementsByTagName("*")
	            let body = document.getElementsByTagName("body")[0]
	        
	            let heightestElem = isBodyScrollable(body) ? body : null
	        
	        
	            for (let i = 0; i < allElems.length; i++) {
	                let elem = allElems[i]
	        
	                if (elem.scrollHeight >= elem.clientHeight && isScrollable(elem) && (elem.scrollHeight - elem.clientHeight) > 50) {
	                    if (!heightestElem) {
	                        heightestElem = elem
	                        continue
	                    }
	        
	                    if (elem.scrollHeight >= heightestElem.scrollHeight) { //&& elem.clientWidth > heightestElem.clientWidth
	                        heightestElem = elem
	                    }
	                }
	            }
	        }
	
	</script>
	
		<!--결제 창 불러오기-->
 
	<script>
			IMP.request_pay({
		    pg : 'payco',
		    pay_method : 'card',
		    merchant_uid: "${orderNo}", // 상점에서 관리하는 주문 번호
		    name : '주문명:결제테스트',
		    amount : 14000,
		    buyer_email : '${member.email}',
		    buyer_name : '&{member.userName}',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456'
				}, function(rsp) {
				    if ( rsp.success ) {
				    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
				    	jQuery.ajax({
				    		url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
				    		type: 'POST',
				    		dataType: 'json',
				    		data: {
					    		imp_uid : rsp.imp_uid
					    		//기타 필요한 데이터가 있으면 추가 전달
				    		}
				    	}).done(function(data) {
				    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
				    		if ( everythings_fine ) {
				    			var msg = '결제가 완료되었습니다.';
				    			msg += '\n고유ID : ' + rsp.imp_uid;
				    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
				    			msg += '\결제 금액 : ' + rsp.paid_amount;
				    			msg += '카드 승인번호 : ' + rsp.apply_num;
				    			
				    			alert(msg);
				    		} else {
				    			//[3] 아직 제대로 결제가 되지 않았습니다.
				    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
				    		}
				    	});
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        msg += '에러내용 : ' + rsp.error_msg;
				        
				        alert(msg);
				    }
				});
			
	</script>
	
	<!--주소 검색-->
	<script>
	    function findAddr(){
	        new daum.Postcode({
	            oncomplete:function(data){
	                console.log(data);
	                var roadAddr = data.roadAddress;
	                var jibunAddr = data.jibunAddress;
	                document.getElementById("postcode").value = data.zonecode;
	                if(roadAddr !== ''){
	                    document.getElementById("address1").value = roadAddr;
	                } else if(jibunAddr !== ''){
	                    document.getElementById("address1").value = jibunAddr;
	                }
	                document.getElementById("address2").focus();
	            }
	        }).open();
	    }
	
	</script>

</body>
</html>