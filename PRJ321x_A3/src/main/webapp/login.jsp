<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css">
<title>Welcome to my Website | Login</title>
</head>
<body>
	<section class="vh-100">
		<div class="container vh-100">
			<div
				class="row d-flex justify-content-center align-items-center vh-100">
				<div class="card border-0 p-0 mx-auto bg-primary-cus shadow"
					style="max-width: 720px">
					<div class="row g-0 align-items-center text-center">
						<div class="col-md-6 bg-white py-5 px-3">
							<h1 class="text-center text-dark fw-bolder">Sign in</h1>
							<!-- Login form -->
							<form class="needs-validation" action="${pageContext.request.contextPath}/login"
								method="post">
								<input type="hidden" name="action" value="dologin">
								<div class="mb-3 mt-3">
									<input type="text" class="form-control" id="username"
										placeholder="Enter your username"
										value="${sessionScope.username}" name="username">
								</div>
								<div class="mb-3">
									<input type="password" class="form-control" id="password"
										placeholder="Enter password" value="${sessionScope.password}"
										name="password">
								</div>
								<div class="d-flex justify-content-between align-items-center">
									<!-- Check box -->
									<div class="form-check mb-0">
										<input class="form-check-input me-2" type="checkbox"
											value="yes" id="rememberme" name="remember" /> <label
											class="form-check-label" for="remeberme"> Remember me
										</label>
									</div>
									<a href="#!" class="text-decoration-none link-primary">Forgot
										password?</a>
								</div>
								<div class="btn-group mt-3" role="group">
									<button type="submit"
										class="btn btn-primary rounded-pill px-4 me-5" id="btn-submit"
										value="user" name="logintype">USER</button>
									<button type="submit"
										class="btn btn-primary rounded-pill px-4 ms-5" id="btn-submit"
										value="admin" name="logintype">ADMIN</button>
								</div>
								<div class="display-error">
									<!-- Display error when login fail -->
									<p class="text-danger text-center m-0">${sessionScope.error}</p>
								</div>
							</form>
							<div class="other-choice mt-3 text-center">
								<p class="mb-1">
									Don't have an user account? <a href="${pageContext.request.contextPath}/login?action=register"
										class="text-decoration-none link-primary">Register here</a>
								</p>
								<p>
									or <a href="${pageContext.request.contextPath}/home"
										class="text-decoration-none link-primary">Back to home</a>
								</p>
							</div>
						</div>
						<div class="col-md-6 text-white">
							<h3 class="fw-bolder lh-lg">Welcome Back!</h3>
							<p class="lead fs-6 fw-normal lh-1">
								To keep connected with us<br>please login with your
								personal info
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>