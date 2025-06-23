<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경 - 관리자</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background: #f5f5f5;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .header h1 {
            font-size: 20px;
        }
        
        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s ease;
            font-size: 14px;
        }
        
        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .container {
            display: flex;
            min-height: calc(100vh - 60px);
        }
        
        .sidebar {
            width: 250px;
            background: white;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            overflow-y: auto;
        }
        
        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            background: #f8f9fa;
        }
        
        .sidebar-header h3 {
            color: #333;
            font-size: 16px;
        }
        
        .menu-section {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        
        .menu-section:last-child {
            border-bottom: none;
        }
        
        .menu-item {
            display: block;
            padding: 12px 20px;
            color: #555;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        
        .menu-item:hover {
            background: #f8f9fa;
            color: #667eea;
            border-left-color: #667eea;
        }
        
        .menu-item.active {
            background: #667eea;
            color: white;
            border-left-color: #667eea;
        }
        
        .main-content {
            flex: 1;
            padding: 30px;
            background: #f5f5f5;
        }
        
        .content-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            max-width: 500px;
            margin: 0 auto;
        }
        
        .content-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .content-header h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .content-header p {
            color: #666;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .submit-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
        }
        
        .message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Football 관리자 시스템</h1>
        <a href="/admin/logout" class="logout-btn">로그아웃</a>
    </div>
    
    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>관리자 메뉴</h3>
            </div>
            
            <div class="menu-section">
                <a href="#" class="menu-item">예약목록</a>
                <a href="#" class="menu-item">확정목록</a>
                <a href="#" class="menu-item">인보이스 목록</a>
                <a href="#" class="menu-item">인보이스® 목록</a>
                <a href="#" class="menu-item">바우처 목록</a>
            </div>
            
            <div class="menu-section">
                <a href="#" class="menu-item">일정표 관리</a>
                <a href="#" class="menu-item">일정표 좌석요금</a>
                <a href="#" class="menu-item">팀정보 관리</a>
            </div>
            
            <div class="menu-section">
                <a href="/admin/changePassword" class="menu-item active">비밀번호 변경</a>
            </div>
            
            <div class="menu-section">
                <a href="#" class="menu-item">메인이미지 관리</a>
                <a href="#" class="menu-item">메인배너 관리</a>
                <a href="#" class="menu-item">구단 관리</a>
                <a href="#" class="menu-item">팝업관리</a>
                <a href="#" class="menu-item">FAQ 관리</a>
                <a href="#" class="menu-item">티켓문의</a>
                <a href="#" class="menu-item">관전후기</a>
            </div>
        </div>
        
        <div class="main-content">
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
        </div>
    </div>
</body>
</html> 