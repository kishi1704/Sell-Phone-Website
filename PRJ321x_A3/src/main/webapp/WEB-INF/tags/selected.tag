<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ attribute name="value" required="true" description="value of option" type="java.lang.String" rtexprvalue="true" %>
<c:if test="${sessionScope.category == value}">selected</c:if>