<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="메인 이미지 관리" />
    <jsp:param name="activeMenu" value="main_img" />
    <jsp:param name="contentPage" value="/WEB-INF/views/admin/main_img/listContent.jsp" />
</jsp:include> 