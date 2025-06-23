<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 대시보드</title>
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
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h1 {
            font-size: 24px;
        }
        
        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        
        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .welcome-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        
        .welcome-card h2 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .welcome-card p {
            color: #666;
            font-size: 16px;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .dashboard-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .dashboard-card h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }
        
        .dashboard-card p {
            color: #666;
            line-height: 1.6;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>관리자 대시보드</h1>
        <a href="/admin/logout" class="logout-btn">로그아웃</a>
    </div>
    
    <div class="container">
        <% if (request.getAttribute("success") != null) { %>
            <div class="success-message">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <div class="welcome-card">
            <h2>환영합니다, <%= session.getAttribute("adminId") %>님!</h2>
            <p>관리자 대시보드에 오신 것을 환영합니다.</p>
        </div>
        
        <div class="dashboard-grid">
            <div class="dashboard-card">
                <h3>사용자 관리</h3>
                <p>시스템 사용자들을 관리하고 권한을 설정할 수 있습니다.</p>
            </div>
            
            <div class="dashboard-card">
                <h3>시스템 설정</h3>
                <p>시스템 전반적인 설정을 관리할 수 있습니다.</p>
            </div>
            
            <div class="dashboard-card">
                <h3>데이터 관리</h3>
                <p>데이터베이스의 데이터를 관리하고 백업할 수 있습니다.</p>
            </div>
            
            <div class="dashboard-card">
                <h3>로그 확인</h3>
                <p>시스템 로그를 확인하고 모니터링할 수 있습니다.</p>
            </div>
        </div>
    </div>
</body>
</html> 