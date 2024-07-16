<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>장바구니 리스트</title>
</head>
<body>

<jsp:include page="../common/menubar.jsp" />

    <div class="container">
        <h2>장바구니</h2>
        <div class="row">
            <div class="col-md-8">
                <table class="table table-hover">
                    <input type="checkbox" id="selectAll" onclick="checkboxALL();"> 모두 선택</input>
                    <thead>
                        <tr>
                            <th>체크박스</th>
                            <th>책표지</th>
                            <th>책제목</th>
                            <th>가격</th>
                            <th>수량</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody id="cartItemsContainer">
                        <!-- 장바구니 항목들이 여기에 추가됩니다. -->
                    </tbody>
                </table>
            </div>
            <div class="col-md-4">
                <div class="border p-3">
                    <p>상품 금액: <span id="totalPrice">0</span>원</p>
                    <p>결제 예정 금액: <span id="finalPrice">0</span>원</p>
                    <p>마일리지 적립: <span id="mileage">0</span>원</p>
                    <hr>
                    <div class="text-center">
                        <button class="btn btn-primary" onclick="purchaseItems()">주문하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            loadCartItems();
        });

        function loadCartItems() {
            $.ajax({
                url: 'list',
                type: 'GET',
                success: function(response) {
                    const cartItems = response.data;
                    $('#cartItemsContainer').empty();
                    if (cartItems.length === 0) {
                        $('#cartItemsContainer').append('<tr><td colspan="6">장바구니에 상품이 없습니다.</td></tr>');
                    } else {
                        var totalPrice = 0;
                        cartItems.forEach(function(cart) {
                            var itemHtml = '<tr data-book-no="' + cart.bookNo + '">' +
                                '<td><input type="checkbox" class="itemCheckbox"></td>' +
                                '<td><img src="' + cart.bookCover + '" alt="' + cart.bookTitle + '" style="width: 50px; height: 50px;"></td>' +
                                '<td>' + cart.bookTitle + '</td>' +
                                '<td>' + cart.bookPrice + '</td>' +
                                '<td>' +
                                    '<button class="btn btn-outline-primary btn-sm" onclick="changeQuantity(' + cart.bookNo + ', -1)">-</button>' +
                                    '<span id="quantity-' + cart.bookNo + '">' + cart.cartAmount + '</span>' +
                                    '<button class="btn btn-outline-primary btn-sm" onclick="changeQuantity(' + cart.bookNo + ', 1)">+</button>' +
                                '</td>' +
                                '<td><button class="btn btn-outline-danger btn-sm" onclick="deleteFromCart(' + cart.bookNo + ')">삭제</button></td>' +
                                '</tr>';
                            $('#cartItemsContainer').append(itemHtml);
                            totalPrice += cart.bookPrice * cart.cartAmount;
                        });
                        $('#totalPrice').text(totalPrice);
                        $('#finalPrice').text(totalPrice); 
                        $('#mileage').text(totalPrice * 0.1); // 마일리지 적립 예: 10%
                    }
                },
                error: function() {
                    alert('장바구니를 불러오는 중 오류가 발생했습니다.');
                }
            });
        }

        function changeQuantity(bookNo, change) {
            var quantity = parseInt($('#quantity-' + bookNo).text()) + change;
            if (quantity < 1) quantity = 1;
            $('#quantity-' + bookNo).text(quantity);
            // 서버에 수량 변경 요청
            $.ajax({
                url: 'updateQuantity',
                type: 'POST',
                data: { bookNo: bookNo,
                        quantity: quantity },
                success: function() {
                    loadCartItems();
                },
                error: function() {
                    alert('수량 변경 중 오류가 발생했습니다.');
                }
            });
        }

        function deleteFromCart(bookNo) {
            if (confirm('정말로 이 항목을 삭제하시겠습니까?')) {
                $.ajax({
                    url: 'delete',
                    type: 'POST',
                    data: { bookNo: bookNo },
                    success: function(response) {
                        if (response.message === '장바구니에서 삭제되었습니다.') {
                            alert('장바구니에서 삭제되었습니다.');
                            loadCartItems();
                        } else {
                            alert('장바구니 삭제 실패');
                        }
                    },
                    error: function() {
                        alert('장바구니 삭제 중 오류가 발생했습니다.');
                    }
                });
            }
        }

        function checkboxALL() {
            $('.itemCheckbox').prop('checked', $('#selectAll').prop('checked'));
        }
    </script>
</body>
</html>
