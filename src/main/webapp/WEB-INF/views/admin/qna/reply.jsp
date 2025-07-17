<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contentPage" value="/WEB-INF/views/admin/qna/replyContent.jsp" />

<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="답변 등록" />
    <jsp:param name="activeMenu" value="qna" />
    <jsp:param name="contentPage" value="${contentPage}"/>
</jsp:include> 