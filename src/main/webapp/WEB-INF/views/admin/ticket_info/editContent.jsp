<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content-card">
    <div class="content-header">
        <h2><i class="fas fa-edit me-2"></i>티켓구매안내 수정</h2>
        <p>티켓구매안내 내용을 수정할 수 있습니다. 웹에디터를 통해 이미지 첨부가 가능합니다.</p>
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
                <i class="fas fa-ticket-alt me-2"></i>티켓구매안내 내용 수정
            </h5>
        </div>
        <div class="card-body">
            <form id="ticketInfoForm" method="post" action="/admin/ticket_info/edit">
                <div class="mb-3">
                    <label for="content" class="form-label">
                        <i class="fas fa-edit me-1"></i>티켓구매안내 내용
                    </label>
                    <textarea id="content" name="content" class="form-control" style="display: none;"
                              placeholder="티켓구매안내 내용을 입력하세요. 이미지 첨부가 가능합니다.">${ticketInfo.content}</textarea>
                    <div id="editor-container"></div>
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>
                        웹에디터를 통해 텍스트 서식과 이미지 첨부가 가능합니다. 이미지는 드래그 앤 드롭도 지원합니다.
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <a href="/admin/ticket_info" class="btn btn-secondary">
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

<!-- CKEditor 5 최신 버전 CDN -->
<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
<script>
    let editorInstance = null;

    // 커스텀 업로드 어댑터
    class MyUploadAdapter {
        constructor(loader) {
            this.loader = loader;
        }

        upload() {
            return this.loader.file.then(file => {
                return new Promise((resolve, reject) => {
                    const formData = new FormData();
                    formData.append('upload', file);

                    console.log('이미지 업로드 시작:', file.name);

                    fetch('/admin/upload/ticket_info/image', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => {
                        console.log('Response status:', response.status);
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(result => {
                        console.log('Upload result:', result);
                        if (result.uploaded) {
                            resolve({
                                default: result.url
                            });
                        } else {
                            reject(result.error ? result.error.message : '업로드 실패');
                        }
                    })
                    .catch(error => {
                        console.error('Upload error:', error);
                        reject('이미지 업로드 중 오류가 발생했습니다: ' + error.message);
                    });
                });
            });
        }

        abort() {
            // 업로드 중단 처리
        }
    }

    // 커스텀 업로드 어댑터 플러그인
    function MyCustomUploadAdapterPlugin(editor) {
        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
            return new MyUploadAdapter(loader);
        };
    }

    // CKEditor 초기화
    document.addEventListener('DOMContentLoaded', function() {
        const initialContent = document.getElementById('content').value || '';
        
        ClassicEditor
            .create(document.querySelector('#editor-container'), {
                extraPlugins: [MyCustomUploadAdapterPlugin],
                toolbar: {
                    items: [
                        'heading', '|',
                        'bold', 'italic', 'link', '|',
                        'bulletedList', 'numberedList', '|',
                        'outdent', 'indent', '|',
                        'blockQuote', 'insertTable', '|',
                        'uploadImage', '|',
                        'undo', 'redo'
                    ]
                },
                language: 'ko',
                image: {
                    toolbar: [
                        'imageStyle:alignLeft',
                        'imageStyle:alignCenter',
                        'imageStyle:alignRight',
                        '|',
                        'linkImage'
                    ],
                    styles: {
                        options: [
                            'inline',
                            'block',
                            'side',
                            'alignLeft',
                            'alignCenter',
                            'alignRight'
                        ]
                    },
                    upload: {
                        types: ['jpeg', 'png', 'gif', 'bmp', 'webp', 'jpg']
                    }
                },
                table: {
                    contentToolbar: [
                        'tableColumn',
                        'tableRow',
                        'mergeTableCells'
                    ]
                },
                htmlSupport: {
                    allow: [
                        {
                            name: 'figure',
                            classes: /^image.*/
                        },
                        {
                            name: 'img',
                            attributes: true,
                            classes: true,
                            styles: true
                        }
                    ]
                }
            })
            .then(editor => {
                editorInstance = editor;
                
                if (initialContent) {
                    editor.setData(initialContent);
                }
                
                console.log('CKEditor 초기화 성공');
                
                editor.model.document.on('change:data', () => {
                    const content = editor.getData();
                    document.getElementById('content').value = content;
                    console.log('Editor content updated:', content.length + ' characters');
                });

                editor.plugins.get('FileRepository').on('uploadAdapter', (evt, data) => {
                    console.log('Upload adapter event:', data);
                });
            })
            .catch(error => {
                console.error('CKEditor 초기화 실패:', error);
            });
    });

    // 폼 제출 처리
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('ticketInfoForm').addEventListener('submit', function(e) {
            console.log('폼 제출 시작');
            
            if (editorInstance) {
                const content = editorInstance.getData();
                document.getElementById('content').value = content;
                
                if (!content || content.trim() === '' || content.trim() === '<p>&nbsp;</p>') {
                    e.preventDefault();
                    alert('티켓구매안내 내용을 입력해주세요.');
                    return false;
                }
            } else {
                const content = document.getElementById('content').value.trim();
                if (!content) {
                    e.preventDefault();
                    alert('티켓구매안내 내용을 입력해주세요.');
                    return false;
                }
            }
            
            console.log('폼 제출 진행');
            return true;
        });
    });
</script>

<!-- CKEditor 스타일 -->
<style>
/* 에디터 기본 스타일 */
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

/* CKEditor 5 이미지 정렬 스타일 - 에디터 내부용 */
.ck-content .image {
    display: table;
    clear: both;
    text-align: center;
    margin: 0.9em auto;
    min-width: 50px;
}

.ck-content .image img {
    display: block;
    margin: 0 auto;
    max-width: 100%;
    min-width: 100%;
}

.ck-content .image-inline {
    display: inline-block;
    max-width: 100%;
    margin: 0 0.5em;
}

.ck-content .image-side {
    float: right;
    margin-left: 1.5em;
    max-width: 50%;
}

.ck-content .image.image-style-align-left,
.ck-content .image-style-align-left {
    float: left;
    margin-right: 1.5em;
}

.ck-content .image.image-style-align-right,
.ck-content .image-style-align-right {
    float: right;
    margin-left: 1.5em;
}

.ck-content .image.image-style-align-center,
.ck-content .image-style-align-center {
    margin-left: auto;
    margin-right: auto;
}

.ck-content .image.image-style-block,
.ck-content .image-style-block {
    margin-left: auto;
    margin-right: auto;
}

.ck-content p + .image.image-style-align-left,
.ck-content p + .image.image-style-align-right {
    margin-top: 0;
}

.ck-content .image-inline.image-style-align-left,
.ck-content .image-inline.image-style-align-right {
    margin-top: 0;
    margin-bottom: 0;
}
</style>

<!-- 저장된 콘텐츠를 표시할 때 적용될 스타일 (뷰 페이지용) -->
<style>
/* 저장된 콘텐츠 표시용 스타일 - 실제 화면에 표시될 때 사용 */
.ticket-info-content .image,
.content-display .image {
    display: table;
    clear: both;
    text-align: center;
    margin: 0.9em auto;
    min-width: 50px;
}

.ticket-info-content .image img,
.content-display .image img {
    display: block;
    margin: 0 auto;
    max-width: 100%;
    min-width: 100%;
}

.ticket-info-content .image-inline,
.content-display .image-inline {
    display: inline-block;
    max-width: 100%;
    margin: 0 0.5em;
}

.ticket-info-content .image-side,
.content-display .image-side {
    float: right;
    margin-left: 1.5em;
    max-width: 50%;
}

.ticket-info-content .image.image-style-align-left,
.ticket-info-content .image-style-align-left,
.content-display .image.image-style-align-left,
.content-display .image-style-align-left {
    float: left;
    margin-right: 1.5em;
    margin-left: 0;
    text-align: left;
}

.ticket-info-content .image.image-style-align-right,
.ticket-info-content .image-style-align-right,
.content-display .image.image-style-align-right,
.content-display .image-style-align-right {
    float: right;
    margin-left: 1.5em;
    margin-right: 0;
    text-align: right;
}

.ticket-info-content .image.image-style-align-center,
.ticket-info-content .image-style-align-center,
.content-display .image.image-style-align-center,
.content-display .image-style-align-center {
    margin-left: auto;
    margin-right: auto;
    text-align: center;
    float: none;
    display: table;
}

.ticket-info-content .image.image-style-block,
.ticket-info-content .image-style-block,
.content-display .image.image-style-block,
.content-display .image-style-block {
    margin-left: auto;
    margin-right: auto;
    text-align: center;
}

/* figure 요소에 대한 스타일 */
.ticket-info-content figure.image,
.content-display figure.image {
    display: table;
}

.ticket-info-content figure.image img,
.content-display figure.image img {
    display: block;
}

.ticket-info-content figure.image.image-style-align-left,
.content-display figure.image.image-style-align-left {
    float: left;
    margin: 0 1.5em 1em 0;
}

.ticket-info-content figure.image.image-style-align-right,
.content-display figure.image.image-style-align-right {
    float: right;
    margin: 0 0 1em 1.5em;
}

.ticket-info-content figure.image.image-style-align-center,
.content-display figure.image.image-style-align-center {
    display: table;
    margin: 1em auto;
}

/* 이미지 캡션 스타일 */
.ticket-info-content figcaption,
.content-display figcaption {
    display: table-caption;
    caption-side: bottom;
    padding: 0.6em;
    font-size: 0.9em;
    text-align: center;
    color: #666;
}

/* clearfix for floating elements */
.ticket-info-content::after,
.content-display::after {
    content: "";
    display: table;
    clear: both;
}
</style> 