<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="header.jsp">
	<c:param name="title" value="Cart | Show cart"></c:param>
</c:import>
<div class="content container py-5 h-100" style="margin-top: 120px">
	<div class="row d-flex justify-content-center align-items-center h-100">
		<div class="col">
			<div class="card border-0">
				<div class="card-body p-4">

					<div class="row">
						<div class="col-lg-7">
							<h5 class="mb-3">
								<a
									href="${pageContext.request.contextPath}/${sessionScope.pageDisplay}?index=${sessionScope.index}&txtSearch=${sessionScope.txtSearch}&category=${sessionScope.category}"
									class="text-body text-decoration-none"><i
									class="fas fa-long-arrow-alt-left me-2"></i>Continue shopping</a>
							</h5>
							<hr>
							<div id="product-list">
								<c:choose>
									<c:when test="${empty sessionScope.cart.getItems()}">
										<p class="text-wrap fs-4">
											<i class="fa-solid fa-cart-plus text-danger"></i>No product
											in cart
										</p>
									</c:when>
									<c:when test="${!empty sessionScope.cart.getItems()}">
										<c:forEach var="product"
											items="${sessionScope.cart.getItems()}">
											<div class="card mb-3">
												<div class="card-body">
													<div class="d-flex justify-content-between">
														<div class="d-flex flex-row align-items-center">
															<div>
																<img src="${product.src}" class="img-fluid rounded-3"
																	alt="Shopping item" style="width: 65px;">
															</div>
															<div class="ms-3">
																<h5>${product.nameProduct}</h5>
															</div>
														</div>

														<div class="d-flex flex-row align-items-center">
															<div class="me-3" style="width: 50px;">
																<input type="number" min="1" name="productamount"
																	oninput="changeAmount(this, ${product.productId}, ${product.priceProduct})"
																	value="${product.amountProduct}"
																	class="form-control text-center">
															</div>
															<div style="width: 80px;">
																<fieldset disabled>
																	<input type="text" id="total-${product.productId}"
																		class="form-control bg-white border-0"
																		value="$${product.getTotalPriceProduct()}">
																</fieldset>
															</div>
															<button type="button"
																onclick="deleteProduct(this,${product.productId})"
																class="btn text-danger">
																<i class="fas fa-trash-alt"></i>
															</button>
														</div>

													</div>
												</div>
											</div>
										</c:forEach>
									</c:when>
								</c:choose>
							</div>
						</div>
						<div class="col-lg-5">

							<div class="card text-dark rounded-3">
								<div class="card-body">
									<form action="">
										<div class="mb-2">
											<label for="customer-name" class="form-label fw-semibold">Customer
												name</label> <input type="text" class="form-control"
												name="customername" value="${sessionScope.user.name}"
												id="customer-name">
										</div>

										<div class="mb-2">
											<label for="customer-address" class="form-label fw-semibold">Customer
												address</label> <input type="text" class="form-control"
												name="customeraddress"
												value="${sessionScope.orders.address}" id="customer-address">
										</div>

										<div class="mb-2">
											<label for="customer-phone" class="form-label fw-semibold">Customer
												phone number</label> <input type="text" class="form-control"
												name="customerphone"
												value="${sessionScope.orders.phoneNumber}"
												id="customer-phone">
										</div>

										<hr class="my-4">
										<fieldset disabled>

											<div class="row mb-3">
												<label for="total" class="col-sm-6 col-form-label">Total</label>
												<div class="col-sm-6">
													<input type="text"
														class="form-control bg-white border-0 text-end pe-0"
														id="total" value="$${sessionScope.cart.getPrice()}">
												</div>
											</div>

										</fieldset>
										<button type="submit" class="btn btn-warning">
											<div class="d-flex justify-content-between">
												<span>Checkout <i
													class="fas fa-long-arrow-alt-right ms-2"></i></span>
											</div>
										</button>
									</form>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<c:import url="footer.jsp">
</c:import>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/all.js"></script>
<script>
	$("#${sessionScope.currentPage}").addClass('active');

	// change amount of product
	function changeAmount(ip, productId, productPrice) {
		if ($(ip).val() < 1) {
			$(ip).val("1");
		}

		$("#total-" + productId).val("$" + productPrice * $(ip).val());

		$.ajax({
			url : "${pageContext.request.contextPath}/cart",
			type : "get", //send it through get method
			data : {
				action : "changeamount",
				productId : productId,
				productAmount : $(ip).val()
			},
			success : function(data) {
				$("#total").val("$" + data);
			},
			error : function(xhr) {
				//Do Something to handle error
			}
		});
	}
	
	// get product out of cart function
	function deleteProduct(delBtn, productId) {
		if(confirm("Are you want to delete this product?")) {
			$(delBtn).closest('.card').addClass('d-none');
			
			$.ajax({
				url : "${pageContext.request.contextPath}/cart",
				type : "get", //send it through get method
				data : {
					action : "removeproduct",
					productId : productId
				},
				success : function(data) {
					$("#total").val("$" + data);
					if(parseInt(data) == 0) {
						$("#product-list").empty();
						$("#product-list").append( '<p class="text-wrap fs-4"><i class="fa-solid fa-cart-plus text-danger"></i>No product in cart</p>');
					}
				},
				error : function(xhr) {
					//Do Something to handle error
				}
			});
		}
	}
</script>
</body>
</html>