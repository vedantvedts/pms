<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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

<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>

    <br />
    
    
	<div class="container">

		<div class="row">

			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header"
						style=" background-color: #055C9D;margin-top: ">

						<h3 class="text-white">Add New Expert</h3>

					</div>
					<form action="ExpertAddSubmit.htm" method="post" name="addcommitteefrm" id="addcommitteefrm" >
					
						<div class="card-body">
							<div class="row">							
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Expert No.</label>
										<input class="form-control" id="ExpertNo" type="text" value="<%=expno!=null?StringEscapeUtils.escapeHtml4(expno): "" %>" readonly="readonly"  name="expertno" required maxlength="50">
									</div>
								</div>
							<div class="col-md-3">
											 <div class="form-group">
									                <label>Title</label><br>
									                 <select class="form-control selectdee" id="titleExp" name="title" data-container="body" data-live-search="true"  style="font-size: 5px;">
														<option value=""  selected="selected"	hidden="true">--Select--</option>
														<option value="Prof.">Prof.</option>
														<option value="Lt.">Lt.</option>
														<option value="Dr.">Dr.</option>	
													</select>
											</div>
							</div>
							<div class="col-md-3">
												 <div class="form-group">
										                <label>Rank/Salutation</label><br>
										                 <select class="form-control selectdee" id="salutaionExp"  name="salutation" data-container="body" data-live-search="true"   style="font-size: 5px;">
															<option value=""  selected="selected"	hidden="true">--Select--</option>
															<option value="Mr.">Mr.</option>
															<option value="Ms.">Ms.</option>
														</select>
												</div>
								</div>
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Expert Name</label><span class="mandatory" style="color: red;">*</span>
										<input class="form-control" type="text" id="expertname" name="expertname" required>
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
									<label class="control-label">Designation</label><span class="mandatory" style="color: red;">*</span>
									<select class="custom-select" id="selectDesig" required="required" name="designationId">
										<option disabled="true"  selected value="">Choose...</option>
										<%for(Object[] desig:desigList){ %>
										<option  value="<%=desig[0]%>"><%=desig[2]!=null?StringEscapeUtils.escapeHtml4(desig[2].toString()): " - "%></option>
										<%}%>
									
									</select>
								</div>
							</div>
						
							<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Mobile No.</label><span class="mandatory" style="color: red;">*</span>
										<input class="form-control" type="text" id="mobile"  maxlength="10"  name="mobilenumber" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
									</div>
								</div>
								
							
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Email</label><span class="mandatory" style="color: red;">*</span>
										<input class="form-control" type="email" id="email"name="email" required>
									</div>
								</div>

							
					     	<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Organization</label><span class="mandatory" style="color: red;">*</span>
										<input class="form-control" type="text" name="organization" id="organization" required>
									</div>
								</div>
						</div>	
						
					</div>
					<div class="row" ><div class="col-md-5"></div><div class="col-md-3">
						<div class="form-group">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="button"  class="btn btn-primary btn-sm submit" value="SUBMIT" onclick="return formCheck('addcommitteefrm');"/>
						<!-- 	<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT" >SUBMIT</button> -->
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

function formCheck(frmid)
{
	var title=$('#titleExp').val();
	var salutation=$('#salutaionExp').val();
	var expertname=$('#expertname').val();
	var selectDesig=$('#selectDesig').val();
	var mobile=$('#mobile').val();
	var email=$('#email').val();
	var organization=$('#organization').val();
	console.log(selectDesig+"----")
	//console.log(title+salutation+expertname+selectDesig+mobile+email+organization);
	if(expertname===""||selectDesig===""||mobile===""||email===""||organization===""||selectDesig===null){
		alert('Please Fill All the Fields ');
	}
	
	else if((title==="" && salutation==="")||(title!=="" && salutation!=="")){
		window.alert('please select either Title or Rank');
		event.preventDefault();
		return false;
	}
 	else{
		if(window.confirm('Are you sure to save?')){
			document.getElementById(frmid).submit(); 
		}
		else{
			event.preventDefault();
			return false;
		}
	}
	
}


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