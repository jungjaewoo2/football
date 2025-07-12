<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>문의 수정</h2>
        <p>티켓 문의 내용을 수정해주세요.</p>
    </div>
    
    <!-- 알림 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <form method="POST" action="/admin/qna/edit/${qna.uid}" id="qnaForm">
        <div class="row">
            <!-- 제목 -->
            <div class="col-12 mb-3">
                <label for="title" class="form-group label">
                    <i class="fas fa-heading me-1"></i>제목
                </label>
                <input type="text" class="form-control" id="title" name="title" 
                       value="${qna.title}" placeholder="문의 제목을 입력하세요" maxlength="200" required>
                <div class="text-muted mt-1">문의의 제목을 입력하세요. (최대 200자)</div>
            </div>
            
            <!-- 작성자 -->
            <div class="col-md-6 mb-3">
                <label for="name" class="form-group label">
                    <i class="fas fa-user me-1"></i>작성자
                </label>
                <input type="text" class="form-control" id="name" name="name" 
                       value="${qna.name}" placeholder="작성자명을 입력하세요" maxlength="100" required>
                <div class="text-muted mt-1">문의 작성자의 이름을 입력하세요.</div>
            </div>
            
            <!-- 내용 -->
            <div class="col-12 mb-3">
                <label for="content" class="form-group label">
                    <i class="fas fa-file-alt me-1"></i>내용
                </label>
                <textarea class="form-control" id="content" name="content" rows="10" 
                          placeholder="문의 내용을 입력하세요" required>${qna.content}</textarea>
                <div class="text-muted mt-1">문의의 상세 내용을 입력하세요. (이미지 업로드 가능)</div>
            </div>
            
            <!-- 공지사항 체크박스 -->
            <div class="col-12 mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="notice" name="notice" value="Y" 
                           ${qna.notice == 'Y' ? 'checked' : ''}>
                    <label class="form-check-label" for="notice">
                        <i class="fas fa-bullhorn me-1"></i>공지사항으로 설정
                    </label>
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>체크하면 문의 목록에서 최상단에 표시됩니다.
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 버튼 그룹 -->
        <div class="d-flex justify-content-between mt-4">
            <a href="/admin/qna/view/${qna.uid}" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>상세보기로 돌아가기
            </a>
            <div>
                <button type="reset" class="btn btn-secondary me-2">
                    <i class="fas fa-undo me-1"></i>원래대로
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-1"></i>수정하기
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
    
    // CKEditor 초기화
    ClassicEditor
        .create(document.querySelector('#content'), {
            toolbar: [
                'heading', '|',
                'bold', 'italic', 'underline', '|',
                'link', 'bulletedList', 'numberedList', '|',
                'outdent', 'indent', '|',
                'imageUpload', 'blockQuote', 'insertTable', '|',
                'undo', 'redo'
            ],
            image: {
                toolbar: [
                    'imageTextAlternative',
                    'imageStyle:full',
                    'imageStyle:side'
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
            console.log('CKEditor가 성공적으로 로드되었습니다.');
            
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
            console.error('CKEditor 로드 중 오류가 발생했습니다:', error);
        });
    
    // 폼 제출 이벤트 처리
    document.getElementById('qnaForm').addEventListener('submit', function(e) {
        e.preventDefault();
        console.log('수정 폼 제출 시작');
        
        var title = document.getElementById('title').value.trim();
        var name = document.getElementById('name').value.trim();
        
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
        
        // CKEditor가 준비되었는지 확인
        if (!isEditorReady || !editor) {
            alert('에디터가 로드되지 않았습니다. 잠시 후 다시 시도해주세요.');
            return false;
        }
        
        // CKEditor 내용을 textarea에 설정
        try {
            var content = editor.getData();
            console.log('CKEditor 내용:', content);
            
            if (!content.trim()) {
                alert('내용을 입력해주세요.');
                return false;
            }
            
            // textarea에 내용 설정
            document.getElementById('content').value = content;
            console.log('textarea 값 설정 완료');
            
            // 제출 버튼 비활성화 (중복 제출 방지)
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>수정 중...';
            
            // 폼 제출
            console.log('수정 폼 제출 실행');
            this.submit();
            
        } catch (error) {
            console.error('폼 제출 중 오류:', error);
            alert('폼 제출 중 오류가 발생했습니다.');
            
            // 버튼 복원
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = false;
            submitBtn.innerHTML = '<i class="fas fa-save me-1"></i>수정하기';
        }
    });
    
    // 초기화 버튼 이벤트
    document.querySelector('button[type="reset"]').addEventListener('click', function(e) {
        e.preventDefault();
        
        if (confirm('내용을 원래대로 되돌리시겠습니까?')) {
            // 원래 내용으로 되돌리기
            document.getElementById('title').value = document.getElementById('title').defaultValue;
            document.getElementById('name').value = document.getElementById('name').defaultValue;
            
            if (editor && isEditorReady) {
                var originalContent = document.getElementById('content').defaultValue;
                editor.setData(originalContent);
            }
        }
    });
    
    // 페이지 이탈 전 경고
    window.addEventListener('beforeunload', function(e) {
        if (editor && isEditorReady && editor.getData().trim()) {
            e.preventDefault();
            e.returnValue = '';
        }
    });
</script> 