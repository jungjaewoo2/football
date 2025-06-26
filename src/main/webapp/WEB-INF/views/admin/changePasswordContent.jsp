<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="content-card">
    <div class="content-header">
        <h2>비밀번호 변경</h2>
        <p>안전한 계정 관리를 위해 비밀번호를 변경해주세요</p>
    </div>
    
    <% if (request.getAttribute("success") != null) { %>
        <div class="message success-message">
            <%= request.getAttribute("success") %>
        </div>
    <% } %>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="message error-message">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
    <form action="/admin/changePassword" method="post">
        <div class="form-group">
            <label for="currentPassword">현재 비밀번호</label>
            <input type="password" id="currentPassword" name="currentPassword" required placeholder="현재 비밀번호를 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="newPassword">새 비밀번호</label>
            <input type="password" id="newPassword" name="newPassword" required placeholder="새 비밀번호를 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="confirmPassword">새 비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="새 비밀번호를 다시 입력하세요">
        </div>
        
        <button type="submit" class="submit-btn">비밀번호 변경</button>
    </form>
</div> 