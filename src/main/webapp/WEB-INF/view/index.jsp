<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Demo</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width" />
<base href="/" />
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"></script>
</head>
<body ng-app="app" ng-controller="home as home">
	<h1>Login</h1>
	<div class="container" ng-show="!home.authenticated">
		<div>
			With Facebook: <a href="/login/facebook">click here</a>
		</div>
		<div>
			With Github: <a href="/login/github">click here</a>
		</div>
	</div>
	<div class="container" ng-show="home.authenticated">
		Logged in as: <span ng-bind="home.user"></span>
		<div>
			<button ng-click="home.logout()" class="btn btn-primary">Logout</button>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.4.0/angular.min.js"></script>

	<script type="text/javascript">
		angular
				.module("app", [])
				.config(
						function($httpProvider) {
							$httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
						}).controller("home", function($http, $location) {
					var self = this;
					$http.get("/user").success(function(data) {
						if (data.name) {
							self.user = data.name;
							self.authenticated = true;
						} else {
							self.user = "N/A";
							self.authenticated = false;
						}
					}).error(function() {
						self.user = "N/A";
						self.authenticated = false;
					});
					self.logout = function() {
						$http.post('logout', {}).success(function() {
							self.authenticated = false;
							$location.path("/bitbox/home");
						}).error(function(data) {
							console.log("Logout failed")
							self.authenticated = false;
						});
					};
				});
	</script>
</body>
</html>