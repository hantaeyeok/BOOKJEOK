<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form id="bookForm" action="book/saveBookDetail" method="post" enctype="multipart/form-data">
            	<input type="hidden" name="bookNo">
          		
                <div class="form-group">
                        <label for="detailImage1">상세설명 이미지 추가</label>
                        <input type="file" class="form-control" id="detailImage" name="detailImage" onchange="previewImage(this, 'imagePreview')">
                        <div class="image-preview" id="imagePreview">
                            <img src="" alt="상세 설명 이미지">
                            <span>이미지 없음</span>
                        </div>
                </div>
                
                <div class="form-group">
                    <label for="detailDescription">상세 설명</label>
                    <textarea class="form-control" id="detailDescription" name="detailDescription" rows="3" placeholder="해당 내용은 상세설명이미지 아래에 들어가는 텍스트입니다."></textarea>
                </div>
                <button type="submit" class="btn btn-primary">등록</button>
          </form>
</body>
</html>