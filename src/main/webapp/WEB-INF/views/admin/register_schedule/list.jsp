<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Spring Security 사용 시 CSRF 토큰 추가 -->
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="예약목록 관리" />
    <jsp:param name="activeMenu" value="register_schedule" />
    <jsp:param name="contentPage" value="/WEB-INF/views/admin/register_schedule/listContent.jsp" />
</jsp:include>