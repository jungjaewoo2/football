<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/adminLayout.jsp">
    <jsp:param name="pageTitle" value="일정표 관리" />
    <jsp:param name="activeMenu" value="schedule_info" />
    <jsp:param name="contentPage" value="/WEB-INF/views/admin/schedule_info/listContent.jsp" />
</jsp:include> 