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

        table * {margin:5px;}
        table {width:100%;}
    </style>
</head>
<body>
        
    <jsp:include page="../common/menubar.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 상세보기</h2>
            <br>

            <a class="btn btn-secondary" style="float:right;" href="">목록으로</a>
            <br><br>

            <table id="contentArea" algin="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${notice.noticeTitle }</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${notice.userId }</td>
                    <th>작성일</th>
                    <td>${notice.noticeDate }</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <c:choose>
                    	<c:when test="${ empty notice.originName }">
                    		<td colspan="3">
                    			파일이 존재하지 않습니다.
		                    </td>
		                </c:when>
		                <c:otherwise>
		                    <td colspan="3">
		                        <a href="${ notice.changeName }"
		                        	download="${ notice.originName }">${ notice.originName }</a>
		                    </td>
		                </c:otherwise>
		             </c:choose>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4"><p style="height:150px;">${notice.noticeContent }</p></td>
                </tr>
            </table>
            <br>

            <div align="center">
	            <c:if test="${ sessionScope.loginUser.userId eq requestScope.notice.userId }">
	                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
                <a class="btn btn-primary" href="updateForm.noticenotice?noticeNo=${notice.noticeNo }">수정</a>
                <a class="btn btn-danger" href="noticeDelete?noticeNo=${notice.noticeNo }">삭제</a>
	            </c:if>
	            
	            <form method="post" action="" id="postForm">
	            	<input type="hidden" name="noticeNo" value="${ notice.noticeNo }" />
	            	<input type="hidden" name="filePath" value="${ notice.changeName }" />
	            </form>
	            
	            <script>
	            	function postSubmit(el) {	       
	            		const attrValue = '수정하기' === el ? 'noticeUpdateForm.do' : 'noticeDelete.do';            		
	            		$('#postForm').attr('action', attrValue).submit();
	            	}
	            </script>
            </div>
            <br><br>

 
        </div>
        <br><br>

    </div>
 
</body>
</html>