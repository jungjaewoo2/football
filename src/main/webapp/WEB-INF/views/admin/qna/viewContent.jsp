<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>

<div class="content-card">
    <div class="content-header">
        <h2>QNA 상세보기 테스트</h2>
        <p>이 텍스트가 보이면 JSP가 정상 동작합니다.</p>
    </div>
    
    <!-- 기본 HTML 테스트 -->
    <div style="background: #f0f0f0; padding: 10px; margin: 10px; border: 1px solid #ccc;">
        <h3>기본 HTML 테스트</h3>
        <p>이 텍스트가 보이면 JSP가 정상 동작합니다.</p>
    </div>
    
    <!-- 서버 정보 -->
    <div style="background: #e0f0e0; padding: 10px; margin: 10px;">
        <h3>서버 정보:</h3>
        <p>서버 시간: <%= new java.util.Date() %></p>
        <p>요청 URI: <%= request.getRequestURI() %></p>
        <p>요청 파라미터: <%= request.getQueryString() %></p>
    </div>
    
    <!-- 데이터 확인 -->
    <div style="background: #f0f0ff; padding: 10px; margin: 10px;">
        <h3>데이터 확인:</h3>
        <% 
        Object qnaObj = request.getAttribute("qna");
        Object repliesObj = request.getAttribute("replies");
        %>
        <p>qna 객체 존재: <%= qnaObj != null %></p>
        <p>replies 객체 존재: <%= repliesObj != null %></p>
        
        <% if (qnaObj != null) { %>
            <p>qna 객체 타입: <%= qnaObj.getClass().getName() %></p>
        <% } %>
        
        <% if (repliesObj != null) { %>
            <p>replies 객체 타입: <%= repliesObj.getClass().getName() %></p>
        <% } %>
    </div>
    
    <!-- 에러 정보 -->
    <% if (exception != null) { %>
        <div style="background: #ffcccc; padding: 10px; margin: 10px;">
            <h3>에러 발생:</h3>
            <p><%= exception.getMessage() %></p>
            <pre><%= exception.getStackTrace() %></pre>
        </div>
    <% } %>
    
    <!-- 세션 정보 -->
    <div style="background: #f0f0ff; padding: 10px; margin: 10px;">
        <h3>세션 정보:</h3>
        <p>세션 ID: <%= session.getId() %></p>
        <p>세션 생성 시간: <%= new java.util.Date(session.getCreationTime()) %></p>
    </div>
</div> 