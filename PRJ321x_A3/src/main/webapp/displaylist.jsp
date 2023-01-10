<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="content container" style="margin-top: 190px">
	<div class="row">
		<!-- Product list to display -->
		<div class="item-list col-md-12">
			<div
				class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
				<c:choose>
					<c:when test="${empty sessionScope.list}">
						<p class="text-wrap fs-4 mx-auto">
							<i class="fa-brands fa-product-hunt me-2 text-danger"></i>No
							product found
						</p>
					</c:when>
					<c:otherwise>
						<c:forEach var="product" items="${sessionScope.list}">
							<div class="item col">
								<div class="card h-100 pt-3" style="max-width: 18rem;">
									<img src="${product.src}" alt="${product.name} image">
									<div class="card-body">
										<h5 class="card-title text-uppercase text-muted">${product.type}</h5>
										<h6 class="card-subtitle mb-2">${product.name}</h6>
										<p class="card-text fw-bold text-danger">$${product.price}</p>
										<a
											href="${pageContext.request.contextPath}/home?action=showproduct&productid=${product.id}"
											class="stretched-link"></a>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="Page-navigation mt-4">
			<nav>
				<ul class="pagination justify-content-center">
					<c:choose>
						<c:when test="${sessionScope.index == 1}">
							<li class="page-item disabled"><a class="page-link" href="#"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/${sessionScope.pageDisplay}?index=${sessionScope.index - 1}
								&txtSearch=${sessionScope.txtSearch}&category=${sessionScope.category}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="i" begin="1" end="${sessionScope.endPage}">
						<li id="${i}" class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/${sessionScope.pageDisplay}?index=${i}&txtSearch=${sessionScope.txtSearch}
							&category=${sessionScope.category}">${i}</a></li>
					</c:forEach>

					<c:choose>
						<c:when
							test="${sessionScope.index == sessionScope.endPage || sessionScope.endPage == 0}">
							<li class="page-item disabled"><a class="page-link" href="#"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/${sessionScope.pageDisplay}?index=${sessionScope.index + 1}
								&txtSearch=${sessionScope.txtSearch}&category=${sessionScope.category}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		</div>

	</div>
</div>