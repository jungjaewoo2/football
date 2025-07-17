<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>답변 등록 디버깅</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>답변 등록 테스트</h2>
        
        <form action="/admin/qna/reply/6783" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">답변자</label>
                <input type="text" class="form-control" id="name" name="name" value="관리자" required>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">답변 내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" required>테스트 답변입니다.</textarea>
            </div>
            <button type="submit" class="btn btn-primary">답변 등록 테스트</button>
        </form>
        
        <hr>
        
        <h3>현재 답변 목록</h3>
        <c:if test="${not empty replies}">
            <ul>
                <c:forEach items="${replies}" var="reply">
                    <li>
                        ID: ${reply.uid}, 
                        작성자: ${reply.name}, 
                        내용: ${reply.content}, 
                        부모ID: ${reply.parentPostId}
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        <c:if test="${empty replies}">
            <p>답변이 없습니다.</p>
        </c:if>
    </div>
</body>
</html> 