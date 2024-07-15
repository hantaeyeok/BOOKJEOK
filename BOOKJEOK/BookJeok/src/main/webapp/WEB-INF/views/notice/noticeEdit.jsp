<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


.ntl-content {
        
        width:80%;
        margin:auto;
        padding:5% 10%;
        background-color:white;
    }


</style>

</head>

<body>



    <!--공지사항 테이블 구간-->  

    <div class="ntl-content">



        <form>
            <div class="form-group row">
            <label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
            <div class="col-sm-10">
                <input type="title" class="form-control" id="inputEmail3" placeholder="제목을 입력하세요">
            </div>
            </div>
            <div class="form-group row">
            <label for="inputAttachedFile" class="col-sm-2 col-form-label">첨부파일</label>
            <div class="col-sm-10">
                <input type="attachedFile" class="form-control" id="inputPassword3" placeholder="첨부파일을 첨부하세요">
            </div>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                <textarea class="form-control" id="exampleFormControlTextarea1" rows="20"></textarea>
              </div>
        </form>
        <br> <br> <br>
        <div class="d-grid gap-2 d-md-block">
            <button class="btn btn-primary" type="button">취소</button>
            <button class="btn btn-primary" type="button">등록</button>
        </div>

    </div>


</body>
</html>