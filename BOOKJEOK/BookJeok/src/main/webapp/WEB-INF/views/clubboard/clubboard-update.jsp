<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .content {
            background-color:rgb(247, 245, 245); 
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        #enrollForm>table {width:100%;}
        #enrollForm>table * {margin:5px;}
        #img-area{
            width : 100%;
            margin : auto;
            text-align: center;
        }
        #img-area > img{
            width : 80%;
        }
    </style>
</head>
<body>
        
    <jsp:include page="../common/menubar.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>독서모임 모집 게시글 수정</h2>
            <br>

            <form id="enrollForm" method="post" action="update.clubboard?clubboardNo=${clubboard.clubboardNo }" enctype="multipart/form-data">
                <table align="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td>
                        	<input type="text" id="title" class="form-control" name="clubboardTitle" value="${clubboard.clubboardTitle }" required>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${clubboard.userId }" name="userId" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="clubname">독서 모임 명</label></th>
                        <td><input type="text" id="clubname" class="form-control" name="bookclubName" value="${clubboard.bookclubName }" required></td>
                    </tr>
                    <tr>
                        <th><label for="clubnum">모집 인원</label></th>
                        <td>
                        	<input type="number" id="clubnum" class="form-control" name="clubNumber" value="${clubboard.clubNumber }" required>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td>
                        	<textarea id="content" class="form-control" rows="10" style="resize:none;" name="clubboardContent" required>
                        		${clubboard.clubboardContent }
                        	</textarea>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="period">모집 기간</label></th>
                        <td>
                        	<input type="date" id="period" class="form-control" name="clubPeriod" value="${clubboard.clubPeriod }" required>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="upfile">이미지 파일</label></th>
                        <td>
                            <input type="file" id="upfile" class="form-control-file border" name="upFile" accept="image/*">
                            현재 업로드된 파일 : 
                            <a href="" download=""></a>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2">
                            <div id="img-area">
                                <img src="https://st.kakaocdn.net/shoppingstore/store/20240528180123_b9a6145839c346e3a34304f14163d941.png" alt="">
                            </div>
                        </th>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <a class="btn btn-danger" href="detail.clubboard?clubboardNo=${clubboard.clubboardNo }">취소하기</a>
                </div>
            </form>
        </div>
        <br><br>

    </div>
    
    <!--<jsp:include page="" />-->
    
</body>
</html>