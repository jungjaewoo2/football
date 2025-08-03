<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>개인정보 수정</h2>
        <p>개인정보처리방침 내용을 수정할 수 있습니다. 웹에디터를 통해 이미지 첨부가 가능합니다.</p>
    </div>
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>
    <div class="card">
        <div class="card-header bg-warning text-dark">
            <h5 class="mb-0">
                <i class="fas fa-user-shield me-2"></i>개인정보처리방침 내용 수정
            </h5>
        </div>
        <div class="card-body">
            <form id="personForm" method="post" action="/admin/person/edit">
                <div class="mb-3">
                    <label for="content" class="form-label">
                        <i class="fas fa-edit me-1"></i>개인정보처리방침 내용
                    </label>
                    <textarea id="content" name="content" class="form-control" 
                              placeholder="개인정보처리방침 내용을 입력하세요. 이미지 첨부가 가능합니다.">${person.content}</textarea>
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>
                        웹에디터를 통해 텍스트 서식과 이미지 첨부가 가능합니다.
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <a href="/admin/person" class="btn btn-secondary">
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

<!-- CKEditor 스크립트 -->
<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>
<script>
    ClassicEditor
        .create(document.querySelector('#content'), {
            toolbar: {
                items: [
                    'undo', 'redo',
                    '|', 'heading',
                    '|', 'bold', 'italic', 'strikethrough', 'underline',
                    '|', 'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor',
                    '|', 'alignment',
                    '|', 'numberedList', 'bulletedList',
                    '|', 'indent', 'outdent',
                    '|', 'link', 'blockQuote', 'insertTable', 'mediaEmbed',
                    '|', 'removeFormat'
                ]
            },
            language: 'ko'
        })
        .then(editor => {
            console.log('CKEditor initialized successfully');
        })
        .catch(error => {
            console.error('CKEditor initialization failed:', error);
        });
    document.getElementById('personForm').addEventListener('submit', function(e) {
        const content = document.getElementById('content').value.trim();
        if (!content) {
            e.preventDefault();
            alert('개인정보처리방침 내용을 입력해주세요.');
            return false;
        }
    });
</script>

<style>
.ck-editor__editable {
    min-height: 400px;
}
.ck-editor__editable_inline {
    border: 1px solid #dee2e6;
    border-radius: 0.375rem;
}
.ck-editor__editable_inline:focus {
    border-color: #86b7fe;
    box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
}
</style> 