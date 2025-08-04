<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">메인 배너 수정</h4>
                </div>
                <div class="card-body">
                    <form action="/admin/main_banner/edit/${mainBanner.uid}" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="imgName">배너 이름</label>
                                    <input type="text" class="form-control" id="imgName" name="imgName" value="${mainBanner.imgName}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="url">링크 주소</label>
                                    <input type="url" class="form-control" id="url" name="url" value="${mainBanner.url}" placeholder="https://example.com">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="file">배너 이미지</label>
                                    <input type="file" class="form-control" id="file" name="file" accept="image/*">
                                    <small class="form-text text-muted">새 이미지를 선택하지 않으면 기존 이미지가 유지됩니다. 적정크기 424*214 (jpg, jpeg, png, gif)</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>현재 이미지</label>
                                    <div>
                                        <img src="/uploads/main_banner/${mainBanner.img}" alt="${mainBanner.imgName}" style="max-width: 200px; max-height: 150px;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">수정</button>
                                <a href="/admin/main_banner/list" class="btn btn-secondary">취소</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div> 