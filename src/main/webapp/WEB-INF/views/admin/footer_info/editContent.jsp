<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>카피라이터 관리</h2>
        <p>연락처 정보를 수정할 수 있습니다.</p>
    </div>
    
    <!-- 알림 메시지 (JSTL 제거) -->
    <div id="successMessage" class="alert alert-success" style="display: none;">
        <i class="fas fa-check-circle me-2"></i><span id="successText"></span>
        </div>
    <div id="errorMessage" class="alert alert-danger" style="display: none;">
        <i class="fas fa-exclamation-circle me-2"></i><span id="errorText"></span>
        </div>
    
    <div class="card">
        <div class="card-header bg-warning text-dark">
            <h5 class="mb-0">
                <i class="fas fa-copyright me-2"></i>연락처 정보 수정
            </h5>
        </div>
        <div class="card-body">
            <form id="footerInfoForm" method="post" action="/admin/footer_info/edit" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="phone" class="form-label">
                                <i class="fas fa-phone me-1"></i>전화번호
                            </label>
                            <input type="tel" id="phone" name="phone" class="form-control" 
                                   placeholder="전화번호를 입력하세요 (예: 070-7779-9614)" 
                                   value="${footerInfo.phone != null ? footerInfo.phone : ''}">
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                하이픈(-)을 포함하여 입력해주세요.
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope me-1"></i>이메일
                            </label>
                            <input type="email" id="email" name="email" class="form-control" 
                                   placeholder="이메일을 입력하세요 (예: info@example.com)" 
                                   value="${footerInfo.email != null ? footerInfo.email : ''}">
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                올바른 이메일 형식으로 입력해주세요.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label for="address" class="form-label">
                                <i class="fas fa-map-marker-alt me-1"></i>주소
                            </label>
                            <input type="text" id="address" name="address" class="form-control" 
                                   placeholder="주소를 입력하세요 (예: 서울특별시 강남구 테헤란로 123)" 
                                   value="${footerInfo.address != null ? footerInfo.address : ''}">
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                상세한 주소를 입력해주세요.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label for="logo" class="form-label">
                                <i class="fas fa-image me-1"></i>로고 이미지
                            </label>
                            <input type="file" id="logo" name="logo" class="form-control" 
                                   accept="image/*" onchange="previewLogo(this)">
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                로고 이미지를 업로드해주세요. (JPG, PNG, GIF 형식 지원)
                            </div>
                            <!-- 현재 로고 미리보기 (JSTL 제거) -->
                            <div id="currentLogoPreview" class="mt-2" style="display: none;">
                                <label class="form-label">현재 로고:</label>
                                <div class="current-logo">
                                    <img id="currentLogoImage" src="" alt="현재 로고" 
                                         class="img-thumbnail" style="max-width: 200px; max-height: 100px;">
                                </div>
                            </div>
                            <!-- 새 로고 미리보기 -->
                            <div id="logoPreview" class="mt-2" style="display: none;">
                                <label class="form-label">새 로고 미리보기:</label>
                                <div class="new-logo">
                                    <img id="previewImage" src="" alt="새 로고 미리보기" 
                                         class="img-thumbnail" style="max-width: 200px; max-height: 100px;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <a href="/admin/footer_info" class="btn btn-secondary">
                        <i class="fas fa-times me-1"></i>취소
                    </a>
                    <button type="submit" class="btn btn-warning">
                        <i class="fas fa-save me-1"></i>저장
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 페이지 로드 시 실행
    document.addEventListener('DOMContentLoaded', function() {
        // 기존 로고 표시
        showExistingLogo();
        
        // 폼 제출 이벤트
        const form = document.getElementById('footerInfoForm');
        if (form) {
            form.addEventListener('submit', function(e) {
        const phone = document.getElementById('phone').value.trim();
        const email = document.getElementById('email').value.trim();
        const address = document.getElementById('address').value.trim();
                const logo = document.getElementById('logo').files[0];
                
                console.log('폼 제출 검증:', {
                    phone: phone,
                    email: email,
                    address: address,
                    logo: logo ? logo.name : '없음'
                });
                
                // 최소 하나의 필드는 입력되어야 함 (로고는 선택사항)
        if (!phone && !email && !address) {
            e.preventDefault();
            alert('전화번호, 이메일, 주소 중 하나는 입력해주세요.');
            return false;
        }
        
                // 로고가 선택된 경우 파일 크기 확인
                if (logo) {
                    const maxSize = 5 * 1024 * 1024; // 5MB
                    if (logo.size > maxSize) {
            e.preventDefault();
                        alert('로고 파일 크기는 5MB 이하여야 합니다.');
            return false;
        }
                }
                
                console.log('폼 제출 승인');
                return true;
            });
        }
    });
    
    // 기존 로고 표시 함수
    function showExistingLogo() {
        try {
            // 서버에서 전달받은 로고 파일명이 있는지 확인
            const logoFileName = '${footerInfo.logo}';
            console.log('로고 파일명:', logoFileName);
            
            if (logoFileName && logoFileName !== '${footerInfo.logo}' && logoFileName !== 'null') {
                const currentLogoPreview = document.getElementById('currentLogoPreview');
                const currentLogoImage = document.getElementById('currentLogoImage');
                
                if (currentLogoPreview && currentLogoImage) {
                    const imagePath = `/uploads/footer_info/${logoFileName}`;
                    console.log('로고 이미지 경로:', imagePath);
                    
                    currentLogoImage.src = imagePath;
                    currentLogoPreview.style.display = 'block';
                    
                    // 이미지 로드 확인
                    currentLogoImage.onload = function() {
                        console.log('기존 로고 이미지 로드 성공');
                    };
                    currentLogoImage.onerror = function() {
                        console.error('기존 로고 이미지 로드 실패:', imagePath);
                        currentLogoPreview.style.display = 'none';
                    };
                }
            } else {
                console.log('기존 로고 없음');
            }
        } catch (error) {
            console.error('로고 표시 오류:', error);
        }
    }
    
    // 로고 미리보기 함수
    function previewLogo(input) {
        try {
            const preview = document.getElementById('logoPreview');
            const previewImage = document.getElementById('previewImage');
            
            if (input.files && input.files[0] && preview && previewImage) {
                const file = input.files[0];
                console.log('선택된 파일:', {
                    name: file.name,
                    size: file.size,
                    type: file.type
                });
                
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImage.src = e.target.result;
                    preview.style.display = 'block';
                    console.log('로고 미리보기 성공');
                };
                reader.onerror = function() {
                    console.error('파일 읽기 오류');
                };
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
            }
        } catch (error) {
            console.error('로고 미리보기 오류:', error);
        }
    }
</script>

<style>
.form-control:focus {
    border-color: #86b7fe;
    box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
}
</style> 