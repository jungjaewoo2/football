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
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        }
        
        .dashboard-card h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }
        
        .dashboard-card p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .dashboard-card a {
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .card-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s ease;
        }
        
        .card-btn:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
            color: white;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .seat-fee-card {
            border-left: 4px solid #ff8c00;
        }
        
        .seat-fee-card h3 {
            color: #ff8c00;
        }
        
        .team-info-card {
            border-left: 4px solid #28a745;
        }
        
        .team-info-card h3 {
            color: #28a745;
        }
        
        .schedule-info-card {
            border-left: 4px solid #3490dc;
        }
        
        .schedule-info-card h3 {
            color: #3490dc;
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
            <div class="dashboard-card seat-fee-card">
                <a href="/admin/seat_fee/list">
                    <h3>🏟️ 좌석요금 관리</h3>
                    <p>경기장 좌석별 요금을 설정하고 관리할 수 있습니다. ORANGE, YELLOW, GREEN, BLUE, PURPLE, RED, BLACK 등급별 요금을 설정하세요.</p>
                    <span class="card-btn">관리하기</span>
                </a>
            </div>
            
            <div class="dashboard-card team-info-card">
                <a href="/admin/team_info/list">
                    <h3>⚽ 팀정보 관리</h3>
                    <p>축구팀 정보를 관리하고 설정할 수 있습니다. 팀구단명, 카테고리, 경기장, 도시, 로고 및 좌석 이미지를 관리하세요.</p>
                    <span class="card-btn">관리하기</span>
                </a>
            </div>
            
            <div class="dashboard-card schedule-info-card">
                <a href="/admin/schedule_info/list">
                    <h3>📅 일정표 관리</h3>
                    <p>경기 일정을 관리하고 설정할 수 있습니다. 경기분류, 홈팀/원정팀, 경기날짜/시간, 요금정보를 관리하세요.</p>
                    <span class="card-btn">관리하기</span>
                </a>
            </div>
            
            <div class="dashboard-card">
                <h3>👥 사용자 관리</h3>
                <p>시스템 사용자들을 관리하고 권한을 설정할 수 있습니다.</p>
                <span class="card-btn">관리하기</span>
            </div>
            
            <div class="dashboard-card">
                <h3>⚙️ 시스템 설정</h3>
                <p>시스템 전반적인 설정을 관리할 수 있습니다.</p>
                <span class="card-btn">관리하기</span>
            </div>
            
            <div class="dashboard-card">
                <h3>📊 데이터 관리</h3>
                <p>데이터베이스의 데이터를 관리하고 백업할 수 있습니다.</p>
                <span class="card-btn">관리하기</span>
            </div>
            
            <div class="dashboard-card">
                <h3>📋 로그 확인</h3>
                <p>시스템 로그를 확인하고 모니터링할 수 있습니다.</p>
                <span class="card-btn">관리하기</span>
            </div>
        </div>
    </div>
</body>
</html> 