<%@page import="javax.persistence.criteria.CriteriaBuilder.In"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>



	<title>EDIT EXPERT</title>
	<style type="text/css">
		.input-group-text {
			font-weight: bold;
		}

		label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}

		hr {
			margin-top: -2px;
			margin-bottom: 12px;
		}

		.card b {
			font-size: 20px;
		}
		
		input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    /* display: none; <- Crashes Chrome on hover */
    -webkit-appearance: none;
    margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
}

input[type=number] {
    -moz-appearance:textfield; /* Firefox */
}
		
	</style>
</head>

<body>


<%String id=(String)request.getAttribute("id"); 

List<Object[]> desigList=(List<Object[]>)request.getAttribute("Designation");
List<Object[]> details=(List<Object[]>)request.getAttribute("EditDetails");

Object[] detail=null;

if(details!=null){
	detail=details.get(0);
}
%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>

    <br />
    
    
	<div class="container">

		<div class="row">

			<div class="col-md-12">

				<div class="card shadow-nohover">
					<div class="card-header"
						style=" background-color: #055C9D;margin-top: ">

						<h3 class="text-white">Edit Expert</h3>

					</div>
					<form action="ExpertEditSubmit.htm" method="post" name="addcommitteefrm" id="addcommitteefrm" onsubmit="return confirm('Are you sure to submit ?');" >
					
						<div class="card-body">
							<div class="row">							
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Expert No.</label>
										<input class="form-control" id="ExpertNo" type="text" readonly="readonly"  value="<%=detail[1]%>" name="expertno" required maxlength="50">
									</div>
								</div>
							
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Expert Name</label>
										<input class="form-control" type="text" value="<%=detail[2]%>" name="expertname" required>
									</div>
								</div>
							<%-- 	<%int i = Integer.parseInt((detail[4].toString()).replaceAll(" ", "")); %> --%>
								<%-- <div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Extension No.</label>
										<input class="form-control" type="number" id="extensionNo" value="<%=detail[4]%>" name="extensionnumber" max="9999" min="1000">
									</div>
								</div> --%>
								

							
							<div class="col-md-4">
								<div class="form-group">
									<label class="control-label">Designation</label>
									<select class="custom-select" id="selectDesig" required="required" name="designationId">
										<option disabled="true"  selected value="">Choose...</option>
										<%for(Object[] desig:desigList){ %>
										<option  value="<%=desig[0]%>" <%if(detail[3].equals(desig[0])){ %> selected="selected" <%} %>><%=desig[2]%></option>
										<%}%>
									
									</select>
								</div>
							</div>
						
						
						</div>
						
						<div class="row">
						
							<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Mobile No.</label>
										<input class="form-control" type="number" id="mobile" value="<%=detail[5]%>" name="mobilenumber" required  max="9999999999" min="1000000000">
									</div>
								</div>
								
							
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Email</label>
										<input class="form-control" type="email" value="<%=detail[6]%>" name="email" required>
									</div>
								</div>

							
					     	<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Organization</label>
										<input class="form-control" type="text" value="<%=detail[7]%>" name="organization" required>
									</div>
								</div>
						</div>	
						
					</div>
					<div class="row" ><div class="col-md-5"></div><div class="col-md-3">
								<input type="hidden" id="expId" name="expertId" value="<%=detail[0] %>" >
								<div class="form-group">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT" onclick="checkExpert()">SUBMIT</button>
							<a class="btn btn-primary btn-sm back" href="Expert.htm" >BACK</a>
							
						</div>
					</div></div>
					
				</form>
			
			
					</div>
					<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ">
					</div>
				</div>
			</div>
		</div>
		<div class="modal" id="loader">
			<!-- Place at bottom of page -->
		</div>

	
<script type='text/javascript'> 
$(document).ready(function() {
    $('#selectDesig').select2();
});
</script>	
<script>
$("#mobile").blur(function(){
	
	 var phoneno = /^\d{10}$/;
	 var inputtxt=document.getElementById("mobile").value;
	
	 if (/^\d{10}$/.test(inputtxt)) {
		   
		} else {
		    alert("Invalid number; must be ten digits");
		    mobile.focus();
		    return false;
		}	  
	});

</script>


<script type="text/javascript">

function checkExpert()
{
	 if(confitm('Are You Sure to submit ?')){
		 $("#addcommitteefrm").submit();
     } 
	 
}

/* 
function checkExpert(){
	event.preventDefault();
	var expId= document.getElementById("expId").value;
	var extensionNo = document.getElementById("extensionNo").value;
	$.ajax({
		type : "GET",
		url : "CheckExtension.htm",
		data : {
		
			project1: extensionNo,
			project:expId
		},
		datatype : 'json',
		success : function(result) {

		           if(result==1){
		        	   alert("Extension No is already exists");
		           } 
		           if(result==0){
		        	 $("#addcommitteefrm").submit();
	  	           }
		}
		});	
	} */
</script>

</body>

</html>