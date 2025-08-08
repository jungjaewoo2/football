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
            <form action="/admin/gallery/register" method="post" id="galleryForm" enctype="multipart/form-data">
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
                    <label for="img" class="form-label">
                        <i class="fas fa-image me-1"></i>이미지 첨부
                    </label>
                    <input type="file" class="form-control" id="img" name="img" 
                           accept="image/*" onchange="previewImage(this)">
                    <div id="imagePreview" class="mt-2" style="display: none;">
                        <img id="preview" src="" alt="미리보기" style="max-width: 300px; max-height: 200px; border-radius: 5px;">
                    </div>
                    <small class="form-text text-muted">이미지 파일만 업로드 가능합니다. (JPG, PNG, GIF)</small>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">
                        <i class="fas fa-edit me-1"></i>내용
                    </label>
                    <textarea id="content" name="content" class="form-control" style="display: none;"
                              placeholder="관전후기 내용을 입력하세요. 이미지 첨부가 가능합니다.">${gallery.content}</textarea>
                    <div id="editor-container"></div>
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>
                        웹에디터를 통해 텍스트 서식과 이미지 첨부가 가능합니다. 이미지는 드래그 앤 드롭도 지원합니다.
                    </div>
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

                    fetch('/admin/upload/gallery/image', {
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

    // 이미지 미리보기 함수
    function previewImage(input) {
        const preview = document.getElementById('preview');
        const imagePreview = document.getElementById('imagePreview');
        
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                preview.src = e.target.result;
                imagePreview.style.display = 'block';
            }
            
            reader.readAsDataURL(input.files[0]);
        } else {
            imagePreview.style.display = 'none';
        }
    }

    // 폼 제출 처리
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('galleryForm').addEventListener('submit', function(e) {
            console.log('폼 제출 시작');
            
            const title = document.getElementById('title').value.trim();
            const name = document.getElementById('name').value.trim();
            
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
            
            if (editorInstance) {
                const content = editorInstance.getData();
                document.getElementById('content').value = content;
                
                if (!content || content.trim() === '' || content.trim() === '<p>&nbsp;</p>') {
                    e.preventDefault();
                    alert('내용을 입력해주세요.');
                    return false;
                }
            } else {
                const content = document.getElementById('content').value.trim();
                if (!content) {
                    e.preventDefault();
                    alert('내용을 입력해주세요.');
                    return false;
                }
            }
            
            console.log('폼 제출 진행');
            return true;
        });
    });
</script> 