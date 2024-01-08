<%-- <%@page import="com.vts.pfms.docs.model.PfmsDocTemplate"%> --%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Topics Layout</title>
<style type="text/css">
<
style>label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

h6 {
	text-decoration: none !important;
}

.multiselect-container>li>a>label {
	padding: 4px 20px 3px 20px;
}

.width {
	width: 210px !important;
}

.bootstrap-select {
	width: 400px !important;
}

#projectname {
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

.control-label {
	font-weight: bold;
	font-size: 1rem;
	color:#07689f;
}
</style>

</head>
<body>
	<%
	List<Object[]> ProjectList = (List<Object[]>) request.getAttribute("ProjectList");
	String ProjectId = (String) request.getAttribute("ProjectId");
	String projectname = "";
	%>
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
               <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
        <%=ses %>
        </div></div>
        <%} %>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="min-height: 34rem;">
					<form method="post" action="DocumentTemplate.htm" id="myform">
						<div class="card-header">
							<div class="row">
								<div class="col-md-6">
									<h4 class="control-label">Document Templates</h4>
								</div>
								<div class="col-md-6" style="margin-top: -8px;">
									<table style="float: right;">
										<tr>
											<td><label class="control-label">Project
													:&nbsp;&nbsp; </label></td>
											<td><select class="form-control selectdee"
												id="ProjectId" required="required" name="projectid"
												onchange="$('#myform').submit();">
													<option disabled="disabled" value="">Choose...</option>
													<%
													for (Object[] obj : ProjectList) {
														String projectshortName = (obj[17] != null) ? " ( " + obj[17].toString() + " ) " : "";
													%>
													<option value="<%=obj[0]%>"
														<%if (ProjectId.equalsIgnoreCase(obj[0].toString())) {
										projectname = obj[4].toString();%>
														selected="selected" <%}%>>
														<%=obj[4] + projectshortName%>
													</option>
													<%
													}
													%>
											</select> <input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" /></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</form>

					<div class="card-body"
						style="background: white; box-shadow: 2px 2px 2px gray;">
						<div class="row">
							<div class="col-md-6  ">
							
							<form>
								<span class="caret">System Requirements Document &nbsp; <button class="btn bg-transparent" name="ProjectId" value="<%=ProjectId %>"   type="submit" formaction="RequirementWordDownload.htm" formmethod="get" formtarget="_blank" >
								<i class="fa fa-download" style="color:green;" aria-hidden="true"></i>
								</button></span>							
							
							
							</form>
							</div>
							<div class="col-md-6 border p-2 ">
								<form action="TemplateAttributesAdd.htm" method="post">
									<div align="center">
										<label class="control-label"
											style="color: #145374; font: 1.5 rem; text-decoration: underline">Document
											Template Attributes</label>
									</div>
									<div class="row mt-2">
										<div class="col-md-1"></div>
										<div class="col-md-4">
											<label class="control-label">Header Font-size:</label>
											<span class="mandatory" style="color: red;">*</span>
										</div>
										<div class="col-md-4"> 
											<input type="number" name="HeaderFontSize" id="HeaderFontSize" required
												class="form-control" placeholder="E.g. 12 px" min="8" max="50"
												oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
										</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-1"></div>
										<div class="col-md-4">
											<label class="control-label">Header Font-weight:</label>
										<span class="mandatory" style="color: red;">*</span>
										</div>
										<div class="col-md-4">
											<select class="form-control form-control selectdee" name="HeaderFontWeight" required
												id="HeaderFontWeight">
												<option disabled="disabled" selected="selected" value="">Select...</option>
												<option value="0">Normal</option>
												<option value="1">Bold</option>
											</select>
										</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-1"></div>
										<div class="col-md-4">
											<label class="control-label">SubHeader Font-size:</label>
										<span class="mandatory" style="color: red;">*</span>
										</div>
										<div class="col-md-4 ">
											<input type="number" name="subHeaderFontSize"
												id="subHeaderFontSize" class="form-control" min="8" max="50" required
												placeholder="E.g. 12 px"
												oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
										</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-1"></div>
										<div class="col-md-4">
											<label class="control-label">SubHeader Font-weight:</label>
											<span class="mandatory" style="color: red;">*</span>
										</div>
										<div class="col-md-4">
											<select class="form-control form-control selectdee" name="subHeaderFontWeight" required
												id="subHeaderFontWeight">
												<option disabled="disabled" selected="selected" value="">Select...</option>
												<option value="0">Normal</option>
												<option value="1">Bold</option>
											</select>
										</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-1"></div>
										<div class="col-md-4">
											<label class="control-label">paragraph Font-size:</label>
											<span class="mandatory" style="color: red;">*</span>
										</div>
										<div class="col-md-4 ">
											<input type="number" name="ParaFontSize" id="ParaFontSize" min="8" max="50" required 
												class="form-control" placeholder="E.g. 12 px"
												oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
										</div>
									</div>

									<div class="row mt-2">
										<div class="col-md-1"></div>
										<div class="col-md-4">
											<label class="control-label">Pargraph Font-weight:</label>
											<span class="mandatory" style="color: red;">*</span>
										</div>
										<div class="col-md-4">
											<select class="form-control form-control selectdee" name="paraFontWeight"
												id="paraFontWeight">
												<option disabled="disabled" selected="selected" value="">Select...</option>
												<option value="0">Normal</option>
												<option value="1">Bold</option>
											</select>
										</div>
									</div>
									<div class="row mt-2" ><div class="col-md-1"></div>
									
									<div class="col-md-4">
									<label class="control-label">Main Table Width:</label>
									<span class="mandatory" style="color: red;">*</span> 
									</div>
									<div class="col-md-4 ">
										<input type="number" name="mainTableWidth" id="mainTableWidth" required
											class="form-control" min="1000" max="6000" placeholder="Min-1000 , Max-5000"
											oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
										</div>
									</div>
									<div class="row mt-2" ><div class="col-md-1"></div>
									<div class="col-md-4">
									<label class="control-label">sub Table Width:</label> 
									<span class="mandatory" style="color: red;">*</span>
									</div>
									
									<div class="col-md-4 ">
										<input type="number" name="subTableWidth" id="subTableWidth" required
											class="form-control" min="1000" max="6000" placeholder="Min-1000 , Max-5000"
											oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
										</div>
									</div>


									<div class="mt-2" align="center">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
											<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<button type="submit" class="btn btn-sm submit"
											onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
									</div>
								</form>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>
	<script>
	</script>
</body>
</html>