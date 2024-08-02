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
<jsp:include page="../common/menubar.jsp"></jsp:include>
	<div style="width: 100%; height: 300px; background-color: #CCC;">
	</div>
	<div style="background-color:#FFF; display:block; height:1200px;">
		<div style="width: 20%; float:left; background-color:#FFF; display:block;">
			<jsp:include page="./mypage-sidebar.jsp"></jsp:include>
		</div>
		<div style="width: 80%; float:right; padding:20px; background-color:#FFF; display:block;">
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
			<tbody class="orderList">
				
				<!-- 줄 단위 블럭 시작 -->
				<c:forEach items="${orderList}" var="order" varStatus="status">
					<tr>
						<th scope="row">${order.orderNo}</th>
						<td>${order.paymentDate}</td>
						<td>
							<!-- 한 줄 당 여러 도서 항목 블럭 시작 -->
							<c:forEach items="${order.orderList}" var="orderPerbook">
								<div class="item_div" style="display:flex;">
									<img class="item_div_img" alt="" src="${orderPerbook.book.bookCover}" />
									<div class="item_div_title">
										${orderPerbook.book.bookTitle}
									</div>
									<div class="item_div_count">
										${orderPerbook.orderQuan}권
									</div>
								</div>
							<!-- 한 줄 당 여러 도서 항목 블럭 끝 -->
							</c:forEach>
							
						</td>
						<td>${order.paymentPrice}(${order.mileageGet })</td>
						<td>${order.deliveryStatus }</td>
						<c:choose>
							<c:when test="${order.paymentStatus eq '1'}">
								<td><button type="button" class="btn btn-primary">환불가능</button></td>
							</c:when>
							<c:otherwise>
								<td><button type="button" class="btn btn-secondary" disabled>환불불가</button></td>
							</c:otherwise>
						</c:choose>
					</tr>
					<!-- 줄 단위 블럭 끝 -->
				</c:forEach>
				
			</tbody>

		</table>
	</div>
	</div>
<script>
	$(document).on('click','.orderList > tr', e => {
		const $order = $(e.currentTarget).children().eq(0).text();
		console.log($order); // 출력 확인 완료\
		let text='';
		text += "?orderNo="+$order
		location.href="orderDetail"+text;
	});
</script>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>