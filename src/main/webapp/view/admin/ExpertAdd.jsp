<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>



	<title> ADD COMMITTEE</title>
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
String expno=(String)request.getAttribute("expno");
List<Object[]> desigList=(List<Object[]>)request.getAttribute("Designation");
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

						<h3 class="text-white">Add New Expert</h3>

					</div>
					<form action="ExpertAddSubmit.htm" method="post" name="addcommitteefrm" id="addcommitteefrm" onsubmit="return confirm('Are you sure to submit');" >
					
						<div class="card-body">
							<div class="row">							
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Expert No.</label>
										<input class="form-control" id="ExpertNo" type="text" value="<%=expno %>" readonly="readonly"  name="expertno" required maxlength="50">
									</div>
								</div>
							<div class="col-md-3">
											 <div class="form-group">
									                <label>Title<span class="mandatory">*</span></label><br>
									                 <select class="form-control selectdee"  name="title" data-container="body" data-live-search="true"  style="font-size: 5px;">
														<option value="" disabled="disabled" selected="selected"	hidden="true">--Select--</option>
														<option value="Prof.">Prof.</option>
														<option value="Rev.">Rev.</option>
														<option value="Dr.">Dr.</option>	
													</select>
											</div>
							</div>
							<div class="col-md-3">
												 <div class="form-group">
										                <label>Rank/Salutation<span class="mandatory">*</span></label><br>
										                 <select class="form-control selectdee"  name="salutation" data-container="body" data-live-search="true"   style="font-size: 5px;">
															<option value="" disabled="disabled" selected="selected"	hidden="true">--Select--</option>
															<option value="Mr.">Mr.</option>
															<option value="Ms.">Ms.</option>
														</select>
												</div>
								</div>
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Expert Name</label>
										<input class="form-control" type="text" name="expertname" required>
									</div>
								</div>
								
								<!-- <div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Extension No.</label>
										<input class="form-control" type="number" id="extensionNo"  name="extensionnumber"  max="9999" min="1000">
									</div>
								</div> -->

						</div>
						
						<div class="row">
						
						<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Designation</label>
									<select class="custom-select" id="selectDesig" required="required" name="designationId">
										<option disabled="true"  selected value="">Choose...</option>
										<%for(Object[] desig:desigList){ %>
										<option  value="<%=desig[0]%>"><%=desig[2]%></option>
										<%}%>
									
									</select>
								</div>
							</div>
						
							<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Mobile No.</label>
										<input class="form-control" type="text" id="mobile"  maxlength="10"  name="mobilenumber" required max="9999999999" min="1000000000">
									</div>
								</div>
								
							
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Email</label>
										<input class="form-control" type="email" name="email" required>
									</div>
								</div>

							
					     	<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Organization</label>
										<input class="form-control" type="text" name="organization" required>
									</div>
								</div>
						</div>	
						
					</div>
					<div class="row" ><div class="col-md-5"></div><div class="col-md-3">
						<div class="form-group">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT" >SUBMIT</button>
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
		    /* mobile.focus(); */
		    return false;
		}	  
	});

</script>

<!-- <script>
$("#ExpertNo").blur(function(){
	
	
	 var inputtxt=document.getElementById("ExpertNo").value;
	
	 if (/^\b[A-Z]{1}\d{4}$/.test(inputtxt)) {
		   
		} else {
		    alert("Expert No; must be like this ex = E0000 ");
		   /* ExpertNo.focus();*/
		    return false;
		}	  
	});

</script> -->




</body>

</html>