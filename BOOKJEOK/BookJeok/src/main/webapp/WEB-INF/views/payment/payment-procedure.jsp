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
            <tr class="order-detail" id="cartNo-${ cart.bookNo }"></tr>
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
            <td>${cart.bookName}</td>
            <td>${cart.bookPrice}</td>
            <td>${cart.bookAmount}</td>
            <td>${cart.mileage}</td>
            <td>${cart.total}</td>
            <td>${cart.departureDate}</td>
            </tr>
            <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
            </tr>
            <tr>
            <th scope="row">3</th>
            <td colspan="2">Larry the Bird</td>
            <td>@twitter</td>
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
                    <input class="form-control form-control-sm" type="text" name="address1" id="address1" placeholder="기본 주소 입력" value="${address[0] }" onclick="findAddr()" required>
                </td>
                    <br>
                <th>상세주소 입력 &nbsp;&nbsp;</th>
                &nbsp;&nbsp;<button type="button" id="post_btn" class="btn btn-secondary btn-sm" onclick="insertAddr()">주소록에 추가</button>
                <td>
                    <input class="form-control form-control-sm"type="text" name="address2" id="address2" placeholder="상세 주소 입력" value="${address[1] }" required>
                    <br>
                <th>전화번호 &nbsp;&nbsp;</th>
                    <input class="form-control form-control-sm"type="text" name="address2" id="address2" placeholder="상세 주소 입력" value="${address[1] }" required>
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






/* 주소검색*/
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
    
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>