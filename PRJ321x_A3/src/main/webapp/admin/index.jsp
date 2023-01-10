<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<title>Dashboard | 1849 TEAM</title>
</head>
<body>
	<div class="container-fluid m-0 p-0">
		<div class="sidebar fixed-left vh-100">
			<div class="list-group list-group-flush px-2">
				<h6 class="text-warning text-center p-3 border-bottom border-dark"><i class="fa-solid fa-people-group pe-1"></i>1849
					TEAM</h6>
				<a href="#" class="list-group-item list-group-item-action active"
					aria-current="true"><i class="fa-solid fa-table-cells-large pe-1"></i>Dashboard</a> <a href="#"
					class="list-group-item list-group-item-action"><i class="fa-solid fa-user pe-1"></i>Staff Manager</a>
			</div>
		</div>
		<div class="content px-0 vh-100 bg-primary-cus" style="margin-left:12rem">
			<nav class="navbar sticky-top bg-secondary-cus">
				<div class="container-fluid">
					<span class="navbar-brand text-warning">Welcome ${sessionScope.name}!</span>
					<ul class="navbar-nav ms-auto">
						<li class="nav-item me-4"><a class="nav-link"
							aria-current="page" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-user pe-1"></i>Logout</a></li>
					</ul>
				</div>
			</nav>
			<div class="banner">
				<img src="${pageContext.request.contextPath}/images/banner.png" height="405" class="img-fluid"
					alt="Banner image">
			</div>
			<div class="staff-members">
				<div class="table-title bg-title-cus py-2">
					<h5 class="text-center text-white m-0">Member of the team</h5>
				</div>
				<table class="table table-hover mb-0">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Name</th>
							<th scope="col">Member ID</th>
							<th scope="col">Role</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td>Mark</td>
							<td>1613553</td>
							<td>Developer</td>
						</tr>
						<tr>
							<th scope="row">2</th>
							<td>Jacob</td>
							<td>1613554</td>
							<td>Tester</td>
						</tr>
						<tr>
							<th scope="row">3</th>
							<td>Jacob</td>
							<td>1613554</td>
							<td>Tester</td>
						</tr>
						<tr>
							<th scope="row">4</th>
							<td>Jacob</td>
							<td>1613554</td>
							<td>Tester</td>
						</tr>
						<tr>
							<th scope="row">5</th>
							<td>Jacob</td>
							<td>1613554</td>
							<td>Tester</td>
						</tr>
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script src="../js/all.js"></script>
</body>
</html>