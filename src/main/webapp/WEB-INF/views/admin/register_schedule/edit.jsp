<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="예약 수정" />
    <jsp:param name="activeMenu" value="register_schedule" />
    <jsp:param name="contentPage" value="/WEB-INF/views/admin/register_schedule/editContent.jsp" />
</jsp:include> 