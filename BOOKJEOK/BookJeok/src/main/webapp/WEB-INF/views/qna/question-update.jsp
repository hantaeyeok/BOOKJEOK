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
        
        #deleteButton {
        	border-radius: 2px; 
        	border-width: 1px; 
        	border-color: gray;
            box-shadow: 0.5px 0.5px rgba(0.5px,0.5px,0.5px,0.5px);
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
            <h2>1대1 문의 : 문의 수정하기</h2>
            <br>

            <form id="enrollForm" method="post" action="update.question?qnaNo=${question.qnaNo}" enctype="multipart/form-data">
                <input type="hidden" value="${question.qnaNo }" id="qnaNo">
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
                            <button type="button"
                                    id="cancelButton" 
                                    class="btn btn-danger btn-sm" 
                                    onclick="clearFile()">파일 선택취소</button>
                        </td>
                    </tr>
                    <tr>
                    	<th></th>
                    	<td>
                    		<c:if test="${ not empty question.questionOriginname }">
                            	<a href="${ question.questionChangename }" 
                            	   download="${ question.questionOriginname }" id="file">
                            	   ${ question.questionOriginname }</a>
                            	<input type="hidden" name="questionChangename" 
                            	       value="${ question.questionChangename }" />
                				<input type="hidden" name="questionOriginname"
                					   id="fileName" 
                				       value="${ question.questionOriginname }" />
                				<a href="delete-file?qnaNo=${question.qnaNo}&filePath=${question.questionChangename}" 
                				class="btn btn-danger">파일 제거</a>
                            </c:if>
                    	</td>
                    </tr>
                    <tr>
                        <th></th>
                        <td><small style="color: red; font-weight: bold;">※ 첨부 파일은 ZIP파일만 업로드가 가능합니다.</small></td>
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
			
			        // 파일 선택 취소 버튼 클릭 시 호출되는 함수
			        function clearFile() {
			            upfile.value = ''; // 파일 선택 취소
			            cancelButton.style.display = 'none'; // 버튼 숨김
			        }
			    </script>
			    
			    <script>
			 		// (첨부되어 있는) 파일 삭제 버튼 클릭 시 호출되는 함수
			    	$('#deleteButton').click(() => {
			    		deleteFile();
			    	});
			 		
			 		function deleteFile() {
			 			file.style.display = 'none';
			 			deleteButton.style.display = 'none';
			 		}
			    </script>
			   
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