<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="약관 수정" />
    <jsp:param name="activeMenu" value="tsc" />
    <jsp:param name="contentPage" value="/WEB-INF/views/admin/tsc/editContent.jsp" />
</jsp:include> 