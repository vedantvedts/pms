<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.committee.model.ProgrammeProjects"%>
<%@page import="com.vts.pfms.committee.model.ProgrammeMaster"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
.heading{
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}
</style>
</head>
<body>

	<%
		FormatConverter fc = new FormatConverter();
		ProgrammeMaster programmeMaster = (ProgrammeMaster)request.getAttribute("prgmMaster");
		List<ProgrammeProjects> prgmprojectsList = (List<ProgrammeProjects>) request.getAttribute("prgmprojectsList");
		List<Object[]> directorsList = (List<Object[]>) request.getAttribute("directorsList");
		List<Object[]> projectsList = (List<Object[]>) request.getAttribute("projectsList");
	
		List<Long> linkedProjectIds = prgmprojectsList!=null?prgmprojectsList.stream().map(e -> e.getProjectId()).collect(Collectors.toList()):new ArrayList<Long>();
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
    

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="card shadow-nohover">
					<div class="card-header" style="background-color: #055C9D;">
						<b class="text-white">Programme Master <%if(programmeMaster==null){%>Add<%} else {%> Edit <% } %></b>
					</div>
					<div class="card-body">
						<form method="post" action="ProgrammeMasterSubmit.htm" id="programmeMasterForm" name="myform" onsubmit="return confirm('Are you sure you want to submit the form?')">
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="form-label"><b class="heading">Programme Code:</b><span class="mandatory" style="color:red;">*</span></label>
										<input type="text" class="form-control" onchange="handleInputChange(this.value,0)" placeholder="Enter Programme Code" name="ProgrammeCode" id="ProgrammeCode" required="required"
										<%if(programmeMaster!=null){%>
										 value="<%=programmeMaster.getPrgmCode()!=null?StringEscapeUtils.escapeHtml4(programmeMaster.getPrgmCode()):""%>" 
										<% } %>
										  style="font-size: 15px; text-transform: uppercase;"/> 
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="form-label"><b class="heading">Programme Name:</b><span class="mandatory" style="color:red;">*</span></label>
										<input type="text" class="form-control" placeholder="Enter Programme Name" name="ProgrammeName" id="ProgrammeName" required="required" 
										<%if(programmeMaster!=null){%>
										 value="<%=programmeMaster.getPrgmName()!=null?StringEscapeUtils.escapeHtml4(programmeMaster.getPrgmName()):""%>" 
										<%} %>
										 />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="form-label">
											<b class="heading">Programme Director:</b><span class="mandatory" style="color:red;">*</span>
										</label>
										<select class="form-control selectdee" id="programmedirector" name="programmedirector" data-width="100%"	data-live-search="true" required="required">
											<option disabled="disabled" selected="selected" value="">Choose.....</option>
											<% if(directorsList!=null && directorsList.size()>0){for(Object[] protype : directorsList){%>
												<option value="<%= protype[0] %>" 
												<%if(programmeMaster!=null && programmeMaster.getPrgmDirector()==Long.parseLong(protype[0].toString())){%> selected="selected" <%} %>
												><%= protype[2]!=null ? StringEscapeUtils.escapeHtml4(protype[2].toString()):"-" %></option>
											<%}} %>
										</select>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="form-label"><b class="heading">Sanctioned On:</b><span class="mandatory" style="color:red;">*</span></label>
										<input type="text"  id="sanc-date" name="sanctionDate" class="form-control" required="required"
										<%if(programmeMaster!=null && programmeMaster.getSanctionedOn()!=null){%>
											value="<%=fc.sdfTordf(programmeMaster.getSanctionedOn()) %>"
										<%} %> readonly="readonly">
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<label class="for-label"><b class="heading">Projects:</b>
											<!-- <span class="mandatory" style="color:red;">*</span> -->
										</label>
										<select class="form-control selectdee" multiple="multiple"  name="prgmprojectids" id="prgmprojectids" data-placeholder="Choose..."	>
											<% for (Object[] obj : projectsList){ %>
												<option value="<%= obj[0] %>" <%if(programmeMaster!=null && linkedProjectIds!=null && linkedProjectIds.contains(Long.parseLong(obj[0].toString()))) {%> selected="selected" <%} %> >
													<%=obj[2]!=null? StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%> (<%=obj[4]!=null? StringEscapeUtils.escapeHtml4(obj[4].toString()):"-"%>)
												</option>
											<%} %>
										</select>
									</div>
								</div> 
							</div>
							<div align="center" style="margin-top:20px;">
								<% if(programmeMaster==null){%>
									<button type="submit" class="btn btn-sm submit" value="Add" name="action">SUBMIT</button>&nbsp;&nbsp;
									<input type="hidden" name="programmeMasterId" value="0" />
								<% } else {%>
									<button type="submit" class="btn btn-sm edit" value="Edit" name="action">UPDATE</button>&nbsp;&nbsp;
									<input type="hidden" name="programmeMasterId" value="<%=programmeMaster.getProgrammeId() %>" />
								 <% }%>
							 
								<a class="btn btn-sm back" href="ProgrammeMaster.htm">BACK</a>&nbsp;&nbsp;
							</div>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">			

	$('#sanc-date').daterangepicker({
		
		"singleDatePicker": true,
		"showDropdowns": true,
		"cancelClass": "btn-default",
		"maxDate":new Date() ,
		locale: {
	    	format: 'DD-MM-YYYY'
			}
	});
	
		function handleInputChange(value,prgmId) {
		    var uppercasedValue = value.trim().toUpperCase();
		    $('#ProgrammeCode').val(uppercasedValue);
		    if (uppercasedValue.length >=2) {
		        $.ajax({
		            type: "GET",
		            url: "ProgrammeCodeCheck.htm",
		            data: {
		                ProgrammeCode: uppercasedValue,
		                ProgrammeId: prgmId
		            },
		            datatype: 'json',
		            success: function(result) {
		                var ajaxresult = JSON.parse(result); 
		                //Check if the Programme code already exists
		                if (ajaxresult >= 1) {
		                	 $('#ProgrammeCode').val('');
		                    alert('Programme Code Already Exists');
		                }
		               
		            },
		            error: function() {
		                alert('An error occurred while checking the Programme code.');
		            }
		        });
		    }
		}
		
	</script>
</body>
</html>