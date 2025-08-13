<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-plus-circle me-2"></i>새 문의 등록</h2>
        <p>새로운 티켓 문의를 등록해주세요.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <form method="POST" action="/admin/qna/register" id="qnaForm">
        <div class="row">
            <!-- 제목 -->
            <div class="col-12 mb-3">
                <label for="title" class="form-group label">
                    <i class="fas fa-heading me-1"></i>제목
                </label>
                <input type="text" class="form-control" id="title" name="title" 
                       placeholder="문의 제목을 입력하세요" maxlength="200" required>
                <div class="text-muted mt-1">문의의 제목을 입력하세요. (최대 200자)</div>
            </div>
            
            <!-- 작성자 -->
            <div class="col-md-6 mb-3">
                <label for="name" class="form-group label">
                    <i class="fas fa-user me-1"></i>작성자
                </label>
                <input type="text" class="form-control" id="name" name="name" 
                       placeholder="작성자명을 입력하세요" maxlength="100" required>
                <div class="text-muted mt-1">문의 작성자의 이름을 입력하세요.</div>
            </div>
            
            <!-- 내용 -->
            <div class="col-12 mb-3">
                <label for="content" class="form-group label">
                    <i class="fas fa-file-alt me-1"></i>내용
                </label>
                <textarea class="form-control" id="content" name="content" rows="10" 
                          placeholder="문의 내용을 입력하세요"></textarea>
                <div class="text-muted mt-1">문의의 상세 내용을 입력하세요. (이미지 업로드 가능)</div>
            </div>
            
            <!-- 공지사항 체크박스 -->
            <div class="col-12 mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="notice" name="notice" value="Y">
                    <label class="form-check-label" for="notice">
                        <i class="fas fa-bullhorn me-1"></i>공지사항으로 설정
                    </label>
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>체크하면 문의 목록에서 최상단에 표시됩니다.
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 테스트 버튼 (임시) -->
        <div class="alert alert-info mb-3">
            <strong>디버깅 정보:</strong>
            <div id="debugInfo">로딩 중...</div>
            <button type="button" class="btn btn-warning btn-sm mt-2" onclick="testDirectSubmit()">
                <i class="fas fa-bug me-1"></i>직접 제출 테스트
            </button>
        </div>
        
        <!-- 버튼 그룹 -->
        <div class="d-flex justify-content-between mt-4">
            <a href="/admin/qna/list" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>목록으로 돌아가기
            </a>
            <div>
                <button type="reset" class="btn btn-secondary me-2">
                    <i class="fas fa-undo me-1"></i>초기화
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-1"></i>등록하기
                </button>
            </div>
        </div>
    </form>
</div>

<!-- CKEditor 스타일 -->
<style>
    .ck-editor__editable {
        min-height: 300px;
    }
</style>

<!-- CKEditor 스크립트 -->
<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>
<script>
    let editor;
    let isEditorReady = false;
    
    // 페이지 로드 완료 확인
    document.addEventListener('DOMContentLoaded', function() {
        console.log('✅ 페이지 로드 완료');
        updateDebugInfo();
        
        // 폼 제출 이벤트 등록
        const form = document.getElementById('qnaForm');
        if (form) {
            console.log('✅ 폼 요소를 찾았습니다.');
            form.addEventListener('submit', handleFormSubmit);
        }
        
        // 초기화 버튼 이벤트 등록
        const resetBtn = document.querySelector('button[type="reset"]');
        if (resetBtn) {
            resetBtn.addEventListener('click', handleReset);
        }
        
        // 공지사항 체크박스 이벤트 등록
        const noticeCheckbox = document.getElementById('notice');
        if (noticeCheckbox) {
            noticeCheckbox.addEventListener('change', function() {
                console.log('📢 공지사항 상태 변경:', this.checked ? 'Y' : 'N');
            });
        }
    });
    
    // CKEditor 초기화
    ClassicEditor
        .create(document.querySelector('#content'), {
            toolbar: [
                'heading', '|',
                'bold', 'italic', '|',
                'link', 'bulletedList', 'numberedList', '|',
                'outdent', 'indent', '|',
                'imageUpload', 'blockQuote', '|',
                'undo', 'redo'
            ],
            image: {
                toolbar: [
                    'imageTextAlternative'
                ]
            },
            table: {
                contentToolbar: [
                    'tableColumn',
                    'tableRow',
                    'mergeTableCells'
                ]
            },
            placeholder: '문의 내용을 입력하세요...'
        })
        .then(newEditor => {
            editor = newEditor;
            isEditorReady = true;
            console.log('✅ CKEditor가 성공적으로 로드되었습니다.');
            
            // 이미지 업로드 어댑터 설정
            editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                return {
                    upload: () => {
                        return new Promise((resolve, reject) => {
                            const data = new FormData();
                            loader.file.then((file) => {
                                data.append('upload', file);
                                
                                fetch('/admin/upload/image', {
                                    method: 'POST',
                                    body: data
                                })
                                .then(response => response.json())
                                .then(result => {
                                    if (result.uploaded) {
                                        resolve({
                                            default: result.url
                                        });
                                    } else {
                                        reject(result.error || '업로드 실패');
                                    }
                                })
                                .catch(error => {
                                    reject('업로드 중 오류가 발생했습니다.');
                                });
                            });
                        });
                    }
                };
            };
        })
        .catch(error => {
            console.error('❌ CKEditor 로드 실패:', error);
            console.log('⚠️ CKEditor 없이 기본 textarea로 작동합니다.');
        });
    
    // 폼 제출 처리
    function handleFormSubmit(e) {
        console.log('🚀 폼 제출 이벤트 발생');
        e.preventDefault();
        
        const title = document.getElementById('title').value.trim();
        const name = document.getElementById('name').value.trim();
        
        console.log('📝 입력된 제목:', title);
        console.log('👤 입력된 작성자:', name);
        console.log('📢 공지사항 상태:', document.getElementById('notice').checked ? 'Y' : 'N');
        
        if (!title) {
            alert('제목을 입력해주세요.');
            document.getElementById('title').focus();
            return false;
        }
        
        if (!name) {
            alert('작성자를 입력해주세요.');
            document.getElementById('name').focus();
            return false;
        }
        
        // CKEditor가 준비된 경우 내용 가져오기
        let content = '';
        if (isEditorReady && editor) {
            content = editor.getData();
            console.log('📄 CKEditor 내용 길이:', content.length);
        } else {
            // CKEditor가 없는 경우 textarea에서 직접 가져오기
            content = document.getElementById('content').value;
            console.log('📄 textarea 내용 길이:', content.length);
        }
        
        if (!content.trim()) {
            alert('내용을 입력해주세요.');
            if (isEditorReady && editor) {
                editor.focus();
            } else {
                document.getElementById('content').focus();
            }
            return false;
        }
        
        // textarea에 내용 설정 (서버로 전송을 위해)
        document.getElementById('content').value = content;
        console.log('✅ textarea에 내용 설정 완료');
        
        // 공지사항 값 설정 (체크되지 않은 경우 N 값 추가)
        const noticeCheckbox = document.getElementById('notice');
        if (!noticeCheckbox.checked) {
            // 체크되지 않은 경우 hidden input으로 N 값 추가
            let hiddenInput = document.querySelector('input[name="notice"][type="hidden"]');
            if (!hiddenInput) {
                hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = 'notice';
                hiddenInput.value = 'N';
                document.getElementById('qnaForm').appendChild(hiddenInput);
            }
            hiddenInput.value = 'N';
        }
        
        console.log('📋 최종 전송 데이터:');
        console.log('- 제목:', title);
        console.log('- 작성자:', name);
        console.log('- 내용 길이:', content.length);
        console.log('- 공지사항:', noticeCheckbox.checked ? 'Y' : 'N');
        
        // 제출 버튼 비활성화
        const submitBtn = e.target.querySelector('button[type="submit"]');
        if (submitBtn) {
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>등록 중...';
        }
        
        console.log('🚀 폼 제출 실행');
        e.target.submit();
    }
    
    // 초기화 처리
    function handleReset(e) {
        e.preventDefault();
        
        if (confirm('입력한 내용을 모두 초기화하시겠습니까?')) {
            document.getElementById('qnaForm').reset();
            if (editor && isEditorReady) {
                editor.setData('');
            }
            console.log('🔄 폼 초기화 완료');
        }
    }
    
    // 디버깅 정보 업데이트
    function updateDebugInfo() {
        const debugInfo = document.getElementById('debugInfo');
        if (debugInfo) {
            const title = document.getElementById('title') ? document.getElementById('title').value : '없음';
            const name = document.getElementById('name') ? document.getElementById('name').value : '없음';
            const content = document.getElementById('content') ? document.getElementById('content').value : '없음';
            const noticeStatus = document.getElementById('notice') ? (document.getElementById('notice').checked ? 'Y' : 'N') : '없음';
            const editorStatus = isEditorReady ? '✅ 준비됨' : '❌ 로딩 중';
            const formAction = document.getElementById('qnaForm') ? document.getElementById('qnaForm').action : '없음';
            
            debugInfo.innerHTML = 
                '<div><strong>제목:</strong> ' + title + '</div>' +
                '<div><strong>작성자:</strong> ' + name + '</div>' +
                '<div><strong>내용 길이:</strong> ' + content.length + '자</div>' +
                '<div><strong>공지사항:</strong> ' + noticeStatus + '</div>' +
                '<div><strong>CKEditor 상태:</strong> ' + editorStatus + '</div>' +
                '<div><strong>폼 액션:</strong> ' + formAction + '</div>';
        }
    }
    
    // 직접 제출 테스트 함수
    function testDirectSubmit() {
        console.log('🧪 직접 제출 테스트 시작');
        
        const title = document.getElementById('title').value.trim();
        const name = document.getElementById('name').value.trim();
        const content = document.getElementById('content').value.trim();
        
        if (!title || !name || !content) {
            alert('모든 필드를 입력해주세요.');
            return;
        }
        
        console.log('📋 테스트 데이터:', { title, name, content: content.substring(0, 50) + '...' });
        
        // 폼 데이터 생성
        const formData = new FormData();
        formData.append('title', title);
        formData.append('name', name);
        formData.append('content', content);
        
        // fetch로 직접 제출
        fetch('/admin/qna/register', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            console.log('📡 서버 응답 상태:', response.status);
            console.log('📡 서버 응답 URL:', response.url);
            
            if (response.redirected) {
                console.log('🔄 리다이렉트됨:', response.url);
                window.location.href = response.url;
            } else {
                return response.text();
            }
        })
        .then(text => {
            if (text) {
                console.log('📄 서버 응답 내용:', text.substring(0, 200) + '...');
            }
        })
        .catch(error => {
            console.error('❌ 직접 제출 테스트 오류:', error);
            alert('테스트 중 오류가 발생했습니다: ' + error.message);
        });
    }
    
    // 주기적으로 디버깅 정보 업데이트
    setInterval(updateDebugInfo, 2000);
</script> 