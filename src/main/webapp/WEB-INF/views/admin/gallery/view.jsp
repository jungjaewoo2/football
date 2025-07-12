<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="관전후기 상세보기" />
    <jsp:param name="activeMenu" value="gallery" />
    <jsp:param name="contentPage" value="/WEB-INF/views/admin/gallery/viewContent.jsp" />
</jsp:include> 