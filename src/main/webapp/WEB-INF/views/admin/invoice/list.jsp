<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="확정목록 관리" />
    <jsp:param name="activeMenu" value="invoice" />
    <jsp:param name="contentPage" value="/WEB-INF/views/admin/invoice/listContent.jsp" />
</jsp:include> 