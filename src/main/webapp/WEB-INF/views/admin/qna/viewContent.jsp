<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="newLine" value="\n" />

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-eye me-2"></i>문의 상세보기</h2>
        <p>티켓 문의의 상세 내용을 확인하고 답변을 관리합니다.</p>
    </div>
    
    <!-- 알림 메시지 -->
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
    
    <!-- 문의 내용 -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">
                    <i class="fas fa-question-circle me-2"></i>${qna.title}
                    <c:if test="${qna.notice == 'Y'}">
                        <span class="badge bg-warning text-dark ms-2">
                            <i class="fas fa-bullhorn me-1"></i>공지사항
                        </span>
                    </c:if>
                </h5>
                <div class="btn-group">
                    <a href="/admin/qna/edit/${qna.uid}" class="btn btn-light btn-sm">
                        <i class="fas fa-edit me-1"></i>수정
                    </a>
                    <button type="button" class="btn btn-light btn-sm" onclick="deleteQna(${qna.uid}, '${qna.title}')">
                        <i class="fas fa-trash me-1"></i>삭제
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <strong><i class="fas fa-user me-1"></i>작성자:</strong> ${qna.name}
                </div>
                <div class="col-md-6 text-md-end">
                    <strong><i class="fas fa-calendar me-1"></i>등록일:</strong> 
                    <c:choose>
                        <c:when test="${qna.regdate != null}">
                            <fmt:formatDate value="${qna.regdate}" pattern="yyyy-MM-dd"/>
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted">등록일 없음</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <strong><i class="fas fa-bullhorn me-1"></i>공지사항:</strong>
                    <c:choose>
                        <c:when test="${qna.notice == 'Y'}">
                            <span class="badge bg-warning text-dark">
                                <i class="fas fa-bullhorn me-1"></i>공지사항
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary">일반</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <hr>
            <div class="content-area">
                <c:set var="formattedContent" value="${fn:replace(qna.content, '\\n', '<br>')}" />
                <c:set var="formattedContent" value="${fn:replace(formattedContent, '\\r\\n', '<br>')}" />
                <c:set var="formattedContent" value="${fn:replace(formattedContent, '\\r', '<br>')}" />
                ${formattedContent}
            </div>
        </div>
    </div>
    
    <!-- 답변 목록 -->
    <div class="card mb-4">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0">
                <i class="fas fa-reply me-2"></i>답변 목록 (${replies.size()}개)
            </h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty replies}">
                    <div class="text-center py-4">
                        <i class="fas fa-comments fa-2x text-muted mb-2"></i>
                        <p class="text-muted">아직 답변이 없습니다.</p>
                        <button type="button" class="btn btn-primary" onclick="showReplyForm()">
                            <i class="fas fa-plus me-1"></i>첫 번째 답변 작성하기
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="reply" items="${replies}" varStatus="status">
                        <div class="reply-item border-start border-success ps-3 mb-3">
                            <div class="d-flex justify-content-between align-items-start">
                                <div class="flex-grow-1">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fas fa-reply text-success me-2"></i>
                                        <strong>${reply.name}</strong>
                                        <span class="text-muted ms-2">
                                            <c:choose>
                                                <c:when test="${reply.regdate != null}">
                                                    <fmt:formatDate value="${reply.regdate}" pattern="yyyy-MM-dd"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">등록일 없음</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="reply-content">
                                        <c:set var="formattedReplyContent" value="${fn:replace(reply.content, '\\n', '<br>')}" />
                                        <c:set var="formattedReplyContent" value="${fn:replace(formattedReplyContent, '\\r\\n', '<br>')}" />
                                        <c:set var="formattedReplyContent" value="${fn:replace(formattedReplyContent, '\\r', '<br>')}" />
                                        ${formattedReplyContent}
                                    </div>
                                </div>
                                <div class="ms-3">
                                    <button type="button" class="btn btn-outline-danger btn-sm" 
                                            onclick="deleteReply(${reply.uid}, ${qna.uid}, '${reply.name}')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- 답변 추가 버튼 -->
                    <div class="text-center mt-3">
                        <button type="button" class="btn btn-success" onclick="showReplyForm()">
                            <i class="fas fa-plus me-1"></i>추가 답변 작성하기
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- 답변 작성 폼 -->
    <div class="card" id="replyFormCard" style="display: none;">
        <div class="card-header bg-info text-white">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">
                    <i class="fas fa-plus me-2"></i>답변 작성
                </h5>
                <button type="button" class="btn btn-sm btn-light" onclick="hideReplyForm()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
        <div class="card-body">
            <form method="POST" action="/admin/qna/reply/${qna.uid}" id="replyForm">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="replyName" class="form-label">
                            <i class="fas fa-user me-1"></i>답변자
                        </label>
                        <input type="text" class="form-control" id="replyName" name="name" 
                               placeholder="답변자명을 입력하세요" value="관리자" required>
                    </div>
                    <div class="col-12 mb-3">
                        <label for="replyContent" class="form-label">
                            <i class="fas fa-comment me-1"></i>답변 내용
                        </label>
                        <textarea class="form-control" id="replyContent" name="content" rows="8" 
                                  placeholder="답변 내용을 입력하세요" required></textarea>
                        <div class="text-muted mt-1">답변 내용을 입력하세요. (이미지 업로드 가능)</div>
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <button type="button" class="btn btn-secondary" onclick="hideReplyForm()">
                        <i class="fas fa-times me-1"></i>취소
                    </button>
                    <button type="submit" class="btn btn-info">
                        <i class="fas fa-paper-plane me-1"></i>답변 등록
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 하단 버튼 -->
    <div class="d-flex justify-content-between mt-4">
        <a href="/admin/qna/list" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-1"></i>목록으로 돌아가기
        </a>
        <div>
            <a href="/admin/qna/edit/${qna.uid}" class="btn btn-warning me-2">
                <i class="fas fa-edit me-1"></i>문의 수정
            </a>
            <button type="button" class="btn btn-danger" onclick="deleteQna(${qna.uid}, '${qna.title}')">
                <i class="fas fa-trash me-1"></i>문의 삭제
            </button>
        </div>
    </div>
</div>

<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">삭제 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>정말로 "<span id="deleteTitle"></span>"을(를) 삭제하시겠습니까?</p>
                <p class="text-danger"><small>삭제된 내용은 복구할 수 없습니다.</small></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <form method="POST" id="deleteForm" style="display: inline;">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- CKEditor 스타일 -->
<style>
    .ck-editor__editable {
        min-height: 200px;
    }
    
    .content-area img {
        max-width: 100%;
        height: auto;
    }
    
    .reply-content img {
        max-width: 100%;
        height: auto;
    }
</style>

<!-- CKEditor 스크립트 -->
<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>
<script>
    let replyEditor;
    
    function showReplyForm() {
        document.getElementById('replyFormCard').style.display = 'block';
        
        // CKEditor 초기화 (이미 초기화되었으면 스킵)
        if (!replyEditor) {
            ClassicEditor
                .create(document.querySelector('#replyContent'), {
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
                    placeholder: '답변 내용을 입력하세요...'
                })
                .then(editor => {
                    replyEditor = editor;
                    console.log('답변용 CKEditor가 성공적으로 로드되었습니다.');
                    
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
                    console.error('답변용 CKEditor 로드 중 오류가 발생했습니다:', error);
                });
        }
        
        // 포커스 설정
        document.getElementById('replyName').focus();
        
        // 스크롤을 답변 폼으로 이동
        document.getElementById('replyFormCard').scrollIntoView({ behavior: 'smooth' });
    }
    
    function hideReplyForm() {
        document.getElementById('replyFormCard').style.display = 'none';
        
        // 폼 초기화
        document.getElementById('replyForm').reset();
        if (replyEditor) {
            replyEditor.setData('');
        }
    }
    
    function deleteQna(uid, title) {
        document.getElementById('deleteTitle').textContent = title;
        document.getElementById('deleteForm').action = '/admin/qna/delete/' + uid;
        
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }
    
    function deleteReply(uid, parentId, name) {
        if (confirm('정말로 "' + name + '"의 답변을 삭제하시겠습니까?')) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '/admin/qna/reply/delete/' + uid;
            
            var parentIdInput = document.createElement('input');
            parentIdInput.type = 'hidden';
            parentIdInput.name = 'parentId';
            parentIdInput.value = parentId;
            
            form.appendChild(parentIdInput);
            document.body.appendChild(form);
            form.submit();
        }
    }
    
    // 답변 폼 제출 이벤트
    document.getElementById('replyForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        var name = document.getElementById('replyName').value.trim();
        
        if (!name) {
            alert('답변자명을 입력해주세요.');
            document.getElementById('replyName').focus();
            return false;
        }
        
        // CKEditor 내용을 textarea에 설정
        if (replyEditor) {
            var content = replyEditor.getData();
            document.getElementById('replyContent').value = content;
            
            if (!content.trim()) {
                alert('답변 내용을 입력해주세요.');
                return false;
            }
        }
        
        // 폼 제출
        this.submit();
    });
</script> 