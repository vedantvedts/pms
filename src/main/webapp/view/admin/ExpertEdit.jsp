<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="jakarta.persistence.criteria.CriteriaBuilder.In"%>
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

						<h3 class="text-white">Edit Expert</h3>

					</div>
					<form action="ExpertEditSubmit.htm" method="post" name="addcommitteefrm" id="addcommitteefrm1"  >
					
						<div class="card-body">
							<div class="row">							
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Expert No.</label>
										<input class="form-control" id="ExpertNo" type="text" readonly="readonly"  value="<%=detail[8]!=null?StringEscapeUtils.escapeHtml4(detail[8].toString()): ""%>" name="expertno" required maxlength="50">
									</div>
								</div>
									<div class="col-md-3">
											 <div class="form-group">
									                <label>Title</label><br>
									                 <select class="form-control selectdee" id="titleExp"  name="title" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
														<option value="" selected="selected"	hidden="true">--Select--</option>
															<option value="Prof." 	<%if(detail[1]!=null && detail[1].toString().equalsIgnoreCase("Prof.")){%> selected="selected" <%}%>>  Prof.</option>
															<option value="Lt."  	<%if(detail[1]!=null && detail[1].toString().equalsIgnoreCase("Lt.")){%>  selected="selected" <%}%>>  Lt.</option>
															<option value="Dr."   	<%if(detail[1]!=null && detail[1].toString().equalsIgnoreCase("Dr.")){%>   selected="selected" <%}%>>  Dr.</option>
															
													</select>
											</div>
									</div>
								<div class="col-md-3">
													 <div class="form-group">
											                <label>Rank/Salutation</label><br>
											                 <select class="form-control selectdee" id="salutationExp" name="salutation" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
																<option value=""  selected="selected"	hidden="true">--Select--</option>
																<option value="Mr."    <%if(detail[2]!=null && detail[2].toString().equalsIgnoreCase("Mr.")){%>    selected="selected" <%}%>> Mr.</option>
																<option value="Ms."   <%if(detail[2]!=null && detail[2].toString().equalsIgnoreCase("Ms.")){%>   selected="selected" <%}%>> Ms.</option>
															</select>
													</div>
									</div>
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Expert Name</label>
										<input class="form-control" id="expertname" type="text" value="<%=detail[3]!=null?StringEscapeUtils.escapeHtml4(detail[3].toString()): ""%>" name="expertname" required>
									</div>
								</div>
							<%-- 	<%int i = Integer.parseInt((detail[4].toString()).replaceAll(" ", "")); %> --%>
								<%-- <div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Extension No.</label>
										<input class="form-control" type="number" id="extensionNo" value="<%=detail[4]%>" name="extensionnumber" max="9999" min="1000">
									</div>
								</div> --%>
								

							
							
						
						
						</div>
						
						<div class="row">
						<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Designation</label>
									<select class="custom-select" id="selectDesig" required="required" name="designationId">
										<option value="" disabled="true"  selected value="">Choose...</option>
										<%for(Object[] desig:desigList){ %>
										<option  value="<%=desig[0]%>" <%if(detail[4].equals(desig[0])){ %> selected="selected" <%} %>><%=desig[2]!=null?StringEscapeUtils.escapeHtml4(desig[2].toString()): " - "%></option>
										<%}%>
									
									</select>
								</div>
							</div>
							<div class="col-md-3">
									<div class="form-group">
										<label class="control-label" id="mobile">Mobile No.</label>
										<input class="form-control" type="number" id="mobileno" value="<%=detail[5]!=null?StringEscapeUtils.escapeHtml4(detail[5].toString()): ""%>" name="mobilenumber" required  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
									</div>
								</div>
								
							
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Email</label>
										<input class="form-control" id="email" type="email" value="<%=detail[6]!=null?StringEscapeUtils.escapeHtml4(detail[6].toString()): ""%>" name="email" required>
									</div>
								</div>

							
					     	<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Organization</label>
										<input class="form-control" type="text" value="<%=detail[7]!=null?StringEscapeUtils.escapeHtml4(detail[7].toString()): ""%>" id="organization" name="organization" required>
									</div>
								</div>
						</div>	
						
					</div>
					<div class="row" ><div class="col-md-5"></div><div class="col-md-3">
								<input type="hidden" id="expId" name="expertId" value="<%=detail[0] %>" >
								<div class="form-group">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="button" value="SUBMIT" onclick="return formEdit('addcommitteefrm1');" class="btn btn-primary btn-sm submit" />
							<!-- <button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT" onclick="checkExpert()">SUBMIT</button> -->
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
		    mobile.focus();
		    return false;
		}	  
	});

</script>


<script type="text/javascript">

/* function checkExpert()
{
	 if(confitm('Are You Sure to submit ?')){
		 $("#addcommitteefrm").submit();
     } 
	 
} */

function formEdit(frmid)
{
	var title=$('#titleExp').val();
	var salutation=$('#salutationExp').val();
	var expertname=$('#expertname').val();
	var selectDesig=$('#selectDesig').val();
	var mobileno=$('#mobileno').val();
	var email=$('#email').val();
	var organization=$('#organization').val();
	
	if(expertname===""||selectDesig===""||mobileno===""||email===""||organization===""||selectDesig===null){
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