<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="header.jsp">
	<c:param name="title" value="Home | Welcome to my Website"></c:param>
</c:import>

<c:import url="displaylist.jsp">
</c:import>
<c:import url="footer.jsp">
</c:import>
<script>
	document.getElementById('${sessionScope.index}').classList.add('active');
	document.getElementById('${sessionScope.currentPage}').classList
			.add('active');
</script>
<script src="${pageContext.request.contextPath}/js/all.js"></script>
</body>
</html>