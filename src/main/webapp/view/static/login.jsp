<%@page import="com.vts.pfms.model.LabMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<!DOCTYPE html>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>PMS Login</title>

<jsp:include page="../static/dependancy.jsp"></jsp:include>


<spring:url value="/resources/css/base.css" var="BaseCss" />
<link href="${BaseCss}" rel="stylesheet" />

<spring:url value="/resources/css/baseresponsive.css" var="BaseresponsiveCss" />
<link href="${BaseresponsiveCss}" rel="stylesheet" />

 <spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" /> 


<style>

.fa-file-text{
	color:rgba(255,222,0,1);
}





</style>


</head>

<body class="home" >


<!--  Login Page  -->  
  
<section  id="swapper-other" class="loginpage">
  
	<header id="header" class="clearfix">
 
	
  		<div class="btmhead clearfix">
    		<div class="widget-guide clearfix">
      			<div class="header-right clearfix">
        			<div class="float-element">
        				<a class="" href="" target="_blank">
        					<img  class ="drdologo" src="view/images/drdologo.png" alt=""></a>
        			</div>
      			</div>
     			<div class="logo">
     				<a href="#" title="PMS"><span class="title"  style="margin-top: 2% !important;font-size: 113% !important;">PROJECT MANAGEMENT SYSTEM</span></a>
     			</div>
     		
     			
    		</div>

  		</div>
  		
  		
  		<ul class="nav nav-tabs justify-content-end ">
					  <li class="nav-item">
					    <a class="nav-link active" href="#"><i class="fa fa-home" aria-hidden="true"></i>&nbsp;Home</a>
					  </li> 
			<!-- 		  <li class="nav-item">
					    <a class="nav-link" href="LoginPage/MmForms2020.htm" target="_blank" ><i class="fa fa-file-text" aria-hidden="true"></i>&nbsp; MM-2020</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" href="LoginPage/DelegationOfPower.htm" target="_blank"  ><i class="fa fa-file-text" aria-hidden="true"></i>&nbsp; DFP-2019</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" href="LoginPage/PurchaseMangementDoc.htm" target="_blank" ><i class="fa fa-file-text" aria-hidden="true"></i>&nbsp; PM-2016</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" href="LoginPage/PurchaseMangementDoc2020.htm" target="_blank" ><i class="fa fa-file-text" aria-hidden="true"></i>&nbsp; PM-2020</a>
					  </li> -->
					  <li class="nav-item">
					    <a class="nav-link" href="LoginPage/PPFMDoc2016.htm" target="_blank" ><i class="fa fa-file-text" aria-hidden="true"></i>&nbsp; PPFM-2016</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" href="LoginPage/DPFMDoc2021.htm" target="_blank" ><i class="fa fa-file-text" aria-hidden="true"></i>&nbsp; DPFM-2021</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" href="LoginPage/DPFMDoc2021Handbook.htm" target="_blank" ><i class="fa fa-file-text" aria-hidden="true"></i>&nbsp; DPFM Handbook-2021</a>
					  </li>
		</ul>
				
  		
	</header>


<!-- Login Page Content -->

 <div class="container" style="margin-top: 20px; ">
		<div class="row">
			<div class="col-md-12">
			
				<div class="login-container justify-content-center">
					<div class="row align-item-center">
						
						<div class="col-md-6">
							<div class="login-banner-wrapper">
								
								<div class="product-info-container">
									<p class="quote">Lets simplify project management</p>
									
	
								 <h3 style="font-family: 'Lato', sans-serif;font-weight: 400" >Analytics  &nbsp;|&nbsp;  Insights  &nbsp;|&nbsp;  Empowerment</h3>
									
									
								</div>
								
								<div class="product-banner-container" style="margin-top:35px">
									<img class="img-fluid " src="view/images/bg4.jpg" style="">
								</div>
								
							</div>
						</div>
						
						
						<div class="col-md-6">
							<div class="row justify-content-end" style="margin-left:7rem;margin-top: 4rem" >
	
								<div class="col-md-12">
								
									<center><h5 style="color:maroon;font-family: 'Lato', sans-serif;display: block;" class="welcome">Welcome !</h5></center> 
									
									<div class="login-form-wrapper " style="padding-right: 43px;padding-left: 43px; padding-bottom: 43px; padding-top: 8px " >
										
										<div class="login-info-container">
											<h3 style="font-family: 'Lato', sans-serif;font-weight: 800" >Login</h3><br>
										</div>
										
										<div class="login-form-container">
										
											   <form autocomplete="off" method="POST" action="${contextPath}/login" class="form-signin">
												
												
												<div class="form-row">
													
													<div class="form-group col-12 position-relative ${error != null ? 'has-error' : ''}">
														<input type="text" name="username" placeholder="Username" class="form-control" required>
														<i class="fa fa-user fa-lg position-absolute"></i>
													</div>
													
													<div class="form-group col-12 position-relative">
														<input name="password" type="password" placeholder="Password" required class="form-control">
														<i class="fa fa-lock fa-lg position-absolute"></i>	
													</div>
														
													<span style="font-family: 'Lato', sans-serif;font-size: 15px;color:red;margin-bottom: 10px;" id="success-alert">${error}</span>
																		
												</div>
												
											
												
												<div class="form-submit">
													<div class="row align-items-center mb-5">
														<div class="col-md-5">
															<div class="form-submit-button">
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																<button type="submit" class="btn btn-block btn-success" style="font-family: 'Montserrat', sans-serif;" >Login</button>
															</div>
														</div>
													</div>
												</div>
												
												
											</form>
											
										</div>
										
										<div class="credentials-info-container">
											<div class="row">
												<div class="col-md-12">
													<div class="info-container text-md-left">
														<p class="text-secondary" style="font-family: 'Lato', sans-serif;font-size: 15px;margin-top: -19px;margin-bottom: -6px">* Do not share credentials with anyone</p>
													</div>
												</div>
											</div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
				</div>
			
			</div>
			
		</div>
	</div>
 </section> 
  


<div class="wrapper" id="skipCont"></div>
<!--/#skipCont-->



<section id="fontSize" class="clearfix" style="font-size: 100%;">
  <section id="page" class="body-wrapper clearfix">
    	
 
<!-- Blue Border for Login Page -->  
    <div class="support-row clearfix" id="swapper-border" >
      		<div class="widget-guide clearfix">
                
              </div>
    	</div> 
    	
  </section>  <!--/#page--> 
  

</section> 


<!-- Footer -->

    <footer id="footer" class="clearfix">
  		<div class="widget-guide clearfix">
       		<div class="footr-rt">
            	<div class="copyright-content"> 
            		<p>Website owned &amp; maintained by Electronic And Radar Development Establishment, Government Of India<br>Site best viewed at 1360 x 768 resolution in I.E 11+, Mozilla 70+, Google Chrome 79+	</p> 
            	</div>
    		</div>
  	</div>
</footer>

    <!--/#footer-->
    
	    

</body>

<script type="text/javascript">

$
	("#success-alert")
					.fadeTo(
							2000, 
							1000)
								.slideUp(
											1000, function(
															){
    $("#success-alert").slideUp(1000);
});


</script>


</html>