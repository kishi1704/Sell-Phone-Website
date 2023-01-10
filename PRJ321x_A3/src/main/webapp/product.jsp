<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="header.jsp">
	<c:param name="title"
		value="Product | ${sessionScope.productInfo.name}"></c:param>
</c:import>

<div class="content container" style="margin-top: 190px">
	<div>
		<h4 class="m-0 position-relative w-20">
			<i class="fa-solid fa-arrow-left-long me-2"></i>Back <a
				href="${pageContext.request.contextPath}/${sessionScope.pageDisplay}?index=${sessionScope.index}
			&txtSearch=${sessionScope.txtSearch}&category=${sessionScope.category}"
				class="stretched-link"></a>
		</h4>
		<hr>
	</div>
	<div class="product card mx-auto my-5 border-0">
		<div class="row align-items-center g-0">
			<div class="col-md-4">
				<img src="${sessionScope.productInfo.src}"
					alt="${sessionScope.productInfo.name} image"
					class="img-fluid rounded-start">
			</div>
			<div class="col-md-8">
				<div class="card-body">
					<h3 class="product-name text-dark card-title fw-bolder">${sessionScope.productInfo.name}</h3>
					<h4 class="price text-danger card-title fw-semibold">$${sessionScope.productInfo.price}</h4>
					<p class="product-des card-text fs-6 fw-semibold text-muted">${sessionScope.productInfo.description}</p>
					<c:choose>
						<c:when test="${sessionScope.productInfo.number < 1}">
							<a href="${pageContext.request.contextPath}/cart"
								class="btn btn-warning disabled" aria-disabled="true">Add to
								cart</a>
							<p class="product-des text-danger text-center fs-4 m-0">Out
								of order</p>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/cart"
								class="btn btn-warning">Add to cart</a>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
		</div>
	</div>

</div>
<c:import url="footer.jsp">
</c:import>
<script src="${pageContext.request.contextPath}/js/all.js"></script>
<script>
	document.getElementById('${sessionScope.currentPage}').classList
			.add('active');
</script>
</body>
</html>