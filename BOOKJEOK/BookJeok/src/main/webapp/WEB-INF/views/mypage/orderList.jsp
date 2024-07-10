<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
.item_div_img {
	width: 100px;
	margin-right: 20px;
}

.item_div {
	padding: 5px;
}
.item_div_title {
padding:0px 10px; width:100%; display:flex;align-items:center;
}
.item_div_count {
border-left: solid 1px #CCC; padding:0px 10px; display:flex; align-items:center; min-width:50px;
}

</style>
</head>
<body>
	<div style="width: 100%; height: 300px; background-color: #CCC;">

	</div>
	<div style="width: 80%; float:right; padding:20px;">
		<table class="table table-hover table-borderless">
			<thead>
				<tr>
					<th scope="col">주문번호</th>
					<th scope="col">접수일자</th>
					<th scope="col">책 정보(수량)</th>
					<th scope="col">결제금액(마일리지)</th>
					<th scope="col">상태</th>
					<th scope="col">환불여부</th>
				</tr>
			</thead>
			<tbody id="orderList">

				
				<!-- 줄 단위 블럭 시작 -->
				<tr>
					<th scope="row">BBBBBBBBBBBBB</th>
					<td>2024.07.01</td>
					<td>
						<!-- 한 줄 당 여러 도서 항목 블럭 시작 -->
						<div class="item_div" style="display:flex;">
							<img class="item_div_img" alt="" src="https://image.yes24.com/goods/90228321/XL" />
							<div class="item_div_title">
								제목제목제목제
							</div>
							<div class="item_div_count">
								2권
							</div>
						</div>
						<!-- 한 줄 당 여러 도서 항목 블럭 끝 -->
						
						
						<div class="item_div" style="display:flex;">
							<img class="item_div_img" alt="" src="https://image.yes24.com/goods/90228321/XL" />
							<div class="item_div_title">
								제목1111
							</div>
							<div class="item_div_count">
								1권
							</div>
						</div>
					</td>
					<td>30000(300)</td>
					<td>배송중</td>
					<td><button type="button" class="btn btn-secondary" onclick="alert('123');" disabled>환불불가</button></td>
				</tr>
				<!-- 줄 단위 블럭 끝 -->
				
				
			</tbody>
		</table>
	</div>
<script>
	$(document).on('click','#orderList > tr', e => {
		const $order = $(e.currentTarget).children().eq(0).text();
		console.log($order); // 출력 확인 완료\
		let text='';
		text += "?orderNo="+$order
		location.href="orderDetail"+text;
	});
	/*
	 각 항목 요소 클릭 시, 데이터를 가지고 구매내역-상세 / 구매내역-환불 페이지로 이동하도록 내용 구성 → 전송방식 : GET, QueryString
	 보안을 위해, 쿼리스트링에서 받아온 주문번호에 해당하는 DB-PAYMENT테이블의 ROW에서의 USER_ID(외래 키)가
	 컨트롤러단에서 session 객체의 userId와 동일한지 확인한다. 
	 */
</script>

</body>
</html>