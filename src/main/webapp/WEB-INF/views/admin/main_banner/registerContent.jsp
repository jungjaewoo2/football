<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">메인 배너 등록</h4>
                </div>
                <div class="card-body">
                    <form action="/admin/main_banner/register" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="imgName">배너 이름</label>
                                    <input type="text" class="form-control" id="imgName" name="imgName" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="url">링크 주소</label>
                                    <input type="url" class="form-control" id="url" name="url" placeholder="https://example.com">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="file">배너 이미지</label>
                                    <input type="file" class="form-control" id="file" name="file" accept="image/*" required>
                                    <small class="form-text text-muted">권장 크기: 300x200px 이하</small>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">등록</button>
                                <a href="/admin/main_banner/list" class="btn btn-secondary">취소</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div> 