<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독서 모임 모집 게시판</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #ffffff;
            border: 1px solid #ddd;
            padding: 20px;
            width: 600px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .header .badge {
            background-color: #00b894;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }
        .header .author {
            font-size: 14px;
            color: #777;
        }
        .image-container {
            width: 100%;
            height: 200px;
            background-color: #ddd;
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .image-container img {
            max-width: 100%;
            max-height: 100%;
        }
        .content div {
            margin-bottom: 10px;
        }
        .content label {
            font-weight: bold;
            display: inline-block;
            width: 100px;
        }
        .content .value {
            margin-left: 10px;
        }
        .textarea-container {
            background-color: #f9f9f9;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-top: 20px;
            font-size: 14px;
            color: #333;
            line-height: 1.5;
            height: 200px;
            overflow-y: scroll;
        }
        .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            color: white;
        }
        .buttons .edit {
            background-color: #4CAF50;
        }
        .buttons .delete {
            background-color: #f44336;
        }
        .buttons .list {
            background-color: #008CBA;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <span class="badge">모집중</span>
            <span class="author">작성자 : 홍길동</span>
        </div>
        <div class="image-container">
            <img src="path/to/your/image.png" alt="모임 이미지">
        </div>
        <div class="content">
            <div>
                <label>독서 모임 명:</label>
                <span class="value">이것은 독서모임</span>
            </div>
            <div>
                <label>모집 인원:</label>
                <span class="value">10명</span>
            </div>
            <div>
                <label>신청 인원:</label>
                <span class="value">5명</span>
            </div>
            <div>
                <label>모집 기간:</label>
                <span class="value">2024. 06. 19 ~ 2024. 07. 11</span>
            </div>
        </div>
        <div class="textarea-container">
            인간에 남는 것은 영락과 두패 뿐이다 낙원을 장식하는 천자만홍이 어디 있으며 인생을 풍부하게 하는 온갖 과실이 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상성 꽃이 피고 희망의 풀이 돋고 열락의 새가 온다사 말이 없으면 인간은 사막이다 음악이 있어도 찾는다 독수심 있는 때까지 반창하여도 보이는 것은 커다란 모래뿐일 것이다 이상의 꽃이 없으면 쓸쓸한 인간에 남는 것은 영락과 입을 속에서 불러 내는 것이 따뜻한 봄바람이라 인생에 따뜻한 봄바람을 불어 보내는 것은 청춘의 꿈나는 청춘의 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망...
        </div>
        <div class="buttons">
            <button class="edit">수정</button>
            <button class="delete">삭제하기</button>
            <button class="list">목록으로</button>
        </div>
    </div>
</body>
</html>