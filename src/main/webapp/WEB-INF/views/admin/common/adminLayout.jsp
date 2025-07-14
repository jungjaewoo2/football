<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.pageTitle} - 유로풋볼투어 관리자</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
            overflow-y: auto;
        }
        
        .content-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .content-header {
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
        
        .message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
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
        
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
            color: white;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            color: white;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
            color: white;
        }
        
        .btn-warning {
            background: #ffc107;
            color: #212529;
        }
        
        .btn-warning:hover {
            background: #e0a800;
            color: #212529;
        }
        
        .btn-sm {
            padding: 5px 10px;
            font-size: 12px;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0,0,0,.05);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #333;
            font-weight: 600;
            font-size: 15px;
        }
        
        .form-control {
            width: 100%;
            padding: 16px 18px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #fafbfc;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #667eea;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .form-control::placeholder {
            color: #adb5bd;
            font-size: 15px;
        }
        
        .input-group {
            display: flex;
        }
        
        .input-group .form-control {
            border-radius: 8px 0 0 8px;
        }
        
        .input-group-text {
            padding: 16px 18px;
            background: #f8f9fa;
            border: 2px solid #e1e5e9;
            border-left: none;
            border-radius: 0 8px 8px 0;
            color: #495057;
            font-weight: 500;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            margin: 20px 0;
        }
        
        .page-item {
            margin: 0 2px;
        }
        
        .page-link {
            display: block;
            padding: 8px 12px;
            color: #667eea;
            background: white;
            border: 1px solid #dee2e6;
            text-decoration: none;
            border-radius: 5px;
        }
        
        .page-link:hover {
            background: #e9ecef;
        }
        
        .page-item.active .page-link {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }
        
        .page-item.disabled .page-link {
            color: #6c757d;
            pointer-events: none;
            background: white;
            border-color: #dee2e6;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 8px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 4px;
        }
        
        .bg-warning {
            background-color: #ffc107;
            color: #212529;
        }
        
        .bg-success {
            background-color: #28a745;
            color: white;
        }
        
        .bg-primary {
            background-color: #007bff;
            color: white;
        }
        
        .bg-purple {
            background-color: #6f42c1;
            color: white;
        }
        
        .bg-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .bg-dark {
            background-color: #343a40;
            color: white;
        }
        
        .alert {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .text-center {
            text-align: center;
        }
        
        .text-muted {
            color: #6c757d;
        }
        
        .d-flex {
            display: flex;
        }
        
        .justify-content-between {
            justify-content: space-between;
        }
        
        .justify-content-center {
            justify-content: center;
        }
        
        .align-items-center {
            align-items: center;
        }
        
        .me-2 {
            margin-right: 0.5rem;
        }
        
        .mb-3 {
            margin-bottom: 1rem;
        }
        
        .mb-4 {
            margin-bottom: 1.5rem;
        }
        
        .mt-4 {
            margin-top: 1.5rem;
        }
        
        .row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -15px;
        }
        
        .col-md-6 {
            flex: 0 0 50%;
            max-width: 50%;
            padding: 0 15px;
        }
        
        .col-12 {
            flex: 0 0 100%;
            max-width: 100%;
            padding: 0 15px;
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        .color-badge {
            display: inline-block;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            margin-right: 8px;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .orange-bg { background-color: #ff8c00; }
        .yellow-bg { background-color: #ffd700; }
        .green-bg { background-color: #32cd32; }
        .blue-bg { background-color: #4169e1; }
        .purple-bg { background-color: #9370db; }
        .red-bg { background-color: #dc143c; }
        .black-bg { background-color: #000000; }
        
        .submit-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }
        
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .card-header {
            padding: 15px 20px;
            border-bottom: 1px solid #dee2e6;
            background: #f8f9fa;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .form-check-input {
            margin-right: 10px;
        }
        
        .form-check-label {
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>유로풋볼투어 관리자 시스템</h1>
        <a href="/admin/logout" class="logout-btn">로그아웃</a>
    </div>
    
    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>관리자 메뉴</h3>
            </div>
            
            <div class="menu-section">
                <a href="/admin/register_schedule/list" class="menu-item ${param.activeMenu == 'register_schedule' ? 'active' : ''}">예약목록</a>
                <a href="#" class="menu-item">확정목록</a>
                <a href="#" class="menu-item">인보이스 목록</a>
            </div>
            
            <div class="menu-section">
                <a href="/admin/schedule_info/list" class="menu-item ${param.activeMenu == 'schedule_info' ? 'active' : ''}">일정표 관리</a>
                <a href="/admin/seat_fee/list" class="menu-item ${param.activeMenu == 'seat_fee' ? 'active' : ''}">일정표 좌석요금</a>
                <a href="/admin/team_info/list" class="menu-item ${param.activeMenu == 'team_info' ? 'active' : ''}">팀정보 관리</a>
            </div>
            
            <div class="menu-section">
                <a href="/admin/changePassword" class="menu-item ${param.activeMenu == 'changePassword' ? 'active' : ''}">비밀번호 변경</a>
            </div>
            
            <div class="menu-section">
                <a href="/admin/main_img/list" class="menu-item ${param.activeMenu == 'main_img' ? 'active' : ''}">메인이미지 관리</a>
                <a href="/admin/main_banner/list" class="menu-item ${param.activeMenu == 'main_banner' ? 'active' : ''}">메인배너 관리</a>
                <a href="/admin/popup" class="menu-item ${param.activeMenu == 'popup' ? 'active' : ''}">팝업관리</a>
                <a href="/admin/faq/list" class="menu-item ${param.activeMenu == 'faq' ? 'active' : ''}">자주하는 질문 관리</a>
                <a href="/admin/qna/list" class="menu-item ${param.activeMenu == 'qna' ? 'active' : ''}">티켓문의</a>
                <a href="/admin/gallery/list" class="menu-item ${param.activeMenu == 'gallery' ? 'active' : ''}">관전후기</a>
                <a href="/admin/customer_center" class="menu-item ${param.activeMenu == 'customer_center' ? 'active' : ''}">고객센터 관리</a>
                <a href="/admin/tour" class="menu-item ${param.activeMenu == 'tour' ? 'active' : ''}">유로풋볼투어 관리</a>
            </div>
        </div>
        
        <div class="main-content">
            <jsp:include page="${param.contentPage}" />
        </div>
    </div>
</body>
</html> 