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
        #img-area > img {
            width : 80%;
        }
        
        #cancelButton {
        	display : none;
        }
        
    </style>
</head>
<body>
        
    <jsp:include page="../common/menubar.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>1대1 문의 : 답변하기</h2>
            <br>

            <form id="enrollForm" method="post" action="insert.answer" enctype="multipart/form-data">
                <input type="hidden" name="qnaNo" value="${param.qnaNo}">
                <table align="center">
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${sessionScope.loginUser.userId }" name="userId" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="answerContent" required></textarea></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부 파일</label></th>
                        <td>
                        	<input type="file" id="upfile" class="form-control-file border" name="upfile" accept=".zip">
                        	<button type="button" id="cancelButton" class="btn btn-danger btn-sm" onclick="clearFile()">파일 선택취소</button>
                        </td>
                    </tr>
                </table>
                
                <script>
			        const upfile = document.getElementById('upfile');
			        const cancelButton = document.getElementById('cancelButton');
			
			        // 파일 선택 이벤트 리스너
			        upfile.addEventListener('change', function() {
			            if (upfile.files.length > 0) {
			            	cancelButton.style.display = 'inline-block'; // 파일이 선택되면 삭제 버튼 표시
			            } else {
			            	cancelButton.style.display = 'none'; // 파일이 선택되지 않으면 삭제 버튼 숨김
			            }
			        });
			
			        // 파일 선택 취소 클릭 시 호출되는 함수
			        function clearFile() {
			            upfile.value = ''; // 파일 선택 취소
			            cancelButton.style.display = 'none'; // 버튼 숨김
			        }
			    </script>
			    
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">답변하기</button>
                    <a class="btn btn-danger" href="detail.qna?qnaNo=${param.qnaNo}">취소하기</a>
                </div>
            </form>
        </div>
        <br><br>

    </div>
    
    <!--<jsp:include page="" />-->
    
</body>
</html>