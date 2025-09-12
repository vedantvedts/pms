<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
  
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>DELEGATION FLOW LIST</title>


<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />


 <spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" /> 

<spring:url value="/resources/css/admin/DelegationFlow.css" var="delegationFlow" />
<link href="${delegationFlow}" rel="stylesheet" />


</head>
<body>


<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

%>


<div class="container">
	<div class="row" >
		<div class="col-md-12 ">
				
				<div class="card shadow-nohover" >
					
					<div class="card-header">
						 <div class="row" >
							<div class="col-md-8 ">
							  <h4 class="text-uppercase"> Delegation Flow for Project Initiation  </h4>
							 </div>
						 </div>
					 </div>
					 
					 <div class="card-body">					 
			   		
      					 <div class="panel-body">
      					 	<span class="f-title"><b>Up to 10 Lakhs &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>

					 		   <span class="badge do-pdc" >DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>

					 		   <span class="badge ad" >AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge director" >Director </span>
					 		</p>       
						</div>
      					
      					<hr><br>

						<div class="panel-body">
      					 	<span class="f-title"><b>10 Lakhs to 5 Crores &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge do-pdc" >DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ad" >AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">TCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ccm" >CCM </span>
					 		</p>       
						</div>						
							     
						<hr><br>

						<div class="panel-body">
      					 	<span class="f-title"><b>5 Crores and Above &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge do-pdc" >DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ad" >AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">TCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ccm" >CCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge dmc" >DMC </span>
					 		</p>       
						</div>	
						
						<hr><br>

						<div class="panel-body">
      					 	<span class="f-title"><b>5 Crores and Above &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge do-pdc" >DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ad" >AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">TCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ccm" >CCM </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge prc" >PRC</span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge  dmc" >DMC </span>
					 		</p>       
						</div>     
						
					</div>
					 
				 </div><!-- card end -->
				 
		</div>
	</div>	
			
		<div class="row" >
			<div class="col-md-12 ">		 
				 
				 <div class="card shadow-nohover" >
					
					<div class="card-header">
						 <div class="row" >
							<div class="col-md-8 ">
							  <h4 class="text-uppercase" > Delegation Flow for Project Approval  </h4>
							 </div>
						 </div>
					 </div>
					 
					 <div class="card-body">					 
					 	
					 	
					 	<div class="panel-body">
					 		<span class="f-title"><b>Up to 10 Lakhs &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge do-pdc" >DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ad" >AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge director" >Director </span>
					 		 </p>       
						</div>
						
						<hr><br>
						
						<div class="panel-body">
							<span class="f-title"><b>10 Lakhs to 10 Crores &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge do-pdc" >DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ad" >AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">PDR </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge cec"  >CEC </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge ifa" >IFA </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class="badge director" >Director </span>
					 	   </p>       
						</div>
						
						<hr><br>
						
						<div class="panel-body">
							 <span class="f-title"><b>10 Crores to 75 Crores &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
							
					 		<p>
					 		   <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>

					 		   <span class="badge do-pdc" >DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>


					 		   <span class="badge ad" >AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge director" >Director </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">PDR </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge cec"  >CEC </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge ifa" >IFA </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b> 
					 		   <span class=" badge director-general" >Director General </span><b> </b>
					 		   </p>       
						</div>
						
						<hr><br>
						
						<div class="panel-body">
							<span class="f-title"><b>75 Crores to 300 Crores &nbsp;&nbsp;&nbsp;&nbsp;</b> </span>
						
					 		<p>
					 		    <span class="badge badge-primary">User </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></i></b>
					 		   <span class="badge badge-warning">DO </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge do-pdc" >DO-P&C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge ad" >AD </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge director" >Director </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge badge-info">PDR </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class="badge cec"  >CEC </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge ifa" >IFA </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b> 
					 		   <span class=" badge director-general" >Director General </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class=" badge dp-c" >DP & C </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class=" badge dg" >DG (R&M) </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class=" badge jsa" >JSA </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i> </b>
					 		   <span class=" badge secy" >SECY </span><b> <i class="fa fa-long-arrow-right" aria-hidden="true"></i></b>
					 		   <span class=" badge under-secy" >UNDER SECY </span>
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