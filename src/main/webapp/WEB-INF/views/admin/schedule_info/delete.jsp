<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>일정표 삭제</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>일정표 삭제</h2>
    <div class="alert alert-danger">
        정말로 삭제하시겠습니까?<br>
        <strong>경기분류:</strong> ${scheduleInfo.gameCategory} <br>
        <strong>홈팀:</strong> ${scheduleInfo.homeTeam} <br>
        <strong>원정팀:</strong> ${scheduleInfo.otherTeam} <br>
        <strong>경기날짜:</strong> ${scheduleInfo.gameDate}
    </div>
    <form action="/admin/schedule_info/delete/${scheduleInfo.uid}" method="post">
        <button type="submit" class="btn btn-danger">삭제</button>
        <a href="/admin/schedule_info/list" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html> 