<%@page import="com.vts.pfms.model.LabMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
<title>PMS Login</title>

<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/LoginPage.css" var="loginPageCss" />
<link href="${loginPageCss}" rel="stylesheet" />

<style>

.fa-file-text{
	color:rgba(255,222,0,1);
}

.scroll {
    max-height: 390px;
    overflow-y: auto;
}

.scrollpolicy{
 	/* max-height: 515px; */
    overflow-y: auto !important;
}
</style>


</head>

<body class="home" >

<!--  Login Page  -->  
  
<section class="loginpage">
  


<%if(request.getAttribute("version").equals("yes")){ %>
 <!-- Button trigger modal -->
<button type="button"  class="btn btn-primary" style="display:none;" data-toggle="modal" data-target="#staticBackdrop" id = "versionerror">
</button>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered  modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <font color="red"><h5 class="modal-title "  id="staticBackdropLabel">Version Mismatch</h5></font>
      </div>
      <div class="modal-body center" ><b>
      <p id="version"></p>
        </b>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-primary" data-dismiss="modal">Still want to continue</button>
      </div>
    </div>
  </div>
</div>
<script>
document.getElementById("versionerror").click();
const paragraphElement = document.getElementById("version");
const originalText = paragraphElement.textContent; // Store original text for backup

// Choose the new word:
const replacementWord = "<%= request.getAttribute("browser")%>";

paragraphElement.innerHTML="<b>Your current Browser version is not supported.<br><br>Please ensure optimal viewing by using Internet Explorer (I.E) or Microsoft Edge 110+,<br> Mozilla 110+, or Google Chrome 110+.</b><br><br><b>Site Best viewed at a resolution of 1360 x 768.</b><br><br><b style=\"color: green;\">Thank You!</b>"
console.log("browser name: "+replacementWord);
console.log(replacementWord+" version: "+"<%= request.getAttribute("versionint") %>");
</script>
  <%} %>
  
  
	<header id="header" class="clearfix">
 
	
  		<div class="btmhead clearfix">
    		<div class="widget-guide clearfix">
      			<div class="header-right clearfix">
        			<div class="float-element">
        				<a class="" href="" target="_blank">
        					<img  class ="drdologo" src="view/images/drdologo.png"alt="">
        				</a>
        			</div>
      			</div>
     			<div class="logo">
     				<a href="#" title="PMS"><span class="c"  style="margin-top: 2% !important;font-size: 113% !important;">PROJECT MANAGEMENT SYSTEM  (VER 1.6)</span></a>
     			</div>
     		
     			
    		</div>

  		</div>
  		
  		
  				<ul class="nav nav-tabs justify-content-end ">
					  <li class="nav-item"  onclick="$('#footer').show();">
						 <a class="nav-link active" data-toggle="tab" href="#tab-1" role="tab" ><i class="fa fa-home" aria-hidden="true"></i>&nbsp;Home</a>
					  </li> 
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
 </section> 
<div class="tab-content">

<!-- -----------------------------------Home--------------------------------------------- -->
<div class="tab-pane active " id="tab-1" role="tabpanel" style=" max-height: 360px; ">
<!-- Login Page Content -->

 <div class="container" style="margin-top: 20px; ">
		<div class="row">
			<div class="col-md-12">
			
				<div class="login-container justify-content-center">
					<div class="row align-item-center">
						
						<div class="col-md-6">
							<div >
								
								<div>
									<p class="quote">Lets simplify project management</p>
								 	<h4 style="font-family: 'Lato', sans-serif;font-weight: 400" >Analytics  &nbsp;|&nbsp;  Insights  &nbsp;|&nbsp;  Empowerment</h4>
								</div>
								
								<div class="product-banner-container" style="margin-top:35px">
									<img class="img-fluid img-responsive" src="view/images/bg4.jpg" style="">
								</div>
								
							</div>
						</div>
						
						
						<div class="col-md-6">
					
							<div class="row justify-content-end login-main-container" style="margin-left:7rem;margin-top: 4rem" >
	
								<div class="col-md-12">
								
									<div align="center"><h5 style="color:maroon;font-family: 'Lato', sans-serif;display: block;" class="welcome">Welcome !</h5></div> 
									
									<div class="login-form-wrapper " style="padding-right: 43px;padding-left: 43px; padding-bottom: 43px; padding-top: 8px " >
										
										<div class="login-info-container">
											<h4 style="font-family: 'Lato', sans-serif;font-weight: 800" >Login</h4><br>
										</div>
										
										<div class="login-form-container">
										
											   <form action="${contextPath}/login" autocomplete="off" method="post" >
											   
									
												<div class="form-row">
													
													<div class="form-group col-12 position-relative ${error != null ? 'has-error' : ''}">
														<input type="text" name="username" placeholder="Username" class="form-control" required>
														<i class="fa fa-user fa-lg position-absolute"></i>
													</div>
													
													<div class="form-group col-12 position-relative">
														<input name="password" type="password" placeholder="Password"  class="form-control">
														<i class="fa fa-lock fa-lg position-absolute"></i>	
													</div>
														
													<%-- <span style="font-family: 'Lato', sans-serif;font-size: 15px;color:red;margin-bottom: 10px;" id="error-alert">${error}</span>
													<span style="font-family: 'Lato', sans-serif;font-size: 15px;color:green;margin-bottom: 10px;" id="success-alert">${success}</span> --%>
													
															<span style="font-family: 'Lato', sans-serif;font-size: 15px;color:red;margin-bottom: 10px;" id="success-alert">${error}</span>
																		
												</div>
												
											
												
												<div class="form-submit">
													<div class="row align-items-center mb-5">
														<div class="col-md-5">
															<div class="form-submit-button">
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																<button type="submit" class="btn btn-block btn-success" style="font-family: 'Montserrat', sans-serif;" >Login</button>
																<!-- <button type="submit" class="btn btn-link" formaction="fpwd/ForgotPassword.htm" > Forgot Password?</button> -->
															</div>
														</div>
													</div>
													
													
												</div>
												
												
											</form>
											
										</div>
										
										<div class="credentials-info-container" style="margin-top: -35px;margin-bottom: -6px">
											<div class="row">
												<div class="col-md-12">
													
													<div class="info-container text-md-left">
														<p class="text-secondary" style="font-family: 'Lato', sans-serif;font-size: 15px;">* Do not share credentials with anyone</p>
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
	
	<div class="credentials-info-container" style="margin-top: 50px;margin-bottom: -6px">
    	<%
        	boolean expstatus = (boolean)request.getAttribute("expstatus");
       		if(!expstatus) {%>
				<marquee  class="news-scroll" behavior="scroll" direction="left" scrollamount="7" onmouseover="this.stop();" onmouseout="this.start();" style="color: red;font-weight: bold;">Your License has been Expired..!</marquee>
		<%} %>
	</div>
	
	</div>

</div>	

   <div id="footer">
	<footer class="footer"  >
	
		<section id="fontSize" class="clearfix" style="font-size: 100%;margin-bottom: -1%;">
		  <section id="page" class="body-wrapper clearfix" style="">
		    	<!-- Blue Border for Login Page -->  
		    <div class="support-row clearfix" id="swapper-border" style="">
		      <div class="marquee-container" onmouseover="stopMarquee()" onmouseout="startMarquee()">
<!--         <marquee behavior="scroll" direction="left" scrollamount="10" id="marquee">
            <p style="font-size: 20px; color: white; line-height: 1.5em;">SMS Abbreviation  :  PMS SMS will be sent every morning at 7:20 AM, 
            AI - P  : ActionItem Pending,  AI - D : ActionItem Delay, AI - T : ActionItem Today, 
            MS - P : MileStone Actions Pending, MS - D : MileStone Actions Delay, MS - T : MileStone Actions Today, 
            MT - P : Meeting Actions Pending, MT - D : Meeting Actions Delay, MT - T : Meeting Actions Today </p>
        </marquee> -->
    </div>
		      	<div class="widget-guide clearfix">
		        </div>
		    </div> 
		    	
		  </section>  
		</section>
		<div class="widget-guide clearfix">
       		<div class="footr-rt">
            	<div class="copyright-content"> 
            		<p>Website maintained by Vedant Tech Solutions<br><b>Site best viewed at 1360 x 768 resolution in I.E / Microsoft Edge 110+, Mozilla 110+, Google Chrome 110+</b>	</p> 
            	</div>
    		</div>
  		</div>
	</footer>
	</div> 
</body>

<script type="text/javascript">
$("#success-alert") .fadeTo(3000, 1000).slideUp(1000, function ( ) {
    $("#success-alert").slideUp(1000);
});

$("#error-alert") .fadeTo(3000, 1000).slideUp(1000, function ( ) {
    $("#error-alert").slideUp(1000);
});

</script>

<script>
    $(document).ready(function() {
        setInterval(function() {
            var docHeight = $(window).height();
            var footerHeight = $('#footer').height();
            var footerTop = $('#footer').position().top + footerHeight;
            var marginTop = (docHeight - footerTop + 10);

            $('.scrollpolicy').css('max-height', docHeight-155+ 'px' )
            
            if (footerTop < docHeight)
                $('#footer').css('margin-top', marginTop + 'px'); // padding of 30 on footer
            else
                $('#footer').css('margin-top', '0px');
            // console.log("docheight: " + docHeight + "\n" + "footerheight: " + footerHeight + "\n" + "footertop: " + footerTop + "\n" + "new docheight: " + $(window).height() + "\n" + "margintop: " + marginTop);
        }, 250);
    }); 
</script>
<% if( request.getAttribute("version").equals("no")){%>
<script>
const replacementWord = "<%= request.getAttribute("browser")%>";
console.log("browser name: "+replacementWord);
console.log(replacementWord+" version: "+"<%= request.getAttribute("versionint") %>");
</script>
<%}%>
<script type="text/javascript">

$("#myTable1,#myTable2,#myTable3").DataTable({
    "lengthMenu": [10,20, 50, 75, 100],
    "pagingType": "simple",
    "language": {
	      "emptyTable": "No Record Found"
	    }

});

</script>
<script>
        var marquee = document.getElementById('marquee');

        function stopMarquee() {
            marquee.stop();
        }

        function startMarquee() {
            marquee.start();
        }
    </script>
</html>