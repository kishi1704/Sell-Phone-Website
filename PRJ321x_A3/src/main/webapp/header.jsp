<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tag"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css">
<title>${param.title}</title>
</head>
<body>
	<div class="header-nav fixed-top">
		<div
			class="container-fluid d-flex align-items-center py-4 bg-primary-cus">
			<div class="header-text w-25">
				<h1 class="text-white m-0 fs-2 lh-1">PRJ321x</h1>
				<p class="lead text-primary m-0 fs-6">Welcome to my Website</p>
			</div>
			<div class="search-bar w-75">
				<form action="${pageContext.request.contextPath}/search"
					method="get">
					<div class="input-group">
						<select class="form-select bg-grey-cus w-10" name="category"
							aria-label="select category">
							<option value="all" <tag:selected value="all"/>>All
								categories</option>
							<option value="apple" <tag:selected value="apple"/>>Apple</option>
							<option value="samsung" <tag:selected value="samsung"/>>Samsung</option>
							<option value="huawei" <tag:selected value="huawei"/>>Huawei</option>
							<option value="oppo" <tag:selected value="oppo"/>>Oppo</option>
						</select> <input class="form-control w-60" type="search" name="txtSearch"
							value="${txtSearch}" placeholder="What are you looking for?"
							aria-label="Search">
						<button class="btn btn-warning" type="submit" value="search">Search</button>
					</div>
				</form>
			</div>
		</div>
		<!-- Top navigation bar -->
		<div class="topnav">
			<nav class="navbar navbar-cus navbar-expand-sm bg-secondary-cus">
				<div class="container-fluid">
					<div class="collapse navbar-collapse" id="navbarScroll">
						<ul class="navbar-nav navbar-nav-scroll">
							<li class="nav-item me-4"><a id="home-page" class="nav-link"
								aria-current="page"
								href="${pageContext.request.contextPath}/home">Home</a></li>
							<li class="nav-item me-4"><a id="products-page"
								class="nav-link" aria-current="page" href="#">Products</a></li>
							<li class="nav-item me-4"><a id="about-page"
								class="nav-link" aria-current="page" href="#">About us</a></li>
						</ul>
						<ul class="navbar-nav navbar-nav-scroll ms-auto">
							<c:choose>
								<c:when test="${empty sessionScope.user}">
									<li class="nav-item me-4"><a class="nav-link"
										aria-current="page"
										href="${pageContext.request.contextPath}/home?action=login">Login</a></li>
									<li class="nav-item me-4"><a class="nav-link"
										aria-current="page"
										href="${pageContext.request.contextPath}/home?action=register">Register</a></li>
								</c:when>
								<c:when test="${!empty sessionScope.user}">
									<li class="nav-item me-4"><a class="nav-link"
										aria-current="page" href="#"><i
											class="fa-solid fa-user me-2"></i>${sessionScope.user.name}</a></li>
									<li class="nav-item me-4"><a id="cart-page"
										class="nav-link" aria-current="page"
										href="${pageContext.request.contextPath}/cart?action=showcart"><i
											class="fa-solid fa-cart-shopping"></i>Cart</a></li>
									<li class="nav-item me-4"><a class="nav-link"
										aria-current="page"
										href="${pageContext.request.contextPath}/logout"><i
											class="fa-solid fa-right-from-bracket"></i>Logout</a></li>
								</c:when>
							</c:choose>
						</ul>
					</div>
				</div>
			</nav>
		</div>
	</div>