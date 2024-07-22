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
		
		    <h1 class="thanks-greeting">${sessionScope.loginUser.userId} 님 저희 서점을 이용해주셔서 감사드립니다.</h1>
		    <h3 class="thanks-greeting">주문번호${payment.paymentNo} 의 결제가 완료되었습니다.</h3>
		    <br>		    <br>
		    <hr>
</body>
</html> 
    