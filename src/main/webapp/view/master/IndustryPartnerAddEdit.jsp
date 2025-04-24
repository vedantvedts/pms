<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.master.model.IndustryPartner"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

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
    -moz-appearance: textfield; /* Firefox */
}
		
</style>
</head>
<body>
<%
Object[] IPDetails = (Object[])request.getAttribute("IndustryPartnerDetails");
List<IndustryPartner> IPNamesList = (List<IndustryPartner>)request.getAttribute("IndustryNamesList");
%>
<% String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    <%=ses1 %>
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>

<br>

<div class="container">

	<div class="row">

		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
					<h3 class="text-white"> <%if(IPDetails!=null) {%>Edit Existing<%} else{%>Add New<%} %> Industry Partner</h3>
				</div>
				<form action="IndustryPartnerSubmit.htm" method="post">
					
					<div class="card-body">
						<div class="row details">
                    		<div class="col-md-6" style="text-align: left;">
                    			<label class="control-label" style="color: black;">Industry Partner Details:</label>
                    		</div>
                    	</div>
						<div class="row">							
							<div class="col-md-4">
								<div class="form-group">
									<label class="control-label">Name</label><span class="mandatory" style="color: red;">*</span>
										<span id="industrypartnerinputfield" style="display: flex;">
											<input class="form-control alphanum-no-leading-space" type="text" id="industryPartnerName" name="industryPartnerName" value="<%if(IPDetails!=null && IPDetails[1]!=null) {%><%=IPDetails[1] %><%} %>" maxlength="255" placeholder="Enter Industry Partner" >
											<button type="button" class="btn btn-sm ml-2" formnovalidate="formnovalidate" onclick="closeeditindustrypartnername()" title="Close" style="padding: 0px 5px 0px 7px;"> 
												<i class="fa fa-close"  style="color: red;"></i>
											</button>
											<input type="hidden" name="industryPartnerId2" <%if(IPDetails!=null && IPDetails[0]!=null) {%>value="<%=IPDetails[0] %>"<%} %> >
										</span>
										
										<span id="industrypartnerselectfield" style="display: flex;">
											<select class="form-control selectdee" id="industryPartnerId" required="required" name="industryPartnerId" onchange="IndustryPartnerSub()" <%if(IPDetails!=null) {%>disabled<%} %> >
												<option value="0" selected="selected">--Select--</option>
												<option value="addNew">Add New</option>
												<% for (IndustryPartner industry : IPNamesList) { %>
	                    							<option value="<%=industry.getIndustryPartnerId()%>" 
	                    							data-address="<%=industry.getIndustryAddress()%>" 
	                    							data-city="<%=industry.getIndustryCity() %>"
	                    							data-pincode="<%=industry.getIndustryPinCode() %>"
	                    							<% if(IPDetails!=null && industry.getIndustryPartnerId()==Long.parseLong(IPDetails[0].toString())) { %>selected<% } %> >
	                    							<%=industry.getIndustryName()%>
	                    							</option>
	                							<% } %>   
											</select>
											<%if(IPDetails!=null) {%>
												<button type="button" class="btn btn-sm edit ml-2" formnovalidate="formnovalidate" style="background: linear-gradient(135deg, #FDC830, #F37335);padding: 0px 5px 0px 7px;">
													<i class="fa fa-edit" style="padding: 0px;" aria-hidden="true" onclick="openeditindustrypartnername()" ></i>
												</button>
											<%} %>
										</span>
										
										
								</div>
							</div>
							<div class="col-md-3 existingaddressdiv">
								<div class="form-group">
									<label class="control-label">Address</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control" type="text" id="industryPartnerAddress" name="industryPartnerAddress" maxlength="1000" placeholder="Enter Street, village/ town" required >	
								</div>
							</div>
							<div class="col-md-3 existingaddressdiv">
								<div class="form-group">
									<label class="control-label">City</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control alpha-no-leading-space" type="text" id="industryPartnerCity" name="industryPartnerCity" maxlength="500" placeholder="Enter City" >	
								</div>
							</div>
							<div class="col-md-2 existingaddressdiv">
								<div class="form-group">
									<label class="control-label">Code</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control numeric-only" type="text" id="industryPartnerPinCode" name="industryPartnerPinCode" maxlength="6" placeholder="Enter Pincode">	
								</div>
							</div>
						</div>
						
						<div class="row" id="addNewIndustryPartnerdiv">							
							<div class="col-md-4">
								<div class="form-group">
									<label class="control-label">New Name</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control alphanum-no-leading-space" type="text" id="industryPartnerName2" name="industryPartnerName2" maxlength="255" placeholder="Enter Industry Partner" >		
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">New Address</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control" type="text" id="industryPartnerAddress2" name="industryPartnerAddress2" maxlength="1000" placeholder="Enter Street, village/ town" >	
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">New City</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control alpha-no-leading-space" type="text" id="industryPartnerCity2" name="industryPartnerCity2" maxlength="500" placeholder="Enter City" >	
								</div>
							</div>
							<div class="col-md-2">
								<div class="form-group">
									<label class="control-label">New Pin Code</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control numeric-only" type="text" id="industryPartnerPinCode2" name="industryPartnerPinCode2" maxlength="6" placeholder="Enter Pincode">	
								</div>
							</div>
						</div>
						
					
						<div class="row details">
                    		<div class="col-md-6" style="text-align: left;">
                    			<label class="control-label" style="color: black;">Industry Partner Representative Details:</label>
                    		</div>
                    	</div>
                    	<div class="row details mb-2" id="existingrepdetails">
                    	</div>
                    	<%if(IPDetails!=null) {%>
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Name</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control alpha-dot-no-leading-space" type="text" id="repName" name="repName" maxlength="255" placeholder="Enter Rep Name" <%if(IPDetails!=null && IPDetails[4]!=null) {%> value="<%=IPDetails[4] %>" <%} %> required>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Designation</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control alphanum-no-leading-space" type="text" name="repDesignation" placeholder="Enter Rep Designation" <%if(IPDetails!=null && IPDetails[5]!=null) {%> value="<%=IPDetails[5] %>" <%} %> maxlength="255" required>
								</div>
							</div>
						
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Mobile No</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control indian-mobile" type="tel" id="repMobileNo"  maxlength="10"  name="repMobileNo" oninput="validateMobileLength(this)" placeholder="Enter Rep Mobile No" <%if(IPDetails!=null && IPDetails[6]!=null) {%> value="<%=IPDetails[6] %>" <%} %> required>
								</div>
							</div>
								
							
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Email</label><span class="mandatory" style="color: red;">*</span>
									<input class="form-control email-input" type="email" id="repEmail" name="repEmail" maxlength="255" placeholder="Enter Rep Email" <%if(IPDetails!=null && IPDetails[7]!=null) {%> value="<%=IPDetails[7] %>" <%} %> required>
								</div>
							</div>
						</div>
						<%} else{%>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<table style="width:100% ; " id="repdetails">
										<thead style = "background-color: #055C9D; color: white;text-align: center;">
											<tr>
										    	<th style="padding: 0px 5px 0px 5px;">Name</th>
										    	<th style="padding: 0px 5px 0px 5px;">Designation</th>
										    	<th style="padding: 0px 5px 0px 5px;">Mobile No</th>
										    	<th style="padding: 0px 5px 0px 5px;">Email</th>
												<td style="">
													<button style="padding: 3px 7px 3px 7px;" type="button" class=" btn btn_add_repdetails"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
												</td>
											</tr>
										</thead>
								 		<tbody>
									 		<tr class="tr_clone_repdetails">
												<td style="padding: 10px 5px 0px 5px;" >
													<input class="form-control alpha-dot-no-leading-space" type="text" id="repName" name="repName" maxlength="255" placeholder="Enter Rep Name" required>
												</td>	
												<td style="padding: 10px 5px 0px 5px;">
													<input class="form-control alphanum-no-leading-space" type="text" name="repDesignation" placeholder="Enter Rep Designation" maxlength="255" required>
												</td>	
												<td style="padding: 10px 5px 0px 5px;">
													<input class="form-control indian-mobile" type="tel" id="repMobileNo"  maxlength="10"  name="repMobileNo" placeholder="Enter Rep Mobile No"  oninput="validateMobileLength(this)" required>
												</td>
												<td style="padding: 10px 5px 0px 5px;">
													<input class="form-control email-input" type="email" id="repEmail" name="repEmail" maxlength="255" placeholder="Enter Rep Email" required>
												</td>
												<td style="width: 5% ; ">
													<button style="padding: 3px 7px 3px 7px;" type="button" class=" btn btn_rem_repdetails" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
												</td>									
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>	
                    	<%} %>	
						
					</div>
					<div class="row" ><div class="col-md-5"></div>
						<div class="col-md-3">
							<div class="form-group">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" id="industryPartnerRepId" name="industryPartnerRepId" value="<%if(IPDetails!=null) {%><%=IPDetails[3]%><%} else{%>0<%} %>" >
								<%if(IPDetails!=null) {%>
								    
									<button type="submit" class="btn btn-sm btn-warning edit " id="addformsubmit" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
								<%}else{ %>
									<button type="submit" class="btn btn-sm btn-success submit " name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
								<%} %>
								<a class="btn btn-primary btn-sm back" href="IndustryPartner.htm" >BACK</a>
							
							</div>
						</div>
					</div>
					
				</form>
			</div>
			<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px "></div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	IndustryPartnerSub();
	
	$('#industrypartnerinputfield').hide();
	$('#industrypartnerselectfield').show();
	
	
});
function IndustryPartnerSub()
{ 
	var industryPartnerId = document.getElementById("industryPartnerId");
	var industryPartnerRepId = document.getElementById("industryPartnerRepId");
    var addressField = document.getElementById("industryPartnerAddress");
    var cityField = document.getElementById("industryPartnerCity");
    var pincodeField = document.getElementById("industryPartnerPinCode");
    var selectedOption = industryPartnerId.options[industryPartnerId.selectedIndex];
    
	if (industryPartnerId.value == 'addNew') {
		
		$('#addNewIndustryPartnerdiv').show();
		$('.existingaddressdiv').hide();
		$('#industryPartnerName2,#industryPartnerAddress2,#industryPartnerCity2,#industryPartnerPinCode2').prop('required', true);
		
		// Clear the fields if "Add New" is selected
		addressField.value = ""; 
		cityField.value = ""; 
		pincodeField.value = ""; 
		
		$('#existingrepdetails').empty();
		
    } 
	else if(industryPartnerId.value == '0'){
		
		$('#addNewIndustryPartnerdiv').hide();
    	$('.existingaddressdiv').show();
    	
		$('#industryPartnerAddress,#industryPartnerCity,#industryPartnerPinCode').prop('readonly', true);
		
		// Clear the fields if "Add New" is selected
		addressField.value = ""; 
		cityField.value = ""; 
		pincodeField.value = ""; 
		
		$('#existingrepdetails').empty();
	}
	else {

    	$('#addNewIndustryPartnerdiv').hide();
    	$('.existingaddressdiv').show();
    	$('#industryPartnerName2,#industryPartnerAddress2,#industryPartnerCity2,#industryPartnerPinCode2').prop('required', false);
		
    	var selectedAddress = selectedOption.getAttribute("data-address");
    	var selectedCity = selectedOption.getAttribute("data-city");
    	var selectedPinCode = selectedOption.getAttribute("data-pincode");
    	
    	// Set the address field based on the selected option
        addressField.value = selectedAddress; 
        cityField.value = selectedCity; 
		pincodeField.value = selectedPinCode; 
		
		if(industryPartnerId.value!=null){
			$.ajax({

				type : "GET",
				url : "IndustryPartnerRepDetails.htm",
				data : {
					industryPartnerId : industryPartnerId.value,
					industryPartnerRepId : industryPartnerRepId.value
					   },
				datatype : 'json',
				success : function(result) {

				var result = JSON.parse(result);
				
				$('#existingrepdetails').empty();
				
					var y='';
					for(var i=0;i<result.length;i++){
						
						y+='<div class="col-md-12" style="text-align: left;">';
						if(i==0){
							y+='<h5 style="color: #FF5733;text-indent: 20px;">Existing Representatives: <button type="button" id="existingRepInfo" value="1" class="btn btn-info btn-sm" style="padding: 0px 5px 0px 5px;border: none;" onclick="return existingRepInfoHandle()"><i class="fa fa-info-circle" aria-hidden="true"></i></button></h5> <hr style="width: 50%;"> ';
						}
						y+='<div class="existingRepInfoContent" style="text-indent: 40px;">';
						y+='<span style="line-height: 1.5;word-spacing: 2px;">'+(i+1)+'. '+result[i][2]+', '+result[i][3]+'</span>';
						y+='</div>';
						y+='</div>';
					}
					
					$('#existingrepdetails').html(y);
				}
					   
			});
		}
		
    }
	
} 

/* Cloning (Adding) the table body rows for Consultants */
$("#repdetails").on('click','.btn_add_repdetails' ,function() {
	
	var $tr = $('.tr_clone_repdetails').last('.tr_clone_repdetails');
	var $clone = $tr.clone();
	$tr.after($clone);
	
	$clone.find("input").val("").end();
	
});


/* Cloning (Removing) the table body rows for Consultants */
$("#repdetails").on('click','.btn_rem_repdetails' ,function() {
	
var cl=$('.tr_clone_repdetails').length;
	
if(cl>1){
   var $tr = $(this).closest('.tr_clone_repdetails');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   
}
   
}); 
</script>

<script type="text/javascript">
function openeditindustrypartnername(){
	
	$('#industrypartnerinputfield').show();
	$('#industrypartnerselectfield').hide();
}

function closeeditindustrypartnername(){
	$('#industrypartnerinputfield').hide();
	$('#industrypartnerselectfield').show();
}
</script>

<!--  <script type="text/javascript">
$("#addformsubmit").click(function(){
	
	/* var industryPartnerId = $('#industryPartnerId').val(); */
	var industryPartnerId = document.getElementById("industryPartnerId");
	var selectedText = industryPartnerId.options[industryPartnerId.selectedIndex].text;
	if(industryPartnerId.value=='addNew'){
		var industryPartnerName2 = $('#industryPartnerName2').val();
		$('#industryPartnerName').val(industryPartnerName2);
	}else{
		$('#industryPartnerName').val(selectedText);
	}
	
});
</script>  -->
</body>

<script type="text/javascript">

//Onclick showing / Closing the info content

/* For Existing Rep Details Content */
 function existingRepInfoHandle() {
	var existingRepInfo = $('#existingRepInfo').val();
	if(existingRepInfo=="0"){
		$('#existingRepInfo').val('1');
		$('.existingRepInfoContent').show();
	
	}else{
		$('#existingRepInfo').val('0');
		$('.existingRepInfoContent').hide();
		}
} 

 function validateMobileLength(input) {
	    if (input.value.length > 10) {
	      input.value = input.value.slice(0, 10); // trim extra input, just in case
	    }

	    // Optional: real-time feedback
	    if (input.value.length === 10) {
	      input.setCustomValidity(""); // valid
	    } else {
	      input.setCustomValidity("Mobile number must be exactly 10 digits");
	    }
	  }

</script> 

</html>