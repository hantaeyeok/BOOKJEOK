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
            <h2>게시글 작성하기</h2>
            <br>

            <form id="enrollForm" method="post" action="insertForm.do" enctype="multipart/form-data">
                <table algin="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="boardTitle" required></td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${sessionScope.loginUser.userId }" name="boardWriter" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile" onchange="loadImg(this);"></td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="boardContent" required></textarea></td>
                    </tr>
                    <tr>
                        <th colspan="2">
                            <div id="img-area">
                                <img id="kakao" src="https://t1.kakaocdn.net/friends/www/talk/kakaofriends_talk_2018.png" alt="카카오친구들">
                            </div>
                        </th>
                    </tr>
                </table>
                <br>
                <script>
                	//이미지 불러오기 함수
                	//onchange : 무언가 변화가 일어날 때 수행됨
                	function loadImg(inputFile) {
                		
                		// inputFile : 현재 change가 일어난 <input type="file"> 요소 객체
                		// console.log(inputFile);
                		
                		// [] : 배열 / {} : 객체	// 둘 다 객체긴 한데 쉽게 생각해서 그렇다는 말
                		
                		//console.log(inputFile.files);	// object 객체
                		
                		// files 속성 : 업로드된 파일의 정보가 들어있음
                		
                		// inputFile.files.length : 1 == 파일이 첨부, 0 선택취소
                		// => 파일의 존재 유무를 알 수 있음
                		// 파일 첨부시 inputFile.files[0]에 선택된 파일의 정보가 있음!!!!!!!!!!!!!!!!!
                		
                		if(inputFile.files.length) {	//파일이 첨부되었다면
                			
                			// 선택된 파일을 읽어서 영역에 미리보기(화면에 띄워줌)
                			// 파일을 읽어들일 FileReader 객체 생성
                			const reader = new FileReader();
                		
                			// reader객체를 가지고 파일을 읽어들이는 메소드를 호출
                			reader.readAsDataURL(inputFile.files[0]);
                			
                			// 해당 파일을 read하는 순간 파일만의 고유한 거어어어업나 긴 url이 만들어짐
                			// url을 src속성의 값으로 부여할 것
                			
                			// 파일 읽기가 완료되면 실행할 핸들러 정의
                			reader.onload = e => {
                				
                				// e.target ==> eventTarget (eventTarget : 이벤트가 발생한 대상)
                				// console.log(e.target);
                				
                				document.getElementById('kakao').src = e.target.result;
                			};
                			
                		}
                		else {
                			
                			document.getElementById('kakao').src = "https://t1.kakaocdn.net/friends/www/talk/kakaofriends_talk_2018.png"
                		}
                		
                		// 보편적으로 js 쓸 때 아래에 코드가 더 들어오면 끝에 ';'를 붙인다. (코드가 있다고 알려주려는 의도)
                		
                		
                	}
                </script>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
        <br><br>

    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>