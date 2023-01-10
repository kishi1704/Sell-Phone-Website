<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css">
<title>Welcome to my Website | Register</title>
</head>
<body>
	<section class="vh-100">
		<div class="container vh-100">
			<div
				class="row d-flex justify-content-center align-items-center vh-100">
				<div class="card border-0 p-0 mx-auto bg-primary-cus shadow"
					style="max-width: 720px">
					<div class="row g-0 align-items-center text-center">
						<div class="col-md-6 bg-white py-2 px-3">
							<h1 class="text-center text-dark fw-bolder">Register</h1>
							<!-- Login form -->
							<form class="needs-validation"
								action="${pageContext.request.contextPath}/login" method="post">
								
								<input type="hidden" name="action" value="doregister">
								<!-- account role - user -->
								<input type="hidden" name="accountrole" value="1">
								
								<!-- Input user's full name-->
								<div class="mb-3">
									<input type="text" class="form-control" id="fullname"
										placeholder="Enter your full name" value="${sessionScope.fullnameR}"
										name="fullname">
								</div>
								
								<!-- Input user's address-->
								<div class="mb-3">
									<input type="text" class="form-control" id="address"
										placeholder="Enter your address" value="${sessionScope.addressR}"
										name="address">
								</div>
								
								<!-- Input user's phone-->
								<div class="mb-3">
									<input type="text" class="form-control" id="phone"
										placeholder="Enter your phone number" value="${sessionScope.phoneR}"
										name="phone">
								</div>
								
								<!-- Input email to be username-->
								<div class="mb-3 mt-3">
									<input type="text" class="form-control" id="username"
										placeholder="Enter your email"
										value="${sessionScope.usernameR}" name="username">
								</div>
								
								<!-- Input password-->
								<div class="mb-3">
									<input type="password" class="form-control" id="password"
										placeholder="Enter password" value="${sessionScope.passwordR}"
										name="password">
								</div>
								
								<!-- Repeat password-->
								<div class="mb-3">
									<input type="password" class="form-control" id="rppassword"
										placeholder="Repeat password" value="${sessionScope.passwordR}"
										name="rppassword">
								</div>
								
								<!-- Submit-->
								<div class="d-grid mx-auto mt-3">
									<button type="submit" class="btn btn-primary rounded-pill px-5"
										id="btn-submit" value="register">REGISTER</button>
									<!-- Display error when register fail -->
									<p class="text-danger text-center m-0">${sessionScope.errorR}</p>
								</div>
								
							</form>
							<div class="other-choice mt-3 text-center">
								<p class="mb-1">
									Have an user account? <a href="${pageContext.request.contextPath}/login?action=login"
										class="text-decoration-none link-primary">Login here</a>
								</p>
								<p>
									or <a href="${pageContext.request.contextPath}/home"
										class="text-decoration-none link-primary">Back to home</a>
								</p>
							</div>
						</div>
						<div class="col-md-6 text-white">
							<h3 class="fw-bolder lh-lg">Welcome to my Website</h3>
							<p class="lead fs-6 fw-normal lh-1">
								To connected with us<br>please register with your personal
								info
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>