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

        table * { margin:5px; }
        table { width:100%; }
        table#replyArea th { width: 100px; }
        
        .status {
            float: right; 
            border-radius: 20px; 
            width: 100px; 
            height: 30px;
            border: 2px; 
            font-weight: bold; 
            color: white; 
            text-align: center; 
            line-height: 30px;
        }
        .processing {
            background-color: blue;
        }
        .completed {
            background-color: red;
        }
        
    </style>
</head>
<body>
        
    <jsp:include page="../common/menubar.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>1대1 문의 : 상세보기</h2>
            <br>
            <c:choose>
                <c:when test="${empty answer}">
                    <span class="status processing">처리중</span>
                </c:when>
                <c:otherwise>
                    <span class="status completed">처리완료</span>
                </c:otherwise>
            </c:choose>
            <br><br>

            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${question.questionTitle }</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${ question.userId }</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>${ question.questionDate }</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="4">
                    	<p style="white-space: pre-wrap;">
                    		${ question.questionContent }
                    	</p>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <c:if test="${empty question.questionOriginname }">
                    	<td colspan="3">업로드 된 파일이 존재하지 않습니다.</td>
                    </c:if>
                    <c:if test="${!empty question.questionOriginname }">
	                    <td colspan="3">
	                        <a href="${ question.questionChangename }" 
	                           download="${ question.questionOriginname }">
	                           ${ question.questionOriginname }</a>
	                    </td>
                    </c:if>
                </tr>
            </table>
            <br>
            <hr>
            <c:if test="${sessionScope.loginUser.userId != 'admin' }">
	            <div align="center">
	                <!-- 수정하기 버튼은 답변이 없을 때 활성화, 답변이 있는 경우 비활성화 -->
	                <c:if test="${empty answer}">
	                	<a class="btn btn-primary" href="updateForm.question?qnaNo=${question.qnaNo }">수정</a>
	                </c:if>
	                <a class="btn btn-danger" href="delete.qna?qnaNo=${question.qnaNo }">삭제</a>
	            </div>
            </c:if>
            <br><br><br>
            <hr>
            <c:if test="${sessionScope.loginUser.userId == 'admin' }">
	            <!--해당 버튼은 관리자만 보이도록 하며, 답변등록을 하지 않은 경우에만 보이도록 한다.-->
	            <c:if test="${empty answer}">
		            <a class="btn btn-primary" href="insertForm.answer?qnaNo=${question.qnaNo }" style="float: right;">답변등록</a>
		            <br><br>
	            </c:if>
	            <!--답변은 작성된 경우에만 보이도록 한다.-->
	            <c:if test="${!empty answer}">
		            <table id="answer" class="table" align="center">
		                <tr>
		                    <th>답변내용</th>
		                    <td colspan="2"><p style="height:150px;">${answer.answerContent }</p></td>
		                </tr>
		                <tr>
		                    <th>첨부파일</th>
		                    <c:if test="${empty answer.answerOriginname }">
		                    	<td colspan="3">업로드 된 파일이 존재하지 않습니다.</td>
		                    </c:if>
		                    <c:if test="${!empty answer.answerOriginname }">
			                    <td colspan="3">
			                        <a href="${ answer.answerChangename }" 
			                           download="${ answer.answerOriginname }">
			                           ${ answer.answerOriginname }</a>
			                    </td>
		                    </c:if>
		                </tr>
		            </table>
		            <br>
		            <hr>
		            <div align="center">
		                <a class="btn btn-primary" href="">답변수정</a>
		                <a class="btn btn-danger" href="delete.answer?answerNo=${answer.answerNo }">답변삭제</a>
		            </div>
		            <br><br>
	            </c:if>
	            <hr>
            </c:if>
            <div align="center">
                <a class="btn btn-secondary" href="list.qna" style="width: 100px;">목록</a>
            </div>
        </div>
        <br><br>

    </div>
    
    <!-- <jsp:include page="" /> -->
    
</body>
</html>