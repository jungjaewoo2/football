<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="일정표 수정" />
    <jsp:param name="activeMenu" value="schedule_info" />
    <jsp:param name="contentPage" value="/WEB-INF/views/admin/schedule_info/editContent.jsp" />
</jsp:include> 