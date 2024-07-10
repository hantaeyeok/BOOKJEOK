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
        
    <!-- <jsp:include page="" /> -->

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>1대1 문의 : 문의 수정하기</h2>
            <br>

            <form id="enrollForm" method="post" action="update.question" enctype="multipart/form-data">
                <table align="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" 
                        		   value="${question.questionTitle }" name="questionTitle" required></td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${question.userId }" name="userId" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" 
                        	 name="questionContent" required>${question.questionContent }</textarea></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td>
                            <input type="file" id="upfile" class="form-control-file border" name="reUpfile" accept=".zip">
                            <c:if test="${ not empty question.questionOriginname }">
                            	<a href="${ question.questionChangename }" download="${ question.questionOriginname }">${ question.questionOriginname }</a>
                            	<input type="hidden" name="questionChangename" value="${ question.questionChangename }" />
                				<input type="hidden" name="questionOriginname" value="${ question.questionOriginname }" />
                				<button style="border-radius: 2px; border-width: 1px; 
                            	border-color: gray; box-shadow: 0.5px 0.5px rgba(0.5px,0.5px,0.5px,0.5px);">파일 제거</button>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td><small style="color: red; font-weight: bold;">※ 첨부 파일은 ZIP파일만 업로드가 가능합니다.</small></td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">문의 수정하기</button>
                    <a class="btn btn-danger" href="detail.qna?qnaNo=${question.qnaNo}">취소하기</a>
                </div>
                
                <input type="hidden" name="qnaNo" value="${question.qnaNo }" />
            </form>
        </div>
        <br><br>

    </div>
    
    <!-- <jsp:include page="" /> -->
    
</body>
</html>