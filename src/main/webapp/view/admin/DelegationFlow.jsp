<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
  
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>DELEGATION FLOW LIST</title>


<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />


 <spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" /> 


<style type="text/css">
label{
  font-weight: bold;
  font-size: 13px;
}

.panel-body .badge{
    padding: 7px 15px;
    font-family: Muli,sans-serif;
        margin: 1% 0%;
}

.card-header{

	font-weight: bold;
	text-transform: uppercase;
	font-size: 20px;
}

.card-accent-info{
	    border-top: 2px solid #0063a7!important;
}

.card{
	margin-bottom: 15px;
} 

h6 {
		color: black;
		font-family: 'Lato', sans-serif;
		font-weight: 800;
	}
	
	.card-header {
		background-color: #07689f;
		color: white;
	}
	
	.card {
		border: 1px solid black;
	}
	
	.input-group-text {
		font-weight: bold;
	}
	
	label {
		font-weight: 800;
		font-size: 16px;
		color: #07689f;
		padding-top: 10px;
		padding-bottom:-5px;
		padding-right: -50px;
	}
	
	hr {
		margin-top: -2px;
		margin-bottom: 12px;
	}
	
	.form-group {
		margin-top: 0.5rem;
		margin-bottom: 1rem;
	}
	
	.mandatory {
		font-weight: 800;
	}
	
	b{
	font-family: 'Lato', sans-serif;
	}
	
	.form-block form{
		display: inline-block;
	}
	
	.fa-input {
  	font-family: FontAwesome, 'Lato', sans-serif;
		}
		td {
    padding-top: 5px;
    padding-bottom: 5px;
}

body{
	overflow-x: hidden; 
}

</style>
</head>
<body>


<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

%>


<div class="container">
	<div class="row" style="">
		<div class="col-md-12 ">
				
				<div class="card shadow-nohover" >
					
					<div class="card-header">
						 <div class="row" >
							<div class="col-md-8 ">
							  <h4 style="text-transform: capitalize;"> Delegation Flow for Project Initiation  </h4>
							 </div>
						 </div>
					 </div>
					 
					 <div class="card-body">					 
			   		
      					 <div class="panel-body">
      					 	<span style="font-size: 18px;font-family: 'Muli',sans-serif;"><b>Up to 10 Lakhs &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>

					 		   <span class="badge " style="background-color: #527318 ; color: white">DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>

					 		   <span class="badge " style="background-color: #93329e ; color: white">AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #394989; color: white">Director </span>
					 		</p>       
						</div>
      					
      					<hr><br>

						<div class="panel-body">
      					 	<span style="font-size: 18px;font-family: 'Muli',sans-serif;"><b>10 Lakhs to 5 Crores &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #527318 ; color: white">DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #93329e ; color: white">AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">TCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge" style="background-color: #84142d; color: white">CCM </span>
					 		</p>       
						</div>						
							     
						<hr><br>

						<div class="panel-body">
      					 	<span style="font-size: 18px;font-family: 'Muli',sans-serif;"><b>5 Crores and Above &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #527318 ; color: white">DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #93329e ; color: white">AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">TCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge" style="background-color: #84142d; color: white">CCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge " style="background-color: #0c3c78; color: white">DMC </span>
					 		</p>       
						</div>	
						
						<hr><br>

						<div class="panel-body">
      					 	<span style="font-size: 18px;font-family: 'Muli',sans-serif;"><b>5 Crores and Above &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #527318 ; color: white">DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #93329e ; color: white">AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">TCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge" style="background-color: #84142d; color: white">CCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge " style="background-color: #6a492b ; color: white">PRC</span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge " style="background-color: #0c3c78; color: white">DMC </span>
					 		</p>       
						</div>     
						
					</div>
					 
				 </div><!-- card end -->
				 
		</div>
	</div>	
			
		<div class="row" style="">
			<div class="col-md-12 ">		 
				 
				 <div class="card shadow-nohover" >
					
					<div class="card-header">
						 <div class="row" >
							<div class="col-md-8 ">
							  <h4 style="text-transform: capitalize;"> Delegation Flow for Project Approval  </h4>
							 </div>
						 </div>
					 </div>
					 
					 <div class="card-body">					 
			   			     
						<!-- <h5 style="color:#07689f">Project Approval </h5>
						<hr><br> -->				
					 	
					 	
					 	<div class="panel-body">
					 		<span style="font-size: 18px;font-family: 'Muli',sans-serif;"><b>Up to 10 Lakhs &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #527318 ; color: white">DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #93329e ; color: white">AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #394989; color: white">Director </span>
					 		 </p>       
						</div>
						
						<hr><br>
						
						<div class="panel-body">
							<span style="font-size: 18px;font-family: 'Muli',sans-serif;"><b>10 Lakhs to 10 Crores &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #527318 ; color: white">DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #93329e ; color: white">AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">PDR </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info" style="background-color: #e7d9ea ; color: black" >CEC </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge " style="background-color: #F96302; color: white">IFA </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class="badge " style="background-color: #394989; color: white">Director </span>
					 	   </p>       
						</div>
						
						<hr><br>
						
						<div class="panel-body">
							 <span style="font-size: 18px;font-family: 'Muli',sans-serif;"><b>10 Crores to 75 Crores &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
							
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>

					 		   <span class="badge " style="background-color: #527318 ; color: white">DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>


					 		   <span class="badge " style="background-color: #93329e ; color: white">AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #394989; color: white">Director </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">PDR </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info" style="background-color: #e7d9ea ; color: black" >CEC </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge " style="background-color: #F96302; color: white">IFA </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b> 
					 		   <span class=" badge " style="background-color: #206a5d; color: white">Director General </span><b> </b>
					 		   </p>       
						</div>
						
						<hr><br>
						
						<div class="panel-body">
							<span style="font-size: 18px;font-family: 'Muli',sans-serif;"><b>75 Crores to 300 Crores &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
						
					 		<p>
					 		    <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #527318 ; color: white">DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #93329e ; color: white">AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge " style="background-color: #394989; color: white">Director </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">PDR </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info" style="background-color: #e7d9ea ; color: black" >CEC </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge " style="background-color: #F96302; color: white">IFA </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b> 
					 		   <span class=" badge " style="background-color: #206a5d; color: white">Director General </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class=" badge " style="background-color: #0c3c78; color: white">DP & C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class=" badge " style="background-color: #c6ebc9; color: black">DG (R&M) </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class=" badge " style="background-color: #95389e; color: white">JSA </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class=" badge " style="background-color: #206a5d; color: white">SECY </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge " style="background-color: #65d6ce; color: black">UNDER SECY </span>
					 		</p>       
					</div>
						

					</div>
					 
				 </div>

			</div>
		</div>	
	</div>









<script type="text/javascript">



function Edit(myfrm){
	
	 var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
function Delete(myfrm){
	

	var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
	  var cnf=confirm("Are You Sure to Delete !");
	  if(cnf){
	
	return true;
	
	}
	  else{
		  event.preventDefault();
			return false;
			}
	
	}


</script>
</body>
</html>