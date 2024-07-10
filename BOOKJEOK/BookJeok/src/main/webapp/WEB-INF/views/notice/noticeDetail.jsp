<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세보기</title>

<style>
* { margin: 0; padding: 0; }

a { text-decoration: none; color: #333; }
ul { list-style: none; }
body, html { width: 100%; overflow-x: hidden; }

.content { width: 60%;  margin: 20px auto; background-color: white; padding: 20px; }

.notice-detailpage-title { font-size: 24px; color: #333; border-bottom: 2px solid #8a8a8a; line-height: 50px;
            padding-bottom: 10px; margin-bottom: 20px; }

/* 상세 정보 스타일링 */
#notice-detail-title-th { display: block; justify-content: space-between;  border-bottom: 2px solid #eee;}
.title { border-bottom :#eee; line-height: 50px }
.notice-data, .notice-file { position: relative;  margin: 20px; padding: 10px; }

.notice-data dt, .notice-file dt {  font-weight: bold;  }
.notice-data dt, dd { border-bottom :#eee; line-height: 20px; clear:both; float: left;  font-size: 10px;  }
.notice-file dt { font-size: 20px; border-bottom :#eee; line-height: 30px;}
.notice-data dd, .notice-file dd { margin-left: 10px; }

/* 첨부파일 리스트 스타일 */
.notice-fileList a { display: inline-block; margin-right: 10px; color: #007bff; text-decoration: none; }

/* 상세 내용 영역 */
.notice-detail-content {  padding: 20px; position: absolute; background-color: #fafafa;
                         border: 1px solid #eee; box-sizing: content-box;  width: 58%;  height: 600px;  padding: 20px;
}

/* 하단 이전글, 다음글 링크 */
.notice-other-content { list-style: none; padding: 0; }

.notice-other-content li { margin-top: 10px; }

/* 버튼 스타일 */
.btn {
    align-items: center;
    clear:right;
    display: inline-block;
    position:relative;
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
    margin: 10px 5px 0 0; /* 마진 설정 조정 */
}



</style>


</head>
<body>

        <div class="content">
            <h2 class="notice-detailpage-title">공지사항 상세보기</h2>
            <div class ="notice-detail" id ="nd_all">
                <div class ="notice-detail-title" id ="ndt_all">
                    <div class ="notice-detail-title" id ="notice-detail-title-th">
                        <p class="title" >${sessionScope.loginUser.userId}</p>
                    </div>
                    <br>
                    <div class ="notice-detail-title" id ="notice-detail-title-tr">
                        <dl class ="notice-data">
                            <dt>작성자</dt>
                            <dd>${notice.userId}</dd>
                            <dt>작성일</dt>
                            <dd>${notice.date}</dd>
                            <dt>조회수</dt>
                            <dd>${notice.visited}</dd>
                        </dl>

                        <dl class ="notice-file">
                            <dt>첨부파일</dt>
                                <dd>
                                    <ul>
                                        <li class="notice-fileList">
                                            <a href="" targt="blank"></a>
                                            <a href="" targt="blank"></a>
                                        </li>
                                    </ul>
                                </dd>
                        </dl>
                    </div>           
                </div>    
                <div class ="notice-detail-content" id ="ndc">
                    <div class ="nd-content" id ="ndc-detail">${notice.content}</div>
                </div>
                <div>
                    <p class="notice-content02">
                        <img src="" alt="">
                    </p>
                    <p class="notice-content03">
                        <a href="" alt="">
                    </p>
                    <ul class="notice-other-content">
                        <li>
                            <span class="prev">이전글</span>
                            <a href="" alt="">
                        </li>
                        <li>
                            <span class="prev">다음글</span>
                            <a href="" alt="">
                        </li>
                    </ul>
                </div>

                <br><br><br>
                <div class="d-grid gap-2 d-md-block">
                        <button class="btn btn-primary" type="button">Button</button>
                        <button class="btn btn-primary" type="button">Button</button>
                </div>

            </div>
        </div> 


</body>
</html>