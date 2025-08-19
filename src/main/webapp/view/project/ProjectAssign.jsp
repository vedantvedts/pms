<%@page import="com.vts.pfms.project.model.ProjectAssign"%>
<%@page import="com.vts.pfms.master.model.RoleMaster"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>PROJECT  ASSIGN</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

b{
	font-family: 'Lato',sans-serif;
}

#myTable thead tr{
	background-color: #055C9D;
    color: white;
}
.select2-container{
	width: 100% !important;
}
</style>
</head>
<body>
	<%	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		List<Object[]> ProjectAssignList=(List<Object[]>) request.getAttribute("ProjectAssignList");
		List<Object[]> allLabList=(List<Object[]>) request.getAttribute("allLabList");
		List<RoleMaster> roleMasterList=(List<RoleMaster>) request.getAttribute("roleMasterList");
		List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("ProjectList");
		String ProjectId=(String)request.getAttribute("ProjectId");
		//String action=(String)request.getAttribute("action");
		//ProjectAssign projectAssign =(ProjectAssign)request.getAttribute("projectAssign");
		Object[] ProjectCode=(Object[])request.getAttribute("ProjectCode");
		String labcode = (String)session.getAttribute("labcode");
	%>

	<% String ses = (String) request.getParameter("result"); 
       String ses1 = (String) request.getParameter("resultfail");
       if (ses1 != null) { %>
        <div align="center">
            <div class="alert alert-danger" role="alert">
                <%= ses1 %>
            </div>
        </div>
    <% } if (ses != null) { %>
        <div align="center">
            <div class="alert alert-success" role="alert">
                <%= ses %>
            </div>
        </div>
    <% } %>
    
	<div class="container-fluid">
		<div class="col-md-12">
			<div class="card">
				<div class="card-header">
					<div class="row">
						<div class="col-md-10"><h4>Project Team</h4></div>
						<div class="col-md-2">		      
							<a class="btn btn-info btn-sm  back"  style="margin-left: 4.2rem; margin-top: -5px;"   href="MainDashBoard.htm">Back</a>
						</div>
					</div>
				</div>
				<div class="" style="background-color: #f4f5f0;">
					<form method="POST" action="ProjectProSubmit.htm">
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
						<div class="row">
							<div class="col-md-3"></div>
							<div class="col-md-2 right">
								<label style="font-weight: 800">Project Code: <span class="mandatory" style="color: red;">*</span></label>
							</div>
							<div class="col-md-3">
								<select class="form-control selectdee" name="ProjectId" id="ProjectId" onchange="this.form.submit()">
					            	<option value="" disabled="disabled" selected="selected">Select Project </option>
					                <%
					                for(Object[] protype:ProjectList ){
					                	String projectshortName=(protype[17]!=null)?" ("+protype[17].toString()+") ":"";
					                	%>
										<option value="<%=protype[0] %>" <%if(ProjectId!=null){ if(protype[0].toString().equalsIgnoreCase(ProjectId)){%>selected="selected" <%}} %>><%=protype[4]+projectshortName %></option>
									<%} %>
								</select>
							</div>
							<div class="col-md-4"></div>
						</div>
						
					</form>
				</div>

				<div class="row" style="margin-top: 10px;">
      				<div class="col-md-6">
						<div style="margin-top: 0px;">
							<div class="card " >
								<div class="card-body  shadow-nohover" >
									<form action="#" method="POST" name="frm1" >
										<div class="row" style="margin-top: 20px;">
											<div class="col-md-12">
												<div class="table-responsive">
													<table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
														<thead style=" text-align: center;">
															<tr style="background-color: white;color: black">
																<th colspan="5">List Of User Assigned for <%if(ProjectCode!=null){ %><%=ProjectCode[1]%><%} %></th>
															</tr>
															<tr>
	   															<th style="width:5%; ">Select</th>
												   				<th >Lab</th>
												   				<th >Employee Name</th>
																<th>Division Code</th>
																<th >Role</th>
	  														</tr>
														</thead>
														<tbody>
	 														<%if(ProjectAssignList!=null){
	 															for(Object[] obj:ProjectAssignList){ %>
	    															<tr>
	  																	<td align="center">
	  																		<input type="radio" name="ProjectEmployeeId" value="<%=obj[0]%>" <%if(obj[8]!=null && Long.parseLong(obj[8].toString())==1) {%>disabled<%} %> >
	  																		<input type="hidden" id="lab_<%=obj[0]%>" value="<%=obj[9]!=null?obj[9]:"-" %>">
	  																		<input type="hidden" id="employee_<%=obj[0]%>" value="<%=obj[3] %>, <%=obj[4] %>">
	  																		<input type="hidden" id="empId_<%=obj[0]%>" value="<%=obj[1] %>">
	  																		<input type="hidden" id="roleMasterId_<%=obj[0]%>" value="<%=obj[8] %>">
	  																	</td>
																		<td style="text-align: left;"><%=obj[9]!=null?obj[9]:"-" %></td>
																		<td style="text-align: left;"><%=obj[3] %>, <%=obj[4] %></td>
																        <td style="text-align: left;"><%=obj[5]!=null?obj[5]:"-" %></td>
																        <td style="text-align: left;"><%=obj[12]!=null?obj[12]:"-" %></td>
																	</tr>
															<%} }%>
														</tbody>
													</table>
												</div>
												<div style="text-align: center;">
 													<button type="button" class="btn btn-sm edit" name="action" value="edit" formaction="ProjectProSubmit.htm" onclick="actionHandle('edit')">EDIT</button>&nbsp;&nbsp;
 													<button type="submit" class="btn btn-danger btn-sm delete" formaction="ProjectRevokeSubmit.htm" onclick="actionHandle('revoke')">REVOKE</button>&nbsp;&nbsp;
												</div>
											</div>
										</div>

										<input type="hidden" name="ProjectId" value="<%=ProjectId%>"/> 	 						
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 									</form>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div style="margin-top: 0px;">
							<div class="card" >
								<div class="card-body  shadow-nohover" >
									<form action="ProjectAssignSubmit.htm" method="POST" name="frm1" >
										<div class="row" style="margin-top: 20px;">
											<div class="col-md-12">
												<div class="table-responsive">
													<table class="table table-bordered table-hover table-striped table-condensed" style="width: 100%;" > 
														<thead style = "background-color: #055C9D; color: white;">
															<tr>
	   															<th width="100%" colspan="3">Select Users  for <%if(ProjectCode!=null){ %><%=ProjectCode[1]%><%} %></th>
	  														</tr>
	   													</thead>
														<tbody>
															<tr>
																<td width="35%">
																	<label>Role</label>
																	<select class="form-control selectdee" name="roleMasterId" id="roleMasterId" data-placeholder="Role">
																		<option selected value="0">Not Applicable</option>
																	    <% for (RoleMaster role : roleMasterList) { 
																	    	if(role.getRoleMasterId()==1) continue; %>
																	    	<option value="<%=role.getRoleMasterId()%>"><%=role.getRoleName()%></option>
																	    <%}%>
																	</select>
																</td>
																<td width="15%">
																	<label>Lab</label>
																	<select class="form-control selectdee" name="labCode" id="labCode" required onchange="renderEmployeeList()" data-placeholder= "Lab Name">
																		<!-- <option disabled="true"  selected value="">Lab Name</option> -->
																	    <% for (Object[] obj : allLabList) { %>
																	    	<option value="<%=obj[3]%>" <%if(labcode.equalsIgnoreCase(obj[3].toString())) {%>selected<%} %> ><%=obj[3]%></option>
																	    <%}%>
																	</select>
																</td>
																<td width="50%">
																	<label>Employees</label>
																	<select class="form-control selectdee" name="empId" id="empId" required multiple="multiple" data-placeholder= "Select Employees"  >
																	</select>
																</td>
															</tr>
														</tbody>
													</table>
												</div>
												<div style="text-align: center;">
													<button type="submit" class="btn btn-success btn-sm submit" name="action" value="Add">ASSIGN</button>&nbsp;&nbsp;
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													<input type="hidden" name="ProjectId" id="ProjectId" value="<%=ProjectId%>"/>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
  	
  	<!-- -------------------------------------------- Project Team Edit Modal ------------------------------------------------------------- -->
	<div class="modal fade" id="projectTeamEditModal" tabindex="-1" role="dialog" aria-labelledby="projectTeamEditModal" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width:135%;margin-left:-20%;">
				<div class="modal-header" style="background: #055C9D;color: white;">
		        	<h5 class="modal-title ">Project Team Edit</h5>
			        <button type="button" class="close" style="text-shadow: none !important" data-dismiss="modal" aria-label="Close">
			          <span class="text-light" aria-hidden="true">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
     				<div class="container-fluid mt-3">
     					<div class="row">
							<div class="col-md-12 " align="left">
								<form action="ProjectAssignSubmit.htm" method="POST" id="myform">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="ProjectId" id="ProjectId" value="<%=ProjectId%>"/>
									<input type="hidden" name="empId" id="empIdEdit"/>
									<input type="hidden" name="projectEmployeeId" id="projectEmployeeIdEdit"/>
									<div class="row">
										<div class="col-md-2">
											<label>Lab</label>
											<input type="text" class="form-control" id="labCodeEdit" readonly>
										</div>
										<div class="col-md-4">
											<label>Employee</label>
											<input type="text" class="form-control" id="employeeEdit" readonly>
										</div>
										<div class="col-md-4">
											<label>Role</label>
											<select class="form-control selectdee" name="roleMasterId" id="roleMasterIdEdit" data-placeholder="Role">
												<option selected value="0">Not Applicable</option>
											    <% for (RoleMaster role : roleMasterList) { 
											    	if(role.getRoleMasterId()==1) continue;%>
											    	<option value="<%=role.getRoleMasterId()%>"><%=role.getRoleName()%></option>
											    <%}%>
											</select>
										</div>
										<div class="col-md-2" style="margin-top: auto;">
											<button type="submit" class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm('Are you sure to Update?')">UPDATE</button>
										</div>
									</div>
								</form>
							</div>
						</div>
     				</div>
     			</div>
     		</div>
		</div>
	</div>			
	<!-- -------------------------------------------- Project Team Edit Modal End ------------------------------------------------------------- -->		
	
<script>
	$(document).ready(function () {
		renderEmployeeList();
	});
	
	function renderEmployeeList(){

		var labCode  = $('#labCode').val();
		var ProjectId  = $('#ProjectId').val();
		
		if(labCode !=""){
			$.ajax({
				type : "GET",
				url : "ProjectTeamByLabCode.htm",
				data : {
					labCode : labCode,
					projectId : ProjectId
				},
				datatype : 'json',
				success : function(result) {
					var result = JSON.parse(result);
					
					var values = Object.keys(result).map(function(e) {
	 					return result[e]
					});
					var s = '<option value="">--Select--</option>';
					for (i = 0; i < values.length; i++) 
					{
						s += '<option value="'+values[i][0]+'">' +values[i][1].trim() + ", " +values[i][2]+""  + '</option>';
					} 
					 
					$('#empId').html(s);
					
				}
			});
		}
	}
	
	function actionHandle(action){
	
		var fields = $("input[name='ProjectEmployeeId']").serializeArray();
	
		if (fields.length === 0){
			bootbox.alert("Please Select One Record");
			event.preventDefault();
			return false;
		}
		
		var rowId = fields[0].value;
		
		if(action=='edit'){
			
			var lab = $('#lab_'+rowId).val();
			var employee = $('#employee_'+rowId).val();
			var empId = $('#empId_'+rowId).val();
			var roleMasterId = $('#roleMasterId_'+rowId).val();
			$('#labCodeEdit').val(lab);
			$('#employeeEdit').val(employee);
			$('#empIdEdit').val(empId);
			$('#projectEmployeeIdEdit').val(rowId);
			$('#roleMasterIdEdit').val(roleMasterId).trigger('change');
			$('#projectTeamEditModal').modal('show');
		}else{
			if(confirm("Are You Sure To Revoke!")){
				return true;
			} else{
				event.preventDefault();
				return false;
			}
		}
		
			
	}

</script>
</body>
</html>