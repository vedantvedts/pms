<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>OnBoarding</title>
<style type="text/css">
.btn-primary-1:hover
{
    animation: swing 1s ease;
    animation-iteration-count: 1;
}
.btn-primary-1{
	border-radius: 3px !important;
	  font-family:'Montserrat', sans-serif !important; 
	letter-spacing: 0px !important;
	font-size: 18px !important;
	padding: 4px 0px !important;
	border-bottom: 4px solid #0f53db;
	font-weight: bold;
	color:black;
	background: #D3CCE3;  /* fallback for old browsers */
	background: -webkit-linear-gradient(to right, #E9E4F0, #D3CCE3);  /* Chrome 10-25, Safari 5.1-6 */
	background: linear-gradient(to right, #E9E4F0, #D3CCE3); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

}
.btn-primary-2{
	border-radius: 3px !important;
	
	  font-family:'Montserrat', sans-serif !important;
	letter-spacing: 0px !important;
	font-size: 18px !important;
	padding: 4px 0px !important;
	border-bottom: 4px solid #17a2b8;
	font-weight: bold;
	color:black;
	background: #D3CCE3;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #E9E4F0, #D3CCE3);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #E9E4F0, #D3CCE3); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

	
}
i{
	font-style: normal !important;
}

@keyframes swing {
    
    30% {
        -webkit-transform: translateY(-5px);
        transform: translateY(-5px);
    }
    50% {
        -webkit-transform: translateY(3px);
        transform: translateY(3px);
    }
    65% {
        -webkit-transform: translateY(-3px);
        transform: translateY(-3px);
    }
    80% {
        -webkit-transform: translateY(2px);
        transform: translateY(2px);
    }
    100% {
        -webkit-transform: translateY(0);
        transform: translateY(0);
    }
}
</style>
</head>
<body>


<div class="container-fluid" >
		<div class="row" >
			<div class="col-md-12" >
				<div class="card shadow-nohover" style="height: 400%;">
				<div class="row">
					<div class="col-md-12">
						<div class="row card-header">
				   			<div class="col-md-12">
								<h4> OnBoarding </h4>
							</div>
						 </div>
					</div>
				</div>
				<div class="row" style=" padding-left: 10px;margin-top: 10px; padding-right: 10px;" align="center">
						<div class="col-md-3">
								<a class="btn shadow-nohover  btn-primary-1 btn-block btn-sm" href="GroupMaster.htm?Onboarding=Yes" style="text-align: left">
									<span class="fa-stack" style="width:3em !important">
									<span class="fa fa-square-o fa-stack-2x"></span>
				   					<strong class="fa-stack-1x" style="font-size: 14px">1</strong></span>
									<i>Group Master </i>
								</a>
						</div>
						<div class="col-md-3">
								<a class="btn shadow-nohover  btn-primary-2 btn-block btn-sm" href="DivisionMaster.htm?Onboarding=Yes" style="text-align: left">
									<span class="fa-stack" style="width:3em !important">
									<span class="fa fa-square-o fa-stack-2x"></span>
				   					<strong class="fa-stack-1x" style="font-size: 14px">2</strong></span>
									<i >Division Master </i>
								</a>
						</div>
						<div class="col-md-3">
								<a class="btn shadow-nohover  btn-primary-1 btn-block btn-sm" href="Officer.htm?Onboarding=Yes" style="text-align: left">
									<span class="fa-stack" style="width:3em !important">
									<span class="fa fa-square-o fa-stack-2x"></span>
				   					<strong class="fa-stack-1x" style="font-size: 14px">3</strong></span>
									<i >Officer Master </i>
								</a>
						</div>
						<div class="col-md-3">
								<a class="btn shadow-nohover  btn-primary-2 btn-block btn-sm" href="ProjectMain.htm?Onboarding=Yes" style="text-align: left">
									<span class="fa-stack" style="width:3em !important">
									<span class="fa fa-square-o fa-stack-2x"></span>
				   					<strong class="fa-stack-1x" style="font-size: 14px">4</strong></span>
									<i >Project Main</i>
								</a>
						</div>
				</div>
				<div class="row" style=" padding-left: 10px;margin-top: 10px; padding-right: 10px;" align="center">
						<div class="col-md-3">
								<a class="btn shadow-nohover  btn-primary-1 btn-block btn-sm" href="ActionLaunch.htm?Onboarding=Yes" style="text-align: left">
									<span class="fa-stack" style="width:3em !important">
									<span class="fa fa-square-o fa-stack-2x"></span>
				   					<strong class="fa-stack-1x" style="font-size: 14px">5</strong></span>
									<i>Action Items</i>
								</a>
						</div>
						
						<div class="col-md-3">
								<a class="btn shadow-nohover  btn-primary-2 btn-block btn-sm" href="UserManagerList.htm?Onboarding=Yes" style="text-align: left">
									<span class="fa-stack" style="width:3em !important">
									<span class="fa fa-square-o fa-stack-2x"></span>
				   					<strong class="fa-stack-1x" style="font-size: 14px">6</strong></span>
									<i>Login List</i>
								</a>
						</div>
					</div>

				</div>
			</div>
		</div>
</div>
</body>
</html>