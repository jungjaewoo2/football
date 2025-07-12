<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-plus me-2"></i>관전후기 등록</h2>
        <p>새로운 관전후기를 등록합니다.</p>
    </div>
    
    <!-- 오류 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    
    <div class="card">
        <div class="card-body">
            <form action="/admin/gallery/register" method="post" id="galleryForm">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="title" class="form-label">
                                <i class="fas fa-heading me-1"></i>제목
                            </label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   value="${gallery.title}" required maxlength="200" 
                                   placeholder="제목을 입력하세요">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">
                                <i class="fas fa-user me-1"></i>작성자
                            </label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="${gallery.name}" required maxlength="100" 
                                   placeholder="작성자를 입력하세요">
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">
                        <i class="fas fa-edit me-1"></i>내용
                    </label>
                    <textarea class="form-control" id="content" name="content" 
                              placeholder="관전후기 내용을 입력하세요">${gallery.content}</textarea>
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <a href="/admin/gallery/list" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-1"></i>목록으로
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i>등록
                    </button>
                </div>
            </form>
        </div>
    </div>
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
        
        // 폼 제출 이벤트 등록
        const form = document.getElementById('galleryForm');
        if (form) {
            console.log('✅ 폼 요소를 찾았습니다.');
            form.addEventListener('submit', handleFormSubmit);
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
            placeholder: '관전후기 내용을 입력하세요...'
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
                                
                                fetch('/admin/upload/gallery/image', {
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
        
        const title = document.getElementById('title').value.trim();
        const name = document.getElementById('name').value.trim();
        
        console.log('📝 입력된 제목:', title);
        console.log('👤 입력된 작성자:', name);
        
        if (!title) {
            e.preventDefault();
            alert('제목을 입력해주세요.');
            document.getElementById('title').focus();
            return false;
        }
        
        if (!name) {
            e.preventDefault();
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
            e.preventDefault();
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
        
        // 제출 버튼 비활성화
        const submitBtn = e.target.querySelector('button[type="submit"]');
        if (submitBtn) {
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>등록 중...';
        }
        
        console.log('🚀 폼 제출 실행');
        // e.preventDefault()를 제거하여 폼이 정상적으로 제출되도록 함
    }
</script> 